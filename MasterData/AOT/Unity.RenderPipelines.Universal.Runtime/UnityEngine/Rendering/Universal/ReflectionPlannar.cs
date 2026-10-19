namespace UnityEngine.Rendering.Universal;

[ExecuteAlways]
public class ReflectionPlannar : MonoBehaviour
{
	public static ReflectionPlannar s_Plane;

	public static bool s_Enable;

	public LayerMask renderLayer;

	private void OnEnable()
	{
	}

	private void OnDisable()
	{
	}
}
