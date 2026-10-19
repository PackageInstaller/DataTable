using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

public class CameraFocusState : DialogueState
{
	private DialogueEnvironmentCameraStateType m_CameraFocusType;

	private string m_Key;

	protected override UniTask ApplyImmediate(DialogueContext context, CancellationToken token)
	{
		LuminDialogueContext luminDialogueContext = context as LuminDialogueContext;
		if ((bool)luminDialogueContext.Env)
		{
			luminDialogueContext.Env.SetCameraState(new DialogueEnvironmentCameraState
			{
				type = m_CameraFocusType,
				key = m_Key
			});
		}
		return UniTask.CompletedTask;
	}

	public UniTask Update(DialogueContext context, DialogueEnvironmentCameraStateType cameraFocusType, string key, CancellationToken token, bool skipping)
	{
		m_CameraFocusType = cameraFocusType;
		m_Key = key;
		if (!skipping)
		{
			return ApplyImmediate(context, token);
		}
		return UniTask.CompletedTask;
	}
}
