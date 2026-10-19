using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class MonoUIEffectActiveSensor : MonoBehaviour
{
	private CanvasGroup _canvasGroup;

	private bool _lastBattleMainActive;

	private void Awake()
	{
		_canvasGroup = GetComponent<CanvasGroup>();
	}

	private void Update()
	{
		IBaseUIController topActivePanel = Singleton<NewUIManager>.instance.GetTopActivePanel();
		bool flag = topActivePanel != null && topActivePanel.UIType == UI_TYPE.UI_BATTLEMAIN;
		if (flag != _lastBattleMainActive)
		{
			_canvasGroup.alpha = (flag ? 1 : 0);
			_lastBattleMainActive = flag;
		}
	}
}
