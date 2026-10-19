using ACT.Battle;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public class InMapAreaCondition : MissionCondition
{
	protected override async void OnActivate()
	{
		if (IsRepeat)
		{
			do
			{
				if (!CheckCondition())
				{
					await UniTask.Yield();
					continue;
				}
				MarkSuccess();
				while (IsActive && CheckCondition())
				{
					await UniTask.Yield();
				}
			}
			while (IsActive);
			return;
		}
		do
		{
			if (CheckCondition())
			{
				MarkSuccess();
				break;
			}
			await UniTask.Yield();
		}
		while (IsActive);
	}

	public override bool PreCheckCondition()
	{
		return CheckCondition();
	}

	private bool CheckCondition()
	{
		InMapAreaConditionParam inMapAreaConditionParam = Param as InMapAreaConditionParam;
		if (!MonoECS.instance)
		{
			return false;
		}
		if (Singleton<GameManager>.instance.worldManager.ActiveMapId != (int)inMapAreaConditionParam.map)
		{
			return false;
		}
		return true;
	}
}
