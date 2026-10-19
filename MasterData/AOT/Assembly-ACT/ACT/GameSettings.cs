using System;
using System.Collections.Generic;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using Cysharp.Threading.Tasks;
using Runtime;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Networking;
using UnityEngine.Rendering.Universal;

namespace ACT;

[CreateAssetMenu(fileName = "GameSettings", menuName = "ACT/Settings/GameSettings")]
public sealed class GameSettings : ScriptableObject, ISerializationCallbackReceiver, IGraphicPerformanceEvaluator
{
	[Serializable]
	private class HighPerformanceMarkSetting
	{
		[SerializeField]
		private string _optionId;

		[SerializeField]
		private HighPerformanceOptionMark[] _optionMarks;

		public string OptionId => _optionId;

		public HighPerformanceOptionMark[] OptionMarks => _optionMarks;

		public HighPerformanceMarkSetting()
		{
			_optionMarks = Array.Empty<HighPerformanceOptionMark>();
		}
	}

	[Serializable]
	private struct HighPerformanceOptionMark
	{
		[SerializeField]
		private int _optionIndex;

		public int OptionIndex => _optionIndex;
	}

	[Serializable]
	private class PerformanceRatingCorrection
	{
		[SerializeField]
		private bool _enabled;

		[SerializeField]
		private int _referencePixelCount = 2592000;

		[SerializeField]
		[Range(0f, 1f)]
		private float _pixelCostFraction = 0.65f;

		[SerializeField]
		private bool _extrapolate = true;

		[SerializeField]
		private PerformanceRatingPoint[] _ratingPoints = Array.Empty<PerformanceRatingPoint>();

		private bool Usable
		{
			get
			{
				if (_enabled && _referencePixelCount > 0 && _ratingPoints != null)
				{
					return _ratingPoints.Length >= 2;
				}
				return false;
			}
		}

		public PerformanceRatingCorrection()
		{
		}

		public PerformanceRatingCorrection(bool enabled, int referencePixelCount, float pixelCostFraction, bool extrapolate, PerformanceRatingPoint[] ratingPoints)
		{
			_enabled = enabled;
			_referencePixelCount = referencePixelCount;
			_pixelCostFraction = pixelCostFraction;
			_extrapolate = extrapolate;
			_ratingPoints = ratingPoints ?? Array.Empty<PerformanceRatingPoint>();
		}

		public float CorrectReferenceRating(float rawRating)
		{
			if (!Usable || rawRating <= 0f)
			{
				return rawRating;
			}
			return EvaluatePiecewiseLinear(rawRating);
		}

		public float CorrectDeviceRating(float rawRating, int currentPixelCount)
		{
			if (!Usable || rawRating <= 0f)
			{
				return rawRating;
			}
			float num = EvaluatePiecewiseLinear(rawRating);
			float num2 = (float)Mathf.Max(1, currentPixelCount) / (float)_referencePixelCount;
			float num3 = Mathf.Clamp01(_pixelCostFraction);
			float num4 = 1f - num3 + num3 * num2;
			if (!(num4 > 0f))
			{
				return rawRating;
			}
			return num / num4;
		}

		private float EvaluatePiecewiseLinear(float rawRating)
		{
			if (!TryFindCurveBounds(rawRating, out var lower, out var upper, out var minimum, out var secondMinimum, out var secondMaximum, out var maximum))
			{
				return rawRating;
			}
			if (rawRating <= minimum.RawRating)
			{
				if (!_extrapolate)
				{
					return minimum.CorrectedRating;
				}
				return Interpolate(minimum, secondMinimum, rawRating);
			}
			if (rawRating >= maximum.RawRating)
			{
				if (!_extrapolate)
				{
					return maximum.CorrectedRating;
				}
				return Interpolate(secondMaximum, maximum, rawRating);
			}
			return Interpolate(lower, upper, rawRating);
		}

		private bool TryFindCurveBounds(float rawRating, out PerformanceRatingPoint lower, out PerformanceRatingPoint upper, out PerformanceRatingPoint minimum, out PerformanceRatingPoint secondMinimum, out PerformanceRatingPoint secondMaximum, out PerformanceRatingPoint maximum)
		{
			lower = default;
			upper = default;
			minimum = default;
			secondMinimum = default;
			secondMaximum = default;
			maximum = default;
			bool flag = false;
			bool flag2 = false;
			bool flag3 = false;
			bool flag4 = false;
			bool flag5 = false;
			bool flag6 = false;
			PerformanceRatingPoint[] ratingPoints = _ratingPoints;
			for (int i = 0; i < ratingPoints.Length; i++)
			{
				PerformanceRatingPoint performanceRatingPoint = ratingPoints[i];
				if (performanceRatingPoint.Valid)
				{
					if (!flag3 || performanceRatingPoint.RawRating < minimum.RawRating)
					{
						secondMinimum = minimum;
						flag4 = flag3;
						minimum = performanceRatingPoint;
						flag3 = true;
					}
					else if ((!flag4 || performanceRatingPoint.RawRating < secondMinimum.RawRating) && !Mathf.Approximately(performanceRatingPoint.RawRating, minimum.RawRating))
					{
						secondMinimum = performanceRatingPoint;
						flag4 = true;
					}
					if (!flag5 || performanceRatingPoint.RawRating > maximum.RawRating)
					{
						secondMaximum = maximum;
						flag6 = flag5;
						maximum = performanceRatingPoint;
						flag5 = true;
					}
					else if ((!flag6 || performanceRatingPoint.RawRating > secondMaximum.RawRating) && !Mathf.Approximately(performanceRatingPoint.RawRating, maximum.RawRating))
					{
						secondMaximum = performanceRatingPoint;
						flag6 = true;
					}
					if (performanceRatingPoint.RawRating <= rawRating && (!flag || performanceRatingPoint.RawRating > lower.RawRating))
					{
						lower = performanceRatingPoint;
						flag = true;
					}
					if (performanceRatingPoint.RawRating >= rawRating && (!flag2 || performanceRatingPoint.RawRating < upper.RawRating))
					{
						upper = performanceRatingPoint;
						flag2 = true;
					}
				}
			}
			if (!flag3 || !flag4 || !flag6 || !flag5)
			{
				return false;
			}
			if (!flag)
			{
				lower = minimum;
			}
			if (!flag2)
			{
				upper = maximum;
			}
			return true;
		}

		private static float Interpolate(PerformanceRatingPoint lower, PerformanceRatingPoint upper, float rawRating)
		{
			float num = upper.RawRating - lower.RawRating;
			if (Mathf.Approximately(num, 0f))
			{
				return lower.CorrectedRating;
			}
			float num2 = (rawRating - lower.RawRating) / num;
			return lower.CorrectedRating + (upper.CorrectedRating - lower.CorrectedRating) * num2;
		}
	}

	[Serializable]
	private struct PerformanceRatingPoint(float rawRating, float correctedRating)
	{
		[SerializeField]
		private float _rawRating = rawRating;

		[SerializeField]
		private float _correctedRating = correctedRating;

		public float RawRating => _rawRating;

