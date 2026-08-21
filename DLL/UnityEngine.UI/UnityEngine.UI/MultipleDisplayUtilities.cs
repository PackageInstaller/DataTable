using UnityEngine.EventSystems;

namespace UnityEngine.UI;

internal static class MultipleDisplayUtilities
{
	public static bool GetRelativeMousePositionForDrag(PointerEventData eventData, ref Vector2 position)
	{
		int displayIndex = eventData.pointerPressRaycast.displayIndex;
		Vector3 vector = RelativeMouseAtScaled(eventData.position);
		if ((int)vector.z != displayIndex)
		{
			return false;
		}
		position = ((displayIndex != 0) ? ((Vector2)vector) : eventData.position);
		return true;
	}

	public static Vector3 RelativeMouseAtScaled(Vector2 position)
	{
		if (Display.main.renderingWidth != Display.main.systemWidth || Display.main.renderingHeight != Display.main.systemHeight)
		{
			float num = (float)Display.main.systemWidth / (float)Display.main.systemHeight;
			Vector2 vector = new Vector2(Display.main.renderingWidth, Display.main.renderingHeight);
			Vector2 zero = Vector2.zero;
			if (Screen.fullScreen)
			{
				float num2 = (float)Screen.width / (float)Screen.height;
				if ((float)Display.main.systemHeight * num2 < (float)Display.main.systemWidth)
				{
					vector.x = (float)Display.main.renderingHeight * num;
					zero.x = (vector.x - (float)Display.main.renderingWidth) * 0.5f;
				}
				else
				{
					vector.y = (float)Display.main.renderingWidth / num;
					zero.y = (vector.y - (float)Display.main.renderingHeight) * 0.5f;
				}
			}
			Vector2 vector2 = vector - zero;
			if (position.y < 0f - zero.y || position.y > vector2.y || position.x < 0f - zero.x || position.x > vector2.x)
			{
				Vector2 vector3 = position;
				if (!Screen.fullScreen)
				{
					vector3.x -= (float)(Display.main.renderingWidth - Display.main.systemWidth) * 0.5f;
					vector3.y -= (float)(Display.main.renderingHeight - Display.main.systemHeight) * 0.5f;
				}
				else
				{
					vector3 += zero;
					vector3.x *= (float)Display.main.systemWidth / vector.x;
					vector3.y *= (float)Display.main.systemHeight / vector.y;
				}
				Vector3 result = Display.RelativeMouseAt(vector3);
				if (result.z != 0f)
				{
					return result;
				}
			}
			return new Vector3(position.x, position.y, 0f);
		}
		return Display.RelativeMouseAt(position);
	}
}
