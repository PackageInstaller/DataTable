using System.Collections.Generic;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;

[AddComponentMenu("触发器结果/关卡事件/触发掉落物", 0)]
public class Task_DropObject : TaskCellBase
{
	public int dropEntityGroupId;

	[SerializeField]
	[Range(0f, 1f)]
	public float dropEntityRate = 1f;

	private FP dropEntityRateFP;

	protected override void OnInit()
	{
		base.OnInit();
		dropEntityRateFP = FP.FromConfigFloat(dropEntityRate);
	}

	protected override void OnExecute()
	{
		if (MonoSingleton<GameController>.Instance.Random_Roguelike(FP.Zero, FP.One) <= dropEntityRateFP)
		{
			TSVector2 specifyMonsterPos = GetSpecifyMonsterPos();
			List<DropObjectGroup> list = Singleton<HotfixDataController>.Instance.DropObjectGroupData.FindAll((DropObjectGroup x) => object.Equals(x.DropObjectGroupId, dropEntityGroupId));
			int num = 0;
			Dictionary<DropObjectGroup, int> dictionary = new Dictionary<DropObjectGroup, int>();
			for (int num2 = 0; num2 < list.Count; num2++)
			{
				num += list.get_Item(num2).Weight;
				dictionary.set_Item(list.get_Item(num2), num);
			}
			int num3 = 0;
			if (num > 0)
			{
				float num4 = Random(0, num);
				foreach (KeyValuePair<DropObjectGroup, int> item in dictionary)
				{
					if (num4 < (float)item.Value)
					{
						num3 = item.Key.DropObjectId;
						break;
					}
				}
			}
			if (num3 != 0)
			{
				PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
				SceneSingleton<DropsManager>.Instance.PlayDropsByDropId(activedPlayerActor, num3, specifyMonsterPos, activedPlayerActor.tsTransform.PositionY);
			}
		}
		EndAction();
	}

	private float Random(float min, float max)
	{
		float result = min;
		if (null != MonoSingleton<GameController>.Instance)
		{
			result = (float)MonoSingleton<GameController>.Instance.Random_Roguelike(min, max);
		}
		else
		{
			Debug.LogError("缺少[GameController.cs]");
		}
		return result;
	}

	private float Random(int min, int max)
	{
		int num = min;
		if (null != MonoSingleton<GameController>.Instance)
		{
			num = MonoSingleton<GameController>.Instance.Random_Roguelike(min, max);
		}
		else
		{
			Debug.LogError("缺少[GameController.cs]");
		}
		return num;
	}
}
