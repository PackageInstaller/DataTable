using Config;

public class UIBGM : AudioBase
{
	public bool use_setting_bgm;

	private bool _mute;

	private static UIBGM lastPlayUIBgm;

	private UIBGM preBgm;

	public bool mute
	{
		get
		{
			return _mute;
		}
		set
		{
			_mute = value;
		}
	}

	public void Awake()
	{
		mute = false;
	}

	private void OnEnable()
	{
		if (!mute)
		{
			Play();
		}
	}

	public void RestartBGM()
	{
		Play();
	}

	public void Play()
	{
		LuaHelper.CallFunction("InitGameSetBGM", use_setting_bgm);
		if (use_setting_bgm)
		{
			object[] array = LuaHelper.CallFunction("PlayGameSetBGM");
			if (array != null && array[0] != null)
			{
				return;
			}
		}
		if (mUIAudioID != -1 && ConfigHelper.GetInstance().TryGetConfig<UIAudio>(mUIAudioID, out var config) && ConfigHelper.GetInstance().TryGetConfig<CommonAudio>(config.AudioID, out var config2))
		{
			AudioManager.Instance.Play(config.SourceKey, config2.CueSheet, config2.CueName, config2.UseStream);
		}
		else if (!string.IsNullOrEmpty(mCueSheet) && !string.IsNullOrEmpty(mCueName))
		{
			AudioManager.Instance.Play("music", mCueSheet, mCueName, !string.IsNullOrEmpty(mCueAwb));
		}
	}
}
