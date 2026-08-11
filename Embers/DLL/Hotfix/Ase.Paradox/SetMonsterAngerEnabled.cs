using Ase.ECS;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("Boss怒气值修改开关", 0)]
[Category("✫ DragonLost/Monster")]
[Description("获取小怪强度.")]
public class SetMonsterAngerEnabled : ActionTaskBase
{
	[Name("BOSS怒气值停止修改", 0)]
	public bool isEnabled;

	[Name("是否跟随行为树结束重置", 0)]
	public bool isFollowTreeDispose;

	protected override void OnExecute()
	{
		base.OnExecute();
		((ownerEntity.GetSystem<BattleSystem>()?.GetMonsterEntity())?.GetComponent<MonsterPhaseComponent>())?.SetAngerEnabled(isEnabled);
		EndAction();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (isFollowTreeDispose)
		{
			((ownerEntity.GetSystem<BattleSystem>()?.GetMonsterEntity())?.GetComponent<MonsterPhaseComponent>())?.SetAngerEnabled(!isEnabled);
		}
	}
}
