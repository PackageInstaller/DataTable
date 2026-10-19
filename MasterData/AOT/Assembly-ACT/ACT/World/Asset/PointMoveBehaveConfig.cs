using UnityEngine;

namespace ACT.World.Asset;

public class PointMoveBehaveConfig : BehaveConfig
{
	[HideInInspector]
	public float characterCheckRadius = 3f;

	[HideInInspector]
	public float monsterCheckRadius = 3f;

	[SerializeReference]
	public EventActionBase monsterEnterOrCharacterExit;

	[SerializeReference]
	public EventActionBase monsterExitAndCharacterEnter;

	public DoActionBases inProgress = new DoActionBases();

	public DoActionBases outProgress = new DoActionBases();

	public DoActionBases resetProgress = new DoActionBases();

	[Range(0f, 1f)]
	public float sanUpRate;

	[Range(0f, 1f)]
	public float sanDownRate;

	[Range(0f, 1f)]
	public float dangerRange;
}
