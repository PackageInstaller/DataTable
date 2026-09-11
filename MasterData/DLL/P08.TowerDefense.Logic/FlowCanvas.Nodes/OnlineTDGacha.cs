using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[OnlineTD]抽卡", 0)]
[Category("Active/TowerDefense/Common")]
[Description("逻辑层抽卡")]
public class OnlineTDGacha : FlowControlNodeOfLogic
{
	private SimWorldState simWorldState;

	private List<int> playerList;

	private int m_position;

	private bool isInit;

	private List<int> result;

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		m_position = 0;
		simWorldState = null;
		playerList = null;
		isInit = false;
		result = null;
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		m_position = 0;
		simWorldState = null;
		playerList = null;
		isInit = false;
		result = null;
	}

	protected override void RegisterPorts()
	{
		AddValueInput<int>("本地玩家ID", "roleID");
		ValueInput<int> triggerID = AddValueInput<int>("触发器ID", "triggerID");
		ValueInput<int> activeID = AddValueInput<int>("活动配置ID", "activeID");
		ValueInput<int> wave = AddValueInput<int>("波次", "wave");
		ValueInput<bool> isOpenEgg = AddValueInput<bool>("是否抽取彩蛋", "isOpenEgg");
		ValueInput<uint> eggPercent = AddValueInput<uint>("彩蛋概率", "eggPercent");
		ValueInput<List<int>> gachaList = AddValueInput<List<int>>("卡池list", "gachaList");
		AddValueOutput("触发器ID", () => triggerID.value);
		AddValueOutput("抽卡结果", () => result);
		FlowOutput output = AddFlowOutput("Out", "output");
		AddFlowOutput("Error", "error");
		AddFlowInput("抽卡", "gacha", delegate(Flow f)
		{
			if (!isInit)
			{
				simWorldState = base.mSimContext.sEntityWorldState.status;
				playerList = new List<int>();
				Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = simWorldState.mRoomMembers.GetEnumerator();
				int num = 0;
				while (enumerator.MoveNext())
				{
					playerList.Add(enumerator.Current.Value.mEntityID);
					if (enumerator.Current.Value.mEntityID == simWorldState.mLocalPlayerID)
					{
						m_position = num;
					}
					num++;
				}
				isInit = true;
			}
			result = gachaList.value;
			activity_online_match config = ConfigHelper.GetInstance().GetConfig<activity_online_match>(activeID.value);
			int type = config.Type;
			List<int> list = new List<int>();
			result.Clear();
			if (config.WaveBaseRelation.Count > wave.value - 1)
			{
				list.AddRange(config.WaveBaseRelation.get_Item(wave.value - 1).Data);
			}
			if (list.Count >= 3)
			{
				for (int i = 0; i < 3; i++)
				{
					for (int j = 0; j < 3; j++)
					{
						result.Add(list[j]);
					}
				}
				output.Call(f);
			}
			else
			{
				bool flag = isOpenEgg.value;
				List<int> list2 = new List<int>();
				if (config.Unique)
				{
					list2.AddRange(simWorldState.m_tower_gacha_List[type]);
				}
				for (int k = 0; k < playerList.Count; k++)
				{
					SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(playerList[k]);
					if (entityWithEntityID == null)
					{
						for (int l = 0; l < 3; l++)
						{
							result.Add(0);
						}
					}
					else
					{
						List<int> list3 = new List<int>();
						result.AddRange(list);
						List<int> list4 = new List<int>();
						List<int> list5 = (config.Unique ? list2 : new List<int>(simWorldState.m_tower_gacha_List[type]));
						for (int m = list.Count; m < 3; m++)
						{
							list3.Clear();
							int rareLow = 0;
							int rareHigh = 255;
							if (config.WaveRareRelation.Count > wave.value - 1)
							{
								rareLow = config.WaveRareRelation.get_Item(wave.value - 1).Data.get_Item(0);
								rareHigh = config.WaveRareRelation.get_Item(wave.value - 1).Data.get_Item(1);
							}
							List<int> personGachaPoll = GetPersonGachaPoll(list5, rareLow, rareHigh, entityWithEntityID);
							if (flag && DRandom.Random(100u) < eggPercent.value)
							{
								personGachaPoll.AddRange(simWorldState.m_tower_gacha_List[3]);
								flag = false;
							}
							if (personGachaPoll.Count == 0)
							{
								personGachaPoll.Add(0);
							}
							else
							{
								RandomSelect(personGachaPoll, 3, list3);
								for (int n = 0; n < list3.Count; n++)
								{
									if (!list4.Contains(list3[n]))
									{
										list4.Add(list3[n]);
										if (config.Unique)
										{
											list5.Remove(list3[n]);
										}
										break;
									}
								}
							}
						}
						result.AddRange(list4);
						for (int num2 = list4.Count; num2 < 3; num2++)
						{
							result.Add(0);
						}
					}
				}
				output.Call(f);
			}
		});
	}

	private List<int> GetPersonGachaPoll(List<int> originPool, int rareLow, int rareHigh, SimEntity entity, bool canRepeat = false)
	{
		if (canRepeat)
		{
			return originPool;
		}
		List<int> list = new List<int>();
		ConfigHelper instance = ConfigHelper.GetInstance();
		for (int i = 0; i < originPool.Count; i++)
		{
			activity_online_tower config = instance.GetConfig<activity_online_tower>(originPool[i]);
			if (config.Rare >= rareLow && config.Rare <= rareHigh && !BuffProcessor.HasBuffOfClassID(entity, config.BuffConfigId))
			{
				list.Add(originPool[i]);
			}
		}
		return list;
	}

	private void RandomSelect(List<int> ori, int count, List<int> target)
	{
		if (ori.Count <= count)
		{
			target.AddRange(ori);
			return;
		}
		int count2 = target.Count;
		for (int i = 0; i < count; i++)
		{
			target.Add(ori[i]);
		}
		for (int j = count; j < ori.Count; j++)
		{
			int num = (int)DRandom.Random((uint)(j + 1));
			if (num < count)
			{
				target[count2 + num] = ori[j];
			}
		}
	}
}
