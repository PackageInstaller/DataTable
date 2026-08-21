using Ase.ECS;

namespace Ase;

public class SkillAdditionBuff : BuffOperationBase<BuffDataSkillAddition>
{
	private float curAddition;

	private HeroSkillData heroSkillData;

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
		if (component != null)
		{
			heroSkillData = component.GetSkillData(dataBase.skillId);
			if (heroSkillData != null)
			{
				heroSkillData.SetSkillAddition(dataBase.additionKind, num);
				curAddition += num;
				AddBuffOperationRecord($"Buff执行\t技能ID:{heroSkillData.Id} {heroSkillData.SkillAdditionData?.ToString()}");
			}
		}
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
		if (heroSkillData != null && curAddition != 0f)
		{
			heroSkillData.SetSkillAddition(dataBase.additionKind, 0f - curAddition);
			AddBuffOperationRecord($"Buff清除\t技能ID:{heroSkillData.Id} {heroSkillData.SkillAdditionData?.ToString()}");
			curAddition = 0f;
		}
	}
}
