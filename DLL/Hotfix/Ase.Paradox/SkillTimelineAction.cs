#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using Ase.ECS;
using GameFramework;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("播放timeline", 0)]
[Category("✫ DragonLost/Timeline")]
[Description("播放配置好的timeline")]
public class SkillTimelineAction : ActionTaskBase
{
	[Name("timeline ID", 0)]
	public int timelineID;

	[Name("是否影响多人", 0)]
	public bool multiExcute;

	[ShowIf("multiExcute", true)]
	[Name("是否有限人播放", 0)]
	public bool multiLimit;

	[ShowIf("multiExcute", true)]
	[Name("影响多人的id列表", 0)]
	public BBParameter<List<int>> multiList;

	protected override void OnExecute()
	{
		base.OnExecute();
		DRParadoxTimeline dataRow = GameEntry.DataTable.GetDataRow<DRParadoxTimeline>(timelineID);
		if (dataRow == null)
		{
			Log.Error($"ID {timelineID} 表数据为空");
			EndAction();
			return;
		}
		List<int> list = new List<int>();
		if (multiExcute)
		{
			if (multiLimit)
			{
				list = multiList.value;
			}
			else
			{
				List<HeroEntity> playerTeamList = ownerEntity.GetWorld().GetSystem<EntitySystem>().PlayerTeamList;
				for (int i = 0; i < playerTeamList.Count; i++)
				{
					list.Add(playerTeamList[i].Id);
				}
			}
		}
		else
		{
			list.Add(ownerEntity.Id);
		}
		ownerEntity.GetSystem<ParadoxTimelineSystem>().StartParadoxTimeline(dataRow, ownerEntity, list);
		EndAction();
	}
}
