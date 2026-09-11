using System;
using BilliardGame.Spell;
using UnityEngine;

namespace BilliardGame.Runtime;

public class PotModule : IMechanismTrigger
{
	private enum State
	{
		Inactive,
		Active
	}

	private EntityMechanism mech;

	private BTEnv env;

	private int turn;

	private State state;

	private int buffID;

	public int maxHP;

	public int remainHP;

	public BilliardGameEnemyHpBar hpBar;

	public int waitTurn;

	public int effectTurn;

	public bool Dead => remainHP <= 0;

	public PotModule(int buffID, EntityMechanism m, int waitTurn, int effectTurn, int hp)
	{
		mech = m;
		this.buffID = buffID;
		maxHP = hp;
		remainHP = maxHP;
		env = BilliardGameSpellManager.Instance.CastBuff(this.buffID, mech);
		turn = 0;
		state = State.Inactive;
		this.waitTurn = waitTurn;
		this.effectTurn = effectTurn;
		BilliardGameLogicManager.Instance.MakeEffectGo("JiGuan/nya_pinball_jiguan_guo_pengren_1", mech.go, 1f);
		InitBar();
	}

	public void BeCollision(BilliardGameEntityBase other)
	{
	}

	public void OnRoundStart()
	{
		turn++;
		if (state == State.Inactive && turn >= waitTurn)
		{
			env.Run();
			state = State.Active;
			turn = 0;
			mech.logic.ChangeAniState("zhukai", isLoop: true);
			BilliardGameLogicManager.Instance.MakeEffectGo("JiGuan/nya_pinball_jiguan_guo_pengren_2", mech.go, 1f);
			BilliardGameAudioManager.PlayAudioByName("minigame_activity_4_3_marble_boiled_loop");
		}
		else if (state == State.Active && turn >= effectTurn)
		{
			state = State.Inactive;
			turn = 0;
			mech.logic.ChangeAniState("weizhukai", isLoop: true);
			BilliardGameAudioManager.PlayAudioByName("minigame_activity_4_3_marble_boiled_loop_stop");
		}
	}

	public void InitBar()
	{
		hpBar = BilliardGameUIManager.Instance.InitEnemyHpBar();
		hpBar.Init(mech.logic.transform.Find("hpBarTargert"));
		hpBar.RefreshEnemyHp(remainHP, maxHP, 0);
		hpBar.Show(isShow: true);
		hpBar.SetBarType(isMech: true);
	}

	public void TakeDamage(int damage)
	{
		remainHP = Math.Max(0, remainHP - damage);
		BilliardGameLogicManager.Instance.exchangeData.OnPotDamage(damage, remainHP);
		hpBar.RefreshEnemyHp(remainHP, maxHP, 0);
		if (Dead)
		{
			mech.go.SetActive(value: false);
			BilliardGameLogicManager.Instance.OverGame(result: false);
		}
	}

	public void TakeRegeneration(int hp, float hpRatio)
	{
		int num = hp + Mathf.FloorToInt((float)maxHP * hpRatio);
		remainHP = Mathf.Min(maxHP, remainHP + num);
		BilliardGameLogicManager.Instance.exchangeData.OnPotRegeneration(num, remainHP);
		hpBar.RefreshEnemyHp(remainHP, maxHP, 0);
	}
}
