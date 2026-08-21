using System.Collections;
using CriMana;
using UnityEngine;

namespace P08.CriLipsEx;

internal class CriLipsExMovieShader : MonoBehaviour
{
	public string shaderName = "CriMana/SofdecPrimeYuvScene";

	public string shaderName_android = "CriMana/AndroidSofdecPrimeYuvScene";

	public string shaderName_ios = "CriMana/SofdecPrimeYuvScene";

	public CriManaMovieMaterial movieMaterial;

	private void Awake()
	{
		StartCoroutine(WaitFrame());
	}

	private IEnumerator WaitFrame()
	{
		yield return new WaitForEndOfFrame();
		if (null != movieMaterial && movieMaterial.player != null)
		{
			movieMaterial.player.SetShaderDispatchCallback(ShaderDispatchCallback);
		}
	}

	private Shader ShaderDispatchCallback(MovieInfo movieInfo, bool additiveMode)
	{
		return Shader.Find(shaderName);
	}
}
