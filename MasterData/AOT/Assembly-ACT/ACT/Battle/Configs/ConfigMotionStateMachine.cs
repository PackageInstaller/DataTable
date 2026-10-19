using UnityEngine;

namespace ACT.Battle.Configs;

public class ConfigMotionStateMachine : ScriptableObject
{
	public ConfigAnimLayer[] layers;

	public ConfigAnimState[] states;

	[Tooltip("状态子集，把一组状态作为一个状态节点")]
	public ConfigAnimStateMachine[] stateMachines;

	public ConfigAnimParameter[] parameters;
}
