using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeClass("UI::RectTransform")]
[NativeHeader("Runtime/Transform/RectTransform.h")]
public sealed class RectTransform : Transform
{
	public enum Edge
	{
		Left,
		Right,
		Top,
		Bottom
	}

	public enum Axis
	{
		Horizontal,
		Vertical
	}

	public delegate void ReapplyDrivenProperties(RectTransform driven);

	public Rect rect
	{
		get
		{
			get_rect_Injected(out var ret);
			return ret;
		}
	}

	public Vector2 anchorMin
	{
		get
		{
			get_anchorMin_Injected(out var ret);
			return ret;
		}
		set
		{
			set_anchorMin_Injected(ref value);
		}
	}

	public Vector2 anchorMax
	{
		get
		{
			get_anchorMax_Injected(out var ret);
			return ret;
		}
		set
		{
			set_anchorMax_Injected(ref value);
		}
	}

	public Vector2 anchoredPosition
	{
		get
		{
			get_anchoredPosition_Injected(out var ret);
			return ret;
		}
		set
		{
			set_anchoredPosition_Injected(ref value);
		}
	}

	public Vector2 sizeDelta
	{
		get
		{
			get_sizeDelta_Injected(out var ret);
			return ret;
		}
		set
		{
			set_sizeDelta_Injected(ref value);
		}
	}

	public Vector2 pivot
	{
		get
		{
			get_pivot_Injected(out var ret);
			return ret;
		}
		set
		{
			set_pivot_Injected(ref value);
		}
	}

	public Vector3 anchoredPosition3D
	{
		get
		{
			Vector2 vector = anchoredPosition;
			return new Vector3(vector.x, vector.y, base.localPosition.z);
		}
		set
		{
			anchoredPosition = new Vector2(value.x, value.y);
			Vector3 vector = base.localPosition;
			vector.z = value.z;
			base.localPosition = vector;
		}
	}

	public Vector2 offsetMin
	{
		get
		{
			return anchoredPosition - Vector2.Scale(sizeDelta, pivot);
		}
		set
		{
			Vector2 vector = value - (anchoredPosition - Vector2.Scale(sizeDelta, pivot));
			sizeDelta -= vector;
			anchoredPosition += Vector2.Scale(vector, Vector2.one - pivot);
		}
	}

	public Vector2 offsetMax
	{
		get
		{
			return anchoredPosition + Vector2.Scale(sizeDelta, Vector2.one - pivot);
		}
		set
		{
			Vector2 vector = value - (anchoredPosition + Vector2.Scale(sizeDelta, Vector2.one - pivot));
			sizeDelta += vector;
			anchoredPosition += Vector2.Scale(vector, pivot);
		}
	}

	public extern Object drivenByObject
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		internal set;
	}

	internal extern DrivenTransformProperties drivenProperties
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static event ReapplyDrivenProperties reapplyDrivenProperties;

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("UpdateIfTransformDispatchIsDirty")]
	public extern void ForceUpdateRectTransforms();

	public void GetLocalCorners(Vector3[] fourCornersArray)
	{
		if (fourCornersArray == null || fourCornersArray.Length < 4)
		{
			Debug.LogError("Calling GetLocalCorners with an array that is null or has less than 4 elements.");
			return;
		}
		Rect rect = this.rect;
		float x = rect.x;
		float y = rect.y;
		float xMax = rect.xMax;
		float yMax = rect.yMax;
		fourCornersArray[0] = new Vector3(x, y, 0f);
		fourCornersArray[1] = new Vector3(x, yMax, 0f);
		fourCornersArray[2] = new Vector3(xMax, yMax, 0f);
		fourCornersArray[3] = new Vector3(xMax, y, 0f);
	}

	public void GetWorldCorners(Vector3[] fourCornersArray)
	{
		if (fourCornersArray == null || fourCornersArray.Length < 4)
		{
			Debug.LogError("Calling GetWorldCorners with an array that is null or has less than 4 elements.");
			return;
		}
		GetLocalCorners(fourCornersArray);
		Matrix4x4 matrix4x = base.transform.localToWorldMatrix;
		for (int i = 0; i < 4; i++)
		{
			fourCornersArray[i] = matrix4x.MultiplyPoint(fourCornersArray[i]);
		}
	}

	public void SetInsetAndSizeFromParentEdge(Edge edge, float inset, float size)
	{
		int index = ((edge == Edge.Top || edge == Edge.Bottom) ? 1 : 0);
		bool flag = edge == Edge.Top || edge == Edge.Right;
		float value = (flag ? 1 : 0);
		Vector2 vector = anchorMin;
		vector[index] = value;
		anchorMin = vector;
		vector = anchorMax;
		vector[index] = value;
		anchorMax = vector;
		Vector2 vector2 = sizeDelta;
		vector2[index] = size;
		sizeDelta = vector2;
		Vector2 vector3 = anchoredPosition;
		vector3[index] = (flag ? (0f - inset - size * (1f - pivot[index])) : (inset + size * pivot[index]));
		anchoredPosition = vector3;
	}

	public void SetSizeWithCurrentAnchors(Axis axis, float size)
	{
		Vector2 vector = sizeDelta;
		vector[(int)axis] = size - GetParentSize()[(int)axis] * (anchorMax[(int)axis] - anchorMin[(int)axis]);
		sizeDelta = vector;
	}

	[RequiredByNativeCode]
	internal static void SendReapplyDrivenProperties(RectTransform driven)
	{
		reapplyDrivenProperties?.Invoke(driven);
	}

	internal Rect GetRectInParentSpace()
	{
		Rect result = rect;
		Vector2 vector = offsetMin + Vector2.Scale(pivot, result.size);
		if ((bool)base.transform.parent)
		{
			RectTransform component = base.transform.parent.GetComponent<RectTransform>();
			if ((bool)component)
			{
				vector += Vector2.Scale(anchorMin, component.rect.size);
			}
		}
		result.x += vector.x;
		result.y += vector.y;
		return result;
	}

	private Vector2 GetParentSize()
	{
		RectTransform rectTransform = base.parent as RectTransform;
		if (!rectTransform)
		{
			return Vector2.zero;
		}
		return rectTransform.rect.size;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_rect_Injected(out Rect ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_anchorMin_Injected(out Vector2 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_anchorMin_Injected(ref Vector2 value);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_anchorMax_Injected(out Vector2 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_anchorMax_Injected(ref Vector2 value);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_anchoredPosition_Injected(out Vector2 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_anchoredPosition_Injected(ref Vector2 value);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_sizeDelta_Injected(out Vector2 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_sizeDelta_Injected(ref Vector2 value);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_pivot_Injected(out Vector2 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_pivot_Injected(ref Vector2 value);
}
