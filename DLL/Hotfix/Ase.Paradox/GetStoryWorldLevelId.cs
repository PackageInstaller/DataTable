using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取关卡ID", 0)]
[Category("✫ DragonLost/Scene")]
[Description("在关卡中获取当前关卡ID")]
public class GetStoryWorldLevelId : ActionTaskBase
{
	[Name("关卡ID", 0)]
	[Description("返回的关卡ID，如果不在关卡中返回0")]
	public BBParameter<int> LevelID;

	protected override void OnExecute()
	{
		LevelID.value = 0;
		base.OnExecute();
		if (ownerEntity.GetSystem<BattleSystem>().BattleMode == BattleWorldMode.LevelBattle)
		{
			if (ownerEntity.GetWorld() is StoryWorld storyWorld)
			{
				LevelID.value = storyWorld.LevelId;
			}
		}
		else
		{
			LevelID.value = 0;
		}
		OnActionFinish();
	}
}
