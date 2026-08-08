using UnityEngine;

public class PinballRoleBattleData
{
	public string model;

	public float maxHealth;

	public float health;

	public float attack;

	public float abilityPower;

	public float maxSkillPoint;

	public float skillPoint;

	public float skillPointRestore;

	public Vector3 spawnOffset;

	public PinballRoleSkillData[] skillList;

	public int[][] actionLoop;

	public int actionTimes;
}