		public float CorrectedRating => _correctedRating;

		public bool Valid
		{
			get
			{
				if (!float.IsNaN(_rawRating) && !float.IsInfinity(_rawRating) && !float.IsNaN(_correctedRating) && !float.IsInfinity(_correctedRating) && _rawRating >= 0f)
				{
					return _correctedRating >= 0f;
				}
				return false;
			}
		}
	}

	private enum CalculateMode
	{
		Add,
		Mul
	}

	[Serializable]
	private class PerformanceEval
	{
		[SerializeField]
		private string _optionId;

		[SerializeField]
		private CalculateMode _calculateMode;

		[SerializeField]
		private PerformanceOptionFactor[] _optionFactors;

		public string OptionId => _optionId;

		public CalculateMode CalculateMode => _calculateMode;

		public PerformanceOptionFactor[] OptionFactors => _optionFactors;

		public PerformanceEval()
		{
			_optionFactors = Array.Empty<PerformanceOptionFactor>();
		}

		public PerformanceEval(string optionId, CalculateMode calculateMode, PerformanceOptionFactor[] optionFactors)
		{
			_optionId = optionId;
			_calculateMode = calculateMode;
			_optionFactors = optionFactors ?? Array.Empty<PerformanceOptionFactor>();
		}

		public float GetWeight(int optionValue)
		{
			if (_optionFactors == null)
			{
				return 0f;
			}
			PerformanceOptionFactor[] optionFactors = _optionFactors;
			for (int i = 0; i < optionFactors.Length; i++)
			{
				PerformanceOptionFactor performanceOptionFactor = optionFactors[i];
				if (performanceOptionFactor.OptionIndex == optionValue)
				{
					return performanceOptionFactor.OptionWeight;
				}
			}
			return 0f;
		}
	}

	[Serializable]
	private struct PerformanceOptionFactor(int optionIndex, float optionWeight)
	{
		[SerializeField]
		private int _optionIndex = optionIndex;

		[SerializeField]
		private float _optionWeight = optionWeight;

		public int OptionIndex => _optionIndex;

		public float OptionWeight => _optionWeight;
	}

	private readonly struct PerformanceEvalBinaryHeader
	{
		public ushort FormatVersion { get; }

		public ushort HeaderSize { get; }

		public uint SchemaVersion { get; }

		public int PayloadLength { get; }

		public byte[] PayloadHash { get; }

		public bool Valid
		{
			get
			{
				if (PayloadHash != null)
				{
					return PayloadHash.Length == 32;
				}
				return false;
			}
		}

		public PerformanceEvalBinaryHeader(ushort formatVersion, ushort headerSize, uint schemaVersion, int payloadLength, byte[] payloadHash)
		{
			FormatVersion = formatVersion;
			HeaderSize = headerSize;
			SchemaVersion = schemaVersion;
			PayloadLength = payloadLength;
			PayloadHash = payloadHash;
		}

		public bool HasSameContent(PerformanceEvalBinaryHeader other)
		{
			if (!Valid || !other.Valid || FormatVersion != other.FormatVersion || SchemaVersion != other.SchemaVersion || PayloadLength != other.PayloadLength)
			{
				return false;
			}
			for (int i = 0; i < PayloadHash.Length; i++)
			{
				if (PayloadHash[i] != other.PayloadHash[i])
				{
					return false;
				}
			}
			return true;
		}
	}

	private sealed class PerformanceEvalBinaryConfig
	{
		public List<PerformanceEval> PerformanceEvals { get; }

		public PerformanceRatingCorrection RatingCorrection { get; }

		public PerformanceEvalBinaryConfig(List<PerformanceEval> performanceEvals, PerformanceRatingCorrection ratingCorrection)
		{
			PerformanceEvals = performanceEvals;
			RatingCorrection = ratingCorrection;
		}
	}

	[SerializeField]
	private SettingUsage m_SettingUsage;

	[NonSerialized]
	private SettingUsage? m_RuntimeSettingUsage;

	[SerializeField]
	private List<SettingBool> m_BoolSettings = new List<SettingBool>();

	[SerializeField]
	private List<SettingInt> m_IntSettings = new List<SettingInt>();

	[SerializeField]
	private List<SettingFloat> m_FloatSettings = new List<SettingFloat>();

	[SerializeField]
	private List<SettingString> m_StringSettings = new List<SettingString>();

	[SerializeField]
	private List<SettingOptions> m_OptionsSettings = new List<SettingOptions>();

	[NonSerialized]
	private List<ISetting> m_SettingsCache = new List<ISetting>();

	[NonSerialized]
	private Dictionary<string, ISetting> m_SettingsMap = new Dictionary<string, ISetting>();

	[SerializeField]
	private List<HighPerformanceMarkSetting> m_HighPerformanceMarks = new List<HighPerformanceMarkSetting>();

	[SerializeField]
	private bool _performanceBarEnabled = true;

	[SerializeField]
	private List<PerformanceEval> m_PerformanceEvals = new List<PerformanceEval>();

	[SerializeField]
	[Tooltip("需求评分整体缩放系数：1 表示需求直接等于低档基准评分 × 档位权重；小于 1 表示按实测标定给进度条留余量，只调整量程，不改变档位之间相对关系。")]
	private float m_PerformanceRequiredRatingScale = 1f;

	[SerializeField]
	private PerformanceRatingCorrection m_PerformanceRatingCorrection = new PerformanceRatingCorrection();

	[SerializeField]
	private UnityEngine.Object m_PerformanceEvalDefaultConfig;

	[SerializeField]
	[HideInInspector]
	private byte[] m_PerformanceEvalDefaultConfigBytes = Array.Empty<byte>();

	[SerializeField]
	private string m_PerformanceEvalRemoteUrl;

	[NonSerialized]
	private bool m_PerformanceEvaluationInitialized;

	[NonSerialized]
	private HashSet<ISetting> m_PerformanceEvaluationSettingConnections;

	private const ushort PerformanceEvalBinaryFormatVersion = 1;

	private const uint PerformanceEvalBinarySchemaVersion = 1u;

	private const int PerformanceEvalBinaryHeaderSize = 48;

	private const int PerformanceEvalBinaryMaxPayloadSize = 65536;

	private const int PerformanceEvalBinaryMaxEvalCount = 64;

	private const int PerformanceEvalBinaryMaxFactorCount = 64;

	private const int PerformanceEvalBinaryMaxPointCount = 64;

	private const int PerformanceEvalBinaryMaxOptionIdBytes = 256;

	private const int PerformanceEvalRequestTimeoutSeconds = 10;

	private const string PerformanceEvalCacheDirectory = "performance_eval";

	private static readonly byte[] PerformanceEvalBinaryMagic = Encoding.ASCII.GetBytes("PECF");

	private static readonly UTF8Encoding StrictUtf8 = new UTF8Encoding(encoderShouldEmitUTF8Identifier: false, throwOnInvalidBytes: true);

	[NonSerialized]
	private PerformanceEvalBinaryHeader m_ActivePerformanceEvalBinaryHeader;

