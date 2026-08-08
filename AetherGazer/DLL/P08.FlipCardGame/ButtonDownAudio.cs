using Config;
using UnityEngine.EventSystems;

public class ButtonDownAudio : AudioBase, IPointerDownHandler, IEventSystemHandler
{
	public void OnPointerDown(PointerEventData eventData)
	{
		if (mUIAudioID != -1 && ConfigHelper.GetInstance().TryGetConfig<UIAudio>(mUIAudioID, out var config) && ConfigHelper.GetInstance().TryGetConfig<CommonAudio>(config.AudioID, out var config2))
		{
			AudioManager.Instance.Play(config.SourceKey, config2.CueSheet, config2.CueName, config2.UseStream);
		}
		else if (!string.IsNullOrEmpty(mCueSheet) && !string.IsNullOrEmpty(mCueName))
		{
			AudioManager.Instance.Play("effect", mCueSheet, mCueName, !string.IsNullOrEmpty(mCueAwb));
		}
	}
}
