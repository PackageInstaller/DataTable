namespace Ase;

public class SkillBtnActiveBuff : BuffOperationBase<BuffDataSkillBtnActive>
{
	protected override void OnExecute()
	{
		if (!base.buffOwner.IsActorEntity || dataBase.heroSkillTypeEnums.IsNullOrEmpty() || dataBase.actives.IsNullOrEmpty() || dataBase.heroSkillTypeEnums.Length != dataBase.actives.Length)
		{
			return;
		}
		TouchSystem system = base.buffOwner.GetSystem<TouchSystem>();
		if (system != null)
		{
			for (int i = 0; i < dataBase.heroSkillTypeEnums.Length; i++)
			{
				system.SetSkillBtnHide(dataBase.heroSkillTypeEnums[i], dataBase.actives[i]);
			}
		}
	}

	protected override void OnDispose()
	{
		if (dataBase.heroSkillTypeEnums.IsNullOrEmpty() || dataBase.actives.IsNullOrEmpty() || dataBase.heroSkillTypeEnums.Length != dataBase.actives.Length)
		{
			return;
		}
		TouchSystem touchSystem = base.buffOwner?.GetSystem<TouchSystem>();
		if (touchSystem != null)
		{
			for (int i = 0; i < dataBase.heroSkillTypeEnums.Length; i++)
			{
				touchSystem.SetSkillBtnHide(dataBase.heroSkillTypeEnums[i], !dataBase.actives[i]);
			}
		}
	}
}
