using Ase.ECS;
using UnityEngine;

[ClipName("直线运动")]
public class LineMoveClip : TaskClip
{
	[VariableName("位移方向")]
	public Vector3 dir;

	[VariableName("延迟时间")]
	public float delayTime;

	[VariableName("位移距离")]
	public float distance;

	private Vector3 _editorInitPosition;

	private float _speed;

	public override void EditorEnter(GameObject context, int fps, int currentFrameID)
	{
		base.EditorEnter(context, fps, currentFrameID);
		_editorInitPosition = context.transform.position;
		_speed = distance / ((float)taskDuration * (1f / (float)fps));
	}

	public override void RunTimeTick(int currentFrameID, int fps, float deltaTime, BaseEntity context)
	{
	}

	public override void EditorTick(int currentFrameID, int fps, float deltaTime, GameObject context)
	{
		context.transform.position = _editorInitPosition + _speed * deltaTime * (float)currentFrameID * dir;
	}

	public override void EditorExit(GameObject context, int fps, int currentFrameID)
	{
		base.EditorExit(context, fps, currentFrameID);
	}
}
