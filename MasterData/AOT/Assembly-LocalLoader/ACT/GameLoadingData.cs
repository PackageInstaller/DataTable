using System;

namespace ACT;

public class GameLoadingData
{
	private static EGameLoadingStage _curStage;

	internal static Action<EGameLoadingStage, EGameLoadingStage> StageChange;

	internal bool AcceptAgreement;

	internal bool BamBooLogin;

	internal bool ApmInitSuccess;

	public static EGameLoadingStage CurStage
	{
		get
		{
			return _curStage;
		}
		set
		{
			if (_curStage != value)
			{
				StageChange?.Invoke(_curStage, value);
				_curStage = value;
			}
		}
	}
}
