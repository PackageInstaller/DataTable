using ACT.Utility;
using Cysharp.Threading.Tasks;
using Sirenix.OdinInspector;
using UnityEngine;

namespace ACT.Battle;

public class BlackScreenTpTrigger : MonoBehaviour
{
	[SerializeField]
	private int _chunkId;

	public Transform targetTransform;

	public bool faceLeft;

	[Unit(Units.Second)]
	public float leastDuration;

	[Unit(Units.Second)]
	public float blackscreenFadeInDur = 0.5f;

	[Unit(Units.Second)]
	public float blackscreenFadeOutDur = 0.5f;

	private bool _inTrigger;

	private void OnTriggerEnter(Collider other)
	{
		MonoEntity component = other.gameObject.GetComponent<MonoEntity>();
		if (!_inTrigger && component != null && MonoECS.instance.IsMainEntity(component.entity))
		{
			_inTrigger = true;
			TeleportParams teleportParams = new TeleportParams
			{
				targetPos = targetTransform.position,
				faceLeft = false,
				forceToFloor = true,
				revive = false
			};
			BlackScreenParams blackScreenParams = new BlackScreenParams
			{
				leastDuration = leastDuration,
				fadeInDuration = blackscreenFadeInDur,
				fadeOutDuration = blackscreenFadeOutDur
			};
			TeleportUtility.TeleportWithBlackScreen(_chunkId, teleportParams, blackScreenParams).Forget();
		}
	}

	private void OnTriggerExit(Collider other)
	{
		MonoEntity component = other.gameObject.GetComponent<MonoEntity>();
		if (_inTrigger && component != null && MonoECS.instance.IsMainEntity(component.entity))
		{
			_inTrigger = false;
		}
	}
}
