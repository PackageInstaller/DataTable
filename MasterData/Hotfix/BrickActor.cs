using Nova.Hotfix;
using TrueSync;
using UnityEngine;

public class BrickActor : DynamicActor
{
	private readonly float HudCenterY = 1f;

	private readonly float HudOffsetX = 2f;

	private readonly float HudOffsetY = 1f;

	public int mainSkillId;

	public BrickActorSkillCom skillMgr;

	public float maxEnergy;

	public float skillCD;

	private BreakOutCharacter actorData;

	protected override void OnInit()
	{
		base.OnInit();
		skillMgr = AddOrGetLogicComponent<BrickActorSkillCom>();
		gameObject.layer = 23;
		HudOffsetValue hudOffsetValue = gameObject.GetComponent<HudOffsetValue>();
		if (hudOffsetValue == null)
		{
			hudOffsetValue = gameObject.AddComponent<HudOffsetValue>();
		}
		hudOffsetValue.centerY = HudCenterY;
		hudOffsetValue.x = HudOffsetX;
		hudOffsetValue.y = HudOffsetY;
	}

	public void LoadData(BreakOutCharacter data)
	{
		actorData = data;
		dataID = data.Id;
		mainSkillId = data.SkillId;
		skillCD = data.SkillCD;
		maxEnergy = data.MP;
		actorScaleInfo.originModelScale = FP.FromMyriad(data.ModelScale);
		actorScaleInfo.modelScale = actorScaleInfo.originModelScale;
		ActorInfo actorInfo = base.actorInfo;
		int factionID = (base.actorInfo.originFactionID = data.Faction);
		actorInfo.factionID = factionID;
		base.actorInfo.moveAcceleration = 99999;
		base.actorInfo.moveRotationSpeed = 10;
		SetAttrInfo(data.Attribute);
		SetupPrimeFSM(0);
		LoadModel((float)dtCollider.Radius, (float)dtCollider.ColliderHeight);
		attackFSM.SetRootMotionScale(actorScaleInfo.modelScale);
		isDead = false;
		isDeclareDead = false;
	}

	public bool SetAttrInfo(int attrId, int percent = 100)
	{
		Attribute attribute = Singleton<HotfixDataController>.Instance.GetAttribute(attrId.ToString());
		if (attribute == null)
		{
			Debug.LogError($"attributeConfig not exist, attrId:{attrId} ");
			return false;
		}
		FDP ratio = FDP.FromPercent(percent);
		SetElementType(actorData.EET);
		actorHealthInfo.SetOriginAttributeData(attribute, ratio);
		actorInfo.SetOriginAttributeData(attribute, ratio);
		actorElementInfo.SetOriginAttributeData(attribute, ratio);
		return true;
	}

	private void SetElementType(int elementType)
	{
		actorElementInfo.originElementType = (HotfixEnum.elementType)elementType;
		actorElementInfo.elementType = actorElementInfo.originElementType;
	}

	public override void SetupPrimeFSM(int aiId)
	{
		if (_primeFSM == null)
		{
			_comboGroupPath = actorData.FCComboGroup;
			base.SetupPrimeFSM(aiId);
			_primeFSM = new ActorPrimeFSM(gameObject);
			_nullState = new ActorNullState();
			_primeFSM.RegistState(_nullState);
			_spawnState = new PlayerSpawnState();
			_primeFSM.RegistState(_spawnState);
			_actionState = new ActorActionState();
			_primeFSM.RegistState(_actionState, actorData.FCAIAction);
		}
	}

	public void LogicActive()
	{
		DisableMovementAgent();
		EnableUnparalleled();
		tsTransform.transformSyncEnabled = false;
	}

	protected override void OnActive()
	{
		base.OnActive();
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
	}

	public override void LevelStart()
	{
		EnableLogicUpdate();
		Spawn();
	}

	public override void LevelEnd()
	{
	}

	protected override void OnLogicUpdate()
	{
		if (!isDead)
		{
			skillMgr.OnLogicUpdate(LogicDeltaTime);
			_primeFSM.OnUpdate();
			UpdateParallelAI();
			buffComponent.LogicUpdate(LogicDeltaTime);
			effectManage?.LogicUpdate(LogicDeltaTime);
			updateTime();
		}
		attackFSM.OnUpdate();
		CheckBrokenLineBulletBack();
	}

	public void Despawn()
	{
		OnShow(show: false);
		ActiveSelf = false;
	}

	protected override void ReleaseVisual()
	{
		base.ReleaseVisual();
		InitializeTransparentFade();
	}

	protected override void SetupVisualComponents(float visibleRadius, float visibleHeight)
	{
		base.SetupVisualComponents(visibleRadius, visibleHeight);
		visualControl.SetupBasicActorVisualComponents(visibleRadius, visibleHeight);
		visualControl.SetCustomStencilMode(200, RendererMaterialStackComponent.StencilMode.Replace);
		visualControl.ResetRenderLayer();
		InitializeTransparentFade();
	}
}
