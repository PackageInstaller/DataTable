using ACT.BluePrint;
using ACT.Model;
using UnityEngine;

namespace ACT.Config.Action;

public class CreateTriggerField : GuideStepAction, IActionUninit
{
	[SerializeReference]
	public TriggerData _triggerData;

	private BPTriggerField triggerField;

	private GuideStepData stepData;

	public override void Execute(GuideStepData data)
	{
		CreateTrigger(data);
		stepData = data;
	}

	public void UnInit()
	{
		if (triggerField != null)
		{
			Object.Destroy(triggerField.gameObject);
			triggerField = null;
		}
		if (stepData != null)
		{
			stepData = null;
		}
	}

	public void CreateTrigger(GuideStepData data)
	{
		GameObject gameObject = new GameObject();
		gameObject.transform.position = _triggerData.center;
		gameObject.layer = 0;
		BoxCollider boxCollider = gameObject.AddComponent<BoxCollider>();
		boxCollider.size = _triggerData.size;
		boxCollider.isTrigger = true;
		BPTriggerField bPTriggerField = gameObject.AddComponent<BPTriggerField>();
		bPTriggerField.triggerName = _triggerData.name;
		bPTriggerField.onEnter = OnBPTriggerEnter;
		bPTriggerField.onExit = OnBPTriggerExit;
		triggerField = bPTriggerField;
	}

	private void OnBPTriggerEnter(string name)
	{
		stepData.OnFinish();
	}

	private void OnBPTriggerExit(string name)
	{
	}
}
