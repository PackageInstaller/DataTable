using System.Threading;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.DialogueSystem;

public class CameraMotionState : DialogueState
{
	private float m_FovScale = 1f;

	private Vector2 m_CameraOffset;

	protected override UniTask ApplyImmediate(DialogueContext context, CancellationToken token)
	{
		UIConversationScene instance = UIConversationScene.Instance;
		if ((bool)instance)
		{
			instance.CameraMotion(m_FovScale, m_CameraOffset);
		}
		return UniTask.CompletedTask;
	}

	public UniTask Update(float fovScale, Vector2 cameraOffset, float duration, UIConversationScene.BgMotionEase ease, bool skipping)
	{
		m_FovScale = fovScale;
		m_CameraOffset = cameraOffset;
		if (skipping)
		{
			return UniTask.CompletedTask;
		}
		UIConversationScene instance = UIConversationScene.Instance;
		if (!instance)
		{
			return UniTask.CompletedTask;
		}
		return instance.CameraMotion(m_FovScale, m_CameraOffset, duration, ease);
	}
}
