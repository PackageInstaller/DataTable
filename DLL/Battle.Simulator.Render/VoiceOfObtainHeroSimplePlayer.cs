public class VoiceOfObtainHeroSimplePlayer : SimplePlayerBase
{
	private string _sheetName;

	private string _cueName;

	private string _awbName;

	private CriAtomExPlayback _criAtomExPlayback;

	private bool _running;

	public void SetVoiceInfo(string pSheetName, string pCueName, string pAwbName)
	{
		_sheetName = pSheetName;
		_cueName = pCueName;
		_awbName = pAwbName;
	}

	public override void OnGraphStart()
	{
	}

	public override void OnGraphStop()
	{
	}

	public override void OnBehaviourPlay()
	{
		if (!_running)
		{
			_running = true;
			if (!string.IsNullOrEmpty(_sheetName) && !string.IsNullOrEmpty(_cueName))
			{
				_criAtomExPlayback = AudioManager.Instance.Play("voice", _sheetName, _cueName, !string.IsNullOrEmpty(_awbName));
			}
		}
	}

	public override void OnBehaviourPause()
	{
	}

	public override void OnPlayableDestroy()
	{
	}

	private void OnDisable()
	{
		if (_running)
		{
			_running = false;
			if (_criAtomExPlayback.status != CriAtomExPlayback.Status.Removed)
			{
				_criAtomExPlayback.Stop();
				_criAtomExPlayback = new CriAtomExPlayback(uint.MaxValue);
			}
		}
	}
}
