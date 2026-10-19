using System;
using System.Collections;
using System.Security.Cryptography;
using System.Text;
using ACT;
using AOT.CryptographyCode;
using SimpleJSON;
using UnityEngine;
using UnityEngine.Networking;
using bamboosdk;

namespace Runtime;

public static class DeviceGradeInfo
{
	private class Processor
	{
		private readonly bool _useEditorSimulation;

		private readonly SettingUsage _referenceUsage;

		private readonly string _graphicsDeviceName;

		private bool _forceBalanceGrade;

		private bool _deviceGradeScoreLoaded;

		private const string PrefsSavedKey = "DeviceGradeScore.SavedKey";

		private const string PrefsSaveValue = "DeviceGradeScore.SavedValue.";

		private static readonly string[] PrefsScoreKeys = new string[5]
		{
			string.Format("{0}.{1}", "DeviceGradeScore.SavedValue.", 0),
			string.Format("{0}.{1}", "DeviceGradeScore.SavedValue.", 1),
			string.Format("{0}.{1}", "DeviceGradeScore.SavedValue.", 2),
			string.Format("{0}.{1}", "DeviceGradeScore.SavedValue.", 3),
			string.Format("{0}.{1}", "DeviceGradeScore.SavedValue.", 4)
		};

		private const string PrefsPositionSaveValue = "DeviceGradePosition.SavedValue.";

		private static readonly string[] PrefsPositionKeys = new string[5]
		{
			string.Format("{0}{1}", "DeviceGradePosition.SavedValue.", 0),
			string.Format("{0}{1}", "DeviceGradePosition.SavedValue.", 1),
			string.Format("{0}{1}", "DeviceGradePosition.SavedValue.", 2),
			string.Format("{0}{1}", "DeviceGradePosition.SavedValue.", 3),
			string.Format("{0}{1}", "DeviceGradePosition.SavedValue.", 4)
		};

		private const string RequestApi = "gpu/model";

		private const string KeyData = "data";

		private const string KeyCode = "code";

		private const string KeyMessage = "message";

		private const string KeyPerfRating = "perf_rating";

		private const string KeyPosition = "pos";

		public DeviceGrade DeviceGrade { get; private set; }

		public Processor(GameSettingsProvider settingsProvider)
		{
			if (settingsProvider != null && settingsProvider.TryGetEditorDeviceGradeSimulation(out _referenceUsage, out _graphicsDeviceName))
			{
				_useEditorSimulation = true;
				return;
			}
			_referenceUsage = GetRuntimeReferenceUsage();
			_graphicsDeviceName = SystemInfo.graphicsDeviceName;
		}

		private string GetGPUNameParams()
		{
			string str = "Nvidia Geforce GTX 1660";
			string text = "Nvidia Geforce RTX 2060";
			string str2 = "NVIDIA GeForce RTX 3060";
			string str3 = "Nvidia Geforce RTX 4060";
			switch (_referenceUsage)
			{
			case SettingUsage.iOS:
				str = "Apple A15";
				text = "Apple A16";
				str2 = "Apple A17 Pro";
				str3 = "Apple A18 Pro";
				break;
			case SettingUsage.Android:
				str = "Adreno 640";
				text = "Adreno 650";
				str2 = "Adreno 740";
				str3 = "Adreno 750";
				break;
			}
			string text2 = _graphicsDeviceName;
			if (_useEditorSimulation && string.IsNullOrWhiteSpace(text2))
			{
				text2 = text;
				_forceBalanceGrade = true;
			}
			JSONObject jSONObject = new JSONObject(JSONObject.Type.OBJECT);
			JSONObject jSONObject2 = new JSONObject(JSONObject.Type.ARRAY);
			jSONObject2.Add(text2);
			jSONObject2.Add(str);
			jSONObject2.Add(text);
			jSONObject2.Add(str2);
			jSONObject2.Add(str3);
			jSONObject.AddField("gpus", jSONObject2);
			BBPresetProperties bBPresetProperties = BamBooSdk.getInstance().getBBPresetProperties();
			jSONObject.AddField("manufacture", bBPresetProperties.manufacture);
			jSONObject.AddField("device_model", bBPresetProperties.device_model);
			return jSONObject.ToString(pretty: false);
		}

