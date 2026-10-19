using UnityEngine;

namespace Unity.VisualScripting.Community.Libraries.Humility;

public static class HUMTransform_Children
{
	public static HUMTransform.Data.SnapPosition Center(this HUMTransform.Data.From from)
	{
		return new HUMTransform.Data.SnapPosition(from, HUMTransform.Data.TransformSnapPosition.Center, Vector3.zero);
	}

	public static HUMTransform.Data.SnapPosition Bottom(this HUMTransform.Data.From from)
	{
		return new HUMTransform.Data.SnapPosition(from, HUMTransform.Data.TransformSnapPosition.Bottom, Vector3.zero);
	}

	public static HUMTransform.Data.SnapPosition Top(this HUMTransform.Data.From from)
	{
		return new HUMTransform.Data.SnapPosition(from, HUMTransform.Data.TransformSnapPosition.Top, Vector3.zero);
	}

	public static HUMTransform.Data.SnapPosition Left(this HUMTransform.Data.From from)
	{
		return new HUMTransform.Data.SnapPosition(from, HUMTransform.Data.TransformSnapPosition.Left, Vector3.zero);
	}

	public static HUMTransform.Data.SnapPosition Right(this HUMTransform.Data.From from)
	{
		return new HUMTransform.Data.SnapPosition(from, HUMTransform.Data.TransformSnapPosition.Right, Vector3.zero);
	}

	public static HUMTransform.Data.SnapPosition Front(this HUMTransform.Data.From from)
	{
		return new HUMTransform.Data.SnapPosition(from, HUMTransform.Data.TransformSnapPosition.Front, Vector3.zero);
	}

	public static HUMTransform.Data.SnapPosition Back(this HUMTransform.Data.From from)
	{
		return new HUMTransform.Data.SnapPosition(from, HUMTransform.Data.TransformSnapPosition.Back, Vector3.zero);
	}

	public static HUMTransform.Data.SnapPosition Center(this HUMTransform.Data.From from, Vector3 offset)
	{
		return new HUMTransform.Data.SnapPosition(from, HUMTransform.Data.TransformSnapPosition.Center, offset);
	}

	public static HUMTransform.Data.SnapPosition Bottom(this HUMTransform.Data.From from, Vector3 offset)
	{
		return new HUMTransform.Data.SnapPosition(from, HUMTransform.Data.TransformSnapPosition.Bottom, offset);
	}

	public static HUMTransform.Data.SnapPosition Top(this HUMTransform.Data.From from, Vector3 offset)
	{
		return new HUMTransform.Data.SnapPosition(from, HUMTransform.Data.TransformSnapPosition.Top, offset);
	}

	public static HUMTransform.Data.SnapPosition Left(this HUMTransform.Data.From from, Vector3 offset)
	{
		return new HUMTransform.Data.SnapPosition(from, HUMTransform.Data.TransformSnapPosition.Left, offset);
	}

	public static HUMTransform.Data.SnapPosition Right(this HUMTransform.Data.From from, Vector3 offset)
	{
		return new HUMTransform.Data.SnapPosition(from, HUMTransform.Data.TransformSnapPosition.Right, offset);
	}

	public static Vector3 Top(this HUMTransform.Data.ObjectBounds bounds, float padding = 0f)
	{
		Vector3 vector = Vector3.zero;
		switch (bounds.to.positionData.position)
		{
		case HUMTransform.Data.TransformSnapPosition.Center:
			vector = bounds.snapTo.position + new Vector3(0f, bounds.snapTo.localScale.y / 2f, 0f);
			bounds.to.positionData.from.transform.Snap().Center().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Top:
			vector = bounds.snapTo.position + new Vector3(0f, bounds.snapTo.localScale.y / 2f, 0f);
			bounds.to.positionData.from.transform.Snap().Top().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Bottom:
			vector = bounds.snapTo.position + new Vector3(0f, bounds.snapTo.localScale.y / 2f, 0f);
			bounds.to.positionData.from.transform.Snap().Bottom().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Left:
			vector = bounds.snapTo.position + new Vector3(0f, bounds.snapTo.localScale.y / 2f, 0f);
			bounds.to.positionData.from.transform.Snap().Left().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Right:
			vector = bounds.snapTo.position + new Vector3(0f, bounds.snapTo.localScale.y / 2f, 0f);
			bounds.to.positionData.from.transform.Snap().Right().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Front:
			vector = bounds.snapTo.position + new Vector3(0f, bounds.snapTo.localScale.y / 2f, 0f);
			bounds.to.positionData.from.transform.Snap().Front().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Back:
			vector = bounds.snapTo.position + new Vector3(0f, bounds.snapTo.localScale.y / 2f, 0f);
			bounds.to.positionData.from.transform.Snap().Back().To()
				.Point(vector, padding);
			break;
		}
		return vector;
	}

