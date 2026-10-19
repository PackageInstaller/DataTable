using System;
using UnityEngine;

public interface IAssetLoader
{
	void LoadShader(string name, Action<Shader> onComplete);
}
