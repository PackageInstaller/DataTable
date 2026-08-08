using UnityEngine;
using UnityEngine.UI;

public class QTEUINode_Drag_Behaviour : QTEUINodeBehaviour
{
	public Vector2 dragDir;

	public string label;

	public float timeLimit;

	public override void CreateUI()
	{
		base.CreateUI();
		if (_ui != null)
		{
			GameObject goFromCfg = _ui.GetGoFromCfg("_text");
			if (goFromCfg != null)
			{
				goFromCfg.GetComponent<Text>().text = label;
			}
		}
	}

	public override void RegisterUIEvent()
	{
		base.RegisterUIEvent();
		P08StoryQTEDrag component = _ui.GetComponent<P08StoryQTEDrag>();
		if (!(component == null))
		{
			component.Init(timeLimit, dragDir, delegate
			{
				OnSuccess();
			}, delegate
			{
				OnFailed();
			});
		}
	}

	public override void UpdateUIPos()
	{
		base.UpdateUIPos();
	}
}
