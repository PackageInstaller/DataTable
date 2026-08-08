using System;
using System.Collections.Generic;
using System.Linq;
using BilliardGame.Spell;
using UnityEngine;

namespace BilliardGame.Runtime;

public class EntityPlayer : BilliardGameEntityBase
{
	protected int attack;

	protected int shield;

	protected HeroType heroType;

	protected int lastTurnNum;

	protected int passiveSkillID;

	protected int activeSkillID;

	protected int skillCD;

	protected int maxSkillCD;

	protected int skillCost;

	protected List<BTEnv> buffList_;

	public Action<int> OnPropertyChange;

	private BilliardGameEffect skillEffect;

	public BilliardGameEffect specialEffect;

	private List<int[]> mergeGroupIds = new List<int[]>();

	private List<BTEnv[]> mergeBuffs = new List<BTEnv[]>();

	private bool isUseSkill;

	public int playerID { get; protected set; }

	public int maxHP { get; protected set; }

	public int remainHP { get; protected set; }

	public float speed { get; protected set; }

	public float linearDrag { get; protected set; }

	public int LastTurnNum
	{
		get
		{
			return lastTurnNum;
		}
		set
		{
			lastTurnNum = value;
		}
	}

	public BilliardGameBall logic { get; protected set; }

	public bool Dead => remainHP <= 0;

	public bool Tired => lastTurnNum <= 0;

	public float SPEED
	{
		get
		{
			float num = speed;
			for (int i = 0; i < buffList_.Count; i++)
			{
				if (buffList_[i].ContainKey("speed"))
				{
					num *= buffList_[i].GetStruct<float>("speed");
				}
			}
			return num;
		}
	}

	public int ATK
	{
		get
		{
			int num = attack;
			for (int i = 0; i < buffList_.Count; i++)
			{
				if (buffList_[i].ContainKey("add_atk"))
				{
					if (buffList_[i].ContainKey("level"))
					{
						int num2 = buffList_[i].GetStruct<int>("level");
						num += num2 * buffList_[i].GetStruct<int>("add_atk");
					}
					else
					{
						num += buffList_[i].GetStruct<int>("add_atk");
					}
				}
				if (buffList_[i].ContainKey("add_hit_damage"))
				{
					if (buffList_[i].ContainKey("level"))
					{
						int num3 = buffList_[i].GetStruct<int>("level");
						num += num3 * buffList_[i].GetStruct<int>("add_hit_damage");
					}
					else
					{
						num += buffList_[i].GetStruct<int>("add_hit_damage");
					}
				}
			}
			num += AddComboDamage;
			return num * AddHitRatioPercent / 100;
		}
	}

	public int SkillCost
	{
		get
		{
			for (int i = 0; i < buffList_.Count; i++)
			{
				if (buffList_[i].ContainKey("free_Skill") && buffList_[i].GetStruct<bool>("free_Skill"))
				{
					return 0;
				}
			}
			return skillCost;
		}
	}

	public Dictionary<int, int> SpeedChangeBuff
	{
		get
		{
			Dictionary<int, int> result = new Dictionary<int, int>();
			for (int i = 0; i < buffList_.Count; i++)
			{
				if (buffList_[i].ContainKey("speed_change_buff"))
				{
					result = buffList_[i].GetLinkedStruct<int, int>("speed_change_buff");
				}
			}
			return result;
		}
	}

	public int penerateDamage
	{
		get
		{
			for (int i = 0; i < buffList_.Count; i++)
			{
				if (buffList_[i].ContainKey("penerate_damage"))
				{
					return buffList_[i].GetStruct<int>("penerate_damage");
				}
			}
			return 0;
		}
	}

	public bool isIgnoreEnemyCollision
	{
		get
		{
			for (int i = 0; i < buffList_.Count; i++)
			{
				if (buffList_[i].ContainKey("ignore_enemy_collision"))
				{
					return buffList_[i].GetStruct<bool>("ignore_enemy_collision");
				}
			}
			return false;
		}
	}

	public int AddAoeDamage
	{
		get
		{
			int num = 0;
			for (int i = 0; i < buffList_.Count; i++)
			{
				if (buffList_[i].ContainKey("add_aoe_damage"))
				{
					num += buffList_[i].GetStruct<int>("add_aoe_damage");
				}
			}
			return num;
		}
	}

