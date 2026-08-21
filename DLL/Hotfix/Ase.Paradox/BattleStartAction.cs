using System;
using Ase.ECS;
using GameFramework;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("战斗开始节点", 0)]
[Category("✫ DragonLost/System")]
[Description("怪物使用 初始化战斗并设置相关参数，如战斗倒计时、Boss血条延迟等。")]
public class BattleStartAction : ActionTaskBase
{
	[Name("是否显示战斗倒计时", 0)]
	[Description("是否显示战斗开始时的倒计时。")]
	public BBParameter<bool> showTime = true;

	[Name("战斗倒计时延迟", 0)]
	[Description("设置战斗开始时倒计时显示的延迟时间，单位为秒。")]
	public BBParameter<float> Time;

	[Name("Boss血条延迟", 0)]
	[Description("设置Boss血条显示的延迟时间，单位为秒。")]
	public BBParameter<float> BarTime;

	[Name("Boss名字延迟", 0)]
	[Description("设置Boss名字显示的延迟时间，单位为秒。")]
	public BBParameter<float> NameTime;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (ownerEntity.GetSystem<BattleSystem>().GetSpecialModeEnum() != BattleSpecialModeEnum.None)
		{
			OnActionFail("当前为特殊模式，无法使用战斗开始节点，请移除");
			return;
		}
		BattleSystem system = ownerEntity.GetSystem<BattleSystem>();
		if (system == null)
		{
			OnActionFail("BattleSystem为空");
			return;
		}
		ActivityRoundBattleSystem system2 = ownerEntity.GetWorld().GetSystem<ActivityRoundBattleSystem>();
		if (system2 != null)
		{
			system2.IsStart = true;
		}
		if (showTime.value)
		{
			system.SetBattleTimeDelay(Time.value);
			ownerEntity.GetSystem<BattleInfoSystem>()?.SetBattleTimeDelay(Time.value);
		}
		IEntityRoom entityRoom = ownerEntity;
		if (entityRoom != null && entityRoom.InLocalActorRoom())
		{
			system.SetMonsterBloodDelay(BarTime.value);
		}
		if ((double)Math.Abs(NameTime.value - -1f) > 0.0010000000474974513)
		{
			system.SetMonsterNameDelay(NameTime.value);
		}
		if (ownerEntity.GetWorld().IsStoryWorld && ownerEntity.GetEntityType() == EntityType.MONSTER)
		{
			MonsterNode data = GetOwnerEntity().GetData<MonsterNode>("MAPDATANODEKEY");
			if ((UnityEngine.Object)(object)data != null)
			{
				data.OpenBossBloodBar(value: true);
			}
		}
		if (ownerEntity is MonsterEntity { IsBoss: not false } monsterEntity)
		{
			monsterEntity.GetSystem<BattleStateSystem>().BossBattleStartHandle(monsterEntity);
			if (system.BattleMode == BattleWorldMode.SingleBattle || system.BattleMode == BattleWorldMode.SyncBattle)
			{
				ObserverBattleStartParams param = ReferencePool.Acquire<ObserverBattleStartParams>();
				monsterEntity.GetSystem<BattleObserverSystem>().Notify(BattleObserverEventEnum.BattleStart, param);
			}
		}
		EndAction();
	}
}
