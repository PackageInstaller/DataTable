using UnityEngine;

namespace ACT.Battle;

internal sealed class BattlePoolAutoRecycleDriver : MonoBehaviour
{
	private void Update()
	{
		BattleGameObjectPoolService.Instance.UpdateAutoRecycle(Time.realtimeSinceStartup);
	}
}