	public float AddAoeRatio
	{
		get
		{
			float num = 1f;
			for (int i = 0; i < buffList_.Count; i++)
			{
				if (buffList_[i].ContainKey("add_aoe_damage_ratio"))
				{
					num += buffList_[i].GetStruct<float>("add_aoe_damage_ratio");
				}
			}
			return num;
		}
	}

	public int AddHitRatioPercent
	{
		get
		{
			int num = 100;
			for (int i = 0; i < buffList_.Count; i++)
			{
				if (buffList_[i].ContainKey("add_atk_ratio"))
				{
					num += buffList_[i].GetStruct<int>("add_atk_ratio");
				}
			}
			return num;
		}
	}

	public int AddComboDamage
	{
		get
		{
			int result = 0;
			for (int i = 0; i < buffList_.Count; i++)
			{
				if (!buffList_[i].ContainKey("add_combo_damage"))
				{
					continue;
				}
				Dictionary<int, int> linkedStruct = buffList_[i].GetLinkedStruct<int, int>("add_combo_damage");
				int comboNum = BilliardGameLogicManager.Instance.GetComboNum();
				foreach (KeyValuePair<int, int> item in linkedStruct.OrderByDescending((KeyValuePair<int, int> x) => x.Key))
				{
					if (comboNum >= item.Key)
					{
						result = item.Value;
						break;
					}
				}
			}
			return result;
		}
	}

	public EntityPlayer(int entityID, GameObject go, int playerID, BilliardCharacterConfig cfg)
		: base(entityID, go)
	{
		attack = (int)cfg.baseAttack;
		maxHP = (int)cfg.baseHp;
		remainHP = maxHP;
		this.playerID = playerID;
		buffList_ = new List<BTEnv>();
		passiveSkillID = cfg.passiveSkillID;
		activeSkillID = cfg.activeSkillID;
		maxSkillCD = cfg.skillCd;
		skillCD = 0;
		skillCost = cfg.cost;
		heroType = (HeroType)cfg.heroType;
		speed = cfg.baseSpeed;
		linearDrag = cfg.baseCollideRatio;
		BilliardGameSpellManager.Instance.CastBuff(passiveSkillID, this);
		logic = base.go.GetComponentInChildren<BilliardGameBall>();
		logic.SetDrag(linearDrag);
	}

	public override void Dispose()
	{
		UnityEngine.Object.DestroyImmediate(base.go);
		for (int i = 0; i < buffList_.Count; i++)
		{
			buffList_[i].Dispose();
		}
		buffList_.Clear();
		mergeGroupIds.Clear();
		mergeBuffs.Clear();
	}

	private BTEnv FindBuff(int buffID, bool requireCombine)
	{
		return buffList_.Find((BTEnv e) => e.ContainKey("BuffId") && e.GetStruct<int>("BuffId") == buffID);
	}

	public override BTEnv GetBuff(int buffID)
	{
		return FindBuff(buffID, requireCombine: false);
	}

	public List<BTEnv> GetAllBuff()
	{
		return buffList_;
	}

	public void CheckBuffDispose()
	{
		List<int> list = new List<int>();
		for (int num = buffList_.Count - 1; num >= 0; num--)
		{
			BTEnv bTEnv = buffList_[num];
			if ((bTEnv.ContainKey("WaitForDispose") && bTEnv.GetStruct<bool>("WaitForDispose")) || !bTEnv.isRunning)
			{
				if (bTEnv.ContainKey("BuffId"))
				{
					int item = bTEnv.GetStruct<int>("BuffId");
					list.Add(item);
				}
				CleanupMergeBuffSlot(bTEnv);
				buffList_.RemoveAt(num);
			}
		}
		Queue<int> queue = new Queue<int>(list);
		HashSet<int> hashSet = new HashSet<int>(list);
		while (queue.Count > 0)
		{
			int buffId = queue.Dequeue();
			List<int> buffConnect = BilliardGameLogicManager.Instance.GetBuffConnect(buffId);
			for (int i = 0; i < buffConnect.Count; i++)
			{
				int num2 = buffConnect[i];
				if (hashSet.Contains(num2))
				{
					continue;
				}
				hashSet.Add(num2);
				for (int num3 = buffList_.Count - 1; num3 >= 0; num3--)
				{
					BTEnv bTEnv2 = buffList_[num3];
					if (bTEnv2.ContainKey("BuffId") && bTEnv2.GetStruct<int>("BuffId") == num2)
					{
						CleanupMergeBuffSlot(bTEnv2);
						buffList_.RemoveAt(num3);
						queue.Enqueue(num2);
						break;
					}
				}
			}
		}
	}

