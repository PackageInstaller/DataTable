using System;
using System.Collections.Generic;
using ACT.World.Asset;
using ACT.World.Condition;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;

namespace ACT.World.StateObject;

public interface ICommonInteractEntrySetting
{
	int StateInteractCount { get; set; }

	int InteractCount { get; set; }

	bool TriggerExiting { get; set; }

	List<BaseCondition> Conditions { get; }

	int StateId { get; }

	int EntryIndex { get; }

	bool Interactable { get; }

	bool InteractOnce { get; }

	InteractTerminal Terminal { get; }

	bool ConditionPassed { get; set; }

	bool TipConditionPassed { get; set; }

	Action<Entity> onInteract { get; set; }

	Func<Entity, UniTask> onInteractAsync { get; set; }

	Entity EntityReference { get; }

	StateWorldAssetData Data { get; }

	InteractActionList InteractActionList { get; }

	IDisposable TriggerStatDisposable { get; set; }

	bool EnterState { get; set; }

	ShowType ShowType { get; set; }
}
