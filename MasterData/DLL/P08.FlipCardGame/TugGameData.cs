using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "TugGameData", menuName = "ScriptableObjects/TugGameData")]
public class TugGameData : ScriptableObject
{
	public new string name;

	public TugInfo info1;

	public TugInfo info2;

	public List<TugSkillInfo> skillInfo = new List<TugSkillInfo>();

	[HideInInspector]
	public float offset;

	public float showTime;

	public float addAnger;

	public float CDtime;

	public float angerLastTime;
}