	public void OnPlayerRoundBegin()
	{
		isUseSkill = false;
		CheckBuffDispose();
		lastTurnNum = 1;
		for (int num = buffList_.Count - 1; num >= 0; num--)
		{
			BTEnv bTEnv = buffList_[num];
			if (bTEnv.GetStruct<BuffTriggerMode>("BuffResetMode") == BuffTriggerMode.PlayerTurnStart)
			{
				bTEnv.Restart();
			}
		}
		for (int num2 = buffList_.Count - 1; num2 >= 0; num2--)
		{
			BTEnv bTEnv2 = buffList_[num2];
			if (bTEnv2.GetStruct<BuffExecuteMode>("BuffExecuteMode") == BuffExecuteMode.TurnStart)
			{
				bTEnv2.Run();
			}
		}
		skillCD = Math.Max(0, skillCD - 1);
		RefreshUI(refreshSkill: true);
	}

	public void OnPlayerRoundEnd()
	{
		CheckBuffDispose();
		for (int num = buffList_.Count - 1; num >= 0; num--)
		{
			BTEnv bTEnv = buffList_[num];
			if (bTEnv.GetStruct<BuffTriggerMode>("BuffResetMode") == BuffTriggerMode.PlayerTurnEnd)
			{
				bTEnv.Restart();
			}
			else if (bTEnv.GetStruct<BuffExecuteMode>("BuffExecuteMode") == BuffExecuteMode.TurnEnd)
			{
				bTEnv.Run();
			}
			else if (bTEnv.GetStruct<BuffTriggerMode>("BuffDisposeMode") == BuffTriggerMode.PlayerTurnEnd)
			{
				CleanupMergeBuffSlot(bTEnv);
				bTEnv.Dispose();
				buffList_.RemoveAt(num);
			}
		}
	}

	public void OnCollisionEnemy(BilliardGameEntityBase otherEntity)
	{
		if (otherEntity == null)
		{
			return;
		}
		CheckBuffDispose();
		for (int num = buffList_.Count - 1; num >= 0; num--)
		{
			BTEnv bTEnv = buffList_[num];
			if (bTEnv.GetStruct<BuffExecuteMode>("BuffExecuteMode") == BuffExecuteMode.OnCollision)
			{
				bTEnv.AddPlayer("TargetEntity", (BilliardGameEntityBase)(otherEntity as EntityEnemy), false);
				bTEnv.Run();
			}
		}
	}

	public void OnCollisionTeammate(BilliardGameEntityBase otherEntity)
	{
		CheckBuffDispose();
		for (int num = buffList_.Count - 1; num >= 0; num--)
		{
			BTEnv bTEnv = buffList_[num];
			if (bTEnv.GetStruct<BuffExecuteMode>("BuffExecuteMode") == BuffExecuteMode.OnTeammateCollision)
			{
				bTEnv.AddPlayer("TargetEntity", (BilliardGameEntityBase)(otherEntity as EntityPlayer), false);
				bTEnv.Run();
			}
		}
	}

	public void OnCollisionPot(BilliardGameEntityBase otherEntity)
	{
		CheckBuffDispose();
		for (int num = buffList_.Count - 1; num >= 0; num--)
		{
			BTEnv bTEnv = buffList_[num];
			if (bTEnv.GetStruct<BuffExecuteMode>("BuffExecuteMode") == BuffExecuteMode.OnTeammateCollision)
			{
				bTEnv.AddPlayer("TargetEntity", (BilliardGameEntityBase)(otherEntity as EntityMechanism), false);
				bTEnv.Run();
			}
		}
	}

	public void BeCollision(BilliardGameEntityBase otherEntity)
	{
		CheckBuffDispose();
		if (otherEntity is EntityBullet)
		{
			TakeDamage((otherEntity as EntityBullet).ATK);
		}
		else
		{
			for (int num = buffList_.Count - 1; num >= 0; num--)
			{
				BTEnv bTEnv = buffList_[num];
				if (bTEnv.GetStruct<BuffExecuteMode>("BuffExecuteMode") == BuffExecuteMode.BeCollision)
				{
					bTEnv.AddPlayer("TargetEntity", (BilliardGameEntityBase)(otherEntity as EntityPlayer), false);
					bTEnv.Run();
				}
			}
		}
		CheckBuffDispose();
	}

