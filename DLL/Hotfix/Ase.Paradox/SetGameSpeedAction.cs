using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("设置游戏速度", 0)]
[Category("✫ DragonLost/System")]
[Description("游戏播放速度*持续时间 != 正整数时，可能出现多时缓1帧的误差")]
public class SetGameSpeedAction : ActionTaskBase
{
	[Name("游戏播放速度", 0)]
	public BBParameter<float> GamePlaySpeed;

	[Name("优先级", 0)]
	public int Priority;

	[Name("是否选择实体列表", 0)]
	public bool UseEntitys;

	[Name("不受影响的实体ID", 0)]
	[ShowIf("UseEntitys", false)]
	public BBParameter<int> IgnoreEntityId;

	[Name("不受影响的实体列表", 0)]
	[ShowIf("UseEntitys", true)]
	public List<int> IgnoreEntityIdList;

	[Name("持续时间（逻辑帧）", 0)]
	public BBParameter<int> Duration;

	[Name("破绽是否受影响", 0)]
	[Description("破绽是否受影响")]
	public bool IsEffectWeakness;

	[Name("随行为树结束还原", 0)]
	[Description("随行为树还原到1")]
	public bool IsTreeStopRestore;

	[Name("联机是否生效", 0)]
	public bool IsCtrlGlobal;

	[Name("AI执行是否生效", 0)]
	public bool IsAIEffect;

	private int gameSpeedIndex;

	protected override void OnExecute()
	{
		base.OnExecute();
		gameSpeedIndex = 0;
		if (ownerEntity == null || Duration.value == 0)
		{
			EndAction();
			return;
		}
		BattleWorldMode battleMode = ownerEntity.GetSystem<BattleSystem>().BattleMode;
		List<int> ignoreEntitys = null;
		if (UseEntitys)
		{
			ignoreEntitys = IgnoreEntityIdList;
		}
		else if (IgnoreEntityId.value != 0)
		{
			ignoreEntitys = new List<int> { IgnoreEntityId.value };
		}
		if (battleMode == BattleWorldMode.SyncBattle || battleMode == BattleWorldMode.GameBack)
		{
			if (IsCtrlGlobal)
			{
				gameSpeedIndex = ownerEntity.GetWorld().AddGameSpeedInfo(Priority, GamePlaySpeed.value, Duration.value, IsEffectWeakness, ignoreEntitys, ownerEntity);
			}
		}
		else if (!IsAIEffect)
		{
			if (ownerEntity.Id == ownerEntity.GetWorld().ActorId)
			{
				gameSpeedIndex = ownerEntity.GetWorld().AddGameSpeedInfo(Priority, GamePlaySpeed.value, Duration.value, IsEffectWeakness, ignoreEntitys, ownerEntity);
			}
		}
		else
		{
			gameSpeedIndex = ownerEntity.GetWorld().AddGameSpeedInfo(Priority, GamePlaySpeed.value, Duration.value, IsEffectWeakness, ignoreEntitys, ownerEntity);
		}
		EndAction();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (ownerEntity != null && IsTreeStopRestore)
		{
			ownerEntity.GetWorld().RemoveGameSpeedInfo(gameSpeedIndex);
		}
	}
}
