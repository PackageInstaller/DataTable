using System.Collections.Generic;
using Ase.ECS;
using UnityEngine.Pool;

namespace Ase;

public class SkillLabelAdditionBuff : BuffOperationBase<BuffDataSkillLabelAddition>
{
	private float curAddition;

	private List<HeroSkillData> heroSkillDataList;

	protected override void OnExecute()
	{
		OnAddition();
	}

	private void OnAddition()
	{
		float num = dataBase.addition;
		if (base.config.LayerOverlying)
		{
			num *= (float)base.buff.GetLayer();
		}
		if (num == 0f)
		{
			return;
		}
		SkillComponent component = base.buffOwner.GetComponent<SkillComponent>();
		if (component == null)
		{
			return;
		}
		heroSkillDataList = component.GetSkillDataListByLabel(dataBase.skillLabelParams);
		if (heroSkillDataList == null)
		{
			return;
		}
		foreach (HeroSkillData heroSkillData in heroSkillDataList)
		{
			heroSkillData.SetSkillAddition(dataBase.additionKind, num);
			AddBuffOperationRecord($"Buff执行\t技能ID:{heroSkillData.Id} {heroSkillData.SkillAdditionData?.ToString()}");
		}
		curAddition += num;
	}

	protected override void OnUpdateLayerChanged(int deltaLayer)
	{
		base.OnUpdateLayerChanged(deltaLayer);
		if (base.buff.HasOperations)
		{
			ClearAddition();
			OnAddition();
		}
	}

	protected override void OnDispose()
	{
		ClearAddition();
	}

	private void ClearAddition()
	{
		if (heroSkillDataList.IsNullOrEmpty() || curAddition == 0f)
		{
			return;
		}
		foreach (HeroSkillData heroSkillData in heroSkillDataList)
		{
			heroSkillData.SetSkillAddition(dataBase.additionKind, 0f - curAddition);
			AddBuffOperationRecord($"Buff清除\t技能ID:{heroSkillData.Id}   {heroSkillData.SkillAdditionData?.ToString()}");
		}
		curAddition = 0f;
	}

	protected override void OnClear()
	{
		if (heroSkillDataList != null)
		{
			CollectionPool<List<HeroSkillData>, HeroSkillData>.Release(heroSkillDataList);
			heroSkillDataList = null;
		}
	}
}
