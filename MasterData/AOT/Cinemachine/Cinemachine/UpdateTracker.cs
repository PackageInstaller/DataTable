using System.Collections.Generic;
using UnityEngine;

namespace Cinemachine;

[DocumentationSorting(DocumentationSortingAttribute.Level.Undoc)]
internal class UpdateTracker
{
	public enum UpdateClock
	{
		Fixed,
		Late
	}

	private class UpdateStatus
	{
		private const int kWindowSize = 30;

		private int windowStart;

		private int numWindowLateUpdateMoves;

		private int numWindowFixedUpdateMoves;

		private int numWindows;

		private int lastFrameUpdated;

		private Matrix4x4 lastPos;

		public UpdateClock PreferredUpdate { get; private set; }

		public UpdateStatus(int currentFrame, Matrix4x4 pos)
		{
			windowStart = currentFrame;
			lastFrameUpdated = Time.frameCount;
			PreferredUpdate = UpdateClock.Late;
			lastPos = pos;
		}

		public void OnUpdate(int currentFrame, UpdateClock currentClock, Matrix4x4 pos)
		{
			if (!(lastPos == pos))
			{
				if (currentClock == UpdateClock.Late)
				{
					numWindowLateUpdateMoves++;
				}
				else if (lastFrameUpdated != currentFrame)
				{
					numWindowFixedUpdateMoves++;
				}
				lastPos = pos;
				UpdateClock preferredUpdate = ((numWindowFixedUpdateMoves <= 3 || numWindowLateUpdateMoves >= numWindowFixedUpdateMoves / 3) ? UpdateClock.Late : UpdateClock.Fixed);
				if (numWindows == 0)
				{
					PreferredUpdate = preferredUpdate;
				}
				if (windowStart + 30 <= currentFrame)
				{
					PreferredUpdate = preferredUpdate;
					numWindows++;
					windowStart = currentFrame;
					numWindowLateUpdateMoves = ((PreferredUpdate == UpdateClock.Late) ? 1 : 0);
					numWindowFixedUpdateMoves = ((PreferredUpdate == UpdateClock.Fixed) ? 1 : 0);
				}
			}
		}
	}

	private static Dictionary<Transform, UpdateStatus> mUpdateStatus = new Dictionary<Transform, UpdateStatus>();

	private static List<Transform> sToDelete = new List<Transform>();

	private static float mLastUpdateTime;

	[RuntimeInitializeOnLoadMethod]
	private static void InitializeModule()
	{
		mUpdateStatus.Clear();
	}

	private static void UpdateTargets(UpdateClock currentClock)
	{
		int frameCount = Time.frameCount;
		Dictionary<Transform, UpdateStatus>.Enumerator enumerator = mUpdateStatus.GetEnumerator();
		while (enumerator.MoveNext())
		{
			KeyValuePair<Transform, UpdateStatus> current = enumerator.Current;
			if (current.Key == null)
			{
				sToDelete.Add(current.Key);
			}
			else
			{
				current.Value.OnUpdate(frameCount, currentClock, current.Key.localToWorldMatrix);
			}
		}
		for (int num = sToDelete.Count - 1; num >= 0; num--)
		{
			mUpdateStatus.Remove(sToDelete[num]);
		}
		sToDelete.Clear();
	}

	public static UpdateClock GetPreferredUpdate(Transform target)
	{
		if (Application.isPlaying && target != null)
		{
			if (mUpdateStatus.TryGetValue(target, out var value))
			{
				return value.PreferredUpdate;
			}
			value = new UpdateStatus(Time.frameCount, target.localToWorldMatrix);
			mUpdateStatus.Add(target, value);
		}
		return UpdateClock.Late;
	}

	public static void OnUpdate(UpdateClock currentClock)
	{
		float currentTime = CinemachineCore.CurrentTime;
		if (currentTime != mLastUpdateTime)
		{
			mLastUpdateTime = currentTime;
			UpdateTargets(currentClock);
		}
	}
}
