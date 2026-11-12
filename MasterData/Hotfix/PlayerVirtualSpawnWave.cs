using UnityEngine;

public class PlayerVirtualSpawnWave : BaseSpawnPointGizmo
{
	[Space]
	public HotfixEnum.fixedRoguelikeGameplayType groupIndex;

	public int ChildCount
	{
		get
		{
			int num = 0;
			int childCount = transform.childCount;
			for (int i = 0; i < childCount; i++)
			{
				if (transform.GetChild(i).gameObject.activeSelf)
				{
					num++;
				}
			}
			return num;
		}
	}
}
