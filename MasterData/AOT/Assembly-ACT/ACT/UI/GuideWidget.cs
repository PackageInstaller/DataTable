using ACT.Event;
using ACT.Model;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public abstract class GuideWidget : UIBehaviour
{
	public int _stepId;

	public abstract void Init(GuideStepData stepData);

	public virtual void UnInit()
	{
		Object.Destroy(gameObject);
	}

	public virtual void StepFinish()
	{
		GuideStepFinishEvt evt = Singleton<EventManager>.instance.GetEvt<GuideStepFinishEvt>();
		evt.stepId = _stepId;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Guide_StepFinish, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	protected virtual void StepFinishInError()
	{
		GuideStepFinishEvt evt = Singleton<EventManager>.instance.GetEvt<GuideStepFinishEvt>();
		evt.Iserror = true;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Guide_StepFinish, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}
}
