using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Core;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/InteractDamageable")]
public class InteractDamageable : StateObjectBase
{
	[NonSerialized]
	[HideInInspector]
	public string address;

	[NonSerialized]
	public int[] attacksList;

	[NonSerialized]
	public bool lastKeep;

	private List<Transform> childs = new List<Transform>();

	private int m_Hits;

	private int m_Stage;

	private AssetLoadHandle m_Handle;

	private Entity eb;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		m_Handle = AssetStationManager.BattleStation.Instantiate("StateObjectBehave/" + address, transform);
		base.InitStateObject(stateId);
	}

	public override void ReleaseStateObject()
	{
		AssetStationManager.BattleStation.ReleaseInstance(m_Handle);
		if (currentStateId == 0)
		{
			MonoECS.instance.TryRemoveBehave(eb);
		}
		m_Hits = 0;
		m_Stage = 0;
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
	}

	protected override void HandleEnterInteract()
	{
	}

	protected override void HandleExitInteract()
	{
	}

	protected override void HandleInitState(int stateId)
	{
		GameObject gameObject = m_Handle.AsGameObject();
		if (currentStateId == 0)
		{
			for (int i = 0; i < gameObject.transform.childCount; i++)
			{
				Transform child = gameObject.transform.GetChild(i);
				childs.Add(child);
				if (i == 0)
				{
					child.gameObject.SetActive(value: true);
				}
				else
				{
					child.gameObject.SetActive(value: false);
				}
			}
			MonoECS instance = MonoECS.instance;
			if (entity.GetCompStateObject()?.StateWorldAssetData is DamageableData data)
			{
				CoSpawnAttackInteractObject(instance, data);
			}
			return;
		}
		for (int j = 0; j < gameObject.transform.childCount; j++)
		{
			if (j == gameObject.transform.childCount - 1)
			{
				EndStage(gameObject.transform.GetChild(j).gameObject.transform);
			}
			else
			{
				gameObject.transform.GetChild(j).gameObject.SetActive(value: false);
			}
		}
	}

	private void CoSpawnAttackInteractObject(MonoECS m_ECS, DamageableData data)
	{
		Entity entity = (eb = GameManager.entities.factory.CreateAttackEntity());
		entity.GetCompStateObject().StateWorldAssetData = data;
		NumberPropertyProvider numberPropertyProvider = NumberPropertyProvider.s_Pool.Get();
		numberPropertyProvider.constValue = 10000f;
		CompAbility? compAbility = entity.GetCompAbility();
		compAbility.GetProperty(1u).PushSubValue(PropertySub.Add, numberPropertyProvider, needCal: true);
		compAbility.onHPChange += new Action<int, int>(GetHit);
	}

	private void GetHit(int hp, int newValue)
	{
		m_Hits++;
		if (m_Hits == attacksList[m_Stage])
		{
			m_Hits = 0;
			m_Stage++;
			if (m_Stage == attacksList.Length)
			{
				MonoECS.instance.TryRemoveBehave(eb);
				NetEnterState(-1).Forget();
			}
			else
			{
				NextStage(m_Stage);
			}
		}
	}

	private void NextStage(int stage)
	{
		childs[stage - 1].gameObject.SetActive(value: false);
		childs[stage].gameObject.SetActive(value: true);
	}

	private void EndStage(Transform lastGO)
	{
		m_Handle.AsGameObject().transform.GetComponent<BoxCollider>().enabled = false;
		if (!lastKeep)
		{
			lastGO.gameObject.SetActive(value: false);
		}
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (-2 <= stateId)
		{
			return stateId <= 0;
		}
		return false;
	}
}
