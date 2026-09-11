using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("飘字", 0)]
[Category("Render/UI")]
[Description("实例化HPTips,设置一下类型")]
[ExposeAsDefinition]
public class SetHPTips : CallableActionNode<Vector3, int, HPTipsType>
{
	private WorldStateManager mgr;

	public static HpTips GetHpTips(string path, int value)
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene == null)
		{
			return null;
		}
		WorldStateManager worldSatetManager = battleScene.GetWorldSatetManager();
		if (worldSatetManager == null)
		{
			return null;
		}
		HpTips hpTip = worldSatetManager.GetHpTip(path);
		if (hpTip != null)
		{
			hpTip.SetValue(value);
		}
		return hpTip;
	}

	public override void Invoke(Vector3 pos, int value, HPTipsType type)
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (mgr == null)
		{
			mgr = battleScene.GetWorldSatetManager();
		}
		HpTips hpTips = null;
		bool weak = false;
		switch (type)
		{
		case HPTipsType.PlayerGetDamage:
			hpTips = GetHpTips("HPTips/HurtHPTips", value);
			break;
		case HPTipsType.AddHP:
			hpTips = GetHpTips("HPTips/RecoverHPTips", value);
			break;
		case HPTipsType.CritAddHP:
			hpTips = GetHpTips("HPTips/RecoverCritHPTips", value);
			break;
		case HPTipsType.Invalid:
			hpTips = GetHpTips("HPTips/AbsorbHPTips", 0);
			break;
		case HPTipsType.DefendDamage:
			hpTips = GetHpTips("HPTips/InvalidHPTips", 0);
			break;
		case HPTipsType.Miss:
			hpTips = GetHpTips("HPTips/MissHPTips", 0);
			break;
		case HPTipsType.NormalDamage:
			if (mgr.show_battle_hit_num_mine != 0)
			{
				hpTips = GetHpTips("HPTips/NormalHPTips", value);
			}
			if (mgr.show_battle_hit_num_mine == 1)
			{
				weak = true;
			}
			break;
		case HPTipsType.HighDamage:
			if (mgr.show_battle_hit_num_mine != 0)
			{
				hpTips = GetHpTips("HPTips/MaxHPTips", value);
			}
			if (mgr.show_battle_hit_num_mine == 1)
			{
				weak = true;
			}
			break;
		case HPTipsType.CritDamage:
			if (mgr.show_battle_hit_num_mine != 0)
			{
				hpTips = GetHpTips("HPTips/CritHPTips", value);
			}
			if (mgr.show_battle_hit_num_mine == 1)
			{
				weak = true;
			}
			break;
		case HPTipsType.CritHighDamage:
			if (mgr.show_battle_hit_num_mine != 0)
			{
				hpTips = GetHpTips("HPTips/CritMaxHPTips", value);
			}
			if (mgr.show_battle_hit_num_mine == 1)
			{
				weak = true;
			}
			break;
		case HPTipsType.Teammate:
			if (mgr.show_battle_hit_num_teammate != 0)
			{
				hpTips = GetHpTips("HPTips/TeammateHPTips", value);
			}
			if (mgr.show_battle_hit_num_teammate == 1)
			{
				weak = true;
			}
			break;
		case HPTipsType.TeammateCrit:
			if (mgr.show_battle_hit_num_teammate != 0)
			{
				hpTips = GetHpTips("HPTips/TeammateCritHPTips", value);
			}
			if (mgr.show_battle_hit_num_teammate == 1)
			{
				weak = true;
			}
			break;
		case HPTipsType.UniqueSkill:
			if (mgr.show_battle_hit_num_mine != 0)
			{
				hpTips = GetHpTips("HPTips/UniqueskilllHPTips", value);
			}
			if (mgr.show_battle_hit_num_mine == 1)
			{
				weak = true;
			}
			break;
		case HPTipsType.UniqueSkillCrit:
			if (mgr.show_battle_hit_num_mine != 0)
			{
				hpTips = GetHpTips("HPTips/UniqueskilllCriHPTips", value);
			}
			if (mgr.show_battle_hit_num_mine == 1)
			{
				weak = true;
			}
			break;
		case HPTipsType.TeammateUniqueSkill:
			if (mgr.show_battle_hit_num_teammate != 0)
			{
				hpTips = GetHpTips("HPTips/UniqueskilllHPTips", value);
			}
			if (mgr.show_battle_hit_num_teammate == 1)
			{
				weak = true;
			}
			break;
		case HPTipsType.TeammateUniqueSkillCrit:
			if (mgr.show_battle_hit_num_teammate != 0)
			{
				hpTips = GetHpTips("HPTips/UniqueskilllCriHPTips", value);
			}
			if (mgr.show_battle_hit_num_teammate == 1)
			{
				weak = true;
			}
			break;
		case HPTipsType.Immune:
			hpTips = GetHpTips("HPTips/ImmuneHPTips", 0);
			break;
		}
		if (hpTips != null)
		{
			hpTips.StartUpdate(pos, weak);
		}
	}
}
