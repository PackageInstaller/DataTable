using System;
using System.Collections.Generic;
using BilliardGame.Spell;
using UnityEngine;

namespace BilliardGame.Runtime;

public class EntityEnemy : BilliardGameEntityBase
{
	public int dataIndex;

	protected int attack;

	protected BTEnv baseEnv;

	protected List<BTEnv> buffList_;

	protected List<BTEnv> onEnemyStatebuffList;

	private bool isBallGame;

	private int roundTotalDamage;

	public BilliardGameEffect shieldEffect;

	public BilliardGameEffect colShieldEffect;

	private SpriteRenderer spriteRenderer;

	private bool isShowAttacked;

	public int bossShieldNum;

	public int bossShieldMax;

	public int bossShieldReduceDamage;

	public BilliardGameEffect bossShieldEffect;

	public BilliardGameEnemyHpBar hpBar;

	public BilliardGameEnemyBuffPredict buffPredict;

	private bool readyATK;

	public int chagedNum;

	public int chagedBuff;

	private bool isMoving;

	private float moveTime;

	private LTDescr moveTween;

	public int enemyID { get; protected set; }

	public int remainHP { get; protected set; }

	public int maxHP { get; protected set; }

	public int shield { get; protected set; }

	public int colShileld { get; protected set; }

	public int skillID { get; protected set; }

	public int hpBarType { get; protected set; }

	public BilliardGameEnemy logic { get; protected set; }

	public bool Dead => remainHP <= 0;

	public bool SuppressDamageHud { get; set; }

	public int ATK
	{
		get
		{
			int num = attack;
			for (int i = 0; i < buffList_.Count; i++)
			{
				if (buffList_[i].ContainKey("add_atk") && buffList_[i].ContainKey("level"))
				{
					int num2 = buffList_[i].GetStruct<int>("level");
					num += num2 * buffList_[i].GetStruct<int>("add_atk");
				}
				if (buffList_[i].ContainKey("add_atk_ratio"))
				{
					num = num * (100 + buffList_[i].GetStruct<int>("add_atk_ratio")) / 100;
				}
			}
			return num;
		}
	}

	public int EXTRADAMAGE
	{
		get
		{
			int num = 0;
			for (int i = 0; i < buffList_.Count; i++)
			{
				if (buffList_[i].ContainKey("extra_damage"))
				{
					int val = 0;
					if (buffList_[i].ContainKey("level"))
					{
						val = buffList_[i].GetStruct<int>("level");
					}
					int num2 = Math.Max(val, 1);
					num += buffList_[i].GetStruct<int>("extra_damage") * num2;
				}
			}
			return num;
		}
	}

	public EntityEnemy(int entityID, GameObject go, BilliardEntityConfig cfg, float hpRatio, float atkRatio)
		: base(entityID, go)
	{
		readyATK = false;
		buffList_ = new List<BTEnv>();
		isBallGame = BilliardGameDataManager.IsBallGame();
		attack = (int)((float)cfg.baseAttack * atkRatio);
		enemyID = cfg.id;
		remainHP = (int)((float)cfg.baseHP * hpRatio);
		maxHP = (int)((float)cfg.baseHP * hpRatio);
		skillID = cfg.skillId;
		hpBarType = cfg.hpBarType;
		logic = base.go.GetComponent<BilliardGameEnemy>();
		spriteRenderer = base.go.GetComponent<SpriteRenderer>();
		buffPredict = BilliardGameUIManager.Instance.InitEnemyBuff();
		buffPredict.Init(logic.buffPredictTrs);
		onEnemyStatebuffList = new List<BTEnv>();
		InitBar();
		baseEnv = BilliardGameSpellManager.Instance.CastBuff(skillID, this);
	}

	public void InitBar()
	{
		if (hpBarType != 0 && !isBallGame)
		{
			hpBar = BilliardGameUIManager.Instance.InitEnemyHpBar(hpBarType);
		}
		else
		{
			hpBar = BilliardGameUIManager.Instance.InitEnemyHpBar();
		}
		hpBar.Init(logic.barPosTrs);
		hpBar.SetBarType(isMech: false);
		hpBar.ShowSpecialBuff(isShowSpecialBuff: false);
	}

