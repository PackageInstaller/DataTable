using Bamboo.ECS;
using Cinemachine;
using UnityEngine;

namespace ACT.Battle;

public class MixingCameraBlend : MonoBehaviour
{
	public enum AxisEnum
	{
		X,
		Y,
		Z,
		Distance
	}

	public bool useNew = true;

	public AxisEnum axisToTrack;

	[Range(0f, 50f)]
	public float damping = 7f;

	public int defaultPriority = 50;

	[Space(20f)]
	public CinemachineVirtualCameraBase[] virtualCameras;

	public MixinCameraID[] mixinCameraIDs;

	private CinemachineMixingCamera mixinCamera;

	private float allWeidght;

	private float[] weightArray;

	private int needStop;

	private int aliveNum;

	[Space(20f)]
	public bool basePointIsPlayer = true;

	public Transform basePoint;

	public Transform checkTransform;

	public AnimationCurve[] distanceCurves;

	private void Start()
	{
		SetMixinCameraTriggerID();
		int num = 0;
		for (int i = 0; i < mixinCameraIDs.Length; i++)
		{
			num = Mathf.Max(num, mixinCameraIDs[i].conditionalCamera.cameraPriority);
		}
		defaultPriority = Mathf.Max(defaultPriority, num);
		weightArray = new float[virtualCameras.Length];
		needStop = 0;
	}

	private void Update()
	{
		if (useNew && mixinCameraIDs != null && mixinCameraIDs.Length != 0)
		{
			aliveNum = 0;
			for (int i = 0; i < mixinCameraIDs.Length; i++)
			{
				if (!mixinCameraIDs[i].conditionalCamera.enabled)
				{
					aliveNum++;
				}
			}
			if (aliveNum == mixinCameraIDs.Length)
			{
				mixinCamera.Priority = 0;
				return;
			}
			mixinCamera.enabled = true;
			mixinCamera.Priority = defaultPriority;
			needStop = 0;
			for (int j = 0; j < mixinCameraIDs.Length; j++)
			{
				if (!mixinCameraIDs[j].isStay)
				{
					needStop++;
				}
			}
			if (needStop == mixinCameraIDs.Length)
			{
				for (int k = 0; k < mixinCameraIDs.Length; k++)
				{
					mixinCameraIDs[k].needStop = true;
					mixinCameraIDs[k].conditionalCamera.vCamera.enabled = false;
					mixinCameraIDs[k].conditionalCamera.enabled = false;
				}
				return;
			}
			allWeidght = 0f;
			for (int l = 0; l < virtualCameras.Length; l++)
			{
				if (axisToTrack == AxisEnum.X)
				{
					float num = (weightArray[l] = mixinCameraIDs[l].xDis);
					allWeidght += ((num != float.MaxValue) ? num : 0f);
				}
				else if (axisToTrack == AxisEnum.Y)
				{
					float num = (weightArray[l] = mixinCameraIDs[l].yDis);
					allWeidght += ((num != float.MaxValue) ? num : 0f);
				}
			}
			for (int m = 0; m < mixinCamera.ChildCameras.Length; m++)
			{
				if (weightArray[m] == float.MaxValue)
				{
					mixinCamera.SetWeight(m, Mathf.Lerp(mixinCamera.GetWeight(m), 0f, damping * Time.deltaTime));
					continue;
				}
				if (allWeidght - weightArray[m] < 0.01f)
				{
					mixinCamera.SetWeight(m, Mathf.Lerp(mixinCamera.GetWeight(m), 1f, damping * Time.deltaTime));
					for (int n = 0; n < mixinCamera.ChildCameras.Length; n++)
					{
						if (n != m)
						{
							mixinCamera.SetWeight(n, Mathf.Lerp(mixinCamera.GetWeight(n), 0f, damping * Time.deltaTime));
						}
					}
					break;
				}
				mixinCamera.SetWeight(m, Mathf.Lerp(mixinCamera.GetWeight(m), weightArray[m] / allWeidght, damping * Time.deltaTime));
			}
			return;
		}
		if (basePointIsPlayer && MonoECS.instance.mainEntity.IsValid)
		{
			basePoint = MonoECS.instance.mainEntity.GetMono().transform;
		}
		if (!basePoint)
		{
			return;
		}
		for (int num2 = 0; num2 < mixinCamera.ChildCameras.Length; num2++)
		{
			Vector3 position = mixinCamera.ChildCameras[num2].transform.position;
			if (checkTransform != null)
			{
				position = checkTransform.position;
			}
			switch (axisToTrack)
			{
			case AxisEnum.X:
				mixinCamera.SetWeight(num2, distanceCurves[num2].Evaluate(Mathf.Abs(basePoint.transform.position.x - position.x)));
				break;
			case AxisEnum.Z:
				mixinCamera.SetWeight(num2, distanceCurves[num2].Evaluate(Mathf.Abs(basePoint.transform.position.z - position.z)));
				break;
			case AxisEnum.Y:
				mixinCamera.SetWeight(num2, distanceCurves[num2].Evaluate(Mathf.Abs(basePoint.transform.position.y - position.y)));
				break;
			case AxisEnum.Distance:
				mixinCamera.SetWeight(num2, distanceCurves[num2].Evaluate((basePoint.transform.position - position).sqrMagnitude));
				break;
			}
		}
	}

	public void SetMixinCameraTriggerID()
	{
		mixinCamera = GetComponentInChildren<CinemachineMixingCamera>(includeInactive: true);
		virtualCameras = mixinCamera.ChildCameras;
		mixinCameraIDs = GetComponentsInChildren<MixinCameraID>(includeInactive: true);
		if (mixinCameraIDs != null && virtualCameras != null && mixinCameraIDs.Length != virtualCameras.Length)
		{
			Debug.LogWarning(name + "相机和范围单独数量对不上");
			return;
		}
		for (int i = 0; i < mixinCameraIDs.Length; i++)
		{
			mixinCameraIDs[i].triggerID = i + 1;
		}
	}
}