	public static Vector3 Bottom(this HUMTransform.Data.ObjectBounds bounds, float padding = 0f)
	{
		Vector3 vector = Vector3.zero;
		switch (bounds.to.positionData.position)
		{
		case HUMTransform.Data.TransformSnapPosition.Center:
			vector = bounds.snapTo.position - new Vector3(0f, bounds.snapTo.localScale.y / 2f, 0f);
			bounds.to.positionData.from.transform.Snap().Center().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Top:
			vector = bounds.snapTo.position - new Vector3(0f, bounds.snapTo.localScale.y / 2f, 0f);
			bounds.to.positionData.from.transform.Snap().Top().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Bottom:
			vector = bounds.snapTo.position - new Vector3(0f, bounds.snapTo.localScale.y / 2f, 0f);
			bounds.to.positionData.from.transform.Snap().Bottom().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Left:
			vector = bounds.snapTo.position - new Vector3(0f, bounds.snapTo.localScale.y / 2f, 0f);
			bounds.to.positionData.from.transform.Snap().Left().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Right:
			vector = bounds.snapTo.position - new Vector3(0f, bounds.snapTo.localScale.y / 2f, 0f);
			bounds.to.positionData.from.transform.Snap().Right().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Front:
			vector = bounds.snapTo.position - new Vector3(0f, bounds.snapTo.localScale.y / 2f, 0f);
			bounds.to.positionData.from.transform.Snap().Front().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Back:
			vector = bounds.snapTo.position - new Vector3(0f, bounds.snapTo.localScale.y / 2f, 0f);
			bounds.to.positionData.from.transform.Snap().Back().To()
				.Point(vector, padding);
			break;
		}
		return vector;
	}

	public static Vector3 Left(this HUMTransform.Data.ObjectBounds bounds, float padding = 0f)
	{
		Vector3 vector = Vector3.zero;
		switch (bounds.to.positionData.position)
		{
		case HUMTransform.Data.TransformSnapPosition.Center:
			vector = bounds.snapTo.position - new Vector3(bounds.snapTo.localScale.x / 2f, 0f, 0f);
			bounds.to.positionData.from.transform.Snap().Center().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Top:
			vector = bounds.snapTo.position - new Vector3(bounds.snapTo.localScale.x / 2f, 0f, 0f);
			bounds.to.positionData.from.transform.Snap().Center().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Bottom:
			vector = bounds.snapTo.position - new Vector3(bounds.snapTo.localScale.x / 2f, 0f, 0f);
			bounds.to.positionData.from.transform.Snap().Bottom().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Left:
			vector = bounds.snapTo.position - new Vector3(bounds.snapTo.localScale.x / 2f, 0f, 0f);
			bounds.to.positionData.from.transform.Snap().Left().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Right:
			vector = bounds.snapTo.position - new Vector3(bounds.snapTo.localScale.x / 2f, 0f, 0f);
			bounds.to.positionData.from.transform.Snap().Right().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Front:
			vector = bounds.snapTo.position - new Vector3(bounds.snapTo.localScale.x / 2f, 0f, 0f);
			bounds.to.positionData.from.transform.Snap().Front().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Back:
			vector = bounds.snapTo.position - new Vector3(bounds.snapTo.localScale.x / 2f, 0f, 0f);
			bounds.to.positionData.from.transform.Snap().Back().To()
				.Point(vector, padding);
			break;
		}
		return vector;
	}

