using System;
using TMPro;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.UI;

namespace ACT;

public class GraphicPerformanceCalc : MonoBehaviour
{
	[Serializable]
	private struct PercentColorDefine
	{
		[SerializeField]
		private LocalizedString _labelText;

		[SerializeField]
		[Range(0f, 1f)]
		private float _from;

		[SerializeField]
		[Range(0f, 1f)]
		private float _to;

		[SerializeField]
		private Color _color;

		public float From => _from;

		public float To => _to;

		public Color Color => _color;

		public LocalizedString LabelText => _labelText;
	}

	[SerializeField]
	private TMP_Text _performanceDesc;

	[SerializeField]
	private RectTransform _performanceArea;

	[SerializeField]
	private Image _performanceBar;

	[SerializeField]
	private PercentColorDefine[] _percentColorDefines;

	private void OnEnable()
	{
		SettingsManager.Instance.RuntimeSettings.PerformanceLoadChanged += OnPerformanceLoadChanged;
		if (SettingsManager.Instance.RuntimeSettings.TryGetPerformanceLoad(out var performanceLoad))
		{
			OnPerformanceLoadChanged(performanceLoad);
		}
	}

	private void OnDisable()
	{
		SettingsManager.Instance.RuntimeSettings.PerformanceLoadChanged -= OnPerformanceLoadChanged;
	}

	private void OnPerformanceLoadChanged(GraphicPerformanceLoad perfLoad)
	{
		SetPercent(perfLoad.NormalizedLoad);
	}

	public void SetPercent(float normalizedPercent)
	{
		normalizedPercent = Mathf.Clamp01(normalizedPercent);
		UpdateBarFillAmount(normalizedPercent);
		if (TryGetPercentColorDefine(normalizedPercent, out var result))
		{
			if (_performanceBar != null)
			{
				_performanceBar.color = result.Color;
			}
			if (_performanceDesc != null)
			{
				_performanceDesc.text = result.LabelText?.GetLocalizedString() ?? string.Empty;
			}
		}
	}

	private void UpdateBarFillAmount(float normalizedPercent)
	{
		if (!(_performanceArea == null) && !(_performanceBar == null))
		{
			RectTransform rectTransform = _performanceBar.rectTransform;
			if (rectTransform.parent == _performanceArea)
			{
				Vector2 anchorMin = rectTransform.anchorMin;
				Vector2 anchorMax = rectTransform.anchorMax;
				anchorMin.x = 0f;
				anchorMax.x = 1f;
				rectTransform.anchorMin = anchorMin;
				rectTransform.anchorMax = anchorMax;
				Vector2 offsetMin = rectTransform.offsetMin;
				Vector2 offsetMax = rectTransform.offsetMax;
				offsetMin.x = 0f;
				offsetMax.x = 0f;
				rectTransform.offsetMin = offsetMin;
				rectTransform.offsetMax = offsetMax;
			}
			_performanceBar.fillAmount = normalizedPercent;
		}
	}

	private bool TryGetPercentColorDefine(float normalizedPercent, out PercentColorDefine result)
	{
		result = default;
		if (_percentColorDefines == null || _percentColorDefines.Length == 0)
		{
			return false;
		}
		bool result2 = false;
		float num = float.NegativeInfinity;
		PercentColorDefine[] percentColorDefines = _percentColorDefines;
		for (int i = 0; i < percentColorDefines.Length; i++)
		{
			PercentColorDefine percentColorDefine = percentColorDefines[i];
			float num2 = Mathf.Clamp01(percentColorDefine.From);
			float num3 = Mathf.Clamp01(percentColorDefine.To);
			if (!(num2 > num3) && normalizedPercent >= num2 && (normalizedPercent < num3 || (Mathf.Approximately(normalizedPercent, 1f) && Mathf.Approximately(num3, 1f))) && !(num2 < num))
			{
				result = percentColorDefine;
				num = num2;
				result2 = true;
			}
		}
		return result2;
	}
}
