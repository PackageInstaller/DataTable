using System;
using UnityEngine;

namespace BilliardGame.Spell;

[Serializable]
[CreateAssetMenu(menuName = "弹珠玩法/技能/创建新技能")]
public class SpellConfig : ScriptableObject
{
	public int Id;

	public string Desc;

	[SerializeField]
	public OdinUnityObject Icon = new OdinUnityObject();

	public int CD;

	public int BuffId;

	public int BuffLevel;

	public int Cost;

	[SerializeReference]
	public TargetSelector TargetSelector;
}
