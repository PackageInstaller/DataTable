using TrueSync;
using UnityEngine;

public class BrickDrop : DropEntity
{
	public HotfixEnum.BrickDropType dropType = HotfixEnum.BrickDropType.BrickFire;

	public float moveSpeed = 5f;

	private FP _moveSpeedFP;

	public GameObject BoomFx;

	public float BoomFxScale = 1f;

	public int hitId;

	public bool desClear;

	public GameObject roleFx;

	public GameObject invFx;

	public GameObject disableFx;

	public float disableDuration;

	public GameObject splitFx;

	public int splitNum = 2;

	public float splitAngle = 120f;

	public float splitRot;

	public float splitDistance;

	public GameObject triggerArea;

	public DeterministicCollider dtCollider { get; private set; }

	public int SpecialParmas { get; private set; }

	public int DropId { get; private set; }

	public BrickDrop()
	{
		doType = DropObjType.brick;
		sameMaxCount = 999;
	}

	protected override void OnInit()
	{
		base.OnInit();
		dtCollider = AddOrGetMonoLogicComponent<DeterministicCollider>();
		_moveSpeedFP = FP.FromConfigFloat(moveSpeed);
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
		SpecialParmas = 0;
		DropId = 0;
	}

	public override void bornShow()
	{
		base.bornShow();
	}

	public override void Finish(bool isPick = false)
	{
		if (ActiveSelf)
		{
			if (isPick && takeEffectFx != null)
			{
				AdventureFXPlayer.PlayFX(takeEffectFx, 1f, cTrans.position, cTrans.rotation);
			}
			if (fxPlayer != null)
			{
				fxPlayer.Stop();
			}
			fxPlayer = null;
			AdventureDropFinishEvent adventureDropFinishEvent = AdventureDropFinishEvent.Generate();
			adventureDropFinishEvent.sender = this;
			adventureDropFinishEvent.entityID = Id;
			adventureDropFinishEvent.dropTag = dropTag;
			adventureDropFinishEvent.owner = owner;
			adventureDropFinishEvent.isPickUp = isPick;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureDropFinishEvent);
			ActiveSelf = false;
		}
	}

	protected override void OnLogicUpdate()
	{
		if (isBornEnd)
		{
			TSVector2 tSVector = TSVector2.down * _moveSpeedFP * LogicDeltaTime;
			tsTransform.Position += tSVector;
			if (!Singleton<BrickBreakerManager>.Instance.CheckInArea(tsTransform.Position))
			{
				Finish();
			}
		}
		else
		{
			_bornTime -= LogicDeltaTime;
			if (_bornTime < 0)
			{
				isBornEnd = true;
				tsTransform.PositionY = _spawnPos.y;
			}
		}
	}

	public void SetParamasValue(int paramas, int id)
	{
		SpecialParmas = paramas;
		DropId = id;
	}
}
