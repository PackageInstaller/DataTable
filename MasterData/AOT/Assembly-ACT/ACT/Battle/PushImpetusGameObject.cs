using UnityEngine;

namespace ACT.Battle;

[AddComponentMenu("ACT/PushImpetusGameObject")]
[RequireComponent(typeof(BoxCollider))]
public class PushImpetusGameObject : MonoBehaviour
{
	public PushImpetusData pushImpetusConfig;

	public void InitConfig(PushImpetusData config)
	{
		pushImpetusConfig = config;
	}
}
