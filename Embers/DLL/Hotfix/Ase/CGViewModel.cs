using GameFramework.Runtime;

namespace Ase;

public class CGViewModel : ViewOptionBase
{
	private readonly InteractionRequest closeRequest;

	private readonly InteractionRequest playVideoRequest;

	private float skipProgress;

	private float skipTime;

	private bool isEnd;

	private int result;

	public float SkipProgress
	{
		get
		{
			return skipProgress;
		}
		private set
		{
			Set(ref skipProgress, value, "SkipProgress");
		}
	}

	public float SkipTime
	{
		get
		{
			return skipTime;
		}
		private set
		{
			Set(ref skipTime, value, "SkipTime");
		}
	}

	public IInteractionRequest PlayVideoRequest => playVideoRequest;

	public IInteractionRequest CloseRequest => closeRequest;

	public bool IsEnd
	{
		get
		{
			return isEnd;
		}
		set
		{
			Set(ref isEnd, value, "IsEnd");
		}
	}

	public int Result
	{
		get
		{
			return result;
		}
		set
		{
			Set(ref result, value, "Result");
		}
	}

	public CGViewModel()
	{
		closeRequest = new InteractionRequest();
		playVideoRequest = new InteractionRequest();
		isEnd = false;
	}

	public void UpdateSkipTime(float totalTime)
	{
		SkipTime = totalTime;
		SkipProgress = 0f;
	}

	public void Exit()
	{
		isEnd = true;
	}

	public async void PlayCG()
	{
		await Singleton<AudioSystem>.Instance.LoadingClear();
		playVideoRequest.Raise();
	}

	public void Close()
	{
		closeRequest.Raise();
	}

	public void UpdateSkipProgress(float progress)
	{
		SkipProgress += progress;
		if (SkipProgress >= SkipTime && !isEnd)
		{
			isEnd = true;
			Exit();
		}
	}
}
