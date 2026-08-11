using Ase;
using Ase.ECS;
using UnityEngine;

[ClipName("播放特效")]
public class PlayEffectClip : TaskClip
{
	[EditorVariable("特效预制体")]
	public GameObject prefab;

	[EditorVariable("位置")]
	public Vector3 position;

	[EditorVariable("旋转")]
	public Vector3 angle;

	[VariableName("特效Id")]
	public int effectId;

	[VariableName("特效挂点")]
	public string effectKey = "center";

	[VariableName("播放类型")]
	public EffectType effectType;

	[VariableName("特效坐标")]
	public Vector3 effectPoint;

	[VariableName("缩放倍率")]
	public float effectScale = 1f;

	[VariableName("位置偏移量")]
	public Vector3 effectOffset;

	[VariableName("旋转偏移量")]
	public float rotationOffsetY;

	[VariableName("是否跟随父节点销毁")]
	public bool followParentDispose;

	[VariableName("是否跟随绑点位置")]
	public bool isFollowBone;

	private GameObject _temp;

	public override void OnRunTimeEnter(BaseEntity context, int fps, int currentFrameID)
	{
		base.OnRunTimeEnter(context, fps, currentFrameID);
		context?.GetSystem<EffectSystem>().PlayEffect(context, context, effectType, effectId, effectKey, effectPoint, effectOffset, Quaternion.identity.eulerAngles, new Vector3(0f, rotationOffsetY, 0f), followParentDispose, effectScale, isFollowBone);
	}

	public override void EditorEnter(GameObject context, int fps, int currentFrameID)
	{
		base.EditorEnter(context, fps, currentFrameID);
		if (!(prefab == null) && !(context == null))
		{
			Quaternion rotation = Quaternion.Euler(angle);
			_temp = Object.Instantiate(prefab, position, rotation);
		}
	}

	public override void RunTimeTick(int currentFrameID, int fps, float deltaTime, BaseEntity context)
	{
		if (context != null)
		{
			_ = _temp == null;
		}
	}

	public override void EditorTick(int currentFrameID, int fps, float deltaTime, GameObject context)
	{
		//IL_002d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		if (!(context == null) && !(_temp == null))
		{
			ParticleSystem[] componentsInChildren = _temp.GetComponentsInChildren<ParticleSystem>();
			for (int i = 0; i < componentsInChildren.Length; i++)
			{
				MainModule main = componentsInChildren[i].main;
				((MainModule)(ref main)).loop = false;
				componentsInChildren[i].Simulate((float)currentFrameID / (float)fps, false, true);
			}
		}
	}

	public override void OnRunTimeExit(BaseEntity context, int fps, int currentFrameID)
	{
		base.OnRunTimeExit(context, fps, currentFrameID);
		if (_temp != null)
		{
			Object.DestroyImmediate(_temp);
		}
	}

	public override void EditorExit(GameObject context, int fps, int currentFrameID)
	{
		base.EditorExit(context, fps, currentFrameID);
		if (_temp != null)
		{
			Object.DestroyImmediate(_temp);
		}
	}
}
