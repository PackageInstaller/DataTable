using System.Collections.Generic;
using UnityEngine;

namespace Cinemachine;

internal class TargetPositionCache
{
	public enum Mode
	{
		Disabled,
		Record,
		Playback
	}

	private class CacheCurve
	{
		public struct Item
		{
			public Vector3 Pos;

			public Quaternion Rot;

			public static Item Empty => new Item
			{
				Rot = Quaternion.identity
			};

			public static Item Lerp(Item a, Item b, float t)
			{
				return new Item
				{
					Pos = Vector3.LerpUnclamped(a.Pos, b.Pos, t),
					Rot = Quaternion.SlerpUnclamped(a.Rot, b.Rot, t)
				};
			}
		}

		public float StartTime;

		public float StepSize;

		private List<Item> m_Cache;

		public int Count => m_Cache.Count;

		public CacheCurve(float startTime, float endTime, float stepSize)
		{
			StepSize = stepSize;
			StartTime = startTime;
			m_Cache = new List<Item>(Mathf.CeilToInt((StepSize * 0.5f + endTime - startTime) / StepSize));
		}

		public void Add(Item item)
		{
			m_Cache.Add(item);
		}

		public void AddUntil(Item item, float time, bool isCut)
		{
			int num = m_Cache.Count - 1;
			float num2 = (float)num * StepSize;
			float num3 = time - StartTime - num2;
			if (isCut)
			{
				for (float num4 = StepSize; num4 <= num3; num4 += StepSize)
				{
					Add(item);
				}
				return;
			}
			Item a = m_Cache[num];
			for (float num5 = StepSize; num5 <= num3; num5 += StepSize)
			{
				Add(Item.Lerp(a, item, num5 / num3));
			}
		}

		public Item Evaluate(float time)
		{
			int count = m_Cache.Count;
			if (count == 0)
			{
				return Item.Empty;
			}
			float num = time - StartTime;
			int num2 = Mathf.Clamp(Mathf.FloorToInt(num / StepSize), 0, count - 1);
			Item item = m_Cache[num2];
			if (num2 == count - 1)
			{
				return item;
			}
			return Item.Lerp(item, m_Cache[num2 + 1], (num - (float)num2 * StepSize) / StepSize);
		}
	}

	private class CacheEntry
	{
		private struct RecordingItem
		{
			public float Time;

			public bool IsCut;

			public CacheCurve.Item Item;
		}

		public CacheCurve Curve;

		private List<RecordingItem> RawItems = new List<RecordingItem>();

		public void AddRawItem(float time, bool isCut, Transform target)
		{
			float num = time - 1f / 60f;
			int num2 = RawItems.Count - 1;
			int num3 = num2;
			while (num3 >= 0 && RawItems[num3].Time > num)
			{
				num3--;
			}
			if (num3 == num2)
			{
				RawItems.Add(new RecordingItem
				{
					Time = time,
					IsCut = isCut,
					Item = new CacheCurve.Item
					{
						Pos = target.position,
						Rot = target.rotation
					}
				});
				return;
			}
			int num4 = num3 + 2;
			if (num4 <= num2)
			{
				RawItems.RemoveRange(num4, RawItems.Count - num4);
			}
			RawItems[num3 + 1] = new RecordingItem
			{
				Time = time,
				IsCut = isCut,
				Item = new CacheCurve.Item
				{
					Pos = target.position,
					Rot = target.rotation
				}
			};
		}

		public void CreateCurves()
		{
			int num = RawItems.Count - 1;
			float startTime = ((num < 0) ? 0f : RawItems[0].Time);
			float endTime = ((num < 0) ? 0f : RawItems[num].Time);
			Curve = new CacheCurve(startTime, endTime, 1f / 60f);
			Curve.Add((num < 0) ? CacheCurve.Item.Empty : RawItems[0].Item);
			for (int i = 1; i <= num; i++)
			{
				Curve.AddUntil(RawItems[i].Item, RawItems[i].Time, RawItems[i].IsCut);
			}
			RawItems.Clear();
		}
	}

	public struct TimeRange
	{
		public float Start;

		public float End;

		public bool IsEmpty => End < Start;

		public static TimeRange Empty => new TimeRange
		{
			Start = float.MaxValue,
			End = float.MinValue
		};

		public bool Contains(float time)
		{
			if (time >= Start)
			{
				return time <= End;
			}
			return false;
		}

