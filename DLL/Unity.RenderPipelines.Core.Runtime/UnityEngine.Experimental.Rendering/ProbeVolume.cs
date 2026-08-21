namespace UnityEngine.Experimental.Rendering;

[AddComponentMenu("Light/Probe Volume (Experimental)")]
[ExecuteAlways]
public class ProbeVolume : MonoBehaviour
{
	public bool globalVolume;

	public Vector3 size = new Vector3(10f, 10f, 10f);

	[Range(0f, 2f)]
	[HideInInspector]
	public float geometryDistanceOffset = 0.2f;

	public LayerMask objectLayerMask = -1;

	[HideInInspector]
	public int lowestSubdivLevelOverride;

	[HideInInspector]
	public int highestSubdivLevelOverride = -1;

	[HideInInspector]
	public bool overridesSubdivLevels;

	[SerializeField]
	internal bool mightNeedRebaking;

	[SerializeField]
	internal Matrix4x4 cachedTransform;

	[SerializeField]
	internal int cachedHashCode;
}
