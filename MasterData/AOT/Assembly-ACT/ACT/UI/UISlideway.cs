using System.Collections.Generic;
using UnityEngine;

namespace ACT.UI;

public class UISlideway : MonoBehaviour
{
	private sealed class SampleInfo
	{
		public Vector3 Position;

		public Quaternion Rotation;
	}

	[SerializeField]
	private Transform[] _samples;

	[SerializeField]
	private float _itemHeight;

	[SerializeField]
	private Vector2 _sizeDelta;

	private List<SampleInfo> _sampleInfos;

	private Transform _root;

	private float _rootInitY;

	private float _lastRootMoveY;

	private void Awake()
	{
		_sampleInfos = new List<SampleInfo>(_samples.Length);
		Transform[] samples = _samples;
		foreach (Transform transform in samples)
		{
			_sampleInfos.Add(new SampleInfo
			{
				Position = transform.localPosition,
				Rotation = transform.localRotation
			});
		}
		_root = base.transform;
		_rootInitY = _root.localPosition.y;
		(_root as RectTransform).sizeDelta = _sizeDelta;
	}

	private void OnEnable()
	{
		_lastRootMoveY = float.MinValue;
	}

	private float CalculateRootMoveY()
	{
		return _root.localPosition.y - _rootInitY;
	}

	private void Update()
	{
		float num = CalculateRootMoveY();
		if (Mathf.Approximately(num, _lastRootMoveY))
		{
			return;
		}
		_lastRootMoveY = num;
		for (int i = 0; i < _samples.Length; i++)
		{
			if (_samples[i].gameObject.activeInHierarchy)
			{
				Recalculate(i, _samples[i], num);
			}
		}
	}

	private void Recalculate(int index, Transform trans, float rootMoveY)
	{
		float num = (0f - rootMoveY) / _itemHeight;
		float num2 = (float)index + num;
		if (!(num2 < 0f) && !(num2 >= (float)(_samples.Length - 1)))
		{
			int num3 = (int)num2;
			float t = num2 - (float)num3;
			Vector3 localPosition = Vector3.Lerp(_sampleInfos[num3].Position, _sampleInfos[num3 + 1].Position, t);
			Quaternion localRotation = Quaternion.Slerp(_sampleInfos[num3].Rotation, _sampleInfos[num3 + 1].Rotation, t);
			localPosition.y -= rootMoveY;
			trans.localPosition = localPosition;
			trans.localRotation = localRotation;
		}
	}
}
