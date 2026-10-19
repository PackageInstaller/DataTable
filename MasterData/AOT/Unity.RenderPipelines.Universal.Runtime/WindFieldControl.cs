using System.Collections.Generic;
using UnityEngine;

[ExecuteAlways]
public class WindFieldControl : MonoBehaviour
{
	public List<WindField.Wind> windList;

	[Range(0f, 10f)]
	public float windGlobalSize = 1f;

	[Range(0f, 25f)]
	public float windGlobalIntensity = 1f;

	[Range(0f, 5f)]
	public float windGlobalTimeScale = 1f;

	private void OnEnable()
	{
		UpdateScriptData();
	}

	private void OnDisable()
	{
		RemoveWindField();
	}

	private void OnValidate()
	{
		UpdateScriptData();
	}

	private void UpdateScriptData()
	{
		WindField.GlobalWindList = windList;
		WindField.windGlobalSize = windGlobalSize;
		WindField.windGlobalIntensity = windGlobalIntensity;
		WindField.windGlobalTimeScale = windGlobalTimeScale;
	}

	private void RemoveWindField()
	{
		WindField.GlobalWindList = null;
	}

	public void ReduceWindIntesntiy()
	{
		foreach (WindField.Wind wind in windList)
		{
			wind.WaveHeight *= 0.1f;
		}
	}

	public void EnhanceWindIntesntiy()
	{
		foreach (WindField.Wind wind in windList)
		{
			wind.WaveHeight *= 10f;
		}
	}

	public void SlowWindSpeed()
	{
		foreach (WindField.Wind wind in windList)
		{
			wind.timeScale *= 0.1f;
		}
	}

	public void FastWindSpeed()
	{
		foreach (WindField.Wind wind in windList)
		{
			wind.timeScale *= 10f;
		}
	}

	public void ScaleUpWind()
	{
		foreach (WindField.Wind wind in windList)
		{
			wind.WaveLength *= 10f;
		}
	}

	public void ScaleDownWind()
	{
		foreach (WindField.Wind wind in windList)
		{
			wind.WaveLength *= 0.1f;
		}
	}
}
