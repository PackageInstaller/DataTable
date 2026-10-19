using UnityEngine;

namespace ACT;

public class GraphicPanelContentControl : MonoBehaviour
{
	public enum GraphicPanelContentMode
	{
		SHOW_PERFORMANCE_BAR,
		HIDE_PERFORMANCE_BAR
	}

	[SerializeField]
	private GameObject _performanceBarNode;

	[SerializeField]
	private RectTransform _graphicSettingView;

	[SerializeField]
	[HideInInspector]
	private bool _performanceBarVisible = true;

	private const int ShowPerformanceBarGap = 98;

	private const int HidePerformanceBarGap = 0;

	public bool PerformanceBarVisible => _performanceBarVisible;

	public void SetPerformanceBarVisible(bool value)
	{
		if (_performanceBarVisible != value)
		{
			_performanceBarVisible = value;
			_performanceBarNode?.gameObject?.SetActive(value);
			int num = (value ? 98 : 0);
			if (!(_graphicSettingView == null))
			{
				Vector2 offsetMax = _graphicSettingView.offsetMax;
				offsetMax.y = -num;
				_graphicSettingView.offsetMax = offsetMax;
			}
		}
	}
}