	public static Vector3 Right(this HUMTransform.Data.ObjectBounds bounds, float padding = 0f)
	{
		Vector3 vector = Vector3.zero;
		switch (bounds.to.positionData.position)
		{
		case HUMTransform.Data.TransformSnapPosition.Center:
			vector = bounds.snapTo.position + new Vector3(bounds.snapTo.localScale.x / 2f, 0f, 0f);
			bounds.to.positionData.from.transform.Snap().Center().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Top:
			vector = bounds.snapTo.position + new Vector3(bounds.snapTo.localScale.x / 2f, 0f, 0f);
			bounds.to.positionData.from.transform.Snap().Center().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Bottom:
			vector = bounds.snapTo.position + new Vector3(bounds.snapTo.localScale.x / 2f, 0f, 0f);
			bounds.to.positionData.from.transform.Snap().Bottom().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Left:
			vector = bounds.snapTo.position + new Vector3(bounds.snapTo.localScale.x / 2f, 0f, 0f);
			bounds.to.positionData.from.transform.Snap().Left().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Right:
			vector = bounds.snapTo.position + new Vector3(bounds.snapTo.localScale.x / 2f, 0f, 0f);
			bounds.to.positionData.from.transform.Snap().Right().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Front:
			vector = bounds.snapTo.position + new Vector3(bounds.snapTo.localScale.x / 2f, 0f, 0f);
			bounds.to.positionData.from.transform.Snap().Front().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Back:
			vector = bounds.snapTo.position + new Vector3(bounds.snapTo.localScale.x / 2f, 0f, 0f);
			bounds.to.positionData.from.transform.Snap().Back().To()
				.Point(vector, padding);
			break;
		}
		return vector;
	}

	public static Vector3 Front(this HUMTransform.Data.ObjectBounds bounds, float padding = 0f)
	{
		Vector3 vector = Vector3.zero;
		switch (bounds.to.positionData.position)
		{
		case HUMTransform.Data.TransformSnapPosition.Center:
			vector = bounds.snapTo.position + new Vector3(0f, 0f, bounds.snapTo.localScale.z / 2f);
			bounds.to.positionData.from.transform.Snap().Center().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Top:
			vector = bounds.snapTo.position + new Vector3(0f, 0f, bounds.snapTo.localScale.z / 2f);
			bounds.to.positionData.from.transform.Snap().Center().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Bottom:
			vector = bounds.snapTo.position + new Vector3(0f, 0f, bounds.snapTo.localScale.z / 2f);
			bounds.to.positionData.from.transform.Snap().Bottom().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Left:
			vector = bounds.snapTo.position + new Vector3(0f, 0f, bounds.snapTo.localScale.z / 2f);
			bounds.to.positionData.from.transform.Snap().Left().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Right:
			vector = bounds.snapTo.position + new Vector3(0f, 0f, bounds.snapTo.localScale.z / 2f);
			bounds.to.positionData.from.transform.Snap().Right().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Front:
			vector = bounds.snapTo.position + new Vector3(0f, 0f, bounds.snapTo.localScale.z / 2f);
			bounds.to.positionData.from.transform.Snap().Front().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Back:
			vector = bounds.snapTo.position + new Vector3(0f, 0f, bounds.snapTo.localScale.z / 2f);
			bounds.to.positionData.from.transform.Snap().Back().To()
				.Point(vector, padding);
			break;
		}
		return vector;
	}

	public static Vector3 Back(this HUMTransform.Data.ObjectBounds bounds, float padding = 0f)
	{
		Vector3 vector = Vector3.zero;
		switch (bounds.to.positionData.position)
		{
		case HUMTransform.Data.TransformSnapPosition.Center:
			vector = bounds.snapTo.position - new Vector3(0f, 0f, bounds.snapTo.localScale.z / 2f);
			bounds.to.positionData.from.transform.Snap().Center().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Top:
			vector = bounds.snapTo.position - new Vector3(0f, 0f, bounds.snapTo.localScale.z / 2f);
			bounds.to.positionData.from.transform.Snap().Center().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Bottom:
			vector = bounds.snapTo.position - new Vector3(0f, 0f, bounds.snapTo.localScale.z / 2f);
			bounds.to.positionData.from.transform.Snap().Bottom().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Left:
			vector = bounds.snapTo.position - new Vector3(0f, 0f, bounds.snapTo.localScale.z / 2f);
			bounds.to.positionData.from.transform.Snap().Left().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Right:
			vector = bounds.snapTo.position - new Vector3(0f, 0f, bounds.snapTo.localScale.z / 2f);
			bounds.to.positionData.from.transform.Snap().Right().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Front:
			vector = bounds.snapTo.position - new Vector3(0f, 0f, bounds.snapTo.localScale.z / 2f);
			bounds.to.positionData.from.transform.Snap().Front().To()
				.Point(vector, padding);
			break;
		case HUMTransform.Data.TransformSnapPosition.Back:
			vector = bounds.snapTo.position - new Vector3(0f, 0f, bounds.snapTo.localScale.z / 2f);
			bounds.to.positionData.from.transform.Snap().Back().To()
				.Point(vector, padding);
			break;
		}
		return vector;
	}

