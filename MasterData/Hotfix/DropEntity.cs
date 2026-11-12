using System.Collections.Generic;
using DG.Tweening;
using TrueSync;
using UnityEngine;

[AddComponentMenu("Game/Adventure/Drops/掉落物")]
public class DropEntity : LogicEntity
{
	public enum DropObjType
	{
		[InspectorName("普通模式")]
		normal = 1,
		[InspectorName("吸血鬼模式")]
		vampire,
		[InspectorName("打砖块模式")]
		brick,
		[InspectorName("共斗模式")]
		traceHunt
	}

	public enum DropBornShow
	{
		[InspectorName("弹出")]
		popUp = 1,
		[InspectorName("特效生成")]
		flashShow
	}

	public enum DropAdsorptionType
	{
		[InspectorName("目标位置(坐标)")]
		TargetPosition = 1,
		[InspectorName("目标挂点")]
		TargetSlot
	}

	public DropObjType doType = DropObjType.normal;

	public string dropTag;

	public int sameMaxCount;

	public DropBornShow dbShow = DropBornShow.popUp;

	public float minDropDis;

	public float maxDropDis;

	public GameObject idleFx;

	public bool isColliderAdaptive;

	public float adsorptionRange;

	public FP adsorptionRangeFP;

	public DropAdsorptionType dropAdsorptionType = DropAdsorptionType.TargetPosition;

	public AnimationSlotConfigComponent.SlotType adsorptionSlotType = AnimationSlotConfigComponent.SlotType.Root;

	public FP maxDuration;

	public FP delayAdsorptionTime;

	public float flyToActorSpeed = 10f;

	public FP flyToActorAcceleration = 2.5f;

	public GameObject flyToActorFx;

	public int[] effectIds;

	public int buffId;

	public GameObject takeEffectFx;

	[HideInInspector]
	public string prefabName;

	[HideInInspector]
	public Transform cTrans;

	[HideInInspector]
	public bool isBornEnd;

	[HideInInspector]
	public bool isCanFlyToActor;

	[HideInInspector]
	public bool isDelayAdsorptionEnd;

	[HideInInspector]
	public FP _leftTime;

	[HideInInspector]
	public FP _bornTime;

	[HideInInspector]
	public FP _delayAdsorption;

	[HideInInspector]
	public bool isFlyEnd;

	[HideInInspector]
	public bool isFlyStart;

	[HideInInspector]
	public FP _endFxTime;

	[HideInInspector]
	public FP _flySpeed;

	[HideInInspector]
	public Vector3 _spawnPos;

	private List<int> _targetDataIdList;

	private Dictionary<long, AdventureActor> _targetList;

	private AdventureActor _currentTarget;

	[HideInInspector]
	public AdventureActor owner { get; protected set; }

	[HideInInspector]
	public AdventureFXPlayer fxPlayer { get; protected set; }

	public bool PickByTarget { get; set; }

	protected override void OnActive()
	{
		base.OnActive();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_SPAWN", OnActorSpawn);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
	}

