namespace Ase;

public class SkillBtnHighLightBySkillTypeBuff : BuffOperationBase<BuffDataSkillBtnHighLightBySkillType>
{
	protected override void OnExecute()
	{
		if (!base.buffOwner.IsActorEntity || dataBase.skillTypes.IsNullOrEmpty() || dataBase.actives.IsNullOrEmpty() || dataBase.skillTypes.Length != dataBase.actives.Length)
		{
			return;
		}
		TouchSystem system = base.buffOwner.GetSystem<TouchSystem>();
		if (system != null)
		{
			for (int i = 0; i < dataBase.skillTypes.Length; i++)
			{
				system.SetSkillTeachClickEffect(dataBase.skillTypes[i], dataBase.actives[i]);
			}
		}
	}

	protected override void OnDispose()
	{
		if (!base.buffOwner.IsActorEntity || dataBase.skillTypes.IsNullOrEmpty() || dataBase.actives.IsNullOrEmpty() || dataBase.skillTypes.Length != dataBase.actives.Length)
		{
			return;
		}
		TouchSystem system = base.buffOwner.GetSystem<TouchSystem>();
		if (system != null)
		{
			for (int i = 0; i < dataBase.skillTypes.Length; i++)
			{
				system.SetSkillTeachClickEffect(dataBase.skillTypes[i], dataBase.actives[i]);
			}
		}
	}
}
