#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;

namespace Ase;

public class ActivityAchievementData
{
	public int id;

	public string name;

	public int activityType;

	public int type;

	public string typeName;

	public string iconPath;

	public int quality;

	public int sort;

	public string desc;

	public List<string> levelDesc;

	public ActivityAchievementState state;

	public List<int> buffIds;

	public ActivityAchievementData(int id, int activityType, ActivityAchievementState state)
	{
		this.id = id;
		this.activityType = activityType;
		this.state = state;
	}

	public void InitCfs(DRLibraryTower cfs)
	{
		if (cfs == null)
		{
			Log.Error("初始化失败，DRLibraryTower为空！");
			return;
		}
		name = cfs.Name;
		type = cfs.Type;
		typeName = cfs.TypeName;
		iconPath = cfs.Icon;
		quality = cfs.Quality;
		sort = cfs.Sort;
		desc = cfs.EffectDesc;
		levelDesc = cfs.LevelDesc;
		buffIds = cfs.BuffId;
	}
}
