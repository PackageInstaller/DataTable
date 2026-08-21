using System;
using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class LoadingProgressBar : ViewModelBase
{
	private float progress;

	private string tip;

	private string title;

	private bool enable;

	private Action<float> _progressChanged;

	private Dictionary<string, LoadingProgressData> loadingDatas;

	public bool Enable
	{
		get
		{
			return enable;
		}
		set
		{
			Set<bool>(ref enable, value, "Enable");
		}
	}

	public float Progress
	{
		get
		{
			return progress;
		}
		set
		{
			if (Math.Abs(value - progress) > 1E-05f)
			{
				_progressChanged?.Invoke(value);
			}
			Set<float>(ref progress, value, "Progress");
		}
	}

	public string Tip
	{
		get
		{
			return tip;
		}
		set
		{
			Set(ref tip, value, "Tip");
		}
	}

	public string Title
	{
		get
		{
			return title;
		}
		set
		{
			Set(ref title, value, "Title");
		}
	}

	public LoadingProgressBar()
	{
		loadingDatas = new Dictionary<string, LoadingProgressData>();
	}

	public void AddLoadingData(string key, int loadingTotal)
	{
		loadingDatas.Add(key, new LoadingProgressData(loadingTotal));
	}

	public void UpdateLoadingData(string key)
	{
		if (!(Progress > 1f) && loadingDatas.TryGetValue(key, out var value))
		{
			value.UpdateProgress();
			UpdateProgress();
		}
	}

	public void UpdateLoadingData(string key, int loadingProgress)
	{
		if (!(Progress > 1f) && loadingDatas.ContainsKey(key))
		{
			loadingDatas[key].UpdateProgress(loadingProgress);
			UpdateProgress();
		}
	}

	public void AddProgress(string key, int loadingProgress)
	{
		if (!(Progress > 1f) && loadingDatas.ContainsKey(key))
		{
			loadingDatas[key].AddProgress(loadingProgress);
			UpdateProgress();
		}
	}

	public void ForceFinish()
	{
		Progress = 1f;
		loadingDatas.Clear();
	}

	public void AddProgressChanged(Action<float> action)
	{
		_progressChanged = (Action<float>)Delegate.Combine(_progressChanged, action);
	}

	private void UpdateProgress()
	{
		int num = 0;
		int num2 = 0;
		foreach (KeyValuePair<string, LoadingProgressData> loadingData in loadingDatas)
		{
			num += loadingData.Value.LoadingTotal;
			num2 += loadingData.Value.LoadingProgress;
		}
		Progress = (float)num2 * 1f / (float)num;
	}
}
