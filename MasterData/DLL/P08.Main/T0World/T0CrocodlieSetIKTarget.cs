using RootMotion.FinalIK;
using UnityEngine;

namespace T0World;

public class T0CrocodlieSetIKTarget : MonoBehaviour
{
	public string ikRoot = "X206a/scene/jh/104402_prop_shayuwanju/ikpos";

	public LimbIK limbIk;

	public Transform ikTarget;

	public void OnEnable()
	{
		GameObject gameObject = GameObject.Find(ikRoot);
		if (!(gameObject == null) && !(T0CrocodileGame.crocodileGame == null))
		{
			int currentPressIndex = T0CrocodileGame.crocodileGame.GetCurrentPressIndex();
			Transform target = (ikTarget = gameObject.transform.GetChild(currentPressIndex - 1));
			limbIk.solver.target = target;
		}
	}
}