	[SerializeField]
	private OptionsPlatformConfig<LocalizedString> m_GraphicQuality = new OptionsPlatformConfig<LocalizedString>();

	[NonSerialized]
	private bool m_SuppressGraphicQualityCustom;

	private const string LegacyGraphicDLSSSettingId = "Graphic.DLSS";

	[SerializeField]
	private List<GraphicGradePreset> m_GraphicGradePresets = new List<GraphicGradePreset>();

	public SettingUsage Usage => m_RuntimeSettingUsage ?? m_SettingUsage;

	public bool IsMobile => IsMobileUsage(Usage);

	public bool PerformanceBarEnabled => _performanceBarEnabled;

	public float PerformanceRequiredRatingScale
	{
		get
		{
			if (!(m_PerformanceRequiredRatingScale > 0f))
			{
				return 1f;
			}
			return m_PerformanceRequiredRatingScale;
		}
	}

	public event Action<GraphicPerformanceLoad> PerformanceLoadChanged;

	public bool IsMatchUsage(SettingUsage usage)
	{
		return m_SettingUsage == usage;
	}

	internal void SetRuntimeSettingUsage(SettingUsage usage)
	{
		m_RuntimeSettingUsage = usage;
	}

	private static bool IsMobileUsage(SettingUsage usage)
	{
		if (usage != SettingUsage.iOS)
		{
			return usage == SettingUsage.Android;
		}
		return true;
	}

