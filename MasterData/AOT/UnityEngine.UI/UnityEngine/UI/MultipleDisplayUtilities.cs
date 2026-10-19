using UnityEngine.EventSystems;

namespace UnityEngine.UI;

internal static class MultipleDisplayUtilities
{
	public static bool GetRelativeMousePositionForDrag(PointerEventData eventData, ref Vector2 position)
	{
		int displayIndex = eventData.pointerPressRaycast.displayIndex;
		Vector3 vector = RelativeMouseAtScaled(eventData.position, eventData.displayIndex);
		if ((int)vector.z != displayIndex)
		{
			return false;
		}
		position = ((displayIndex != 0) ? ((Vector2)vector) : eventData.position);
		return true;
	}

	internal static Vector3 GetRelativeMousePositionForRaycast(PointerEventData eventData)
	{
		Vector3 vector = RelativeMouseAtScaled(eventData.position, eventData.displayIndex);
		if (vector == Vector3.zero)
		{
			vector = eventData.position;
		}
		if (eventData.displayIndex > 0)
		{
			vector.z = eventData.displayIndex;
		}
		return vector;
	}

	public static Vector3 RelativeMouseAtScaled(Vector2 position, int displayIndex)
	{
		Display main = Display.main;
		main = Display.displays[displayIndex];
		if (!Screen.fullScreen)
		{
			return new Vector3(position.x, position.y, displayIndex);
		}
		if (main.renderingWidth != main.systemWidth || main.renderingHeight != main.systemHeight)
		{
			float num = (float)main.systemWidth / (float)main.systemHeight;
			Vector2 vector = new Vector2(main.renderingWidth, main.renderingHeight);
			Vector2 zero = Vector2.zero;
			if (Screen.fullScreen)
			{
				float num2 = (float)Screen.width / (float)Screen.height;
				if ((float)main.systemHeight * num2 < (float)main.systemWidth)
				{
					vector.x = (float)main.renderingHeight * num;
					zero.x = (vector.x - (float)main.renderingWidth) * 0.5f;
				}
				else
				{
					vector.y = (float)main.renderingWidth / num;
					zero.y = (vector.y - (float)main.renderingHeight) * 0.5f;
				}
			}
			Vector2 vector2 = vector - zero;
			if (position.y < 0f - zero.y || position.y > vector2.y || position.x < 0f - zero.x || position.x > vector2.x)
			{
				Vector2 vector3 = position;
				if (!Screen.fullScreen)
				{
					vector3.x -= (float)(main.renderingWidth - main.systemWidth) * 0.5f;
					vector3.y -= (float)(main.renderingHeight - main.systemHeight) * 0.5f;
				}
				else
				{
					vector3 += zero;
					vector3.x *= (float)main.systemWidth / vector.x;
					vector3.y *= (float)main.systemHeight / vector.y;
				}
				Vector3 result = new Vector3(vector3.x, vector3.y, displayIndex);
				if (result.z != 0f)
				{
					return result;
				}
			}
			return new Vector3(position.x, position.y, displayIndex);
		}
		return new Vector3(position.x, position.y, displayIndex);
	}
}
