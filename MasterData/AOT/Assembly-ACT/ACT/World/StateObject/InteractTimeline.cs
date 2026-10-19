using System;
using ACT.Battle;
using ACT.Drama;
using ACT.World.Asset;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.StateObject;

public class InteractTimeline : InteractObject
{
	public string[] abilities;

	public bool useLocalPos = true;

	protected YooAssetReference m_AssetReferenceAssetID;

	public override void InitStateObject(int stateId)
	{
		if (entity.GetCompStateObject()?.StateWorldAssetData is TimelineData timelineData)
		{
			m_AssetReferenceAssetID = timelineData.timelineAssetAssetID;
			base.InitStateObject(stateId);
		}
	}

	protected override void HandleInitState(int stateId)
	{
		if (currentState == null)
		{
			return;
		}
		base.HandleInitState(stateId);
		if (stateId != 0)
		{
			return;
		}
		foreach (InteractEntry interactEntry in currentState.interactEntries)
		{
			interactEntry.onInteractAsync = (Func<Entity, UniTask>)Delegate.Combine(interactEntry.onInteractAsync, new Func<Entity, UniTask>(PlayTimelineAsync));
		}
	}

	protected override void HandleUninitState(int stateId)
	{
		if (currentState == null)
		{
			return;
		}
		base.HandleUninitState(stateId);
		if (stateId != 0)
		{
			return;
		}
		foreach (InteractEntry interactEntry in currentState.interactEntries)
		{
			interactEntry.onInteractAsync = (Func<Entity, UniTask>)Delegate.Remove(interactEntry.onInteractAsync, new Func<Entity, UniTask>(PlayTimelineAsync));
		}
	}

	private async UniTask PlayTimelineAsync(Entity entityBehave)
	{
		CompAbility compAbility = entityBehave.GetCompAbility();
		compAbility.AddAbilities(abilities, AbilitySource.Ability);
		Vector3 position = (useLocalPos ? transform.position : Vector3.zero);
		await Singleton<TimelineConversationManager>.instance.PlayTimeline(m_AssetReferenceAssetID, position);
		string[] array = abilities;
		foreach (string text in array)
		{
			compAbility.RemoveAbility(text);
		}
	}
}