	public void OnEnemyTurnStart()
	{
		CheckBuffDispose();
		for (int num = buffList_.Count - 1; num >= 0; num--)
		{
			BTEnv bTEnv = buffList_[num];
			if (bTEnv.GetStruct<BuffExecuteMode>("BuffExecuteMode") == BuffExecuteMode.EnemyAction)
			{
				bTEnv.Run();
			}
		}
		CheckBuffDispose();
	}

	public void OnShoot(Vector3 dir)
	{
		CheckBuffDispose();
		lastTurnNum--;
		for (int num = buffList_.Count - 1; num >= 0; num--)
		{
			BTEnv bTEnv = buffList_[num];
			if (bTEnv.ContainKey("BuffExecuteMode") && bTEnv.GetStruct<BuffExecuteMode>("BuffExecuteMode") == BuffExecuteMode.Shoot)
			{
				bTEnv.AddStruct("shootDir", dir);
				bTEnv.Run();
			}
		}
		CheckBuffDispose();
		RefreshUI();
	}

	public void OnAnyAttackEnd()
	{
		CheckBuffDispose();
		for (int num = buffList_.Count - 1; num >= 0; num--)
		{
			BTEnv bTEnv = buffList_[num];
			if (bTEnv.GetStruct<BuffTriggerMode>("BuffResetMode") == BuffTriggerMode.AnyAttackEnd)
			{
				bTEnv.Restart();
			}
		}
		CheckBuffDispose();
		for (int num2 = buffList_.Count - 1; num2 >= 0; num2--)
		{
			BTEnv bTEnv2 = buffList_[num2];
			if (!bTEnv2.isRunning || bTEnv2.GetStruct<BuffTriggerMode>("BuffDisposeMode") == BuffTriggerMode.AnyAttackEnd)
			{
				CleanupMergeBuffSlot(bTEnv2);
				bTEnv2.Dispose();
				buffList_.RemoveAt(num2);
			}
		}
		CheckBuffDispose();
	}

	public void OnAttackEnd()
	{
		CheckBuffDispose();
		for (int num = buffList_.Count - 1; num >= 0; num--)
		{
			BTEnv bTEnv = buffList_[num];
			if (bTEnv.GetStruct<BuffTriggerMode>("BuffResetMode") == BuffTriggerMode.PlayerAttackEnd)
			{
				bTEnv.Restart();
			}
		}
		CheckBuffDispose();
		for (int num2 = buffList_.Count - 1; num2 >= 0; num2--)
		{
			BTEnv bTEnv2 = buffList_[num2];
			if (bTEnv2.GetStruct<BuffExecuteMode>("BuffExecuteMode") == BuffExecuteMode.AttackEnd)
			{
				bTEnv2.Run();
			}
		}
		CheckBuffDispose();
		for (int num3 = buffList_.Count - 1; num3 >= 0; num3--)
		{
			BTEnv bTEnv3 = buffList_[num3];
			if (!bTEnv3.isRunning || bTEnv3.GetStruct<BuffTriggerMode>("BuffDisposeMode") == BuffTriggerMode.PlayerAttackEnd)
			{
				CleanupMergeBuffSlot(bTEnv3);
				bTEnv3.Dispose();
				buffList_.RemoveAt(num3);
			}
		}
		CheckBuffDispose();
	}

	public void OnRoundEnd()
	{
		CheckBuffDispose();
		for (int num = buffList_.Count - 1; num >= 0; num--)
		{
			BTEnv bTEnv = buffList_[num];
			int num2 = bTEnv.GetStruct<int>("Turn");
			if (num2 > -1)
			{
				num2--;
				if (num2 <= 0)
				{
					CleanupMergeBuffSlot(bTEnv);
					bTEnv.Dispose();
					buffList_.RemoveAt(num);
				}
				else
				{
					bTEnv.AddStruct("Turn", num2);
				}
			}
		}
		CheckBuffDispose();
	}

	public void OnPenetrate(BilliardGameEntityBase otherEntity)
	{
		CheckBuffDispose();
		for (int num = buffList_.Count - 1; num >= 0; num--)
		{
			BTEnv bTEnv = buffList_[num];
			if (bTEnv.GetStruct<BuffExecuteMode>("BuffExecuteMode") == BuffExecuteMode.OnPenetrate)
			{
				bTEnv.AddPlayer("TargetEntity", otherEntity);
				bTEnv.Run();
			}
		}
	}

