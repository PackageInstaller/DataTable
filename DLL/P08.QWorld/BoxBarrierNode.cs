using System.Collections.Generic;
using UnityEngine;

public class BoxBarrierNode : BaseSoundNode
{
	public List<BarrierAtomSource> atomSourceList = new List<BarrierAtomSource>();

	[Header("屏蔽音效范围（进入范围内开始影响选中的音效）")]
	[SerializeField]
	private Vector3 halfAreaLength = new Vector3(5f, 4f, 3f);

	[SerializeField]
	private bool inArea;

	[SerializeField]
	private float disArea;

	private float preDis;

	private Transform areaTrs;

	private Transform roleTrs;

	protected override void NodeStart()
	{
		disArea = 0f;
		inArea = false;
		preDis = 0f;
		areaTrs = base.transform;
		roleTrs = QWorldCameraManager.Instance.MainCamera.transform;
		intervalTick = 10;
		tickCount = 0;
	}

	protected override void NodeProcess(bool forceInit = false)
	{
		preDis = disArea;
		DisFunc(roleTrs.position);
		intervalTick = (inArea ? 10 : 30);
		if (!((preDis != disArea) | forceInit))
		{
			return;
		}
		for (int i = 0; i < atomSourceList.Count; i++)
		{
			if (!string.IsNullOrEmpty(atomSourceList[i].ctrlName))
			{
				string ctrlName = atomSourceList[i].ctrlName;
				float value = atomSourceList[i].curve.Evaluate(disArea);
				atomSourceList[i].src.player.SetAisacControl(ctrlName, value);
				atomSourceList[i].src.player.UpdateAll();
			}
		}
	}

	private void DisFunc(Vector3 point)
	{
		disArea = 0f;
		inArea = false;
		Vector3 vector = areaTrs.InverseTransformPoint(point);
		float num = Mathf.Max(halfAreaLength.x - Mathf.Abs(vector.x), 0f);
		float num2 = Mathf.Max(halfAreaLength.y - Mathf.Abs(vector.y), 0f);
		float num3 = Mathf.Max(halfAreaLength.z - Mathf.Abs(vector.z), 0f);
		if (num * num2 * num3 > 0f)
		{
			disArea = Mathf.Min(num, num2, num3);
			inArea = true;
		}
	}
}
