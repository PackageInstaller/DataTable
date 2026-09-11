using System.Collections.Generic;
using UnityEngine;

public class TugEnemy : MonoBehaviour
{
	private float speedChange;

	[SerializeField]
	private float constSpeed = 0.15f;

	[SerializeField]
	private float skillASpeed = 0.2f;

	[SerializeField]
	private float skillBSpeed = 0.3f;

	public Dictionary<int, float> skillSpeed1 = new Dictionary<int, float>();

	private float speed;

	[SerializeField]
	private float anger;

	[SerializeField]
	private float angerMax = 30f;

	[SerializeField]
	public float angerAddSpeed = 0.2f;

	[SerializeField]
	private float angerDecay = 0.2f;

	[SerializeField]
	private int attackTimes;

	[SerializeField]
	private int superAttackTimes = 3;

	private TugEnemyState state = TugEnemyState.defense;

	private float rage;

	public float Speed
	{
		get
		{
			return speed;
		}
		set
		{
			speed = value;
		}
	}

	public float Rage
	{
		get
		{
			return rage;
		}
		set
		{
			rage = value;
		}
	}

	public void SetData(TugInfo info)
	{
		speed = info.constSpeed;
		skillASpeed = info.skillASpeed;
		attackTimes = info.superAttackTimes;
		angerDecay = info.angerDecay;
		anger = info.angerStart;
		angerAddSpeed = info.angerAddSpeed;
		angerMax = info.angerMax;
		skillBSpeed = info.skillBSpeed;
		skillASpeed = info.skillASpeed;
	}

	private void Start()
	{
	}

	public void UpdateAnger()
	{
		Debug.Log(anger + "  怒气");
		if (state == TugEnemyState.defense)
		{
			anger = Mathf.Clamp(anger + angerAddSpeed, 0f, angerMax);
		}
		else if (state == TugEnemyState.attack)
		{
			anger = Mathf.Clamp(anger - angerDecay, 0f, angerMax);
		}
		else if (state == TugEnemyState.SuperAttack)
		{
			anger = Mathf.Clamp(anger - angerDecay, 0f, angerMax);
		}
		if (anger == angerMax)
		{
			attackTimes++;
			if (attackTimes % superAttackTimes == 0)
			{
				Debug.Log("superAttackTimes");
				state = TugEnemyState.SuperAttack;
				AddSkillSpeed(1, 0f);
				AddSkillSpeed(2, skillBSpeed);
			}
			else
			{
				state = TugEnemyState.attack;
				AddSkillSpeed(1, skillASpeed);
				AddSkillSpeed(2, 0f);
			}
		}
		else if (anger == 0f)
		{
			state = TugEnemyState.defense;
			ResetSkillSpeed();
		}
	}

	private void SetBehaviorByState()
	{
		if (state != TugEnemyState.defense && state != TugEnemyState.attack)
		{
			_ = state;
			_ = 3;
		}
	}

	public float GetEnemySpeed()
	{
		float num = constSpeed;
		foreach (int key in skillSpeed1.Keys)
		{
			num += skillSpeed1[key];
		}
		return num;
	}

	public void ResetSkillSpeed()
	{
		skillSpeed1.Clear();
	}

	public void AddSkillSpeed(int key, float value)
	{
		if (!skillSpeed1.ContainsKey(key))
		{
			skillSpeed1.Add(key, 0f);
		}
		skillSpeed1[key] = value;
	}

	public void UpdateEnemy()
	{
		UpdateAnger();
		SetBehaviorByState();
	}
}