	public static Vector3 Half(this HUMTransform.Data.Size data)
	{
		if (!(data.transform == null))
		{
			return data.transform.localScale / 2f;
		}
		return Vector3.zero;
	}

	public static void Backward(this HUMTransform.Data.Move moveData, float speed, TimeType timeType = TimeType.Delta)
	{
		moveData.transform.position -= moveData.transform.forward * (speed * timeType.GetTime());
	}

	public static void Left(this HUMTransform.Data.Move moveData, float speed, TimeType timeType = TimeType.Delta)
	{
		moveData.transform.position -= moveData.transform.right * (speed * timeType.GetTime());
	}

	public static void Right(this HUMTransform.Data.Move moveData, float speed, TimeType timeType = TimeType.Delta)
	{
		moveData.transform.position += moveData.transform.right * (speed * timeType.GetTime());
	}

	public static HUMTransform.Data.In In(this HUMTransform.Data.Look lookData)
	{
		return new HUMTransform.Data.In(lookData);
	}

	public static HUMTransform.Data.At At(this HUMTransform.Data.Look lookData)
	{
		return new HUMTransform.Data.At(lookData);
	}

	public static Vector3 Point(this HUMTransform.Data.To to, Vector3 point, float padding = 0f)
	{
		Vector3 vector = to.positionData.from.transform.Size().Half();
		switch (to.positionData.position)
		{
		case HUMTransform.Data.TransformSnapPosition.Center:
			to.positionData.from.transform.position = point;
			break;
		case HUMTransform.Data.TransformSnapPosition.Top:
			to.positionData.from.transform.position = new Vector3(point.x, point.y - padding - vector.y, point.z);
			break;
		case HUMTransform.Data.TransformSnapPosition.Bottom:
			to.positionData.from.transform.position = new Vector3(point.x, point.y + padding + vector.y, point.z);
			break;
		case HUMTransform.Data.TransformSnapPosition.Left:
			to.positionData.from.transform.position = new Vector3(point.x + padding + vector.x, point.y, point.z);
			break;
		case HUMTransform.Data.TransformSnapPosition.Right:
			to.positionData.from.transform.position = new Vector3(point.x - padding - vector.x, point.y, point.z);
			break;
		}
		return point;
	}

	public static Vector2 Point(this HUMTransform.Data.To to, Vector2 point, Axis lockedAxis)
	{
		return lockedAxis switch
		{
			Axis.X => (Vector2)to.Point(new Vector3(to.positionData.from.transform.position.x, point.x, point.y)), 
			Axis.Y => (Vector2)to.Point(new Vector3(point.x, to.positionData.from.transform.position.y, point.y)), 
			Axis.Z => (Vector2)to.Point(new Vector3(point.x, point.y, to.positionData.from.transform.position.z)), 
			_ => (Vector2)Vector3.zero, 
		};
	}

	public static HUMTransform.Data.ObjectBounds ObjectBounds(this HUMTransform.Data.To to, Transform snapTo)
	{
		Vector3 snapFromHalf = to.positionData.from.transform.Size().Half();
		Vector3 snapToHalf = snapTo.Size().Half();
		return new HUMTransform.Data.ObjectBounds(snapTo, to, snapFromHalf, snapToHalf);
	}

	public static void Forward(this HUMTransform.Data.Move moveData, float speed, TimeType timeType = TimeType.Delta)
	{
		moveData.transform.position += moveData.transform.forward * (speed * timeType.GetTime());
	}

	public static void Forward(this HUMTransform.Data.MoveRigidbody moveData, Transform transform, float speed, TimeType timeType = TimeType.Delta)
	{
		moveData.rigidbody.MovePosition(moveData.rigidbody.position + transform.forward * (speed * timeType.GetTime()));
	}

	public static HUMTransform.Data.To To(this HUMTransform.Data.SnapPosition positionData)
	{
		return new HUMTransform.Data.To(positionData);
	}

	public static void Direction(this HUMTransform.Data.In inData, Vector3 direction)
	{
		inData.look.transform.forward = direction.normalized;
	}

	public static void Object(this HUMTransform.Data.At atData, GameObject gameObject)
	{
		atData.look.transform.forward = atData.look.transform.position - gameObject.transform.position;
	}
}
