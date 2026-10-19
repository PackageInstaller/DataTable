using ACT.Utility;
using UnityEngine;

namespace ACT.Battle;

[DisallowMultipleComponent]
[AddComponentMenu("ACT/Battle/落雷天花板")]
public class BloodThunderCeiling : MonoBehaviour
{
	internal static bool TryGetBloodThunderCeilingHit(Vector3 footPos, float rayDistance, out RaycastHit ceilingHit)
	{
		RaycastHit[] cacheHits = PhysicsUtility.cacheHits;
		int num = Physics.RaycastNonAlloc(footPos, Vector3.up, cacheHits, rayDistance, BattleConsts.enviromentMask);
		float num2 = float.MaxValue;
		ceilingHit = default;
		for (int i = 0; i < num; i++)
		{
			RaycastHit raycastHit = cacheHits[i];
			if (!(raycastHit.distance >= num2) && !(raycastHit.collider.GetComponent<BloodThunderCeiling>() == null))
			{
				num2 = raycastHit.distance;
				ceilingHit = raycastHit;
			}
		}
		PhysicsUtility.Release(cacheHits);
		return num2 < float.MaxValue;
	}
}
