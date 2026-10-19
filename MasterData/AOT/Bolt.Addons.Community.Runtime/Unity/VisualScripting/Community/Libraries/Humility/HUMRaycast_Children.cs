using UnityEngine;

namespace Unity.VisualScripting.Community.Libraries.Humility;

public static class HUMRaycast_Children
{
	public static HUMRaycast.Data.Multiple Multiple(this HUMRaycast.Data.With withData)
	{
		return new HUMRaycast.Data.Multiple(withData.origin);
	}

	public static HUMRaycast.Data.With With(this HUMRaycast.Data.Find findData)
	{
		return new HUMRaycast.Data.With(findData.origin);
	}

	public static HUMRaycast.Data.Touching Touching(this HUMRaycast.Data.Is isData)
	{
		return new HUMRaycast.Data.Touching(isData.origin);
	}

	public static ContactConnection<GameObject> Environment(this HUMRaycast.Data.Touching touchData, Vector3 direction, float length)
	{
		RaycastHit[] array = Physics.RaycastAll(touchData.origin, direction, length);
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i].collider.tag == "Environment")
			{
				return new ContactConnection<GameObject>(array[i].collider.gameObject);
			}
		}
		return new ContactConnection<GameObject>(null);
	}

	public static ContactConnection<GameObject> Environment(this HUMRaycast.Data.Touching touchData, Vector3 direction)
	{
		RaycastHit[] array = Physics.RaycastAll(touchData.origin, direction);
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i].collider.tag == "Environment")
			{
				return new ContactConnection<GameObject>(array[i].collider.gameObject);
			}
		}
		return new ContactConnection<GameObject>(null);
	}

	public static ContactConnection<GameObject> Ceiling(this HUMRaycast.Data.Touching touchData, float length)
	{
		Debug.DrawRay(new Vector3(touchData.origin.x, touchData.origin.y, touchData.origin.z), Vector3.up, Color.red);
		return touchData.Environment(Vector3.up, length);
	}

	public static ContactConnection<GameObject> Floor(this HUMRaycast.Data.Touching touchData, float length)
	{
		Debug.DrawRay(new Vector3(touchData.origin.x, touchData.origin.y, touchData.origin.z), Vector3.down, Color.red);
		return touchData.Environment(Vector3.down, length);
	}

	public static ContactConnection<T> Rays<T>(this HUMRaycast.Data.Multiple multipleData, Vector3 forward, Vector3 up, Vector2 spacing, int rows, int columns, float rayLength, out RaycastHit[] hit) where T : class
	{
		T val = null;
		hit = null;
		for (int i = 0; i < rows; i++)
		{
			for (int j = 0; j < columns; j++)
			{
				Vector3 origin = multipleData.origin;
				origin += Vector3.Cross(up.normalized, forward.normalized).Multiply(i) * spacing.y;
				origin += -up.Multiply(j) * spacing.x;
				hit = Physics.RaycastAll(origin, forward, rayLength);
				Debug.DrawRay(origin, forward * rayLength, Color.red);
				for (int k = 0; k < hit.Length; k++)
				{
					val = hit[k].collider.GetComponent<T>();
					if (val != null)
					{
						return new ContactConnection<T>(val, hit[k].distance);
					}
				}
			}
		}
		return new ContactConnection<T>(null);
	}

	public static ContactConnection<T> Rays<T>(this HUMRaycast.Data.Multiple multipleData, Transform targetPoint, Vector2 spacing, int rows, int columns, float rayLength, out RaycastHit[] hit) where T : class
	{
		T val = null;
		hit = null;
		for (int i = 0; i < rows; i++)
		{
			for (int j = 0; j < columns; j++)
			{
				Vector3 origin = multipleData.origin;
				origin += -targetPoint.right.Multiply(i) * spacing.y;
				origin += -targetPoint.up.Multiply(j) * spacing.x;
				hit = Physics.RaycastAll(origin, targetPoint.forward, rayLength);
				Debug.DrawRay(origin, targetPoint.forward * rayLength, Color.red);
				for (int k = 0; k < hit.Length; k++)
				{
					val = hit[k].collider.GetComponent<T>();
					if (val != null)
					{
						return new ContactConnection<T>(val, hit[k].distance);
					}
				}
			}
		}
		return new ContactConnection<T>(null);
	}
}
