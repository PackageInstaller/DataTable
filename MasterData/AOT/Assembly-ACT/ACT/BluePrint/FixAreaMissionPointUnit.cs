using System;
using Unity.VisualScripting;
using UnityEngine;

namespace ACT.BluePrint;

public class FixAreaMissionPointUnit : MissionPointUnit
{
	public ValueInput worldPosition;

	[AllowsNull]
	public ValueInput guidEffect;

	protected override void Definition()
	{
		base.Definition();
		worldPosition = ValueInput("worldPosition", Vector3.zero);
		guidEffect = ValueInput<object>("guidEffect", null);
		guidEffect.AllowsNull();
	}

	protected override ControlOutput Enter(Flow flow)
	{
		base.Enter(flow);
		bool value = flow.GetValue<bool>(active);
		Vector3 zero = Vector3.zero;
		try
		{
			zero = flow.GetValue<Vector3>(worldPosition);
		}
		catch (Exception)
		{
			zero = flow.GetValue<GameObject>(worldPosition).transform.position;
		}
		try
		{
			flow.GetValue<object>(guidEffect);
		}
		catch (Exception)
		{
		}
		if (value)
		{
			m_BpMission.EnableFixedAreaMissionPoint(zero, m_MapArea, (int)m_MapLayer, m_Use3DLogic);
		}
		else
		{
			m_BpMission.DisableFixedAreaMissionPoint(zero);
		}
		return exit;
	}
}
