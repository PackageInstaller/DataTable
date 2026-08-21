using System;

namespace Ase;

public class LoadingProgressData
{
	private int loadingTotal;

	private int loadingProgress;

	public int LoadingTotal => loadingTotal;

	public int LoadingProgress => loadingProgress;

	public LoadingProgressData(int total)
	{
		loadingTotal = total;
	}

	public void UpdateProgress()
	{
		loadingProgress++;
	}

	public void AddProgress(int progress)
	{
		loadingProgress = Math.Clamp(loadingProgress + progress, 0, loadingTotal);
	}

	public void UpdateProgress(int progress)
	{
		loadingProgress = Math.Clamp(progress, 0, loadingTotal);
	}
}
