using ACT.Battle;
using ACT.Battle.Configs;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Test;

public class JumpInfoTest : MonoBehaviour
{
	private MonoEntity mono;

	public float airTime;

	public int airUpdateFrame;

	public float airHeightTime;

	public int airHeightUpdateFrame;

	private void Start()
	{
		mono = GetComponent<MonoEntity>();
		airTime = (airHeightTime = 0f);
		airUpdateFrame = (airHeightUpdateFrame = 0);
	}

	private void Update()
	{
		MotionState curMotionState = mono.entity.GetCompMotion().curMotionState;
		if (curMotionState == MotionState.Jump || curMotionState == MotionState.FreeFall)
		{
			airTime += Time.deltaTime;
			airUpdateFrame++;
			if ((double)mono.entity.GetCompPhysics().groundDistance > 2.5)
			{
				airHeightTime += Time.deltaTime;
				airHeightUpdateFrame++;
			}
			return;
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"滞空时间 {airTime}  {airUpdateFrame} ， 2.5米以上维持时间{airHeightTime}  {airHeightUpdateFrame}");
		}
		airTime = (airHeightTime = 0f);
		airUpdateFrame = (airHeightUpdateFrame = 0);
	}
}
