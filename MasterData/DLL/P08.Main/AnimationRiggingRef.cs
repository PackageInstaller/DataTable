using UnityEngine;
using UnityEngine.Animations.Rigging;
using UnityEngine.Animations.Rigging.Extension;

public class AnimationRiggingRef : MonoBehaviour
{
	private void Start()
	{
		base.gameObject.GetComponent<Rig>();
		base.gameObject.GetComponent<RigBuilder>();
		base.gameObject.GetComponent<MaintainOffsetConstraint>();
	}

	private void Update()
	{
	}
}