		private static SettingUsage GetRuntimeReferenceUsage()
		{
			return SettingUsage.Android;
		}

		public IEnumerator LoadDeviceGradeScore(Action callback)
		{
			string gPUNameParams = GetGPUNameParams();
			byte[] bytes = Encoding.UTF8.GetBytes(gPUNameParams);
			string versionHash;
			using (MD5 mD = MD5.Create())
			{
				versionHash = BitConverter.ToString(mD.ComputeHash(bytes)).Replace("-", "").ToLowerInvariant();
			}
			if (_useEditorSimulation || !TryLoadDeviceGradeValuesFromPlayerPrefs(versionHash))
			{
				yield return LoadGradeScoreValueFromRemote(versionHash, bytes);
			}
			InitDeviceGrade();
			DebugLogDeviceGradeScore();
			yield return null;
			callback?.Invoke();
		}

		private void InitDeviceGrade()
		{
			DeviceGrade deviceGrade = ((!_deviceGradeScoreLoaded || _forceBalanceGrade || CurDevicePosition <= 0) ? DeviceGrade.Mid : ((CurDevicePosition <= LowGradeBasePosition) ? ((CurDevicePosition > MidGradeBasePosition) ? DeviceGrade.Mid : ((CurDevicePosition <= HighGradeBasePosition) ? DeviceGrade.Top : DeviceGrade.High)) : DeviceGrade.Low));
			DeviceGrade = deviceGrade;
		}

		private bool TryLoadDeviceGradeValuesFromPlayerPrefs(string versionHash)
		{
			if (PlayerPrefs.GetString("DeviceGradeScore.SavedKey", string.Empty) != versionHash)
			{
				return false;
			}
			for (int i = 0; i < PrefsScoreKeys.Length; i++)
			{
				if (!PlayerPrefs.HasKey(PrefsScoreKeys[i]) || !PlayerPrefs.HasKey(PrefsPositionKeys[i]))
				{
					return false;
				}
			}
			_deviceGradeScores[0] = PlayerPrefs.GetFloat(PrefsScoreKeys[0]);
			_deviceGradeScores[1] = PlayerPrefs.GetFloat(PrefsScoreKeys[1]);
			_deviceGradeScores[2] = PlayerPrefs.GetFloat(PrefsScoreKeys[2]);
			_deviceGradeScores[3] = PlayerPrefs.GetFloat(PrefsScoreKeys[3]);
			_deviceGradeScores[4] = PlayerPrefs.GetFloat(PrefsScoreKeys[4]);
			_deviceGradePositions[0] = PlayerPrefs.GetInt(PrefsPositionKeys[0]);
			_deviceGradePositions[1] = PlayerPrefs.GetInt(PrefsPositionKeys[1]);
			_deviceGradePositions[2] = PlayerPrefs.GetInt(PrefsPositionKeys[2]);
			_deviceGradePositions[3] = PlayerPrefs.GetInt(PrefsPositionKeys[3]);
			_deviceGradePositions[4] = PlayerPrefs.GetInt(PrefsPositionKeys[4]);
			_deviceGradeScoreLoaded = true;
			return true;
		}

		public void ResetApplicationGraphicGrade()
		{
			bool flag = !_deviceGradeScoreLoaded || _forceBalanceGrade || CurDevicePosition <= 0;
			CurrentGraphicPresetLevel = GetPlatformGraphicPresetLevel(_deviceGradePositions, flag);
			CurrentDeviceGrade = DeviceGrade;
			IsPCPlatform = _referenceUsage == SettingUsage.PC;
			if (LuminApplication.LogEnabled)
			{
				Debug.Log(flag ? $"设备名次无效或未提供模拟显卡名，当前平台画质档位回退为: {CurrentGraphicPresetLevel}" : $"当前平台画质档位为: {CurrentGraphicPresetLevel}");
			}
		}

