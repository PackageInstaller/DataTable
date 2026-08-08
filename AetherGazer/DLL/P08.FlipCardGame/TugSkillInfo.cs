using System;
using UnityEngine;

[Serializable]
public struct TugSkillInfo
{
	[HideInInspector]
	public int effectType;

	public int skillType;

	[HideInInspector]
	public float nowCd;

	public float cd;

	[HideInInspector]
	public float nowSpeed;

	public float speed;

	public float AddSpeedA;

	public float cost;

	[HideInInspector]
	public bool isEffect;

	public float mistakeSpeed;

	public float mistakeAddSpeedA;

	public float rightSpeed;

	public float rightAddSpeedA;

	[HideInInspector]
	public float nowQteSpeed;
}
