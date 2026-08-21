using System;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
[RequireComponent(typeof(LineRenderer))]
public class UVChainLightning : MonoBehaviour
{
	public List<Transform> PointTransformList = new List<Transform>(10);

	[NonSerialized]
	public List<Vector3> PointPosList = new List<Vector3>(10);

	public float yOffset;

	private LineRenderer _lineRender;

	private List<Vector3> _linePosList = new List<Vector3>();

	private List<Vector3> _lineNoiseList = new List<Vector3>();

	public bool UseNoise;

	public int lerpPointNumber = 50;

	public float shakeSpeed = 100f;

	public float period = 10f;

	public float noiseFactor = 10f;

	public bool Pause { get; set; }

	private void Awake()
	{
		if (_lineRender == null)
		{
			_lineRender = GetComponent<LineRenderer>();
		}
	}

	public void Update()
	{
		if (Pause)
		{
			return;
		}
		PointPosList.Clear();
		for (int i = 0; i < PointTransformList.Count; i++)
		{
			if (PointTransformList[i] != null)
			{
				PointPosList.Add(PointTransformList[i].position + Vector3.up * yOffset);
			}
		}
		if (UseNoise)
		{
			_linePosList.Clear();
			for (int j = 0; j < PointPosList.Count - 1; j++)
			{
				_lineNoiseList.Clear();
				CalcPerlinNoise(lerpPointNumber, shakeSpeed, period, noiseFactor, PointPosList[j], PointPosList[j + 1], _lineNoiseList);
				if (j == 0)
				{
					_linePosList.AddRange(_lineNoiseList);
					continue;
				}
				for (int k = 1; k < _lineNoiseList.Count; k++)
				{
					_linePosList.Add(_lineNoiseList[k]);
				}
			}
			_lineRender.positionCount = _linePosList.Count;
			_lineRender.SetPositions(_linePosList.ToArray());
		}
		else
		{
			_lineRender.positionCount = PointPosList.Count;
			for (int l = 0; l < PointPosList.Count; l++)
			{
				_lineRender.SetPosition(l, PointPosList[l]);
			}
		}
	}

	public void Reset()
	{
		if (_lineRender != null)
		{
			_lineRender.positionCount = 0;
		}
		ClearPoint();
		Pause = false;
	}

	public void CalcPerlinNoise(int lerpPointNumber, float shakeSpeed, float period, float noiseFactor, Vector3 startPos, Vector3 endPos, List<Vector3> ret)
	{
		for (int i = 0; i < lerpPointNumber; i++)
		{
			Vector3 item = Vector3.Lerp(startPos, endPos, (float)i / ((float)lerpPointNumber - 1f));
			float num = Mathf.Sin(Time.time * shakeSpeed + (float)i / ((float)lerpPointNumber - 1f) * period);
			num += Mathf.PerlinNoise(item.x, item.y + Mathf.Sin(Time.time * noiseFactor));
			num *= (float)i * (float)(lerpPointNumber - i) / (float)(lerpPointNumber * lerpPointNumber);
			item.y += num;
			ret.Add(item);
		}
	}

	public void ClearPoint()
	{
		PointPosList.Clear();
		PointTransformList.Clear();
	}
}
