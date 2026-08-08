using System.Collections.Generic;
using BilliardGame.Runtime;
using UnityEngine;

namespace BilliardGame.Spell;

public class BTLineDamage : BActionNode
{
	public int Damage;

	public float width;

	public int buffID;

	public int buffLevel = 1;

	public bool isRandom;

	public int dir;

	public string verticalEffectName;

	public string horizontalEffectName;

	public string mergeEffectName;

	public override BTNodeStatus Run(BTEnv env)
	{
		int num = Damage;
		BilliardGameEntityBase player = env.GetPlayer<BilliardGameEntityBase>("Caster");
		BilliardGameEntityBase obj = (env.ContainKey("TargetEntity") ? env.GetPlayer<BilliardGameEntityBase>("TargetEntity") : player);
		if (env.ContainKey("add_aoe_damage"))
		{
			num += env.GetStruct<int>("add_aoe_damage");
		}
		if (env.ContainKey("add_aoe_damage_ratio"))
		{
			num = Mathf.FloorToInt((float)num * env.GetStruct<float>("add_aoe_damage_ratio"));
		}
		Vector3 position = obj.position;
		int num2 = (isRandom ? Random.Range(0, 2) : dir);
		List<EntityEnemy> lineEnemy = BilliardGameLogicManager.Instance.GetLineEnemy(position, width, num2);
		if (player is EntityPlayer)
		{
			EntityPlayer obj2 = player as EntityPlayer;
			int addAoeDamage = obj2.AddAoeDamage;
			int addComboDamage = obj2.AddComboDamage;
			float addAoeRatio = obj2.AddAoeRatio;
			num += addComboDamage;
			num += addAoeDamage;
			num = Mathf.FloorToInt((float)num * addAoeRatio);
			obj2.OnAOEDamage(env.GetStruct<int>("BuffId"), lineEnemy);
		}
		for (int i = 0; i < lineEnemy.Count; i++)
		{
			lineEnemy[i].TakeDamage(num);
			if (buffID != 0)
			{
				BilliardGameSpellManager.Instance.CastBuff(buffID, lineEnemy[i], buffLevel);
			}
		}
		BilliardGameLogicManager.Instance.AddCurRoundHitNumber(lineEnemy.Count);
		string text = null;
		if (num2 == -1 && mergeEffectName != null && mergeEffectName != "")
		{
			text = mergeEffectName;
		}
		else if (num2 == 0 && horizontalEffectName != null && horizontalEffectName != "")
		{
			text = horizontalEffectName;
		}
		else if (num2 == 1 && verticalEffectName != null && verticalEffectName != "")
		{
			text = verticalEffectName;
		}
		if (text != null)
		{
			BilliardGameLogicManager.Instance.MakeEffectWorld(text, position, 1f);
		}
		return BTNodeStatus.Success;
	}
}
