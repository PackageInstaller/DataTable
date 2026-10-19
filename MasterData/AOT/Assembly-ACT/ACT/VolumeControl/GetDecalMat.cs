using UnityEngine;
using UnityEngine.Rendering.Universal;

namespace ACT.VolumeControl;

public class GetDecalMat : MonoBehaviour
{
	public DecalProjector DecalProjector;

	public float cut;

	private void Start()
	{
		cut = 0f;
		if (DecalProjector == null)
		{
			DecalProjector = GetComponent<DecalProjector>();
		}
	}

	private void Update()
	{
		DecalProjector.material.SetFloat("_Cut", cut);
	}
}
