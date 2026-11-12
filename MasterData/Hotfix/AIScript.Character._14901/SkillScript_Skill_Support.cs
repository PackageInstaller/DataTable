using System;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._14901;

public class SkillScript_Skill_Support : SkillAdvancedBase
{
	private int _curLoopTimes;

	private TSVector2 TransformLocalPoint(Vector3 localPoint)
	{
		Vector3 localScale = _actor.transform.localScale;
		return TSVector2.Rotate(new TSVector2((FP)localPoint.x * (FP)localScale.x, (FP)localPoint.z * (FP)localScale.z), _actor.tsTransform.Rotation) + _actor.tsTransform.Position;
	}

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_curLoopTimes = 0;
		Config_Support.supportSkillBeginTime = _actor.LogicTime;
	}

	public void OnStart()
	{
		if (GetPerk(514925))
		{
			_actor.buffComponent.AddBuff(14925011, _actor);
		}
		int num = 0;
		if (GetPerk(514921))
		{
			num++;
		}
		if (GetPerk(514922))
		{
			num += 10;
		}
		if (GetPerk(514923))
		{
			num += 100;
		}
		string actionTag = Config_Support.dicSkillTag.get_Item(num);
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboLoop = OnComboLoop;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent, null, fadeOutAnim: false, onComboLoop);
	}

	private void OnComboLoop()
	{
		_curLoopTimes++;
		if (GetPerk(514923))
		{
			if (_curLoopTimes >= 6)
			{
				comboAttack?.CancelAttack();
			}
		}
		else
		{
			comboAttack?.CancelAttack();
		}
	}

	private void OnCustomEvent(string evt)
	{
		if (string.Equals(evt, "149_Earthquake_Enemy_Start"))
		{
			string fxAlias = "AreaEffect_14901_B2_Skill_Earthquake_Start";
			if (GetPerk(514930))
			{
				fxAlias = "AreaEffect_14901_B2P30_Skill_Earthquake_Start";
			}
			if (GetPerk(514921))
			{
				for (int i = 0; i < Config_Support.areaPos.Count; i++)
				{
					TSVector2 position = TransformLocalPoint(Config_Support.areaPos.get_Item(i));
					long id = ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, position);
					if (GetPerk(514924))
					{
						ILRuntimeAPI.ModifyAreaEffectScale(id, Config_Support.scale_24);
					}
				}
			}
			else
			{
				TSVector2 position2 = TransformLocalPoint(Config_Support.offsetPos);
				long id2 = ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, position2);
				if (GetPerk(514924))
				{
					ILRuntimeAPI.ModifyAreaEffectScale(id2, Config_Support.scale_24);
				}
			}
		}
		if (string.Equals(evt, "149_Earthquake_Enemy"))
		{
			string fxAlias2 = "AreaEffect_14901_B2_Skill_Earthquake";
			if (GetPerk(514930))
			{
				fxAlias2 = "AreaEffect_14901_B2P30_Skill_Earthquake";
			}
			if (GetPerk(514921))
			{
				for (int j = 0; j < Config_Support.areaPos.Count; j++)
				{
					TSVector2 position3 = TransformLocalPoint(Config_Support.areaPos.get_Item(j));
					long id3 = ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias2, position3);
					if (GetPerk(514924))
					{
						ILRuntimeAPI.ModifyAreaEffectScale(id3, Config_Support.scale_24);
					}
				}
			}
			else
			{
				TSVector2 position4 = TransformLocalPoint(Config_Support.offsetPos);
				long id4 = ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias2, position4);
				if (GetPerk(514924))
				{
					ILRuntimeAPI.ModifyAreaEffectScale(id4, Config_Support.scale_24);
				}
			}
		}
		if (string.Equals(evt, "149_Earthquake_Self"))
		{
			string fxAlias3 = "AreaEffect_14901_B2_Skill_Earthquake_Self";
			if (GetPerk(514930))
			{
				fxAlias3 = "AreaEffect_14901_B2P30_Skill_Earthquake_Self";
			}
			TSVector2 position5 = TransformLocalPoint(Config_Support.offsetPosSelf);
			long id5 = ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias3, position5);
			if (GetPerk(514924))
			{
				ILRuntimeAPI.ModifyAreaEffectScale(id5, Config_Support.scale_24);
			}
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		comboAttack?.Clear();
	}
}
