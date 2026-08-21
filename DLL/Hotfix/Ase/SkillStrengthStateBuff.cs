using Ase.ECS;

namespace Ase;

public class SkillStrengthStateBuff : BuffOperationBase<BuffDataSkillStrengthState>
{
	protected override void OnExecute()
	{
		base.buffOwner.GetComponent<SkillComponent>()?.SetSkillStrengthen(dataBase.skillId, dataBase.state);
	}

	protected override void OnDispose()
	{
		base.buffOwner.GetComponent<SkillComponent>()?.SetSkillStrengthen(dataBase.skillId, !dataBase.state);
	}
}