		private GraphicPresetLevel GetPlatformGraphicPresetLevel(int[] positions, bool fallback)
		{
			if (_referenceUsage == SettingUsage.PC)
			{
				if (fallback)
				{
					return GraphicPresetLevel.BALANCE;
				}
				int num = positions[0];
				if (num > positions[2])
				{
					return GraphicPresetLevel.PERFER_PERFORMANCE;
				}
				if (num > positions[3])
				{
					return GraphicPresetLevel.BALANCE;
				}
				if (num <= positions[4])
				{
					return GraphicPresetLevel.BEST_GRAPHICS;
				}
				return GraphicPresetLevel.PERFER_GRAPHICS;
			}
			if (_referenceUsage == SettingUsage.Android)
			{
				if (fallback)
				{
					return GraphicPresetLevel.PERFER_PERFORMANCE;
				}
				int num2 = positions[0];
				if (num2 > positions[2])
				{
					return GraphicPresetLevel.BEST_PERFORMANCE;
				}
				if (num2 > positions[3])
				{
					return GraphicPresetLevel.PERFER_PERFORMANCE;
				}
				if (num2 <= positions[4])
				{
					return GraphicPresetLevel.PERFER_GRAPHICS;
				}
				return GraphicPresetLevel.BALANCE;
			}
			if (_referenceUsage == SettingUsage.iOS)
			{
				if (fallback)
				{
					return GraphicPresetLevel.PERFER_PERFORMANCE;
				}
				int num3 = positions[0];
				if (num3 > positions[1])
				{
					return GraphicPresetLevel.BEST_PERFORMANCE;
				}
				if (num3 > positions[2])
				{
					return GraphicPresetLevel.PERFER_PERFORMANCE;
				}
				if (num3 <= positions[3])
				{
					return GraphicPresetLevel.PERFER_GRAPHICS;
				}
				return GraphicPresetLevel.BALANCE;
			}
			return GraphicPresetLevel.BALANCE;
		}

		private void DebugLogDeviceGradeScore()
		{
			if (LuminApplication.LogEnabled)
			{
				if (_deviceGradeScoreLoaded)
				{
					Debug.Log($"设备分级数据加载成功，当前设备分级评分: {CurDeviceGradeRating}, 参照评分 => low:{LowGradeBaseRating}, mid:{MidGradeBaseRating}, high:{HighGradeBaseRating}, top:{TopGradeBaseRating}");
					Debug.Log($"设备分档名次加载成功，当前设备名次: {CurDevicePosition}, 参照名次 => low:{LowGradeBasePosition}, mid:{MidGradeBasePosition}, high:{HighGradeBasePosition}, top:{TopGradeBasePosition}");
				}
				else
				{
					Debug.Log("设备分级数据加载失败，无法获取当前设备分级评分和参照评分");
				}
			}
		}

		private IEnumerator LoadGradeScoreValueFromRemote(string versionHash, byte[] paramBytes)
		{
			using UnityWebRequest request = BambooSafeHttpRequest.Post(GMApi.BaseUrl + "/gpu/model");
			request.SetRequestHeader("Content-Type", "application/json");
			request.uploadHandler = new UploadHandlerRaw(paramBytes);
			request.downloadHandler = new DownloadHandlerBuffer();
			request.timeout = 30;
			yield return request.SendWebRequest();
			if (request.result == UnityWebRequest.Result.Success)
			{
				string jsonStr = Encoding.UTF8.GetString(request.downloadHandler.data);
				if (ReadDeviceGradeValues(jsonStr))
				{
					PlayerPrefs.SetString("DeviceGradeScore.SavedKey", versionHash);
					PlayerPrefs.SetFloat(PrefsScoreKeys[0], CurDeviceGradeRating);
					PlayerPrefs.SetFloat(PrefsScoreKeys[1], LowGradeBaseRating);
					PlayerPrefs.SetFloat(PrefsScoreKeys[2], MidGradeBaseRating);
					PlayerPrefs.SetFloat(PrefsScoreKeys[3], HighGradeBaseRating);
					PlayerPrefs.SetFloat(PrefsScoreKeys[4], TopGradeBaseRating);
					PlayerPrefs.SetInt(PrefsPositionKeys[0], CurDevicePosition);
					PlayerPrefs.SetInt(PrefsPositionKeys[1], LowGradeBasePosition);
					PlayerPrefs.SetInt(PrefsPositionKeys[2], MidGradeBasePosition);
					PlayerPrefs.SetInt(PrefsPositionKeys[3], HighGradeBasePosition);
					PlayerPrefs.SetInt(PrefsPositionKeys[4], TopGradeBasePosition);
					_deviceGradeScoreLoaded = true;
				}
			}
		}

