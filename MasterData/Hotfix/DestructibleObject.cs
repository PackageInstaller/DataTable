using System.Collections.Generic;
using System.Linq;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;
using UnityEngine.Playables;

[RequireComponent(typeof(PlayableDirector))]
public class DestructibleObject : LogicEntity
{
	public int configID;

	public DestructibleStateSingle[] stepDatas;

	public GameObject spawnFx;

	public bool LockHp;

	public bool behitBoom;

	public bool clearDes;

	public int boomId;

	public FP clearRange;

	public GameObject cleaFx;

	public float fxScale = 1f;

	protected FP aniDurotion;

	protected int lifeStep;

	private List<DestructibleStateSingle> curStepDatas;

	public bool beKill { get; private set; }

	protected override void OnInit()
	{
		lifeStep = 0;
		beKill = false;
		curStepDatas = stepDatas.OrderByDescending((DestructibleStateSingle item) => item._minHpPercent).ToList();
		for (int num = 0; num < curStepDatas.Count; num++)
		{
			curStepDatas.get_Item(num).InitData(configID, this);
			curStepDatas.get_Item(num).SetActiveSate(lifeStep == num);
		}
	}

	public void OnKill()
	{
		beKill = true;
	}

	public void CheckBeHitClear()
	{
		if (!behitBoom || beKill || lifeStep >= curStepDatas.Count)
		{
			return;
		}
		if (cleaFx != null)
		{
			AdventureFXPlayer.PlayFX(cleaFx, 1f, transform.position, Quaternion.identity, fxScale);
		}
		if (clearRange <= 0)
		{
			return;
		}
		List<DeterministicCollider> list = new List<DeterministicCollider>();
		int layerMask = 65792;
		SceneSingleton<DeterministicCollisionManager>.Instance.CheckCircleOverlap(clearRange, tsTransform.Position, list, layerMask);
		if (list.Count <= 0)
		{
			return;
		}
		LogicEntity logicEntity = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		if (logicEntity == null)
		{
			logicEntity = SceneSingleton<AdventurePlayerController>.Instance.dynamicActor;
		}
		for (int i = 0; i < list.Count; i++)
		{
			DestructibleStateSingle component = list.get_Item(i).GetComponent<DestructibleStateSingle>();
			if (clearDes && component != null)
			{
				component.OnKill();
			}
			else if (boomId > 0)
			{
				AdventureActor component2 = list.get_Item(i).GetComponent<AdventureActor>();
				if (component2 != null && logicEntity is AdventureActor actor)
				{
					ILRuntimeAPI.HitActor(actor, component2, boomId);
				}
			}
		}
	}

	protected override void OnActive()
	{
		lifeStep = 0;
		EnableLogicUpdate();
	}

	public void FixHp(long fixedHp)
	{
		for (int i = 0; i < curStepDatas.Count; i++)
		{
			curStepDatas.get_Item(i).FixHp(fixedHp);
		}
		if (!LockHp)
		{
			CheckLife();
		}
	}

	private void CheckLifeStep()
	{
		for (int i = 0; i < curStepDatas.Count; i++)
		{
			curStepDatas.get_Item(i).SetActiveSate(lifeStep == i);
		}
	}

	private void CheckLife()
	{
		if (curStepDatas.Count <= lifeStep)
		{
			ActiveSelf = false;
		}
		else if (beKill || (!curStepDatas.get_Item(lifeStep).IsCurrentState() && !curStepDatas.get_Item(lifeStep).forbbeddenBeHurt))
		{
			curStepDatas.get_Item(lifeStep).OnTriggerFx();
			lifeStep++;
			CheckLifeStep();
		}
	}

	protected override void OnLogicUpdate()
	{
		CheckLife();
	}

	protected override void OnDeactive()
	{
		AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
		if (!(instance == null))
		{
			AdventureLevelState adventureLevelState = instance.adventureLevelState;
			if (adventureLevelState != AdventureLevelState.LevelEnd && adventureLevelState != AdventureLevelState.Finish && !instance.isUnloadingLevel)
			{
				DestructibleObjectBeDestoryEvent destructibleObjectBeDestoryEvent = DestructibleObjectBeDestoryEvent.Generate();
				destructibleObjectBeDestoryEvent.configID = configID;
				destructibleObjectBeDestoryEvent.pos = tsTransform.Position;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(destructibleObjectBeDestoryEvent);
			}
		}
	}

	private void RefrshConditions()
	{
	}
}
