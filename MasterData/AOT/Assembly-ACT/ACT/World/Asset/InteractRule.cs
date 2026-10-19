using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Event;
using ACT.Game;

namespace ACT.World.Asset;

[Serializable]
public class InteractRule : IDataToBake
{
	public MonoDataRef<InteractEventBaker, IInteractEvent> @event = new MonoDataRef<InteractEventBaker, IInteractEvent>();

	public List<MonoDataRef<InteractVerificationBaker, IInteractVerification>> verifications = new List<MonoDataRef<InteractVerificationBaker, IInteractVerification>>();

	public List<MonoDataRef<ServiceActionBaker, IServiceAction>> actions = new List<MonoDataRef<ServiceActionBaker, IServiceAction>>();

	public void Bake(object baker)
	{
	}

	public void ApplyConfig(IRuleManager ruleManager)
	{
		foreach (int item in @event.data.checkedSwid)
		{
			if (item != int.MinValue)
			{
				ruleManager.AddEventListener(@event.data.clientEvent, item, OnEvent);
			}
		}
	}

	public void RemoveConfig(IRuleManager ruleManager)
	{
		foreach (int item in @event.data.checkedSwid)
		{
			if (item != int.MinValue)
			{
				ruleManager.RemoveEventListener(@event.data.clientEvent, item, OnEvent);
			}
		}
	}

	private InteractRuleResult PeekResult(IRuleManager ruleManager, LocalStateWorldEvent eventContent)
	{
		InteractRuleResult result = default;
		if (@event.data is OnCustomInteract onCustomInteract && onCustomInteract.eventName != eventContent.eventName)
		{
			return result;
		}
		result.isLegal = true;
		foreach (MonoDataRef<InteractVerificationBaker, IInteractVerification> verification in verifications)
		{
			if (!verification.data.Verify(ruleManager, eventContent))
			{
				return result;
			}
		}
		result.isVerified = true;
		return result;
	}

	private InteractRuleResult OnEvent(LocalStateWorldEvent eventContent)
	{
		RuleManager ruleManager = MonoECS.instance.ruleManager;
		InteractRuleResult result = PeekResult(ruleManager, eventContent);
		if (result.isVerified && G.service is LocalGameService)
		{
			foreach (MonoDataRef<ServiceActionBaker, IServiceAction> action in actions)
			{
				action.data.Do(ruleManager, eventContent);
			}
		}
		return result;
	}
}
