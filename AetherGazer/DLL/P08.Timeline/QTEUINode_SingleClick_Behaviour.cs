using UnityEngine.UI;
using YS.CustomTimelineTrack;

public class QTEUINode_SingleClick_Behaviour : QTEUINodeBehaviour
{
	public override void CreateUI()
	{
		base.CreateUI();
	}

	public override void RegisterUIEvent()
	{
		base.RegisterUIEvent();
		Button btn = _ui.GetComponent<Button>();
		if (!(btn == null))
		{
			btn.onClick.AddListener(delegate
			{
				btn.onClick.RemoveAllListeners();
				OnClick();
			});
		}
	}

	private void OnClick()
	{
		QTEContext.GetInstance().clickCount = 1;
		OnSuccess();
	}
}
