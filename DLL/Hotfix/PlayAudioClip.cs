using Ase.ECS;
using UnityEngine;

[ClipName("播放音效")]
public class PlayAudioClip : TaskClip
{
	public AudioClip AudioClip;

	public Vector3 Position;

	public float Volume;

	private GameObject _temp;

	public override void RunTimeTick(int currentFrameID, int fps, float deltaTime, BaseEntity context)
	{
		if (context != null && (Object)(object)AudioClip != null)
		{
			AudioSource.PlayClipAtPoint(AudioClip, Position);
		}
	}

	public override void EditorTick(int currentFrameID, int fps, float deltaTime, GameObject context)
	{
		//IL_0068: Unknown result type (might be due to invalid IL or missing references)
		//IL_006d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0079: Unknown result type (might be due to invalid IL or missing references)
		//IL_0084: Unknown result type (might be due to invalid IL or missing references)
		if (!(context == null) && currentFrameID == 0 && (Object)(object)AudioClip != null)
		{
			Vector3 position = context.transform.TransformPoint(Position);
			_temp = new GameObject("One shot audio");
			_temp.transform.position = position;
			AudioSource val = (AudioSource)_temp.AddComponent(typeof(AudioSource));
			val.clip = AudioClip;
			val.spatialBlend = 1f;
			val.volume = Volume;
			val.Play();
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
