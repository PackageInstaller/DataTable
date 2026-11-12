using System;
using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._12301;

public class SkillScript_B2_Skill : SkillAdvancedBase
{
	private Dictionary<PlayerTalentGroupType, string> dicKey = new Dictionary<PlayerTalentGroupType, string>
	{
		[PlayerTalentGroupType.None] = "B2_Skill",
		[PlayerTalentGroupType.Group1] = "B2T1_Skill",
		[PlayerTalentGroupType.Group2] = "B2_Skill",
		[PlayerTalentGroupType.Group3] = "B2_Skill",
		[PlayerTalentGroupType.Group4] = "B2T4_Skill",
		[PlayerTalentGroupType.Group12] = "B2_Skill",
		[PlayerTalentGroupType.Group13] = "B2_Skill",
		[PlayerTalentGroupType.Group14] = "B2T14_Skill",
		[PlayerTalentGroupType.Group23] = "B2_Skill",
		[PlayerTalentGroupType.Group24] = "B2T24_Skill",
		[PlayerTalentGroupType.Group34] = "B2_Skill"
	};

	private Dictionary<int, string> dicKey_B2T13 = new Dictionary<int, string>
	{
		[1] = "B2T13_1",
		[2] = "B2T13_2",
		[3] = "B2T13_3",
		[4] = "B2T13_4",
		[5] = "B2T13_5"
	};

	private Dictionary<int, string> dicKey_B2T23 = new Dictionary<int, string>
	{
		[1] = "B2T23_1",
		[2] = "B2T23_2",
		[3] = "B2T23_3",
		[4] = "B2T23_4",
		[5] = "B2T23_5"
	};

	private Dictionary<int, string> dicKey_B2T34 = new Dictionary<int, string>
	{
		[1] = "B2T23_1",
		[2] = "B2T23_2",
		[3] = "B2T23_3",
		[4] = "B2T23_4",
		[5] = "B2T23_5"
	};

	private FP cast_time = 1;

	private string evt_area = "evt_area";

	private string areaEffect_T12 = "AreaEffect_123_B2T1_Skill_BigWindWall";

	private TSVector2 offset_T12 = new TSVector2(0, 0);

	private FP height_T12 = 0;

	private string areaEffect_T14 = "AreaEffect_123_B2T14_Skill_BigHurtWindWall";

	private TSVector2 offset_T14 = new TSVector2(0, 0);

	private FP height_T14 = 0;

	private Dictionary<int, FP> dicAddTime = new Dictionary<int, FP>
	{
		[0] = 5,
		[1] = 5,
		[2] = 6,
		[3] = 7,
		[4] = 8,
		[5] = 9
	};

	private string area_5 = "AreaEffect_123_B2_Skill_WindWall";

	private const int perkId_5 = 512305;

	private readonly Dictionary<int, int> dicPro_5 = new Dictionary<int, int>
	{
		[1] = 40,
		[2] = 50,
		[3] = 60,
		[4] = 70,
		[5] = 80
	};

	private CoroutineNode corMain;

	public PlayerSkillCd skillMgr;

	public PlayerTalentGroupType talentGroupType;

	private string actionKey;

	private AreaEffectEntity effectEntity;

	private int talentLv;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		skillMgr = _actor.GetLogicComponent<PlayerSkillCd>();
		talentGroupType = (_actor as PlayerAdventureActor).GetTalentGroupType();
		talentLv = (_actor as PlayerAdventureActor).GetTalentGroupLevel();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		Clear();
	}

	public void OnStart()
	{
		StartCoroutine(ref corMain, DoMainLogic());
	}

	private void Clear()
	{
		StopCoroutine(ref corMain);
	}

	public void SkillFinish()
	{
		_skill?.Clear();
	}

	public void SkillInterrupt()
	{
		_skill?.Clear();
	}

	private void ParseKey()
	{
		actionKey = dicKey.get_Item(talentGroupType);
		if (talentLv > 0)
		{
			if (talentGroupType == PlayerTalentGroupType.Group13)
			{
				actionKey = dicKey_B2T13.get_Item(talentLv);
			}
			else if (talentGroupType == PlayerTalentGroupType.Group23)
			{
				actionKey = dicKey_B2T23.get_Item(talentLv);
			}
			else if (talentGroupType == PlayerTalentGroupType.Group34)
			{
				actionKey = dicKey_B2T34.get_Item(talentLv);
			}
		}
	}

	private IEnumerator DoMainLogic()
	{
		ParseKey();
		SkillScript_B2_Skill skillScript_B2_Skill = this;
		string actionTag = actionKey;
		Action<string> action = onCustomEvent;
		System.Action onComboFinish = SkillFinish;
		System.Action onInterrupt = SkillInterrupt;
		skillScript_B2_Skill.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
		yield return cast_time;
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512305, out var perkLevel) && TSRandom.Range(0, 100) < dicPro_5.get_Item(perkLevel))
		{
			FP rotation = _actor.tsTransform.Rotation;
			for (int i = 1; i <= 3; i++)
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, area_5, _actor.tsTransform.Position, rotation + i * 90);
			}
		}
	}

	private void onCustomEvent(string evt)
	{
		if (!string.Equals(evt, evt_area))
		{
			return;
		}
		string text = "";
		if (talentGroupType == PlayerTalentGroupType.Group12)
		{
			text = areaEffect_T12;
		}
		else if (talentGroupType == PlayerTalentGroupType.Group14)
		{
			text = areaEffect_T14;
		}
		if (!string.IsNullOrEmpty(text))
		{
			long id = ILRuntimeAPI.PlayAreaEffect(_actor, text, _actor.tsTransform.Position, _actor.tsTransform.Rotation);
			effectEntity = ILRuntimeAPI.GetAreaEffect(id);
			if (talentGroupType == PlayerTalentGroupType.Group12)
			{
				effectEntity.hitBoxOffset = offset_T12;
				effectEntity.hitBoxOffsetY = height_T12;
			}
			else if (talentGroupType == PlayerTalentGroupType.Group14)
			{
				effectEntity.hitBoxOffset = offset_T14;
				effectEntity.hitBoxOffsetY = height_T14;
			}
			int talentGroupLevel = (_actor as PlayerAdventureActor).GetTalentGroupLevel();
			if (talentGroupLevel > 0)
			{
				effectEntity.AddLeftTime(dicAddTime.get_Item(talentGroupLevel));
			}
		}
	}
}
