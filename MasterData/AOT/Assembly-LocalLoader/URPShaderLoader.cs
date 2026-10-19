using System;
using System.Collections.Generic;
using UnityEngine;

public class URPShaderLoader : IAssetLoader
{
	private List<(string, Action<Shader>)> tasks = new List<(string, Action<Shader>)>();

	public URPShaderLoader()
	{
		URPAssetLoader.AssetLoader = this;
	}

	public void PrepaeredAssetComplete()
	{
		foreach (var task in tasks)
		{
			LoadShader(task.Item1, task.Item2);
		}
	}

	public void LoadShader(string name, Action<Shader> onComplete)
	{
	}
}
