using System;
using UnityEngine;

public class NewChessCameraTarget
{
	public struct cameraTarget
	{
		public int uuid;

		public Vector3 target;

		public Action callback;
	}

	private static int uuidGenerator;

	public static cameraTarget SetNewTarget(Vector3 tar, Action callback)
	{
		uuidGenerator = (uuidGenerator + 1) % 100;
		cameraTarget result = default(cameraTarget);
		result.uuid = uuidGenerator;
		result.target = tar;
		result.callback = callback;
		return result;
	}
}
