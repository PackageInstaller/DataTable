using System.Collections.Generic;
using Ase;
using Ase.ECS;
using UnityEngine;

public class BuffCooling : CoolingBase
{
	private int _buffId;

	public int BuffId => _buffId;

	public BuffCooling(string[] param, bool isConsumeCondition, BaseEntity baseEntity)
		: base(param, isConsumeCondition, baseEntity)
	{
		if (param.Length != 0)
		{
			_buffId = Utility.Convert.StringToInt(param[1]);
			base.ReleaseParamValue = int.Parse(isConsumeCondition ? param[2] : param[3]);
		}
	}

	public override bool Check()
	{
		int num = 0;
		Buff buff = entity.GetSystem<BuffSystem>()?.FindEntityBuff(entity.Id, _buffId);
		if (buff != null)
		{
			num = buff.GetLayer();
		}
		if (!isConsumeCondition)
		{
			enoughCondition = ReleaseOption(num);
			return enoughCondition;
		}
		enoughCondition = ConditionExtensions.CompareValueMethod(CompareMethodType.GOrE, num, base.ReleaseParamValue);
		return enoughCondition;
	}

	public override void Release()
	{
		base.Release();
		Buff buff = entity.GetSystem<BuffSystem>()?.FindEntityBuff(entity.Id, _buffId);
		buff?.SetLayer(buff.GetLayer() - (int)base.ReleaseParamValue);
	}

	public override void Cultivate(CoolingBase coolingBase)
	{
		if (coolingBase.IsConsumeCondition == base.IsConsumeCondition && coolingBase is BuffCooling buffCooling && buffCooling._buffId == _buffId)
		{
			base.ReleaseParamValue = Mathf.Clamp(base.ReleaseParamValue + buffCooling.ReleaseParamValue, 0f, 9999f);
		}
	}

	public override string NotEnoughConditionText(List<string> tipTexts)
	{
		if (!enoughCondition)
		{
			DRBuff dataRow = GameEntry.DataTable.GetDataRow<DRBuff>(_buffId);
			if (dataRow != null)
			{
				if (tipTexts.Contains(dataRow.Name))
				{
					return string.Empty;
				}
				tipTexts.Add(dataRow.Name);
				return dataRow.Name;
			}
		}
		return string.Empty;
	}
}
