using Ase.ECS;

namespace Ase;

public class SkillBtnActiveByIdBuff : BuffOperationBase<BuffDataSkillBtnActiveById>
{
	protected override void OnExecute()
	{
		if (!base.buffOwner.IsActorEntity || dataBase.skillIds.IsNullOrEmpty() || dataBase.actives.IsNullOrEmpty() || dataBase.skillIds.Length != dataBase.actives.Length || base.buffOwner.GetSystem<TouchSystem>() == null)
		{
			return;
		}
		SkillComponent component = base.buffOwner.GetComponent<SkillComponent>();
		if (component != null)
		{
			for (int i = 0; i < dataBase.skillIds.Length; i++)
			{
				component.SetSkillNormalShow(dataBase.skillIds[i], dataBase.actives[i]);
			}
		}
	}

	protected override void OnDispose()
	{
		if (!base.buffOwner.IsActorEntity || dataBase.skillIds.IsNullOrEmpty() || dataBase.actives.IsNullOrEmpty() || dataBase.skillIds.Length != dataBase.actives.Length)
		{
			return;
		}
		SkillComponent component = base.buffOwner.GetComponent<SkillComponent>();
		if (component != null)
		{
			for (int i = 0; i < dataBase.skillIds.Length; i++)
			{
				component.SetSkillNormalShow(dataBase.skillIds[i], !dataBase.actives[i]);
			}
		}
	}
}
