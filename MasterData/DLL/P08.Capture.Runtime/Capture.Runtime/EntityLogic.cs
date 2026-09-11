using System.Collections.Generic;

namespace Capture.Runtime;

public class EntityLogic : CaptureLogicBase
{
	private List<BehaviourBase> behaviours;

	public override void Dispose()
	{
		LuaHelper.CallFunction("CaptureGameBridge.EntityLogicStop");
	}

	public override void Execute()
	{
	}

	public override void LateUpdate()
	{
		foreach (BehaviourBase behaviour in behaviours)
		{
			behaviour.ExecuteBehaviour();
		}
	}

	public override void Init()
	{
		LuaHelper.CallFunction("CaptureGameBridge.EntityLogicStart");
		behaviours = new List<BehaviourBase>();
		AddBehaviour();
	}

	private void AddBehaviour()
	{
		if (!base.context.isFreeCapture)
		{
			behaviours.Add(new OBBBehaviour());
			behaviours.Add(new OnScreenBehaviour());
			if (base.context.CheckIsSingleMode())
			{
				behaviours.Add(new OcculusionBehaviour());
			}
		}
	}
}
