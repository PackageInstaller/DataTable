using System;
using Spine;
using Spine.Unity;

namespace BilliardGame.Runtime;

public class BilliardGameMechanism : BilliardGameBehaviorBase
{
	private const int CRYSTAL_ID = 40310;

	private const int POT_ID = 40311;

	private const int CHEST_ID = 40312;

	private const int BOLT_ID = 40313;

	private const int PORTAL_ID = 40314;

	private const int SPEED_BUMP_ID = 50101;

	private const int TIME_PORTAL_ID = 50102;

	private const int BAG_ID = 50103;

	private AnimationState.TrackEntryDelegate roleAnimEndHandler;

	public MechanismType mechanismType;

	public bool hideWhenMagnify;

	public int maxCol = 1;

	public int colX = 1;

	public int colY = 10;

	public int dir;

	public int chestType = 1;

	public int chestCol = 1;

	public int waitTurn = 2;

	public int effectTurn = 1;

	public int hp = 1000;

	public float cdTime = 0.5f;

	public int totalInvokeNum = 5;

	public int maxRound = 3;

	protected SkeletonAnimation roleSpine;

	private bool isCrystal => mechanismType == MechanismType.Crystal;

	private bool isBolt => mechanismType == MechanismType.Bolt;

	private bool isChest => mechanismType == MechanismType.Chest;

	private bool isPot => mechanismType == MechanismType.Pot;

	private bool isTimePortal => mechanismType == MechanismType.TimePortal;

	private bool isSpeedBump => mechanismType == MechanismType.SpeedBump;

	public int GetMechainID()
	{
		return mechanismType switch
		{
			MechanismType.Crystal => 40310, 
			MechanismType.Pot => 40311, 
			MechanismType.Chest => 40312, 
			MechanismType.Bolt => 40313, 
			MechanismType.Portal => 40314, 
			MechanismType.TimePortal => 50102, 
			MechanismType.Bag => 50103, 
			MechanismType.SpeedBump => 50101, 
			_ => 0, 
		};
	}

	public void Awake()
	{
		Init();
	}

	public override void Init()
	{
		base.Init();
		roleSpine = GetComponent<SkeletonAnimation>();
	}

	public override void Dispose()
	{
		base.Dispose();
		if (roleSpine != null)
		{
			roleSpine.AnimationState.End -= roleAnimEndHandler;
		}
	}

	public void ChangeAniState(string stateName, bool isLoop, Action callback = null)
	{
		if (null == roleSpine)
		{
			return;
		}
		roleSpine.AnimationState.SetAnimation(0, stateName, isLoop);
		roleSpine.AnimationState.End -= roleAnimEndHandler;
		if (callback == null)
		{
			return;
		}
		roleAnimEndHandler = delegate
		{
			if (roleSpine.AnimationName == stateName)
			{
				callback();
			}
		};
		roleSpine.AnimationState.End += roleAnimEndHandler;
	}

	public void AddAniState(string stateName, bool isLoop, Action callback)
	{
		if (null == roleSpine)
		{
			return;
		}
		roleSpine.AnimationState.AddAnimation(0, stateName, isLoop, 0f);
		roleSpine.AnimationState.Complete += delegate
		{
			if (roleSpine.AnimationName == stateName)
			{
				callback();
			}
		};
	}

	public void SetHideWhenMagnify(bool flag)
	{
		hideWhenMagnify = flag;
	}
}
