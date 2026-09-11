using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class ZumaTrackData
{
	public List<Vector3> ballPosList = new List<Vector3>();

	public List<Vector3> linePosList = new List<Vector3>();

	public List<Vector3> pathControllList = new List<Vector3>();

	public List<ZumaHideData> hideList = new List<ZumaHideData>();

	public int ballCount;

	public Vector3 beginPos;

	public Vector3 endPos;

	public float beginMoveSeepd;

	public int beginMoveToPoint;

	private Vector3 hidePos = new Vector3(999f, 999f, 0f);

	private float _endPoint = -1f;

	public float EndPoint
	{
		get
		{
			if (_endPoint < 0f)
			{
				_endPoint = ballPosList.Count - 1;
			}
			return _endPoint;
		}
	}

	public Vector3 GetPosition(float progress)
	{
		if (progress <= 0f)
		{
			return hidePos;
		}
		if (progress >= EndPoint)
		{
			return ballPosList[ballPosList.Count - 1];
		}
		int num = Mathf.FloorToInt(progress);
		return Vector3.Lerp(ballPosList[num], ballPosList[num + 1], progress - (float)num);
	}
}
