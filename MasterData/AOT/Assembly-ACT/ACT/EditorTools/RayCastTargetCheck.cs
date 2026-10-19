using UnityEngine;
using UnityEngine.UI;

namespace ACT.EditorTools;

public class RayCastTargetCheck : MonoBehaviour
{
	public Color[] list;

	private int getParentCount(Transform t)
	{
		int num = 0;
		while (t.parent != t.root)
		{
			num++;
			t = t.parent;
		}
		return num;
	}

	private void OnDrawGizmos()
	{
		MaskableGraphic[] array = Object.FindObjectsOfType<MaskableGraphic>();
		foreach (MaskableGraphic maskableGraphic in array)
		{
			if (maskableGraphic.raycastTarget)
			{
				RectTransform rectTransform = maskableGraphic.transform as RectTransform;
				float height = rectTransform.rect.height;
				float width = rectTransform.rect.width;
				Vector3 s = new Vector3(width * rectTransform.lossyScale.x, height * rectTransform.lossyScale.y, 0f);
				Vector2 pivot = rectTransform.pivot;
				Vector3 pos = rectTransform.position + new Vector3(s.x * (0.5f - pivot.x), s.y * (0.5f - pivot.y), 0f);
				if (maskableGraphic.TryGetComponent<Graphic>(out var component))
				{
					Vector4 raycastPadding = component.raycastPadding;
					pos += new Vector3(rectTransform.lossyScale.x * (raycastPadding.x - raycastPadding.z) / 2f, rectTransform.lossyScale.y * (raycastPadding.y - raycastPadding.w) / 2f, 0f);
					s += new Vector3(rectTransform.lossyScale.x * (0f - raycastPadding.x - raycastPadding.z), rectTransform.lossyScale.y * (0f - raycastPadding.y - raycastPadding.w), 0f);
				}
				int num = getParentCount(rectTransform) % list.Length;
				Gizmos.color = list[num];
				Matrix4x4 matrix = Gizmos.matrix;
				Gizmos.matrix = Matrix4x4.TRS(pos, rectTransform.rotation, s);
				Gizmos.DrawCube(Vector3.zero, Vector3.one);
				Gizmos.matrix = matrix;
			}
		}
	}
}
