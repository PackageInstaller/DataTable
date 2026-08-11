using System.Collections.Generic;
using Ase.ECS;
using UnityEngine;

public class SkillLayerCooling : CoolingBase
{
	private int _id;

	private HeroSkillData _heroSkillData;

	public int Id => _id;

	public SkillLayerCooling(string[] param, bool isConsumeCondition, BaseEntity baseEntity)
		: base(param, isConsumeCondition, baseEntity)
	{
		if (param.Length != 0)
		{
			_id = int.Parse(param[1]);
			base.ReleaseParamValue = int.Parse(isConsumeCondition ? param[2] : param[3]);
		}
	}

	public override bool Check()
	{
		if (_heroSkillData == null)
		{
			enoughCondition = false;
			_heroSkillData = entity.GetComponent<SkillComponent>().GetSkillData(_id);
		}
		if (_heroSkillData == null)
		{
			enoughCondition = false;
			return false;
		}
		if (isConsumeCondition)
		{
			enoughCondition = (float)_heroSkillData.CacheLayer >= base.ReleaseParamValue;
			return enoughCondition;
		}
		enoughCondition = ReleaseOption(_heroSkillData.CacheLayer);
		return enoughCondition;
	}

	public override void Release()
	{
		if (_heroSkillData != null)
		{
			_heroSkillData.ExpendSKillLayer((int)base.ReleaseParamValue);
		}
	}

	public override void Cultivate(CoolingBase coolingBase)
	{
		if (coolingBase.IsConsumeCondition == base.IsConsumeCondition && coolingBase is SkillLayerCooling skillLayerCooling && skillLayerCooling._id == _id)
		{
			base.ReleaseParamValue = Mathf.Clamp(base.ReleaseParamValue + skillLayerCooling.ReleaseParamValue, 0f, 9999f);
		}
	}

	public override void Update()
	{
		if (_heroSkillData != null)
		{
			base.CurrentParamValue = _heroSkillData.CacheLayer;
		}
	}

	public override string NotEnoughConditionText(List<string> tipTexts)
	{
		if (!enoughCondition && !tipTexts.Contains("层数"))
		{
			tipTexts.Add("层数");
			return "层数";
		}
		return string.Empty;
	}
}
