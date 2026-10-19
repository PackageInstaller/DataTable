using System.Collections.Generic;

namespace UnityEngine.Rendering.Universal;

[ExecuteAlways]
[AddComponentMenu("Rendering/Inner World Filter Mask")]
[DisallowMultipleComponent]
public sealed class InnerWorldFilterMask : MonoBehaviour
{
	internal const int MaxMaskCount = 16;

	private static readonly List<InnerWorldFilterMask> s_ActiveMasks = new List<InnerWorldFilterMask>(16);

	[Min(0.001f)]
	public float radius = 3f;

	public Color gizmoColor = new Color(0.45f, 0.75f, 1f, 0.35f);

	internal static int WriteActiveMasks(Vector4[] masks)
	{
		int num = 0;
		int num2 = masks.Length;
		for (int i = 0; i < s_ActiveMasks.Count; i++)
		{
			if (num >= num2)
			{
				break;
			}
			InnerWorldFilterMask innerWorldFilterMask = s_ActiveMasks[i];
			if (!(innerWorldFilterMask == null) && innerWorldFilterMask.isActiveAndEnabled && !(innerWorldFilterMask.radius <= 0f))
			{
				Vector3 position = innerWorldFilterMask.transform.position;
				masks[num] = new Vector4(position.x, position.y, position.z, innerWorldFilterMask.radius);
				num++;
			}
		}
		return num;
	}

	internal static bool HasActiveMask()
	{
		for (int i = 0; i < s_ActiveMasks.Count; i++)
		{
			InnerWorldFilterMask innerWorldFilterMask = s_ActiveMasks[i];
			if (innerWorldFilterMask != null && innerWorldFilterMask.isActiveAndEnabled && innerWorldFilterMask.radius > 0f)
			{
				return true;
			}
		}
		return false;
	}

	private void OnEnable()
	{
		if (!s_ActiveMasks.Contains(this))
		{
			s_ActiveMasks.Add(this);
		}
	}

	private void OnDisable()
	{
		s_ActiveMasks.Remove(this);
	}

	private void OnValidate()
	{
		if (radius < 0.001f)
		{
			radius = 0.001f;
		}
	}

	private void OnDrawGizmos()
	{
		DrawGizmo(selected: false);
	}

	private void OnDrawGizmosSelected()
	{
		DrawGizmo(selected: true);
	}

	private void DrawGizmo(bool selected)
	{
		Color color = Gizmos.color;
		Color color2 = gizmoColor;
		color2.a = (selected ? 0.75f : gizmoColor.a);
		Gizmos.color = color2;
		Gizmos.DrawWireSphere(transform.position, radius);
		Gizmos.color = color;
	}
}
