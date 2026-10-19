using UnityEngine;

namespace Unity.VisualScripting.Community.Libraries.Humility;

public static class HUMTransform
{
	public class Data
	{
		public struct Look(Transform transform)
		{
			public Transform transform = transform;
		}

		public struct In(Look look)
		{
			public Look look = look;
		}

		public struct At(Look look)
		{
			public Look look = look;
		}

		public struct Move(Transform transform)
		{
			public Transform transform = transform;
		}

		public struct MoveRigidbody(Rigidbody rigidbody)
		{
			public Rigidbody rigidbody = rigidbody;
		}

		public struct Straif(Move moveData)
		{
			public Move moveData = moveData;
		}

		public struct Size(Transform transform)
		{
			public Transform transform = transform;
		}

		public struct SnapPosition(From from, TransformSnapPosition position, Vector3 centerOffset)
		{
			public From from = from;

			public TransformSnapPosition position = position;

			public Vector3 centerOffset = centerOffset;
		}

		public struct From(Transform transform)
		{
			public Transform transform = transform;
		}

		public struct To(SnapPosition positionData)
		{
			public SnapPosition positionData = positionData;
		}

		public struct ObjectBounds(Transform snapTo, To to, Vector3 snapFromHalf, Vector3 snapToHalf)
		{
			public Transform snapTo = snapTo;

			public To to = to;

			public Vector3 snapToHalf = snapToHalf;

			public Vector3 snapFromHalf = snapFromHalf;
		}

		public enum TransformSnapPosition
		{
			Center,
			Left,
			Right,
			Top,
			Bottom,
			Front,
			Back
		}

		public enum TransformSnapToPosition
		{
			Left,
			Right,
			Top,
			Bottom,
			Front,
			Back
		}
	}

	internal static float GetTime(this TimeType timeType)
	{
		return timeType switch
		{
			TimeType.Time => Time.time, 
			TimeType.Delta => Time.deltaTime, 
			TimeType.Fixed => Time.fixedDeltaTime, 
			TimeType.UnscaledDelta => Time.unscaledDeltaTime, 
			TimeType.UnscaledFixed => Time.fixedUnscaledDeltaTime, 
			TimeType.UnscaledTime => Time.unscaledTime, 
			TimeType.UnscaledFixedTime => Time.fixedUnscaledTime, 
			_ => Time.deltaTime, 
		};
	}

	public static Data.Move Move(this Transform transform)
	{
		return new Data.Move(transform);
	}

	public static Data.MoveRigidbody Move(this Rigidbody rigidbody)
	{
		return new Data.MoveRigidbody(rigidbody);
	}

	public static Data.Look Look(this Transform transform)
	{
		return new Data.Look(transform);
	}

	public static Data.From Snap(this Transform transform)
	{
		return new Data.From(transform);
	}

	public static Data.Size Size(this Transform transform)
	{
		return new Data.Size(transform);
	}
}
