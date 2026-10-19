using System;
using System.Collections.Generic;
using UnityEngine.ResourceManagement.AsyncOperations;

namespace UnityEngine.Localization.PropertyVariants.TrackedObjects;

[Serializable]
[DisplayName("Rect Transform", null)]
[CustomTrackedObject(typeof(RectTransform), false)]
public class TrackedRectTransform : TrackedTransform
{
	private Vector3 m_AnchorPosToApply;

	private Vector2 m_AnchorMinToApply;

	private Vector2 m_AnchorMaxToApply;

	private Vector2 m_PivotToApply;

	private Vector2 m_SizeDeltaToApply;

	protected override void AddPropertyHandlers(Dictionary<string, Action<float>> handlers)
	{
		base.AddPropertyHandlers(handlers);
		handlers["m_AnchoredPosition.x"] = (float val) =>
		{
			m_AnchorPosToApply.x = val;
		};
		handlers["m_AnchoredPosition.y"] = (float val) =>
		{
			m_AnchorPosToApply.y = val;
		};
		handlers["m_AnchoredPosition.z"] = (float val) =>
		{
			m_AnchorPosToApply.z = val;
		};
		handlers["m_AnchorMin.x"] = (float val) =>
		{
			m_AnchorMinToApply.x = val;
		};
		handlers["m_AnchorMin.y"] = (float val) =>
		{
			m_AnchorMinToApply.y = val;
		};
		handlers["m_AnchorMax.x"] = (float val) =>
		{
			m_AnchorMaxToApply.x = val;
		};
		handlers["m_AnchorMax.y"] = (float val) =>
		{
			m_AnchorMaxToApply.y = val;
		};
		handlers["m_SizeDelta.x"] = (float val) =>
		{
			m_SizeDeltaToApply.x = val;
		};
		handlers["m_SizeDelta.y"] = (float val) =>
		{
			m_SizeDeltaToApply.y = val;
		};
		handlers["m_Pivot.x"] = (float val) =>
		{
			m_PivotToApply.x = val;
		};
		handlers["m_Pivot.y"] = (float val) =>
		{
			m_PivotToApply.y = val;
		};
	}

	public override AsyncOperationHandle ApplyLocale(Locale variantLocale, Locale defaultLocale)
	{
		RectTransform rectTransform = (RectTransform)Target;
		m_AnchorPosToApply = rectTransform.anchoredPosition3D;
		m_AnchorMinToApply = rectTransform.anchorMin;
		m_AnchorMaxToApply = rectTransform.anchorMax;
		m_PivotToApply = rectTransform.pivot;
		m_SizeDeltaToApply = rectTransform.sizeDelta;
		base.ApplyLocale(variantLocale, defaultLocale);
		rectTransform.anchoredPosition3D = m_AnchorPosToApply;
		rectTransform.anchorMin = m_AnchorMinToApply;
		rectTransform.anchorMax = m_AnchorMaxToApply;
		rectTransform.pivot = m_PivotToApply;
		rectTransform.sizeDelta = m_SizeDeltaToApply;
		return default;
	}
}