	public override void Dispose()
	{
		UnityEngine.Object.DestroyImmediate(hpBar.gameObject);
		hpBar = null;
		UnityEngine.Object.DestroyImmediate(buffPredict.gameObject);
		buffPredict = null;
		UnityEngine.Object.DestroyImmediate(base.go);
		base.go = null;
		for (int i = 0; i < buffList_.Count; i++)
		{
			buffList_[i].Dispose();
		}
		buffList_.Clear();
		for (int j = 0; j < onEnemyStatebuffList.Count; j++)
		{
			onEnemyStatebuffList[j].Dispose();
		}
		onEnemyStatebuffList.Clear();
		if (moveTween != null)
		{
			moveTween.setOnUpdate((Action<float>)delegate
			{
			});
			LeanTween.cancel(moveTween.id);
			moveTween = null;
		}
	}

	public void CheckBuffDispose()
	{
		List<int> list = new List<int>();
		for (int num = buffList_.Count - 1; num >= 0; num--)
		{
			BTEnv bTEnv = buffList_[num];
			if ((bTEnv.ContainKey("WaitForDispose") && bTEnv.GetStruct<bool>("WaitForDispose")) || !bTEnv.isRunning)
			{
				int item = (bTEnv.ContainKey("BuffId") ? bTEnv.GetStruct<int>("BuffId") : 0);
				list.Add(item);
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
						buffList_.RemoveAt(num3);
						queue.Enqueue(num2);
						break;
					}
				}
			}
		}
	}

	public void BeCollision(BilliardGameEntityBase otherEntity)
	{
		if (otherEntity is EntityPlayer)
		{
			TakeDamage((otherEntity as EntityPlayer).ATK);
		}
		if (otherEntity is EntityBullet)
		{
			TakeDamage((otherEntity as EntityBullet).ATK);
		}
		if (otherEntity is EntityPhysicalBullet)
		{
			TakeDamage((otherEntity as EntityPhysicalBullet).ATK);
		}
		CheckBuffDispose();
		for (int i = 0; i < buffList_.Count; i++)
		{
			BTEnv bTEnv = buffList_[i];
			if (bTEnv.GetStruct<BuffExecuteMode>("BuffExecuteMode") == BuffExecuteMode.BeCollision)
			{
				bTEnv.AddPlayer("TargetEntity", (BilliardGameEntityBase)(otherEntity as EntityEnemy), false);
				bTEnv.Run();
			}
		}
	}

	public void BePenetrate(BilliardGameEntityBase otherEntity)
	{
		if (otherEntity is EntityPlayer)
		{
			TakeDamage((otherEntity as EntityPlayer).penerateDamage);
		}
		if (otherEntity is EntityPhysicalBullet)
		{
			TakeDamage((otherEntity as EntityPhysicalBullet).ATK);
		}
		CheckBuffDispose();
	}

	public void OnRoundBegin()
	{
		if (bossShieldMax > 0)
		{
			bossShieldNum = bossShieldMax;
		}
	}

	public void ReadyAtk()
	{
		readyATK = true;
		baseEnv.Restart();
		baseEnv.Run();
	}

	public void OnRoundEnd()
	{
		for (int i = 0; i < buffList_.Count; i++)
		{
			BTEnv bTEnv = buffList_[i];
			if (bTEnv.GetStruct<BuffTriggerMode>("BuffDisposeMode") == BuffTriggerMode.EnemyTurnEnd)
			{
				bTEnv.AddStruct("WaitForDispose", value: true);
			}
			int num = bTEnv.GetStruct<int>("Turn");
			if (num > -1)
			{
				num--;
				if (num <= 0)
				{
					bTEnv.Dispose();
				}
				else
				{
					bTEnv.AddStruct("Turn", num);
				}
			}
		}
		roundTotalDamage = 0;
		CheckBuffDispose();
	}

	public void OnEnemyState()
	{
		buffPredict.RefreshPredictIcon(-1);
		CheckExtraDamageBuff();
		bool isAtk = logic.HidePredict();
		if (readyATK)
		{
			logic.ChangeAniState("atk", isLoop: false, delegate
			{
				if (isAtk)
				{
					BilliardGameAudioManager.PlayEnemyAtkAudio(enemyID);
				}
				for (int i = 0; i < onEnemyStatebuffList.Count; i++)
				{
					onEnemyStatebuffList[i].Run();
				}
				for (int num3 = onEnemyStatebuffList.Count - 1; num3 >= 0; num3--)
				{
					BTEnv bTEnv2 = onEnemyStatebuffList[num3];
					if (!bTEnv2.isRunning)
					{
						onEnemyStatebuffList.Remove(bTEnv2);
					}
				}
			});
		}
		else
		{
			for (int num = 0; num < onEnemyStatebuffList.Count; num++)
			{
				onEnemyStatebuffList[num].Run();
			}
			for (int num2 = onEnemyStatebuffList.Count - 1; num2 >= 0; num2--)
			{
				BTEnv bTEnv = onEnemyStatebuffList[num2];
				if (!bTEnv.isRunning)
				{
					onEnemyStatebuffList.Remove(bTEnv);
				}
			}
		}
		readyATK = false;
		RefreshEnemyHp(remainHP, maxHP);
	}

	public override BTEnv GetBuff(int buffID)
	{
		BTEnv bTEnv = buffList_.Find((BTEnv e) => e.GetStruct<int>("BuffId") == buffID);
		buffPredict.RefreshPredictIcon(buffID);
		if (bTEnv == null)
		{
			return null;
		}
		return bTEnv;
	}

	public void TakeDamage(int damage)
	{
		if (Dead)
		{
			return;
		}
		damage += EXTRADAMAGE;
		if (damage <= 0)
		{
			return;
		}
		logic.ChangeAniState("hit", isLoop: false);
		if (colShileld > 0)
		{
			int num = colShileld - 1;
			colShileld = num;
			RefreshEnemyHp(remainHP, maxHP);
			return;
		}
		if (bossShieldNum > 0)
		{
			bossShieldNum--;
			if (bossShieldNum <= 0)
			{
				bossShieldMax = 0;
				if (null != bossShieldEffect)
				{
					bossShieldEffect.Die();
					BilliardGameLogicManager.Instance.MakeEffectWorld("GuaiWu/nya_pinball_guaiwu_hudun_4", base.position, 3f);
				}
			}
			damage *= (100 - bossShieldReduceDamage) / 100;
		}
		BilliardGameLogicManager.Instance.AddTotalDamage(damage);
		int num2 = damage;
		if (shield >= damage)
		{
			shield -= damage;
		}
		else
		{
			num2 = damage - shield;
			shield = 0;
			remainHP = Math.Max(remainHP - num2, 0);
		}
		roundTotalDamage -= damage;
		if (!SuppressDamageHud)
		{
			BilliardGameUIManager.Instance.ShowTextHud(roundTotalDamage, base.go.transform);
			SuppressDamageHud = false;
		}
		AttackedColorChange();
		RefreshEnemyHp(remainHP, maxHP);
		if (Dead)
		{
			if (enemyID == 40309)
			{
				logic.ChangeAniState("die", isLoop: false);
			}
			else
			{
				BilliardGameLogicManager.Instance.effectMgr.AddWorldEffect("TongYong/nya_pinball_tongyong_siwang_2", base.position, 1f);
				base.go.SetActive(value: false);
			}
			logic.Dispose();
			hpBar.Show(isShow: false);
			hpBar.ShowSpecialBuff(isShowSpecialBuff: false);
			buffPredict.Show(isShow: false);
			BilliardGameLogicManager.Instance.UpdateEnemyDeadNum(enemyID);
			LuaHelper.CallFunction("OnBilliardGameMonsterDead", enemyID);
			for (int i = 0; i < onEnemyStatebuffList.Count; i++)
			{
				onEnemyStatebuffList[i].Dispose();
			}
			onEnemyStatebuffList.Clear();
		}
	}

	public void ShowBar(bool isShow)
	{
		hpBar.Show(isShow);
		RefreshEnemyHp(remainHP, maxHP);
	}

	public void TakeRegeneration(int hp)
	{
		remainHP = Mathf.Min(maxHP, remainHP + hp);
		RefreshEnemyHp(remainHP, maxHP);
	}

	public void TakeRegenerationByHpRatio(float ratio)
	{
		int hp = (int)((float)maxHP * ratio);
		TakeRegeneration(hp);
	}

	public void TakeShield(int shield)
	{
		this.shield += shield;
		RefreshEnemyHp(remainHP, maxHP);
	}

	public void TakeShieldByHpRatio(float ratio)
	{
		int num = (int)((float)maxHP * ratio);
		TakeShield(num);
	}

	public void TakeColShield(int shield)
	{
		colShileld += shield;
		RefreshEnemyHp(remainHP, maxHP);
	}

	public void AddEnemyStateBuff(BTEnv buff)
	{
		int num = 0;
		if (buff.ContainKey("damage"))
		{
			num = buff.GetStruct<int>("damage");
		}
		buff.AddStruct("damage", num + ATK);
		onEnemyStatebuffList.Add(buff);
	}

	public void AddBuff(BTEnv buff)
	{
		buffList_.Add(buff);
	}

	public void TakeBossShield(int num, int ratio)
	{
		bossShieldMax = num;
		bossShieldNum = num;
		bossShieldReduceDamage = ratio;
		bossShieldEffect = BilliardGameLogicManager.Instance.MakeEffectGo("GuaiWu/nya_pinball_guaiwu_hudun_3", base.go, 3f);
	}

	private void RefreshEnemyHp(int remainHP, int maxHP)
	{
		hpBar.RefreshEnemyHp(remainHP, maxHP, shield);
		if (shield > 0)
		{
			if (shieldEffect == null)
			{
				shieldEffect = BilliardGameLogicManager.Instance.MakeEffectGo("GuaiWu/nya_pinball_guaiwu_hudun_1", base.go, 1f);
			}
		}
		else if (shieldEffect != null)
		{
			shieldEffect.Die();
			shieldEffect = null;
			BilliardGameLogicManager.Instance.MakeEffectWorld("GuaiWu/nya_pinball_guaiwu_hudun_2", base.position, 1f);
		}
		if (colShileld > 0)
		{
			if (colShieldEffect == null)
			{
				colShieldEffect = BilliardGameLogicManager.Instance.MakeEffectGo("GuaiWu/nya_pinball_guaiwu_hudun_3", base.go, 1f);
			}
		}
		else if (colShieldEffect != null)
		{
			colShieldEffect.Die();
			colShieldEffect = null;
			BilliardGameLogicManager.Instance.MakeEffectWorld("GuaiWu/nya_pinball_guaiwu_hudun_4", base.position, 1f);
		}
	}

	public void SetChagedNumAndBuff(int num, int buffID)
	{
		chagedNum = num;
		chagedBuff = buffID;
	}

	public void ReduceChagedNum()
	{
		if (chagedNum > 0)
		{
			chagedNum--;
			if (chagedNum <= 0)
			{
				BilliardGameSpellManager.Instance.CastBuff(chagedBuff, this)?.Run();
			}
		}
		logic.ShowChargedPredict(chagedNum);
	}

	public void DoMove(Vector3 targetPos, float moveTime, Action onComplete = null)
	{
		isMoving = true;
		this.moveTime = moveTime;
		Vector3 vector = base.go.transform.position;
		Vector3 normalized = (targetPos - vector).normalized;
		float num = Mathf.Min(1.5f, Vector3.Distance(vector, targetPos) * 0.3f);
		Vector3 to = vector - normalized * num;
		float time = moveTime * 0.2f;
		float launchTime = moveTime * 0.8f;
		moveTween = LeanTween.move(base.go, to, time).setEase(LeanTweenType.easeInCubic).setOnComplete((Action)delegate
		{
			LeanTween.move(base.go, targetPos, launchTime).setEase(LeanTweenType.easeOutCubic).setOnComplete((Action)delegate
			{
				onComplete?.Invoke();
				isMoving = false;
				this.moveTime = 0f;
			});
		});
	}

	public bool GetIsMoving()
	{
		return isMoving;
	}

	public float GetMoveTime()
	{
		return moveTime;
	}

	public void CheckExtraDamageBuff()
	{
		hpBar.ShowSpecialBuff(EXTRADAMAGE > 0);
	}

	private void AttackedColorChange()
	{
		if (!isBallGame && !isShowAttacked)
		{
			spriteRenderer.color = new Color(1f, 0.5f, 0.5f, 1f);
			isShowAttacked = true;
			FuncTimerManager.inst.CreateFuncTimer(delegate
			{
				spriteRenderer.color = Color.white;
				isShowAttacked = false;
			}, 0.2f, 1);
		}
	}
}
