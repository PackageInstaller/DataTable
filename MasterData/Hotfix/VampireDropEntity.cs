using System.Collections.Generic;
using TrueSync;
using UnityEngine;

public class VampireDropEntity : DropEntity
{
	public HotfixEnum.dropEntityType dGood = HotfixEnum.dropEntityType.VampireExp;

	public List<GameObject> ExperienceEffects = new List<GameObject>();

	public List<GameObject> ExperienceTakeEffectFx = new List<GameObject>();

	private int currentExperience;

	private int currentSpecialType;

	private int currentDropWave;

	private FP dropConfigRange = 2;

	public override void Setup(AdventureActor owner, string pName, Vector3 spawnPos)
	{
		ModuleController<AdventureModuleController>.Instance.AddEventListener("DROP_ADSORPTIONCHANGE", AdsorptionChangeEvent);
		FP adsorptionChangeValue = SceneSingleton<DropsManager>.Instance.GetAdsorptionChangeValue(dGood);
		if (!string.IsNullOrEmpty(dropTag))
		{
			dropConfigRange = CommonHelper.ParseStringParamToFP(Singleton<GameDataController>.Instance.GetConfig(dropTag).Value);
		}
		base.Setup(owner, pName, spawnPos);
		adsorptionRangeFP = dropConfigRange + adsorptionChangeValue;
	}

	internal override bool CheckTargetDistance(out AdventureActor target)
	{
		target = null;
		AdventureActor adventureActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as AdventureActor;
		if (TSVector2.Distance(adventureActor.tsTransform.Position, tsTransform.Position) < adsorptionRangeFP)
		{
			target = adventureActor;
			return true;
		}
		return false;
	}

	public override void bornShow()
	{
		if (cTrans == null)
		{
			cTrans = transform;
		}
		if (dGood == HotfixEnum.dropEntityType.VampireExp)
		{
			showExperienceFx();
			isBornEnd = true;
		}
		else if (dGood == HotfixEnum.dropEntityType.VampireBox)
		{
			if (idleFx != null)
			{
				fxPlayer = AdventureFXPlayer.PlayFX(idleFx, 1f, cTrans.position, cTrans.rotation);
			}
			isBornEnd = true;
		}
		else
		{
			base.bornShow();
		}
	}

	protected override void OnLogicUpdate()
	{
		if (isBornEnd)
		{
			_leftTime -= LogicDeltaTime;
			if (_leftTime < 0)
			{
				Finish();
			}
			if (!isDelayAdsorptionEnd)
			{
				_delayAdsorption -= LogicDeltaTime;
				if (_delayAdsorption < 0)
				{
					isDelayAdsorptionEnd = true;
				}
			}
			if (!isCanFlyToActor || !isDelayAdsorptionEnd || isFlyEnd)
			{
				return;
			}
			Transform transform = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor?.transform;
			if (!(cTrans != null))
			{
				return;
			}
			Vector3 position = transform.position;
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
			if (dGood != HotfixEnum.dropEntityType.VampireExp)
			{
				if (takeEffectFx != null)
				{
					Quaternion spawnRotation = Quaternion.Euler(0f, 0f - (float)SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.tsTransform.Rotation360, 0f);
					AdventureFXPlayer.PlayFX(takeEffectFx, 1f, transform.position, spawnRotation);
				}
			}
			else
			{
				GameObject experienceTakeFx = GetExperienceTakeFx();
				if (experienceTakeFx != null)
				{
					Quaternion spawnRotation2 = Quaternion.Euler(0f, 0f - (float)SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.tsTransform.Rotation360, 0f);
					AdventureFXPlayer.PlayFX(experienceTakeFx, 1f, transform.position, spawnRotation2);
				}
			}
			Finish(isPick: true);
		}
		else
		{
			_bornTime -= LogicDeltaTime;
			if (_bornTime < 0)
			{
				isBornEnd = true;
			}
		}
	}

	public override void SetExperienceVal(int val)
	{
		currentExperience = val;
	}

	public override void AddExperienceVal(int val)
	{
		if (dGood == HotfixEnum.dropEntityType.VampireExp)
		{
			currentExperience += val;
			showExperienceFx();
		}
	}

	public override void SetDropWave(int specialType, int dropWave)
	{
		currentSpecialType = specialType;
		currentDropWave = dropWave;
	}

	public override bool isVampireExp()
	{
		return dGood == HotfixEnum.dropEntityType.VampireExp;
	}

	public override HotfixEnum.dropEntityType GetDropEntityType()
	{
		return dGood;
	}

	private void showExperienceFx()
	{
		if (fxPlayer != null)
		{
			fxPlayer.Stop();
		}
		fxPlayer = null;
		int num = CommonHelper.ParseStringParamToInt(Singleton<GameDataController>.Instance.GetConfig("VampireDropExperienceMinInterval").Value);
		int num2 = CommonHelper.ParseStringParamToInt(Singleton<GameDataController>.Instance.GetConfig("VampireDropExperienceMaxInterval").Value);
		if (currentExperience < num)
		{
			if (ExperienceEffects.get_Item(0) != null)
			{
				fxPlayer = AdventureFXPlayer.PlayFX(ExperienceEffects.get_Item(0), 1f, cTrans.position, cTrans.rotation);
			}
		}
		else if (currentExperience > num2)
		{
			if (ExperienceEffects.get_Item(2) != null)
			{
				fxPlayer = AdventureFXPlayer.PlayFX(ExperienceEffects.get_Item(2), 1f, cTrans.position, cTrans.rotation);
			}
		}
		else if (ExperienceEffects.get_Item(1) != null)
		{
			fxPlayer = AdventureFXPlayer.PlayFX(ExperienceEffects.get_Item(1), 1f, cTrans.position, cTrans.rotation);
		}
	}

	private GameObject GetExperienceTakeFx()
	{
		int num = CommonHelper.ParseStringParamToInt(Singleton<GameDataController>.Instance.GetConfig("VampireDropExperienceMinInterval").Value);
		int num2 = CommonHelper.ParseStringParamToInt(Singleton<GameDataController>.Instance.GetConfig("VampireDropExperienceMaxInterval").Value);
		GameObject result = null;
		if (currentExperience < num)
		{
			if (ExperienceTakeEffectFx.get_Item(0) != null)
			{
				result = ExperienceTakeEffectFx.get_Item(0);
			}
		}
		else if (currentExperience > num2)
		{
			if (ExperienceTakeEffectFx.get_Item(2) != null)
			{
				result = ExperienceTakeEffectFx.get_Item(2);
			}
		}
		else if (ExperienceTakeEffectFx.get_Item(1) != null)
		{
			result = ExperienceTakeEffectFx.get_Item(1);
		}
		return result;
	}

	public override void Finish(bool isPick = false)
	{
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("DROP_ADSORPTIONCHANGE", AdsorptionChangeEvent);
		if (dGood == HotfixEnum.dropEntityType.VampireExp)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("Vampire_Drop", 1, currentExperience);
		}
		else if (dGood == HotfixEnum.dropEntityType.VampireBox)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("Vampire_Drop", 2, currentSpecialType, currentDropWave);
		}
		base.Finish(isPick);
	}

	protected void AdsorptionChangeEvent(IEvent ievent)
	{
		if (((AdventureLevelDropAdsorptionChangeMsgEvent)ievent).dropType == dGood)
		{
			FP adsorptionChangeValue = SceneSingleton<DropsManager>.Instance.GetAdsorptionChangeValue(dGood);
			adsorptionRangeFP = dropConfigRange + adsorptionChangeValue;
		}
	}
}
