using System;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Core;
using UnityEngine;

namespace ACT.MultiPlayer;

[Serializable]
public struct CmdDamageNumber
{
	public DamageFeature damageFeature;

	public int damage;

	public Element element;

	public bool critical;

	public bool isWeakElement;

	public int dotIconId;

	public MannerType mannerType;

	public Vector3 pos;

	public EntityType entityType;

	public bool faceLeft;

	public bool useMonsterType;

	public MonsterWeigtType monsterWeigtType;

	public Vector2 entitySize;

	public Vector3 entityPos;

	public double serverTime;

	public bool IsSacrifice
	{
		get
		{
			DamageFeature damageFeature = this.damageFeature;
			return damageFeature == DamageFeature.Sacrifice || damageFeature == DamageFeature.HpRemoval;
		}
	}

	public bool IsCharacter => entityType == EntityType.Character;
}
