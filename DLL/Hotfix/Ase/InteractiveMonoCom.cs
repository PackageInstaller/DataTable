using Ase.ECS;
using Sirenix.OdinInspector;

namespace Ase;

public class InteractiveMonoCom : SerializedMonoBehaviour, IMathTriggerEventHandler
{
	private InteractiveStateChecker interactiveStateChecker;

	protected BaseEntity entity;

	protected void ActiveInteractive(string interName, float interactiveTime = 1f)
	{
		interactiveStateChecker = new InteractiveStateChecker(int.MaxValue, interactiveTime, 4003, "interactiveIcon_3", interName, InteractiveStartCallback, InteractiveFinishCallback, InteractiveCloseCallback);
	}

	public virtual void InteractiveCloseCallback(int obj)
	{
	}

	public virtual void InteractiveFinishCallback(int obj)
	{
	}

	public virtual void InteractiveStartCallback(int obj)
	{
	}

	public virtual void OnMathTriggerStay(MathTriggerEventData eventData)
	{
		if (eventData.Other.TryGetComponent<EntityView>(out var component) && component.Entity != null && component.Entity.IsActorEntity && !component.Entity.GetComponent<HeroInteractiveComponent>().ContanisInteractiveChecker(interactiveStateChecker) && component.Entity.GetComponent<HeroInteractiveComponent>().CheckCanInteractiving())
		{
			entity = component.Entity;
			entity.GetComponent<HeroInteractiveComponent>().ShowInterctiveIcon(interactiveStateChecker);
		}
	}

	public virtual void OnMathTriggerExit(MathTriggerEventData eventData)
	{
		if (eventData.Other.TryGetComponent<EntityView>(out var component) && component.Entity != null && component.Entity.IsActorEntity && entity == component.Entity && entity.GetComponent<HeroInteractiveComponent>().ContanisInteractiveChecker(interactiveStateChecker))
		{
			entity.GetComponent<HeroInteractiveComponent>().RemoveInteractive(interactiveStateChecker);
		}
	}

	public virtual void OnMathTriggerEnter(MathTriggerEventData eventData)
	{
	}
}
