using ACT.Model;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class CameraPlayerWrapper : MonoBehaviour
{
	public void OnUpdate()
	{
		if (!(MonoECS.instance == null) && MonoECS.instance.mainEntity.IsValid && MonoECS.instance.mainEntity.IsLogicAvailable())
		{
			Entity mainEntity = MonoECS.instance.mainEntity;
			float num = mainEntity.GetCompTime()?.fixedDeltaTime ?? 0f;
			float t = ((num > 0f) ? ((Time.time - Time.fixedTime) / num) : 0f);
			CompTransform compTransform = mainEntity.GetCompTransform();
			CompPhysics compPhysics = mainEntity.GetCompPhysics();
			Vector3 position = Vector3.Lerp(compTransform.lastPhysicsPosition, compTransform.physicsPosition, t);
			Quaternion rotation = default;
			switch (Model<BattleMainModel>.Interface.PlayerPerspective)
			{
			case PlayerPerspectiveState.Normal:
				rotation = compPhysics.InterpolationPathQuaternion;
				break;
			case PlayerPerspectiveState.Back:
				rotation = compPhysics.InterpolationPathOrientation;
				break;
			}
			transform.position = position;
			transform.rotation = rotation;
		}
	}
}
