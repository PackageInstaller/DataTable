using System.Collections.Generic;
using GameFramework;
using UnityEngine;

namespace Ase;

public class WeaknessStateInfo : IReference
{
	public int ConfigId;

	public int LV;

	public float DamagePercent;

	public List<int> EffectList;

	public List<int> EffectCoolingList;

	public float EndTimer;

	public bool IsWarnWeakness;

	public float StartTimer;

	public int TempValue;

	public float Timer;

	public float ToughDamagePercent;

	public Color ViewColor;

	public string WeaknessCriticalDamageTextType;

	public string WeaknessDamageTextType;

	public int WeaknessLevel;

	public float XpIncrease;

	public bool IsWeakEnd;

	public float StateScale { get; set; }

	public void Clear()
	{
		ConfigId = 0;
		DamagePercent = 0f;
		ToughDamagePercent = 0f;
		StateScale = 0f;
		Timer = 0f;
		StartTimer = 0f;
		EndTimer = 0f;
		XpIncrease = 0f;
		TempValue = 0;
		WeaknessLevel = 0;
		IsWarnWeakness = false;
		IsWeakEnd = false;
	}
}
