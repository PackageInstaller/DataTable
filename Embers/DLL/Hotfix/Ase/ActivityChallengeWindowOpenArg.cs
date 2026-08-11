using System;

namespace Ase;

public class ActivityChallengeWindowOpenArg
{
	public ActivityChallengeViewModel ViewModel { get; }

	public string WindowPath { get; }

	public Action Callback { get; }

	public ActivityChallengeWindowOpenArg(ActivityChallengeViewModel viewModel, string windowPath, Action callback)
	{
		ViewModel = viewModel;
		WindowPath = windowPath;
		Callback = callback;
	}
}