	private void RebuildSettingsCache()
	{
		m_SettingsCache.Clear();
		m_SettingsMap.Clear();
		foreach (SettingBool boolSetting in m_BoolSettings)
		{
			if (boolSetting != null && !string.IsNullOrEmpty(boolSetting.Id))
			{
				m_SettingsCache.Add(boolSetting);
			}
		}
		foreach (SettingInt intSetting in m_IntSettings)
		{
			if (intSetting != null && !string.IsNullOrEmpty(intSetting.Id))
			{
				m_SettingsCache.Add(intSetting);
			}
		}
		foreach (SettingFloat floatSetting in m_FloatSettings)
		{
			if (floatSetting != null && !string.IsNullOrEmpty(floatSetting.Id))
			{
				m_SettingsCache.Add(floatSetting);
			}
		}
		foreach (SettingString stringSetting in m_StringSettings)
		{
			if (stringSetting != null && !string.IsNullOrEmpty(stringSetting.Id))
			{
				m_SettingsCache.Add(stringSetting);
			}
		}
		foreach (SettingOptions optionsSetting in m_OptionsSettings)
		{
			if (optionsSetting != null && !string.IsNullOrEmpty(optionsSetting.Id))
			{
				m_SettingsCache.Add(optionsSetting);
			}
		}
		foreach (ISetting item in m_SettingsCache)
		{
			if (m_SettingsMap.ContainsKey(item.Id))
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError("Setting " + item.Id + " has been already added");
				}
			}
			else
			{
				m_SettingsMap.Add(item.Id, item);
			}
		}
	}

	public void Initialize(SerializedSettingsData serializedData, GraphicGradePreset initialGraphicGradePreset = null)
	{
		RebuildSettingsCache();
		foreach (ISetting item in m_SettingsCache)
		{
			item.Initialize(this);
		}
		if (serializedData != null)
		{
			MigrateLegacyTemporalUpscalerQuality(serializedData);
			foreach (SettingData settingData in serializedData.SettingDatas)
			{
				GetSetting(settingData.Id)?.DeserializeValueFromData(settingData);
			}
			RestoreGraphicQualityCustomSnapshot(serializedData);
		}
		ApplyGraphicQualityRuntimeDefaults();
		ApplyInitialGraphicGradePreset(initialGraphicGradePreset);
		RefreshGraphicQualityFromCurrentSettings();
		foreach (ISetting item2 in m_SettingsCache)
		{
			if (item2.HasConnection())
			{
				item2.InitToConnection();
			}
		}
		InitializePerformanceEvaluation();
	}

	private void ApplyGraphicQualityRuntimeDefaults()
	{
		SettingOptions settingOptions = GetSettingOptions("Graphic.Quality");
		if (settingOptions?.GetConnection() is GraphicQualityConnectionSO.Connection connection)
		{
			int graphicQualityDefault = GetGraphicQualityDefault();
			connection.ApplyPresetAsRuntimeDefault(graphicQualityDefault);
			connection.ApplyPresetAsRuntimeValue(graphicQualityDefault, forceValues: false);
			connection.ApplyPresetAsRuntimeValue(settingOptions.GetValue(), !settingOptions.Modified);
		}
	}

	public SerializedSettingsData ExportToSerializedData()
	{
		RebuildSettingsCache();
		SerializedSettingsData serializedSettingsData = new SerializedSettingsData();
		foreach (ISetting item2 in m_SettingsCache)
		{
			bool flag = ShouldSerializeGraphicQualitySnapshot(item2);
			if ((item2.Usable || flag) && (item2.Modified || flag))
			{
				SettingData item = item2.SerializeValueToData();
				serializedSettingsData.SettingDatas.Add(item);
			}
		}
		return serializedSettingsData;
	}

	public List<ISetting> GetAllSettings()
	{
		RebuildSettingsCache();
		return new List<ISetting>(m_SettingsCache);
	}

	public ISetting GetSetting(string id)
	{
		if (string.IsNullOrEmpty(id))
		{
			return null;
		}
		if (m_SettingsMap.TryGetValue(id, out var value))
		{
			return value;
		}
		return null;
	}

	public void ResetToDefaults()
	{
		m_SuppressGraphicQualityCustom = true;
		try
		{
			List<ISetting> settingsCache = m_SettingsCache;
			for (int i = 0; i < settingsCache.Count; i++)
			{
				ISetting setting = settingsCache[i];
				if (setting.Usable)
				{
					setting.ResetToDefault();
				}
			}
			if (GetSettingOptions("Graphic.Quality")?.GetConnection() is GraphicQualityConnectionSO.Connection connection)
			{
				connection.ResetToPreset(GetGraphicQualityDefault());
			}
		}
		finally
		{
			m_SuppressGraphicQualityCustom = false;
		}
	}

	public void Apply()
	{
		List<ISetting> settingsCache = m_SettingsCache;
		for (int i = 0; i < settingsCache.Count; i++)
		{
			ISetting setting = settingsCache[i];
			if (setting.Usable && setting.HasUnAppliedChanges())
			{
				setting.Apply();
			}
		}
	}

	public void OnBeforeSerialize()
	{
		RebuildSettingsCache();
	}

	public void OnAfterDeserialize()
	{
		RebuildSettingsCache();
	}

	public HashSet<int> GetHighPerformanceInfos(string id)
	{
		HashSet<int> hashSet = new HashSet<int>();
		if (string.IsNullOrEmpty(id) || m_HighPerformanceMarks == null)
		{
			return hashSet;
		}
		foreach (HighPerformanceMarkSetting highPerformanceMark in m_HighPerformanceMarks)
		{
			if (highPerformanceMark != null && !(highPerformanceMark.OptionId != id))
			{
				HighPerformanceOptionMark[] optionMarks = highPerformanceMark.OptionMarks;
				foreach (HighPerformanceOptionMark highPerformanceOptionMark in optionMarks)
				{
					hashSet.Add(highPerformanceOptionMark.OptionIndex);
				}
			}
		}
		return hashSet;
	}

	public SettingBool GetSettingBool(string id)
	{
		return GetSetting(id) as SettingBool;
	}

	public SettingInt GetSettingInt(string id)
	{
		return GetSetting(id) as SettingInt;
	}

	public SettingFloat GetSettingFloat(string id)
	{
		return GetSetting(id) as SettingFloat;
	}

	public SettingString GetSettingString(string id)
	{
		return GetSetting(id) as SettingString;
	}

	public SettingOptions GetSettingOptions(string id)
	{
		return GetSetting(id) as SettingOptions;
	}

	private HashSet<ISetting> GetAllGraphicPerformanceEvalSettingConnections()
	{
		HashSet<ISetting> hashSet = new HashSet<ISetting>();
		if (m_PerformanceEvals == null)
		{
			return hashSet;
		}
		foreach (PerformanceEval performanceEval in m_PerformanceEvals)
		{
			if (performanceEval != null && !string.IsNullOrEmpty(performanceEval.OptionId))
			{
				SettingOptions settingOptions = GetSettingOptions(performanceEval.OptionId);
				if (settingOptions != null)
				{
					hashSet.Add(settingOptions);
				}
			}
		}
		return hashSet;
	}

	private void InitializePerformanceEvaluation()
	{
		if (!m_PerformanceEvaluationInitialized)
		{
			LoadInitialPerformanceEvaluationConfig();
			m_PerformanceEvaluationInitialized = true;
			BindPerformanceEvaluationSettings();
		}
	}

	private void BindPerformanceEvaluationSettings()
	{
		m_PerformanceEvaluationSettingConnections = GetAllGraphicPerformanceEvalSettingConnections();
		foreach (ISetting performanceEvaluationSettingConnection in m_PerformanceEvaluationSettingConnections)
		{
			performanceEvaluationSettingConnection.OnChange = (Action<ISetting>)Delegate.Combine(performanceEvaluationSettingConnection.OnChange, new Action<ISetting>(OnPerformanceSettingChanged));
		}
	}

	private void UnbindPerformanceEvaluationSettings()
	{
		if (m_PerformanceEvaluationSettingConnections == null)
		{
			return;
		}
		foreach (ISetting performanceEvaluationSettingConnection in m_PerformanceEvaluationSettingConnections)
		{
			performanceEvaluationSettingConnection.OnChange = (Action<ISetting>)Delegate.Remove(performanceEvaluationSettingConnection.OnChange, new Action<ISetting>(OnPerformanceSettingChanged));
		}
		m_PerformanceEvaluationSettingConnections.Clear();
	}

	private void OnPerformanceSettingChanged(ISetting setting)
	{
		TryGetPerformanceLoad(out var performanceLoad);
		PerformanceLoadChanged?.Invoke(performanceLoad);
	}

	public bool TryGetPerformanceLoad(out GraphicPerformanceLoad performanceLoad)
	{
		performanceLoad = default;
		float num = DeviceGradeInfo.CurDeviceGradeRating;
		if (Mathf.Approximately(num, -1f))
		{
			num = (DeviceGradeInfo.MidGradeBaseRating + DeviceGradeInfo.HighGradeBaseRating) * 0.5f;
		}
		float lowGradeBaseRating = DeviceGradeInfo.LowGradeBaseRating;
		int currentRenderPixelCount = GetCurrentRenderPixelCount();
		float num2 = ((m_PerformanceRatingCorrection != null) ? m_PerformanceRatingCorrection.CorrectDeviceRating(num, currentRenderPixelCount) : num);
		float num3 = ((m_PerformanceRatingCorrection != null) ? m_PerformanceRatingCorrection.CorrectReferenceRating(lowGradeBaseRating) : lowGradeBaseRating);
		if (num2 <= 0f || num3 <= 0f)
		{
			return false;
		}
		float num4 = 1f;
		float num5 = 1f;
		if (m_PerformanceEvals != null)
		{
			foreach (PerformanceEval performanceEval in m_PerformanceEvals)
			{
				if (performanceEval == null || string.IsNullOrEmpty(performanceEval.OptionId))
				{
					continue;
				}
				SettingOptions settingOptions = GetSettingOptions(performanceEval.OptionId);
				if (settingOptions != null)
				{
					if (performanceEval.CalculateMode == CalculateMode.Mul)
					{
						num5 += performanceEval.GetWeight(settingOptions.GetValue());
					}
					else
					{
						num4 += performanceEval.GetWeight(settingOptions.GetValue());
					}
				}
			}
		}
		float num6 = num4 * num5;
		float num7 = num3 * num6 * PerformanceRequiredRatingScale;
		if (num7 <= 0f)
		{
			return false;
		}
		float num8 = num7 / num2;
		float num9 = num2 / num7;
		if (float.IsNaN(num8) || float.IsInfinity(num8) || float.IsNaN(num9) || float.IsInfinity(num9))
		{
			return false;
		}
		performanceLoad = new GraphicPerformanceLoad(num, lowGradeBaseRating, num2, num3, num4, num5, num6, num7, PerformanceRequiredRatingScale, num8, num9);
		return true;
	}

	private int GetCurrentRenderPixelCount()
	{
		UniversalRenderPipelineAsset universalRenderPipelineAsset = QualitySettings.renderPipeline as UniversalRenderPipelineAsset;
		float renderScale = ((universalRenderPipelineAsset != null) ? universalRenderPipelineAsset.renderScale : 1f);
		SettingOptions settingOptions = GetSettingOptions("Graphic.RenderScale");
		if (settingOptions?.GetConnection() is RenderScaleConnectionSO.Connection connection)
		{
			renderScale = connection.ResolveRenderScale(settingOptions.GetValue());
		}
		return GetRenderPixelCount(renderScale);
	}

	private static int GetRenderPixelCount(float renderScale)
	{
		URPGraphicSettings.GetEstimatedRenderResolution(renderScale, Screen.width, Screen.height, out var renderWidth, out var renderHeight);
		long num = (long)renderWidth * (long)renderHeight;
		if (num < int.MaxValue)
		{
			return (int)num;
		}
		return int.MaxValue;
	}

	public bool TryGetPerformanceAdjustmentCandidates(out IReadOnlyList<GraphicPerformanceAdjustment> adjustments)
	{
		adjustments = Array.Empty<GraphicPerformanceAdjustment>();
		if (!TryGetPerformanceLoad(out var performanceLoad) || m_PerformanceEvals == null)
		{
			return false;
		}
		List<GraphicPerformanceAdjustment> list = new List<GraphicPerformanceAdjustment>();
		HashSet<string> hashSet = new HashSet<string>();
		foreach (PerformanceEval performanceEval in m_PerformanceEvals)
		{
			if (performanceEval == null || string.IsNullOrEmpty(performanceEval.OptionId) || !hashSet.Add(performanceEval.OptionId))
			{
				continue;
			}
			SettingOptions settingOptions = GetSettingOptions(performanceEval.OptionId);
			if (settingOptions == null || !settingOptions.Usable)
			{
				continue;
			}
			int value = settingOptions.GetValue();
			float weight = performanceEval.GetWeight(value);
			List<string> optionLabels = settingOptions.GetOptionLabels<string>();
			if (performanceEval.OptionFactors == null)
			{
				continue;
			}
			PerformanceOptionFactor[] optionFactors = performanceEval.OptionFactors;
			for (int i = 0; i < optionFactors.Length; i++)
			{
				PerformanceOptionFactor performanceOptionFactor = optionFactors[i];
				int optionIndex = performanceOptionFactor.OptionIndex;
				if (optionIndex == value)
				{
					continue;
				}
				float optionWeight = performanceOptionFactor.OptionWeight;
				float num = performanceLoad.AdditiveWeight;
				float num2 = performanceLoad.MultiplicativeWeight;
				if (performanceEval.CalculateMode == CalculateMode.Mul)
				{
					num2 += optionWeight - weight;
				}
				else
				{
					num += optionWeight - weight;
				}
				float num3 = num * num2;
				if (!(num3 <= 0f) && !Mathf.Approximately(num3, performanceLoad.SettingWeight))
				{
					float num4 = ((performanceLoad.SettingWeight > 0f) ? (performanceLoad.RequiredRating * (num3 / performanceLoad.SettingWeight)) : (performanceLoad.LowGradeBaseRating * num3));
					float num5 = performanceLoad.DeviceRating;
					if (settingOptions.Id == "Graphic.RenderScale" && settingOptions.GetConnection() is RenderScaleConnectionSO.Connection connection)
					{
						int renderPixelCount = GetRenderPixelCount(connection.ResolveRenderScale(optionIndex));
						num5 = ((m_PerformanceRatingCorrection != null) ? m_PerformanceRatingCorrection.CorrectDeviceRating(performanceLoad.RawDeviceRating, renderPixelCount) : performanceLoad.DeviceRating);
					}
					float num6 = num4 / num5;
					if (!float.IsNaN(num6) && !float.IsInfinity(num6))
					{
						list.Add(new GraphicPerformanceAdjustment(performanceEval.OptionId, value, GetOptionLabel(optionLabels, value), optionIndex, GetOptionLabel(optionLabels, optionIndex), num3, num4, num6, num6 - performanceLoad.LoadRatio));
					}
				}
			}
		}
		adjustments = list;
		return true;
	}

	private static string GetOptionLabel(IReadOnlyList<string> optionLabels, int optionIndex)
	{
		if (optionLabels == null || optionIndex < 0 || optionIndex >= optionLabels.Count)
		{
			return optionIndex.ToString();
		}
		return optionLabels[optionIndex];
	}

	public bool TryEvaluatePerformance(out float evalPercent)
	{
		if (TryGetPerformanceLoad(out var performanceLoad))
		{
			evalPercent = performanceLoad.PerformanceMarginRatio;
			return true;
		}
		evalPercent = 0f;
		return false;
	}

	public float EvaluatePerformance()
	{
		if (!TryEvaluatePerformance(out var evalPercent))
		{
			return 0f;
		}
		return evalPercent;
	}

	private static bool TryDeserializePerformanceEvalConfig(byte[] bytes, out PerformanceEvalBinaryHeader header, out PerformanceEvalBinaryConfig config, out string error)
	{
		config = null;
		if (!TryReadPerformanceEvalBinaryHeader(bytes, requireCompleteFile: true, out header, out error))
		{
			return false;
		}
		try
		{
			using MemoryStream memoryStream = new MemoryStream(bytes, writable: false);
			using BinaryReader binaryReader = new BinaryReader(memoryStream, StrictUtf8, leaveOpen: false);
			memoryStream.Position = header.HeaderSize;
			ushort num = binaryReader.ReadUInt16();
			if (num == 0 || num > 64)
			{
				error = "性能评估项目数量非法。";
				return false;
			}
			List<PerformanceEval> list = new List<PerformanceEval>(num);
			HashSet<string> hashSet = new HashSet<string>(StringComparer.Ordinal);
			for (int i = 0; i < num; i++)
			{
				string text = ReadPerformanceEvalString(binaryReader);
				if (string.IsNullOrWhiteSpace(text) || !hashSet.Add(text))
				{
					error = "性能评估配置包含空白或重复的 OptionId。";
					return false;
				}
				byte b = binaryReader.ReadByte();
				if (b > 1)
				{
					error = "性能评估配置包含未知计算模式。";
					return false;
				}
				ushort num2 = binaryReader.ReadUInt16();
				if (num2 == 0 || num2 > 64)
				{
					error = "性能评估选项权重数量非法。";
					return false;
				}
				PerformanceOptionFactor[] array = new PerformanceOptionFactor[num2];
				HashSet<int> hashSet2 = new HashSet<int>();
				for (int j = 0; j < num2; j++)
				{
					int num3 = binaryReader.ReadInt32();
					float num4 = binaryReader.ReadSingle();
					if (num3 < 0 || !hashSet2.Add(num3) || !IsFiniteNonNegative(num4))
					{
						error = "性能评估配置包含非法选项索引或权重。";
						return false;
					}
					array[j] = new PerformanceOptionFactor(num3, num4);
				}
				list.Add(new PerformanceEval(text, (CalculateMode)b, array));
			}
			bool enabled = ReadPerformanceEvalBoolean(binaryReader);
			bool extrapolate = ReadPerformanceEvalBoolean(binaryReader);
			int num5 = binaryReader.ReadInt32();
			float num6 = binaryReader.ReadSingle();
			ushort num7 = binaryReader.ReadUInt16();
			if (num5 <= 0 || !IsFiniteNonNegative(num6) || num6 > 1f || num7 < 2 || num7 > 64)
			{
				error = "评分修正配置头非法。";
				return false;
			}
			PerformanceRatingPoint[] array2 = new PerformanceRatingPoint[num7];
			float num8 = float.NegativeInfinity;
			float num9 = float.NegativeInfinity;
			for (int k = 0; k < num7; k++)
			{
				float num10 = binaryReader.ReadSingle();
				float num11 = binaryReader.ReadSingle();
				if (!IsFiniteNonNegative(num10) || !IsFiniteNonNegative(num11) || num10 <= num8 || num11 < num9)
				{
					error = "评分修正曲线必须按原始评分严格递增，且修正评分单调不降。";
					return false;
				}
				array2[k] = new PerformanceRatingPoint(num10, num11);
				num8 = num10;
				num9 = num11;
			}
			if (memoryStream.Position != memoryStream.Length)
			{
				error = "性能评估二进制包含未识别的尾部数据。";
				return false;
			}
			config = new PerformanceEvalBinaryConfig(list, new PerformanceRatingCorrection(enabled, num5, num6, extrapolate, array2));
			error = string.Empty;
			return true;
		}
		catch (Exception ex) when (ex is EndOfStreamException || ex is IOException || ex is DecoderFallbackException)
		{
			error = "性能评估二进制内容不完整：" + ex.Message;
			return false;
		}
	}

	private static bool TryReadPerformanceEvalBinaryHeader(byte[] bytes, bool requireCompleteFile, out PerformanceEvalBinaryHeader header, out string error)
	{
		header = default;
		error = string.Empty;
		if (bytes == null || bytes.Length < 48)
		{
			error = "性能评估二进制头不完整。";
			return false;
		}
		try
		{
			using MemoryStream input = new MemoryStream(bytes, writable: false);
			using BinaryReader binaryReader = new BinaryReader(input, Encoding.ASCII, leaveOpen: false);
			byte[] array = binaryReader.ReadBytes(PerformanceEvalBinaryMagic.Length);
			for (int i = 0; i < PerformanceEvalBinaryMagic.Length; i++)
			{
				if (array[i] != PerformanceEvalBinaryMagic[i])
				{
					error = "性能评估二进制 Magic 不匹配。";
					return false;
				}
			}
			ushort num = binaryReader.ReadUInt16();
			ushort num2 = binaryReader.ReadUInt16();
			uint num3 = binaryReader.ReadUInt32();
			uint num4 = binaryReader.ReadUInt32();
			byte[] array2 = binaryReader.ReadBytes(32);
			if (num != 1 || num2 != 48 || num3 != 1 || num4 == 0 || num4 > 65536 || array2.Length != 32)
			{
				error = "性能评估二进制版本或长度非法。";
				return false;
			}
			long num5 = (long)num2 + (long)num4;
			if (requireCompleteFile && bytes.LongLength != num5)
			{
				error = "性能评估二进制长度与文件头不一致。";
				return false;
			}
			byte[] array3;
			checked
			{
				header = new PerformanceEvalBinaryHeader(num, num2, num3, (int)num4, array2);
				if (!requireCompleteFile)
				{
					return true;
				}
				using (SHA256 sHA = SHA256.Create())
				{
					array3 = sHA.ComputeHash(bytes, num2, (int)num4);
				}
			}
			for (int j = 0; j < array2.Length; j++)
			{
				if (array2[j] != array3[j])
				{
					error = "性能评估二进制 Payload 校验失败。";
					header = default;
					return false;
				}
			}
			return true;
		}
		catch (Exception ex) when (ex is EndOfStreamException || ex is IOException || ex is CryptographicException || ex is ArgumentException || ex is OverflowException)
		{
			error = "读取性能评估二进制头失败：" + ex.Message;
			return false;
		}
	}

	private static string ReadPerformanceEvalString(BinaryReader reader)
	{
		ushort num = reader.ReadUInt16();
		if (num == 0 || num > 256)
		{
			throw new IOException("OptionId 长度非法。");
		}
		byte[] array = reader.ReadBytes(num);
		if (array.Length != num)
		{
			throw new EndOfStreamException("OptionId 内容不完整。");
		}
		return StrictUtf8.GetString(array);
	}

	private static bool ReadPerformanceEvalBoolean(BinaryReader reader)
	{
		byte b = reader.ReadByte();
		if (b > 1)
		{
			throw new IOException("Boolean 字段非法。");
		}
		return b == 1;
	}

	private static bool IsFiniteNonNegative(float value)
	{
		if (!float.IsNaN(value) && !float.IsInfinity(value))
		{
			return value >= 0f;
		}
		return false;
	}

	private void LoadInitialPerformanceEvaluationConfig()
	{
		string text = null;
		try
		{
			text = GetPerformanceEvalCachePath();
		}
		catch (Exception ex)
		{
			LogPerformanceEvalWarning("初始化性能评估缓存失败：" + ex.Message);
		}
		if (string.IsNullOrEmpty(text) || !TryReadPerformanceEvalFile(text, out var bytes) || !TryApplyPerformanceEvalConfig(bytes, notify: false, out var _))
		{
			string error2 = string.Empty;
			if ((m_PerformanceEvalDefaultConfigBytes == null || m_PerformanceEvalDefaultConfigBytes.Length == 0 || !TryApplyPerformanceEvalConfig(m_PerformanceEvalDefaultConfigBytes, notify: false, out error2)) && m_PerformanceEvalDefaultConfigBytes != null && m_PerformanceEvalDefaultConfigBytes.Length != 0)
			{
				LogPerformanceEvalWarning("包内默认配置无效，将继续使用 GameSettings 序列化值：" + error2);
			}
		}
	}

	private bool TryApplyPerformanceEvalConfig(byte[] bytes, bool notify, out string error)
	{
		if (!TryDeserializePerformanceEvalConfig(bytes, out var header, out var config, out error))
		{
			return false;
		}
		if (m_PerformanceEvaluationInitialized)
		{
			UnbindPerformanceEvaluationSettings();
		}
		m_PerformanceEvals = config.PerformanceEvals;
		m_PerformanceRatingCorrection = config.RatingCorrection;
		m_ActivePerformanceEvalBinaryHeader = header;
		if (m_PerformanceEvaluationInitialized)
		{
			BindPerformanceEvaluationSettings();
		}
		if (notify)
		{
			TryGetPerformanceLoad(out var performanceLoad);
			PerformanceLoadChanged?.Invoke(performanceLoad);
		}
		return true;
	}

	private static bool TryReadPerformanceEvalFile(string path, out byte[] bytes)
	{
		bytes = null;
		try
		{
			if (!File.Exists(path))
			{
				return false;
			}
			bytes = File.ReadAllBytes(path);
			return true;
		}
		catch (Exception ex)
		{
			LogPerformanceEvalWarning("读取性能评估缓存失败：" + ex.Message);
			return false;
		}
	}

	public async UniTask RefreshPerformanceEvaluationConfigAsync()
	{
		if (!Application.isPlaying || !_performanceBarEnabled || string.IsNullOrWhiteSpace(m_PerformanceEvalRemoteUrl))
		{
			return;
		}
		string remoteUrl = m_PerformanceEvalRemoteUrl.Trim();
		if (!Uri.TryCreate(remoteUrl, UriKind.Absolute, out var result) || (result.Scheme != Uri.UriSchemeHttp && result.Scheme != Uri.UriSchemeHttps))
		{
			LogPerformanceEvalWarning("CDN 配置地址不是有效的 HTTP/HTTPS URL。");
			return;
		}
		try
		{
			byte[] array = await DownloadPerformanceEvalBytesAsync(remoteUrl, headerOnly: true);
			if (!this || array == null)
			{
				return;
			}
			PerformanceEvalBinaryHeader remoteHeader;
			string error2;
			if (TryDeserializePerformanceEvalConfig(array, out var header, out var config, out var _))
			{
				ApplyAndCachePerformanceEvalConfig(array, header);
			}
			else if (!TryReadPerformanceEvalBinaryHeader(array, requireCompleteFile: false, out remoteHeader, out error2))
			{
				LogPerformanceEvalWarning("远端性能评估文件头无效：" + error2);
			}
			else
			{
				if (m_ActivePerformanceEvalBinaryHeader.HasSameContent(remoteHeader))
				{
					return;
				}
				byte[] array2 = await DownloadPerformanceEvalBytesAsync(remoteUrl, headerOnly: false);
				if ((bool)this && array2 != null)
				{
					if (!TryDeserializePerformanceEvalConfig(array2, out var header2, out config, out var error3))
					{
						LogPerformanceEvalWarning("远端性能评估配置校验失败：" + error3);
					}
					else if (!remoteHeader.HasSameContent(header2))
					{
						LogPerformanceEvalWarning("远端性能评估文件头在下载期间发生变化，本次不应用。下次启动将重试。");
					}
					else
					{
						ApplyAndCachePerformanceEvalConfig(array2, header2);
					}
				}
			}
		}
		catch (Exception ex)
		{
			LogPerformanceEvalWarning("同步远端性能评估配置失败：" + ex.Message);
		}
	}

	private async UniTask<byte[]> DownloadPerformanceEvalBytesAsync(string url, bool headerOnly)
	{
		using UnityWebRequest request = UnityWebRequest.Get(url);
		request.timeout = 10;
		if (headerOnly)
		{
			request.SetRequestHeader("Range", $"bytes=0-{47}");
		}
		try
		{
			await request.SendWebRequest();
		}
		catch (UnityWebRequestException ex)
		{
			if (IsPerformanceEvalRemoteFileMissing(request.responseCode))
			{
				return null;
			}
			LogPerformanceEvalWarning($"下载性能评估配置失败：HTTP {request.responseCode}，{ex.Message}");
			return null;
		}
		if (request.result != UnityWebRequest.Result.Success)
		{
			if (IsPerformanceEvalRemoteFileMissing(request.responseCode))
			{
				return null;
			}
			LogPerformanceEvalWarning($"下载性能评估配置失败：HTTP {request.responseCode}，{request.error}");
			return null;
		}
		return request.downloadHandler?.data;
	}

	private static bool IsPerformanceEvalRemoteFileMissing(long responseCode)
	{
		if (responseCode != 404)
		{
			return responseCode == 410;
		}
		return true;
	}

	private void ApplyAndCachePerformanceEvalConfig(byte[] bytes, PerformanceEvalBinaryHeader header)
	{
		if (m_ActivePerformanceEvalBinaryHeader.HasSameContent(header))
		{
			return;
		}
		if (!TryApplyPerformanceEvalConfig(bytes, notify: true, out var error))
		{
			LogPerformanceEvalWarning("应用性能评估配置失败：" + error);
			return;
		}
		string performanceEvalCachePath = GetPerformanceEvalCachePath();
		if (!string.IsNullOrEmpty(performanceEvalCachePath))
		{
			TryWritePerformanceEvalCache(performanceEvalCachePath, bytes);
		}
	}

	private string GetPerformanceEvalCachePath()
	{
		if (string.IsNullOrWhiteSpace(m_PerformanceEvalRemoteUrl))
		{
			return null;
		}
		byte[] array;
		using (SHA256 sHA = SHA256.Create())
		{
			array = sHA.ComputeHash(Encoding.UTF8.GetBytes(m_PerformanceEvalRemoteUrl.Trim()));
		}
		string text = BitConverter.ToString(array, 0, 8).Replace("-", string.Empty).ToLowerInvariant();
		return Path.Combine(Application.persistentDataPath, "cache", "performance_eval", text + ".bin");
	}

	private static void TryWritePerformanceEvalCache(string path, byte[] bytes)
	{
		string text = path + ".tmp";
		try
		{
			string directoryName = Path.GetDirectoryName(path);
			if (!string.IsNullOrEmpty(directoryName))
			{
				Directory.CreateDirectory(directoryName);
			}
			File.WriteAllBytes(text, bytes);
			File.Copy(text, path, overwrite: true);
		}
		catch (Exception ex)
		{
			LogPerformanceEvalWarning("写入性能评估缓存失败：" + ex.Message);
		}
		finally
		{
			try
			{
				if (File.Exists(text))
				{
					File.Delete(text);
				}
			}
			catch
			{
			}
		}
	}

	private static void LogPerformanceEvalWarning(string message)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.LogWarning("[PerformanceEval] " + message);
		}
	}

	internal bool GetGraphicQualityUsable()
	{
		return m_GraphicQuality?.Usable ?? false;
	}

	internal int GetGraphicQualityDefault()
	{
		int valueOrDefault = (m_GraphicQuality?.Options?.Count).GetValueOrDefault();
		if (valueOrDefault <= 0)
		{
			return 0;
		}
		return Mathf.Clamp(m_GraphicQuality.Default, 0, valueOrDefault - 1);
	}

	internal List<LocalizedString> GetGraphicQualityOptions()
	{
		return m_GraphicQuality?.Options;
	}

	internal bool TryGetGraphicQualityLabel(GraphicPresetLevel gradeLevel, out LocalizedString label)
	{
		label = null;
		List<LocalizedString> graphicQualityOptions = GetGraphicQualityOptions();
		if (graphicQualityOptions == null)
		{
			return false;
		}
		for (int i = 0; i < graphicQualityOptions.Count; i++)
		{
			if (TryGetGraphicQualityPreset(i, out var preset) && preset.GradeLevel == gradeLevel)
			{
				label = graphicQualityOptions[i];
				return label != null;
			}
		}
		return false;
	}

	internal bool TryGetGraphicQualityPreset(int qualityValue, out GraphicGradePreset preset)
	{
		preset = null;
		if (!TryGetGraphicQualityCustomValue(out var customValue) || qualityValue < 0 || qualityValue >= customValue || m_GraphicGradePresets == null)
		{
			return false;
		}
		int num = 0;
		foreach (GraphicGradePreset graphicGradePreset in m_GraphicGradePresets)
		{
			if (graphicGradePreset != null)
			{
				if (num == qualityValue)
				{
					preset = graphicGradePreset;
					return true;
				}
				num++;
			}
		}
		return false;
	}

	internal void NotifySettingApplied(ISetting setting)
	{
		if (!m_SuppressGraphicQualityCustom && setting != null && IsGraphicQualityPresetSetting(setting.Id) && TryGetGraphicQualityCustomValue(out var customValue))
		{
			if (TryInferGraphicQualityValue(out var qualityValue))
			{
				GetSettingOptions("Graphic.Quality")?.SetValue(qualityValue);
			}
			else
			{
				GetSettingOptions("Graphic.Quality")?.SetValue(customValue);
			}
		}
	}

	internal void RefreshGraphicQualityFromCurrentSettings()
	{
		SettingOptions settingOptions = GetSettingOptions("Graphic.Quality");
		if (settingOptions != null && TryGetGraphicQualityCustomValue(out var customValue))
		{
			settingOptions.SetValue(TryInferGraphicQualityValue(out var qualityValue) ? qualityValue : customValue);
		}
	}

	internal void FallbackTemporalUpscalerToTAA()
	{
		SettingOptions settingOptions = GetSettingOptions("Graphic.AntiAlias");
		if (settingOptions == null || settingOptions.GetValue() != 2)
		{
			return;
		}
		m_SuppressGraphicQualityCustom = true;
		try
		{
			settingOptions.SetValue(1, applyImmediatly: true);
		}
		finally
		{
			m_SuppressGraphicQualityCustom = false;
		}
	}

	private void MigrateLegacyTemporalUpscalerQuality(SerializedSettingsData serializedData)
	{
		SettingOptions settingOptions = GetSettingOptions("Graphic.TemporalUpscalerQuality");
		if (settingOptions == null || serializedData?.SettingDatas == null)
		{
			return;
		}
		SettingData settingData = null;
		foreach (SettingData settingData3 in serializedData.SettingDatas)
		{
			if (settingData3?.Id == "Graphic.TemporalUpscalerQuality")
			{
				return;
			}
			if (settingData3?.Id == "Graphic.DLSS")
			{
				settingData = settingData3;
			}
		}
		if (settingData?.IntValues != null && settingData.IntValues.Length != 0)
		{
			SettingData settingData2 = settingOptions.SerializeValueToData();
			settingData2.IntValues = new int[1] { Mathf.Clamp(settingData.IntValues[0] + 1, 1, 3) };
			serializedData.SettingDatas.Add(settingData2);
		}
	}

	private bool ShouldSerializeGraphicQualitySnapshot(ISetting setting)
	{
		if (IsGraphicQualityCustom() && setting != null)
		{
			return IsGraphicQualityPresetSetting(setting.Id);
		}
		return false;
	}

	private void RestoreGraphicQualityCustomSnapshot(SerializedSettingsData serializedData)
	{
		SettingOptions settingOptions = GetSettingOptions("Graphic.Quality");
		if (serializedData == null || settingOptions == null || !settingOptions.Modified || !IsGraphicQualityCustom())
		{
			return;
		}
		foreach (SettingData settingData in serializedData.SettingDatas)
		{
			if (settingData != null && IsGraphicQualityPresetSetting(settingData.Id))
			{
				GetSettingOptions(settingData.Id)?.DeserializeValueFromDataIgnoringUsable(settingData);
			}
		}
	}

	private bool IsGraphicQualityCustom()
	{
		if (TryGetGraphicQualityCustomValue(out var customValue))
		{
			SettingOptions settingOptions = GetSettingOptions("Graphic.Quality");
			if (settingOptions == null)
			{
				return false;
			}
			return settingOptions.GetValue() == customValue;
		}
		return false;
	}

	private bool TryGetGraphicQualityCustomValue(out int customValue)
	{
		int valueOrDefault = (m_GraphicQuality?.Options?.Count).GetValueOrDefault();
		customValue = valueOrDefault - 1;
		return valueOrDefault > 0;
	}

	private bool IsGraphicQualityPresetSetting(string settingId)
	{
		if (string.IsNullOrEmpty(settingId) || m_GraphicGradePresets == null)
		{
			return false;
		}
		foreach (GraphicGradePreset graphicGradePreset in m_GraphicGradePresets)
		{
			GraphicSettingPreset[] array = graphicGradePreset?.GraphicPresets;
			if (array == null)
			{
				continue;
			}
			GraphicSettingPreset[] array2 = array;
			foreach (GraphicSettingPreset graphicSettingPreset in array2)
			{
				if (IsGraphicQualityControlledSetting(graphicSettingPreset) && graphicSettingPreset.OptionId == settingId)
				{
					return true;
				}
			}
		}
		return false;
	}

	private bool TryInferGraphicQualityValue(out int qualityValue)
	{
		qualityValue = 0;
		if (!TryGetGraphicQualityCustomValue(out var customValue) || m_GraphicGradePresets == null)
		{
			return false;
		}
		int num = GetSettingOptions("Graphic.Quality")?.GetValue() ?? (-1);
		if (TryGetGraphicQualityPreset(num, out var preset) && DoesGraphicQualityPresetMatchCurrentSettings(preset))
		{
			qualityValue = num;
			return true;
		}
		for (int i = 0; i < customValue; i++)
		{
			if (i != num && TryGetGraphicQualityPreset(i, out var preset2) && DoesGraphicQualityPresetMatchCurrentSettings(preset2))
			{
				qualityValue = i;
				return true;
			}
		}
		return false;
	}

	private bool DoesGraphicQualityPresetMatchCurrentSettings(GraphicGradePreset preset)
	{
		bool result = false;
		GraphicSettingPreset[] array = preset?.GraphicPresets;
		if (array == null)
		{
			return false;
		}
		GraphicSettingPreset[] array2 = array;
		foreach (GraphicSettingPreset graphicSettingPreset in array2)
		{
			if (IsGraphicQualityControlledSetting(graphicSettingPreset))
			{
				result = true;
				SettingOptions settingOptions = GetSettingOptions(graphicSettingPreset.OptionId);
				if (settingOptions == null || settingOptions.GetAppliedValue() != graphicSettingPreset.Value)
				{
					return false;
				}
			}
		}
		return result;
	}

	private static bool IsGraphicQualityControlledSetting(GraphicSettingPreset presetSetting)
	{
		if (presetSetting != null && !presetSetting.OnlyForInitUse && !string.IsNullOrEmpty(presetSetting.OptionId))
		{
			return presetSetting.OptionId != "Graphic.Quality";
		}
		return false;
	}

	public GraphicGradePreset GetGraphicGradePreset(GraphicPresetLevel activeLevel)
	{
		if (m_GraphicGradePresets == null || m_GraphicGradePresets.Count == 0)
		{
			return null;
		}
		foreach (GraphicGradePreset graphicGradePreset in m_GraphicGradePresets)
		{
			if (graphicGradePreset != null && graphicGradePreset.GradeLevel == activeLevel)
			{
				return graphicGradePreset;
			}
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"当前平台未配置画质档位预设: {activeLevel}");
		}
		return null;
	}

	private void ApplyInitialGraphicGradePreset(GraphicGradePreset preset)
	{
		if (preset?.GraphicPresets == null)
		{
			return;
		}
		GraphicSettingPreset[] graphicPresets = preset.GraphicPresets;
		foreach (GraphicSettingPreset graphicSettingPreset in graphicPresets)
		{
			if (graphicSettingPreset != null && !string.IsNullOrEmpty(graphicSettingPreset.OptionId))
			{
				SettingOptions settingOptions = GetSettingOptions(graphicSettingPreset.OptionId);
				if (settingOptions != null)
				{
					settingOptions.SetRuntimeDefaultValue(graphicSettingPreset.Value);
					settingOptions.SetRuntimeValue(graphicSettingPreset.Value, forceValue: true, markAsModified: true);
				}
			}
		}
		SettingOptions settingOptions2 = GetSettingOptions("Graphic.Quality");
		if (settingOptions2 != null && TryInferGraphicQualityValue(out var qualityValue))
		{
			settingOptions2.SetRuntimeValue(qualityValue, forceValue: true, markAsModified: true);
		}
	}
}