		private bool ReadDeviceGradeValues(string jsonStr)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("开始解析设备分级返回数据: " + jsonStr);
			}
			if (!TryReadDeviceGradeValues(jsonStr, _deviceGradeScores, _deviceGradePositions, out var errorMessage))
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError("设备分级用数据分析异常: " + errorMessage);
				}
				return false;
			}
			_deviceGradeScoreLoaded = true;
			return true;
		}

		private static bool TryReadDeviceGradeValues(string jsonStr, float[] scores, int[] positions, out string errorMessage)
		{
			try
			{
				JSONClass asObject = JSON.Parse(jsonStr).AsObject;
				int asInt = ((JSONNode)asObject).get_Item("code").AsInt;
				if (asInt != 0)
				{
					errorMessage = ((JSONNode)asObject).get_Item("message")?.Value ?? $"接口返回错误码 {asInt}";
					return false;
				}
				JSONArray asArray = ((JSONNode)asObject).get_Item("data").AsArray;
				if (asArray == null || asArray.Count < scores.Length)
				{
					errorMessage = "接口返回的 GPU 评分数量不足。";
					return false;
				}
				scores[0] = ((JSONNode)asArray).get_Item(0).get_Item("perf_rating").AsFloat;
				scores[1] = ((JSONNode)asArray).get_Item(1).get_Item("perf_rating").AsFloat;
				scores[2] = ((JSONNode)asArray).get_Item(2).get_Item("perf_rating").AsFloat;
				scores[3] = ((JSONNode)asArray).get_Item(3).get_Item("perf_rating").AsFloat;
				scores[4] = ((JSONNode)asArray).get_Item(4).get_Item("perf_rating").AsFloat;
				for (int i = 0; i < positions.Length; i++)
				{
					positions[i] = ((JSONNode)asArray).get_Item(i).get_Item("pos").AsInt;
					if (positions[i] <= 0)
					{
						errorMessage = $"接口返回的设备名次无效（index:{i}）";
						return false;
					}
				}
				errorMessage = string.Empty;
				return true;
			}
			catch (Exception ex)
			{
				errorMessage = "解析 GPU 分档数据失败：" + ex.Message;
				return false;
			}
		}
	}

	private static float[] _deviceGradeScores = new float[5];

	private static int[] _deviceGradePositions = new int[5];

	private const int CurGradeScoreIndex = 0;

	private const int LowGradeScoreIndex = 1;

	private const int MidGradeScoreIndex = 2;

	private const int HigGradeScoreIndex = 3;

	private const int TopGradeScoreIndex = 4;

	private static bool _inProcessing;

	public static float CurDeviceGradeRating => _deviceGradeScores[0];

	public static float LowGradeBaseRating => _deviceGradeScores[1];

	public static float MidGradeBaseRating => _deviceGradeScores[2];

	public static float HighGradeBaseRating => _deviceGradeScores[3];

	public static float TopGradeBaseRating => _deviceGradeScores[4];

	public static int CurDevicePosition => _deviceGradePositions[0];

	public static int LowGradeBasePosition => _deviceGradePositions[1];

	public static int MidGradeBasePosition => _deviceGradePositions[2];

	public static int HighGradeBasePosition => _deviceGradePositions[3];

	public static int TopGradeBasePosition => _deviceGradePositions[4];

	public static GraphicPresetLevel CurrentGraphicPresetLevel { get; private set; } = GraphicPresetLevel.BALANCE;

	public static DeviceGrade CurrentDeviceGrade { get; private set; } = DeviceGrade.Mid;

	public static bool IsPCPlatform { get; private set; }

	public static void SetupDeviceGradeSetting(MonoBehaviour root, Action callback, GameSettingsProvider settingsProvider = null)
	{
		if (!_inProcessing)
		{
			_inProcessing = true;
			Processor processor = new Processor(settingsProvider);
			root.StartCoroutine(processor.LoadDeviceGradeScore(() =>
			{
				processor.ResetApplicationGraphicGrade();
				_inProcessing = false;
				callback?.Invoke();
			}));
		}
	}
}