	public void OnAOEDamage(int buffId, List<EntityEnemy> enemyList)
	{
		CheckBuffDispose();
		for (int num = buffList_.Count - 1; num >= 0; num--)
		{
			BTEnv bTEnv = buffList_[num];
			if (bTEnv.GetStruct<BuffExecuteMode>("BuffExecuteMode") == BuffExecuteMode.OnAOEDamage)
			{
				bTEnv.Run();
			}
		}
		for (int i = 0; i < enemyList.Count; i++)
		{
			CheckMergeBuffTrigger(buffId, enemyList[i]);
		}
	}

	public void OnPhysicalBulletCollsionEnemy(int sourceBuffID, EntityEnemy enemy)
	{
		CheckBuffDispose();
		CheckMergeBuffTrigger(sourceBuffID, enemy);
	}

	public override void Tick()
	{
		CheckBuffDispose();
		for (int num = buffList_.Count - 1; num >= 0; num--)
		{
			BTEnv bTEnv = buffList_[num];
			if (bTEnv.GetStruct<BuffExecuteMode>("BuffExecuteMode") == BuffExecuteMode.TickTime)
			{
				float num2 = bTEnv.GetStruct<float>("BuffTickTime");
				float num3 = bTEnv.GetStruct<float>("BuffTickTimeLastStartTime");
				if (num3 == 0f)
				{
					bTEnv.AddStruct("BuffTickTimeStartTime", Time.time);
				}
				float num4 = bTEnv.GetStruct<float>("BuffTickTimeStartTime");
				float num5 = bTEnv.GetStruct<float>("BuffTickTimeDisposeTime");
				if (Time.time - num3 > num2)
				{
					bTEnv.Run();
					bTEnv.AddStruct("BuffTickTimeLastStartTime", Time.time);
				}
				else if (Time.time - num4 > num5)
				{
					CleanupMergeBuffSlot(bTEnv);
					bTEnv.Dispose();
					buffList_.RemoveAt(num);
				}
			}
		}
		CheckBuffDispose();
	}

	public bool CheckRest()
	{
		if (null == logic)
		{
			return true;
		}
		return logic.CheckRest();
	}

	public void UseSkill()
	{
		if (activeSkillID != 0 && skillCD <= 0 && SkillCost <= BilliardGameLogicManager.Instance.Food && !Tired)
		{
			BilliardGameLogicManager.Instance.exchangeData.OnUseSkill(activeSkillID, !isUseSkill);
			isUseSkill = true;
			skillCD = maxSkillCD;
			BilliardGameSpellManager.Instance.CastSpell(activeSkillID, this);
			BilliardGameLogicManager.Instance.Food -= SkillCost;
			BilliardGameUIManager.Instance.skillPop.PlaySkillPop(playerID, base.entityID);
			CheckBuffDispose();
			RefreshUI(refreshSkill: true);
			BilliardGameLogicManager.Instance.MakeEffectGo("TongYong/nya_pinball_tongyong_dazhaobaokai_1", base.go, 1f);
			BilliardGameAudioManager.PlayAudioByName("minigame_activity_4_3_marble_skill_ready");
		}
	}

	public void AddBuff(BTEnv buff)
	{
		buffList_.Add(buff);
		BilliardGameAudioManager.PlayAudioByName("minigame_activity_4_3_marble_buff");
		RefreshUI(refreshSkill: true);
	}

	public void ForceRemoveBuff(int buffID)
	{
		BTEnv buff = GetBuff(buffID);
		if (buff != null)
		{
			buff.AddStruct("WaitForDispose", value: true);
			CheckBuffDispose();
		}
		else
		{
			Debug.LogError($"玩家{playerID}身上不存在buff{buffID}，无法移除");
		}
	}

	public void TakeDamage(int damage)
	{
		if (shield >= damage)
		{
			shield -= damage;
		}
		else
		{
			int num = damage - shield;
			shield = 0;
			remainHP = Math.Max(remainHP - num, 0);
			BilliardGameUIManager.Instance.ShowPlayerTextHud(-damage, base.go.transform);
		}
		if (Dead)
		{
			BilliardGameLogicManager.Instance.effectMgr.AddWorldEffect("TongYong/nya_pinball_tongyong_siwang_1", base.position, 1f);
			base.go.SetActive(value: false);
		}
		RefreshUI(refreshSkill: true);
	}