		public void Include(float time)
		{
			Start = Mathf.Min(Start, time);
			End = Mathf.Max(End, time);
		}
	}

	public static bool UseCache;

	public const float CacheStepSize = 1f / 60f;

	private static Mode m_CacheMode;

	public static float CurrentTime;

	public static int CurrentFrame;

	public static bool IsCameraCut;

	private static Dictionary<Transform, CacheEntry> m_Cache;

	private static TimeRange m_CacheTimeRange;

	private const float kWraparoundSlush = 0.1f;

	public static Mode CacheMode
	{
		get
		{
			return m_CacheMode;
		}
		set
		{
			if (value != m_CacheMode)
			{
				m_CacheMode = value;
				switch (value)
				{
				default:
					ClearCache();
					break;
				case Mode.Record:
					ClearCache();
					break;
				case Mode.Playback:
					CreatePlaybackCurves();
					break;
				}
			}
		}
	}

	public static bool IsRecording
	{
		get
		{
			if (UseCache)
			{
				return m_CacheMode == Mode.Record;
			}
			return false;
		}
	}

	public static bool CurrentPlaybackTimeValid
	{
		get
		{
			if (UseCache && m_CacheMode == Mode.Playback)
			{
				return HasCurrentTime;
			}
			return false;
		}
	}

	public static bool IsEmpty => CacheTimeRange.IsEmpty;

	public static TimeRange CacheTimeRange => m_CacheTimeRange;

	public static bool HasCurrentTime => m_CacheTimeRange.Contains(CurrentTime);

	public static void ClearCache()
	{
		m_Cache = ((CacheMode == Mode.Disabled) ? null : new Dictionary<Transform, CacheEntry>());
		m_CacheTimeRange = TimeRange.Empty;
		CurrentTime = 0f;
		CurrentFrame = 0;
		IsCameraCut = false;
	}

	private static void CreatePlaybackCurves()
	{
		if (m_Cache == null)
		{
			m_Cache = new Dictionary<Transform, CacheEntry>();
		}
		Dictionary<Transform, CacheEntry>.Enumerator enumerator = m_Cache.GetEnumerator();
		while (enumerator.MoveNext())
		{
			enumerator.Current.Value.CreateCurves();
		}
	}

	public static Vector3 GetTargetPosition(Transform target)
	{
		if (!UseCache || CacheMode == Mode.Disabled)
		{
			return target.position;
		}
		if (CacheMode == Mode.Record && !m_CacheTimeRange.IsEmpty && CurrentTime < m_CacheTimeRange.Start - 0.1f)
		{
			ClearCache();
		}
		if (CacheMode == Mode.Playback && !HasCurrentTime)
		{
			return target.position;
		}
		if (!m_Cache.TryGetValue(target, out var value))
		{
			if (CacheMode != Mode.Record)
			{
				return target.position;
			}
			value = new CacheEntry();
			m_Cache.Add(target, value);
		}
		if (CacheMode == Mode.Record)
		{
			value.AddRawItem(CurrentTime, IsCameraCut, target);
			m_CacheTimeRange.Include(CurrentTime);
			return target.position;
		}
		if (value.Curve == null)
		{
			return target.position;
		}
		return value.Curve.Evaluate(CurrentTime).Pos;
	}

	public static Quaternion GetTargetRotation(Transform target)
	{
		if (CacheMode == Mode.Disabled)
		{
			return target.rotation;
		}
		if (CacheMode == Mode.Record && !m_CacheTimeRange.IsEmpty && CurrentTime < m_CacheTimeRange.Start - 0.1f)
		{
			ClearCache();
		}
		if (CacheMode == Mode.Playback && !HasCurrentTime)
		{
			return target.rotation;
		}
		if (!m_Cache.TryGetValue(target, out var value))
		{
			if (CacheMode != Mode.Record)
			{
				return target.rotation;
			}
			value = new CacheEntry();
			m_Cache.Add(target, value);
		}
		if (CacheMode == Mode.Record)
		{
			if (m_CacheTimeRange.End <= CurrentTime)
			{
				value.AddRawItem(CurrentTime, IsCameraCut, target);
				m_CacheTimeRange.Include(CurrentTime);
			}
			return target.rotation;
		}
		return value.Curve.Evaluate(CurrentTime).Rot;
	}
}
