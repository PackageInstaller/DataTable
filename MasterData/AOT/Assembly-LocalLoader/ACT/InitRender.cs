using System;
using System.Collections.Generic;
using UnityEngine;
using YooAsset;

namespace ACT;

internal class InitRender : GameLoadingFlowBase, IAssetLoader
{
	private List<(string, Action<Shader>)> tasks = new List<(string, Action<Shader>)>();

	private bool isLoaded;

	internal override EGameLoadingStage Stage => EGameLoadingStage.Render;

	internal InitRender()
	{
		URPAssetLoader.AssetLoader = this;
	}

	internal override void Init(GameLoadingData data)
	{
		foreach (var task in tasks)
		{
			LoadShader(task.Item1, task.Item2);
		}
		base.Init(data);
	}

	public void LoadShader(string name, Action<Shader> onComplete)
	{
		if (isLoaded)
		{
			YooAssets.LoadAssetAsync<Shader>(name).Completed += (AssetHandle r) =>
			{
				onComplete?.Invoke((Shader)r.AssetObject);
			};
		}
		else
		{
			tasks.Add((name, onComplete));
		}
	}
}
