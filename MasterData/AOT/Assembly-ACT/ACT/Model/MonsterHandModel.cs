using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model.Jump;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;
using Pb;

namespace ACT.Model;

public class MonsterHandModel : Model<MonsterHandModel>, IJumpable
{
	public Dictionary<int, List<EntityEnemyData>> MonsterHandDic = new Dictionary<int, List<EntityEnemyData>>();

	public Dictionary<int, int> monsterBook = new Dictionary<int, int>();

	private Dictionary<int, bool> _wildBossUnLockDic = new Dictionary<int, bool>();

	public LuminModelType JumpSourceType => LuminModelType.MonsterType;

	private void Start()
	{
	}

	private void Update()
	{
	}

	protected override void Init()
	{
		if (MonsterHandDic == null || MonsterHandDic.Count == 0)
		{
			InitMonsterHandData();
		}
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.MonsterDieCount, OnRefreshMosterDieCount);
	}

	public void MergeHandBookInfo(Handbook data)
	{
		monsterBook.Clear();
		monsterBook.AddRange(data.MonsterHandbook.TypeKilledCount);
	}

	private void InitMonsterHandData()
	{
		int[] monsterHandListType = RuntimeConfigs.data.game.MonsterHandListType;
		Dictionary<int, EntityEnemyData> entityEnemyDatas = RuntimeConfigs.data.entityEnemyDatas;
		if (entityEnemyDatas == null)
		{
			return;
		}
		foreach (KeyValuePair<int, EntityEnemyData> item in entityEnemyDatas)
		{
			EntityData data = CoreUtils.GetData(item.Value.id, RuntimeConfigs.data.entityDatas);
			if (!item.Value.isShowInMonsterBook)
			{
				continue;
			}
			for (int i = 0; i < monsterHandListType.Length; i++)
			{
				if (monsterHandListType[i] == data.type)
				{
					if (MonsterHandDic.TryGetValue(data.type, out var value))
					{
						value.Add(item.Value);
						continue;
					}
					MonsterHandDic.Add(data.type, new List<EntityEnemyData> { item.Value });
				}
			}
		}
	}

	protected override void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MonsterDieCount, OnRefreshMosterDieCount);
	}

	public bool MonsterIsUnLock(int type)
	{
		if (monsterBook.ContainsKey(type))
		{
			return true;
		}
		return false;
	}

	private void OnRefreshMosterDieCount(BaseEventContent obj)
	{
		EntityDieEvt entityDieEvt = (EntityDieEvt)obj;
		SendMonsterKillNum(entityDieEvt.entity.GetCompMonster().id);
	}

	public int GetKillNum(int type)
	{
		if (monsterBook.TryGetValue(type, out var value))
		{
			return value;
		}
		return 0;
	}

	public bool IsUnlockByenemyType(int enemyType)
	{
		return monsterBook.ContainsKey(enemyType);
	}

	public void SendUnLockMonster(int enemyType)
	{
		G.service.SendUnLockMonster(enemyType, (bool r) =>
		{
			if (r && !monsterBook.ContainsKey(enemyType))
			{
				monsterBook.Add(enemyType, 0);
				MonsterUnLock monsterUnLock = new MonsterUnLock
				{
					enemyType = enemyType
				};
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.MonsterUnlock, monsterUnLock);
				Singleton<EventManager>.instance.ReleaseEvt(monsterUnLock);
			}
		});
	}

	public void SendUnLockWildBoss(int monsterPointId)
	{
		if (WildBossUnLock(monsterPointId))
		{
			return;
		}
		G.service.SendUnLockWildBoss(monsterPointId, (bool r) =>
		{
			if (r)
			{
				_wildBossUnLockDic.TryAdd(monsterPointId, value: true);
			}
		});
	}

	public void InitWildBossDic(Handbook data)
	{
		_wildBossUnLockDic.Clear();
		_wildBossUnLockDic.AddRange(data.MonsterHandbook.UnlockedWildbossIds);
	}

	public bool WildBossUnLock(int monsterPointId)
	{
		return _wildBossUnLockDic.ContainsKey(monsterPointId);
	}

	public void SendMonsterKillNum(int Monsterid)
	{
		G.service.SendKillMonsterNum(Monsterid, (HandbookUpdateAck r) =>
		{
			if (r != null)
			{
				foreach (KeyValuePair<int, int> item in r.MonsterKilledCount)
				{
					if (monsterBook.ContainsKey(item.Key))
					{
						monsterBook[item.Key] = item.Value;
					}
					else
					{
						monsterBook.Add(item.Key, 1);
					}
				}
			}
		});
	}

	private static RuntimeJumpData ConvertTraverseMonsterParams(RuntimeJumpData jumpData)
	{
		List<int> list = jumpData.Params;
		if (list == null || list.Count != 2)
		{
			return jumpData;
		}
		jumpData.Params = new List<int>
		{
			jumpData.Params[0],
			1,
			Model<WorldLevelModel>.Interface.GetCurWorldLevel(),
			jumpData.Params[1]
		};
		return jumpData;
	}

	public JumpResult CanJump(RuntimeJumpData jumpData)
	{
		jumpData = ConvertTraverseMonsterParams(jumpData);
		return Model<MapModel>.Interface.CanJump(jumpData);
	}

	public void Jump(RuntimeJumpData jumpData)
	{
		jumpData = ConvertTraverseMonsterParams(jumpData);
		Model<MapModel>.Interface.Jump(jumpData);
	}
}
