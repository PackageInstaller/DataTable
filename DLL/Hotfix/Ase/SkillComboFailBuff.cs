namespace Ase;

public class SkillComboFailBuff : BuffOperationBase<BuffDataSkillComboFail>
{
	protected override void OnExecute()
	{
		base.buffOwner.GetSystem<TeachGuideSystem>()?.ForceCurrentSkillComboFail();
	}
}