	public void TakeRegeneration(int hp, float hpRatio)
	{
		int num = hp + Mathf.FloorToInt(hpRatio * (float)maxHP);
		remainHP = Mathf.Min(maxHP, remainHP + num);
		RefreshUI(refreshSkill: true);
	}

	public void TakeShield(int shield)
	{
		this.shield += shield;
		RefreshUI(refreshSkill: true);
	}

	public void ChangePosition(Vector3 pos)
	{
		base.go.transform.position = pos;
		if (logic != null)
		{
			logic.NotifyTeleport();
		}
	}

	public void RefreshUI(bool refreshSkill = false)
	{
		List<int> list = null;
		List<int> list2 = null;
		if (refreshSkill)
		{
			list = new List<int>();
			list2 = new List<int>();
			for (int i = 0; i < buffList_.Count; i++)
			{
				BTEnv bTEnv = buffList_[i];
				if (!bTEnv.ContainKey("BuffId"))
				{
					continue;
				}
				int num = bTEnv.GetStruct<int>("BuffId");
				BilliardBuffConfig buffCfg = BilliardGameDataManager.GetBuffCfg(num);
				if (buffCfg != null && !list.Contains(num))
				{
					list.Add(num);
					if (bTEnv.ContainKey("Turn"))
					{
						int item = bTEnv.GetStruct<int>("Turn");
						list2.Add(item);
					}
					else
					{
						list2.Add(-1);
					}
				}
			}
		}
		HeroHeadContext context = new HeroHeadContext
		{
			maxHp = maxHP,
			curHp = remainHP,
			curShield = shield,
			maxCd = maxSkillCD,
			curCd = skillCD,
			skillCost = SkillCost,
			isTired = Tired,
			buffIDList = list,
			timeList = list2
		};
		BilliardGameLogicManager.Instance.UpdateHero(playerID, context);
		if (activeSkillID != 0 && skillCD <= 0 && SkillCost <= BilliardGameLogicManager.Instance.Food && !Tired)
		{
			if (null == skillEffect)
			{
				skillEffect = BilliardGameLogicManager.Instance.MakeEffectGo("TongYong/nya_pinball_tongyong_dazhao_1", base.go, 1f);
			}
		}
		else if (null != skillEffect)
		{
			skillEffect.Die();
			skillEffect = null;
		}
	}

	public void AddMergeBuffGroup(int[] mergeBuffList)
	{
		if (mergeBuffList == null || mergeBuffList.Length == 0)
		{
			return;
		}
		int num = -1;
		for (int i = 0; i < mergeGroupIds.Count; i++)
		{
			if (IdListEquals(mergeGroupIds[i], mergeBuffList))
			{
				num = i;
				break;
			}
		}
		if (num < 0)
		{
			num = mergeBuffs.Count;
			mergeGroupIds.Add((int[])mergeBuffList.Clone());
			mergeBuffs.Add(new BTEnv[mergeBuffList.Length]);
		}
		int[] array = mergeGroupIds[num];
		BTEnv[] array2 = mergeBuffs[num];
		for (int j = 0; j < array.Length; j++)
		{
			BTEnv buff = GetBuff(array[j]);
			array2[j] = buff;
		}
	}

	public void CheckMergeBuffTrigger(int sourceBuffId, BilliardGameEntityBase entity)
	{
		for (int i = 0; i < mergeGroupIds.Count; i++)
		{
			int[] array = mergeGroupIds[i];
			int num = Array.IndexOf(array, sourceBuffId);
			if (num < 0)
			{
				continue;
			}
			BTEnv[] array2 = mergeBuffs[i];
			for (int j = num + 1; j < array.Length; j++)
			{
				BTEnv bTEnv = array2[j];
				if (bTEnv != null)
				{
					bTEnv.AddPlayer("TargetEntity", entity);
					bTEnv.Run();
				}
			}
		}
	}

	private static bool IdListEquals(int[] a, int[] b)
	{
		if (a.Length != b.Length)
		{
			return false;
		}
		for (int i = 0; i < a.Length; i++)
		{
			if (a[i] != b[i])
			{
				return false;
			}
		}
		return true;
	}

	private void CleanupMergeBuffSlot(BTEnv env)
	{
		if (env == null)
		{
			return;
		}
		for (int i = 0; i < mergeBuffs.Count; i++)
		{
			BTEnv[] array = mergeBuffs[i];
			for (int j = 0; j < array.Length; j++)
			{
				if (array[j] == env)
				{
					array[j] = null;
				}
			}
		}
	}
}
