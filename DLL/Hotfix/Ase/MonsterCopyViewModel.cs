using UnityEngine;

namespace Ase;

public class MonsterCopyViewModel : OptionBase
{
	private string taskContent;

	private string killCount;

	private Transform root;

	public Transform Root => root;

	public string TaskContent
	{
		get
		{
			return taskContent;
		}
		set
		{
			Set(ref taskContent, value, "TaskContent");
		}
	}

	public string KillCount
	{
		get
		{
			return killCount;
		}
		set
		{
			Set(ref killCount, value, "KillCount");
		}
	}

	public MonsterCopyViewModel()
	{
	}

	public MonsterCopyViewModel(OptionBase parent, Transform root)
	{
		this.root = root;
	}
}