	public virtual void Setup(AdventureActor owner, string pName, Vector3 spawnPos)
	{
		this.owner = owner;
		prefabName = pName;
		_leftTime = maxDuration;
		_delayAdsorption = delayAdsorptionTime;
		_flySpeed = FP.FromConfigFloat(flyToActorSpeed);
		_spawnPos = spawnPos;
		_bornTime = 0.8;
		PickByTarget = false;
		adsorptionRangeFP = FP.FromConfigFloat(adsorptionRange);
		bornShow();
		AdventureDropBeginEvent adventureDropBeginEvent = AdventureDropBeginEvent.Generate();
		adventureDropBeginEvent.sender = this;
		adventureDropBeginEvent.entityID = Id;
		adventureDropBeginEvent.dropTag = dropTag;
		adventureDropBeginEvent.owner = owner;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureDropBeginEvent);
		EnableLogicUpdate();
	}

	private void OnActorSpawn(IEvent evt)
	{
		if (!(evt is AdventurActorSpawned { sender: AdventureActor sender }))
		{
			return;
		}
		List<int> targetDataIdList = _targetDataIdList;
		if (targetDataIdList != null && targetDataIdList.Count > 0 && _targetDataIdList.Contains(sender.dataID))
		{
			if (_targetList == null)
			{
				_targetList = new Dictionary<long, AdventureActor>(5);
			}
			_targetList.TryAdd(sender.Id, sender);
		}
	}

	private void OnActorDied(IEvent evt)
	{
		if (evt is AdventureActorDiedEvent { sender: AdventureActor sender })
		{
			List<int> targetDataIdList = _targetDataIdList;
			if (targetDataIdList != null && targetDataIdList.Count > 0 && _targetDataIdList.Contains(sender.dataID))
			{
				_targetList?.Remove(sender.Id);
			}
		}
	}

	internal virtual bool CheckTargetDistance(out AdventureActor target)
	{
		target = null;
		if (PickByTarget)
		{
			Dictionary<long, AdventureActor> targetList = _targetList;
			if (targetList != null && targetList.Count > 0)
			{
				foreach (AdventureActor value in _targetList.Values)
				{
					if (TSVector2.Distance(value.tsTransform.Position, tsTransform.Position) < adsorptionRangeFP)
					{
						target = value;
						return true;
					}
				}
			}
		}
		else
		{
			AdventureActor adventureActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as AdventureActor;
			if (TSVector2.Distance(adventureActor.tsTransform.Position, tsTransform.Position) < adsorptionRangeFP)
			{
				target = adventureActor;
				return true;
			}
		}
		return false;
	}

	public virtual void bornShow()
	{
		if (dbShow == DropBornShow.popUp)
		{
			if (idleFx != null)
			{
				if (cTrans == null)
				{
					cTrans = transform;
				}
				fxPlayer = AdventureFXPlayer.PlayFX(idleFx, 1f, cTrans.position, cTrans.rotation);
				cTrans.transform.DOJump(_spawnPos, 3f, 1, 0.8f);
			}
			return;
		}
		if (idleFx != null)
		{
			if (cTrans == null)
			{
				cTrans = transform;
			}
			fxPlayer = AdventureFXPlayer.PlayFX(idleFx, 1f, cTrans.position, cTrans.rotation);
		}
		isBornEnd = true;
	}

	public virtual void Finish(bool isPick = false)
	{
		if (!ActiveSelf)
		{
			return;
		}
		if (isPick)
		{
			AdventureActor currentTarget = _currentTarget;
			if ((object)currentTarget != null)
			{
				if (buffId != 0)
				{
					currentTarget.buffComponent?.AddBuff(buffId, owner);
				}
				if (effectIds != null && effectIds.Length != 0)
				{
					for (int i = 0; i < effectIds.Length; i++)
					{
						currentTarget.effectManage?.AddEffectByBuff(effectIds[i], owner);
					}
				}
			}
			if (fxPlayer != null)
			{
				fxPlayer.Stop();
			}
			fxPlayer = null;
		}
		AdventureDropFinishEvent adventureDropFinishEvent = AdventureDropFinishEvent.Generate();
		adventureDropFinishEvent.sender = this;
		adventureDropFinishEvent.entityID = Id;
		adventureDropFinishEvent.dropTag = dropTag;
		adventureDropFinishEvent.owner = owner;
		adventureDropFinishEvent.target = _currentTarget;
		adventureDropFinishEvent.isPickUp = isPick;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureDropFinishEvent);
		ActiveSelf = false;
	}

	internal void SetFlyToActor(AdventureActor target)
	{
		isCanFlyToActor = true;
		_currentTarget = target;
	}

	protected virtual void OnFlyStart()
	{
		if (!(flyToActorFx == null) && !(cTrans == null))
		{
			if (fxPlayer != null)
			{
				fxPlayer.Stop();
			}
			fxPlayer = AdventureFXPlayer.PlayFX(flyToActorFx, 1f, cTrans.position, cTrans.rotation);
		}
	}

	public void SetTargetDataId(List<int> dataIdList)
	{
		if (dataIdList != null && dataIdList.Count > 0)
		{
			if (_targetDataIdList == null)
			{
				_targetDataIdList = new List<int>(5);
			}
			_targetDataIdList.AddRange(dataIdList);
		}
	}

	public void AddTarget(AdventureActor target)
	{
		if (!(target == null))
		{
			if (_targetList == null)
			{
				_targetList = new Dictionary<long, AdventureActor>(5);
			}
			_targetList.TryAdd(target.Id, target);
		}
	}

	public void RemoveTarget(AdventureActor target)
	{
		if (!(target == null))
		{
			_targetList?.Remove(target.Id);
		}
	}

	protected override void OnInit()
	{
		base.OnInit();
	}

	protected override void OnLogicUpdate()
	{
		if (isBornEnd)
		{
			_leftTime -= LogicDeltaTime;
			if (_leftTime <= 0)
			{
				Finish();
				return;
			}
			if (!isDelayAdsorptionEnd)
			{
				_delayAdsorption -= LogicDeltaTime;
				if (_delayAdsorption <= 0)
				{
					isDelayAdsorptionEnd = true;
				}
			}
			if (!isCanFlyToActor || !isDelayAdsorptionEnd || isFlyEnd)
			{
				return;
			}
			if (!isFlyStart)
			{
				isFlyStart = true;
				OnFlyStart();
			}
			if (!(cTrans != null) || !(_currentTarget != null))
			{
				return;
			}
			Transform transform = _currentTarget.transform;
			Vector3 position = transform.position;
			if (dropAdsorptionType == DropAdsorptionType.TargetSlot)
			{
				Transform slotNode = _currentTarget.slotConfig.GetSlotNode(adsorptionSlotType);
				if (slotNode != null)
				{
					position = slotNode.transform.position;
				}
			}
			Vector3 vector = position - cTrans.transform.position;
			_flySpeed += flyToActorAcceleration * LogicDeltaTime;
			if (vector.magnitude > _flySpeed * LogicDeltaTime.AsFloat())
			{
				Vector3 vector2 = cTrans.transform.position + vector.normalized * (_flySpeed * LogicDeltaTime).AsFloat();
				tsTransform.Position = new TSVector2(vector2.x, vector2.z);
				tsTransform.PositionY = vector2.y;
				return;
			}
			isFlyEnd = true;
			tsTransform.Position = new TSVector2(position.x, position.z);
			tsTransform.PositionY = position.y;
			if (takeEffectFx != null)
			{
				Quaternion spawnRotation = Quaternion.Euler(0f, 0f - (float)_currentTarget.tsTransform.Rotation360, 0f);
				AdventureFXPlayer.PlayFX(takeEffectFx, 1f, transform.position, spawnRotation);
			}
			Finish(isPick: true);
		}
		else
		{
			_bornTime -= LogicDeltaTime;
			if (_bornTime <= 0)
			{
				isBornEnd = true;
			}
		}
	}

	protected override void OnVisualUpdate()
	{
		if (fxPlayer != null)
		{
			fxPlayer.transform.position = cTrans.position;
			fxPlayer.transform.rotation = cTrans.rotation;
		}
	}

	internal void Recycle()
	{
		if (fxPlayer != null)
		{
			fxPlayer.Stop(dontPlaySubFX: true);
		}
		fxPlayer = null;
		owner = null;
		_targetDataIdList?.Clear();
		_targetList?.Clear();
		_currentTarget = null;
		_leftTime = 0;
		isBornEnd = false;
		isCanFlyToActor = false;
		isDelayAdsorptionEnd = false;
		isFlyEnd = false;
		isFlyStart = false;
		PickByTarget = false;
		SceneSingleton<DropsManager>.Instance.Despawn(this);
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_SPAWN", OnActorSpawn);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
		DisableLogicUpdate();
		if (fxPlayer != null)
		{
			fxPlayer.Stop(dontPlaySubFX: true);
		}
		fxPlayer = null;
		owner = null;
		_targetDataIdList?.Clear();
		_targetList?.Clear();
		_currentTarget = null;
		_leftTime = 0;
		isBornEnd = false;
		isCanFlyToActor = false;
		isDelayAdsorptionEnd = false;
		isFlyEnd = false;
		isFlyStart = false;
		PickByTarget = false;
	}

	public virtual void SetExperienceVal(int val)
	{
	}

	public virtual void AddExperienceVal(int val)
	{
	}

	public virtual void SetDropWave(int specialType, int dropWave)
	{
	}

	public virtual bool isVampireExp()
	{
		return false;
	}

	public virtual HotfixEnum.dropEntityType GetDropEntityType()
	{
		return HotfixEnum.dropEntityType.VampireExp;
	}
}
