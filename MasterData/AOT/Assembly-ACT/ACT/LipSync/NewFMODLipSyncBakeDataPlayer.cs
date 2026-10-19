using System;
using System.Collections.Generic;
using UnityEngine;
using uLipSync;

namespace ACT.LipSync;

[RequireComponent(typeof(uLipSyncAnimator))]
[RequireComponent(typeof(Animator))]
public class NewFMODLipSyncBakeDataPlayer : MonoBehaviour
{
	public ULipSyncBakeData bakedData;

	public bool playOnAwake;

	public bool loop;

	[Range(0f, 1f)]
	public float volume = 1f;

	[Range(-0.3f, 0.3f)]
	public float timeOffset = 0.1f;

	private bool _isPlaying;

	private bool _isPaused;

	private double _startTime;

	private double _pauseTime;

	private double _totalPlayTime;

	private uLipSyncAnimator _lipSyncAnimator;

	public Action onPlayComplete;

	public bool isPlaying
	{
		get
		{
			if (_isPlaying)
			{
				return !_isPaused;
			}
			return false;
		}
	}

	public bool isPaused => _isPaused;

	public double currentTime => _totalPlayTime;

	public double normalizedTime => bakedData ? Mathf.Clamp01((float)(_totalPlayTime / (double)bakedData.duration)) : 0f;

	private void Awake()
	{
		_lipSyncAnimator = GetComponent<uLipSyncAnimator>();
	}

	private void OnEnable()
	{
		if (playOnAwake && (bool)bakedData)
		{
			Play();
		}
	}

	private void OnDisable()
	{
		if (_isPlaying)
		{
			Stop();
		}
	}

	private void Update()
	{
		if (!_isPlaying || _isPaused || !bakedData)
		{
			return;
		}
		_totalPlayTime += Time.deltaTime;
		if (_totalPlayTime >= (double)bakedData.duration)
		{
			if (!loop)
			{
				CompletePlayback();
				return;
			}
			_totalPlayTime = 0.0;
			_startTime = Time.time;
		}
		UpdateLipSyncAnimation();
	}

	private void UpdateLipSyncAnimation()
	{
		if ((bool)bakedData)
		{
			BakedFrame frame = bakedData.GetFrame((float)_totalPlayTime + timeOffset);
			frame.volume *= volume;
			LipSyncInfo lipSyncInfo = BakedData.GetLipSyncInfo(frame);
			_lipSyncAnimator?.OnLipSyncUpdate(lipSyncInfo);
		}
	}

	private void CompletePlayback()
	{
		_isPlaying = false;
		_totalPlayTime = bakedData.duration;
		UpdateLipSyncAnimation();
		onPlayComplete?.Invoke();
	}

	private void Reset()
	{
		string text = "";
		int nameHash = 0;
		int index = 0;
		string text2 = "";
		int nameHash2 = 0;
		int index2 = 0;
		string text3 = "";
		int nameHash3 = 0;
		int index3 = 0;
		string text4 = "";
		int nameHash4 = 0;
		int index4 = 0;
		string text5 = "";
		int nameHash5 = 0;
		int index5 = 0;
		string text6 = "";
		int nameHash6 = 0;
		int index6 = 0;
		Animator component = gameObject.GetComponent<Animator>();
		for (int i = 0; i < component.parameters.Length; i++)
		{
			AnimatorControllerParameter animatorControllerParameter = component.parameters[i];
			switch (animatorControllerParameter.name)
			{
			case "A":
				text = animatorControllerParameter.name;
				nameHash = animatorControllerParameter.nameHash;
				index = i;
				break;
			case "E":
				text2 = animatorControllerParameter.name;
				nameHash2 = animatorControllerParameter.nameHash;
				index2 = i;
				break;
			case "I":
				text3 = animatorControllerParameter.name;
				nameHash3 = animatorControllerParameter.nameHash;
				index3 = i;
				break;
			case "O":
				text4 = animatorControllerParameter.name;
				nameHash4 = animatorControllerParameter.nameHash;
				index4 = i;
				break;
			case "U":
				text5 = animatorControllerParameter.name;
				nameHash5 = animatorControllerParameter.nameHash;
				index5 = i;
				break;
			case "V":
				text6 = animatorControllerParameter.name;
				nameHash6 = animatorControllerParameter.nameHash;
				index6 = i;
				break;
			}
		}
		uLipSyncAnimator component2 = gameObject.GetComponent<uLipSyncAnimator>();
		component2.updateMethod = UpdateMethod.LateUpdate;
		component2.parameters = new List<uLipSyncAnimator.AnimatorInfo>
		{
			new uLipSyncAnimator.AnimatorInfo
			{
				phoneme = "A",
				name = text,
				nameHash = nameHash,
				index = index,
				weight = 1f
			},
			new uLipSyncAnimator.AnimatorInfo
			{
				phoneme = "E",
				name = text2,
				nameHash = nameHash2,
				index = index2,
				weight = 1f
			},
			new uLipSyncAnimator.AnimatorInfo
			{
				phoneme = "I",
				name = text3,
				nameHash = nameHash3,
				index = index3,
				weight = 1f
			},
			new uLipSyncAnimator.AnimatorInfo
			{
				phoneme = "O",
				name = text4,
				nameHash = nameHash4,
				index = index4,
				weight = 1f
			},
			new uLipSyncAnimator.AnimatorInfo
			{
				phoneme = "U",
				name = text5,
				nameHash = nameHash5,
				index = index5,
				weight = 1f
			},
			new uLipSyncAnimator.AnimatorInfo
			{
				phoneme = "V",
				name = text6,
				nameHash = nameHash6,
				index = index6,
				weight = 1f
			}
		};
		component2.animator = component;
	}

	public void Play()
	{
		if (!bakedData)
		{
			_ = LuminApplication.LogEnabled;
			return;
		}
		_isPlaying = true;
		_isPaused = false;
		_startTime = Time.time;
		_totalPlayTime = 0.0;
	}

	public void PlayFromTime(float startTime)
	{
		if ((bool)bakedData)
		{
			_isPlaying = true;
			_isPaused = false;
			_startTime = Time.time - startTime;
			_totalPlayTime = Mathf.Clamp(startTime, 0f, bakedData.duration);
		}
	}

	public void Play(ULipSyncBakeData data)
	{
		bakedData = data;
		Play();
	}

	public void Pause()
	{
		if (_isPlaying && !_isPaused)
		{
			_isPaused = true;
			_pauseTime = Time.time;
		}
	}

	public void Resume()
	{
		if (_isPlaying && _isPaused)
		{
			_isPaused = false;
			_startTime += (double)Time.time - _pauseTime;
			_ = LuminApplication.LogEnabled;
		}
	}

	public void Stop()
	{
		if (_isPlaying)
		{
			_isPlaying = false;
			_isPaused = false;
			_totalPlayTime = 0.0;
		}
	}

	public void Restart()
	{
		Stop();
		Play();
	}

	public void SetTime(float time)
	{
		if ((bool)bakedData)
		{
			_totalPlayTime = Mathf.Clamp(time, 0f, bakedData.duration);
			if (_isPlaying && !_isPaused)
			{
				UpdateLipSyncAnimation();
			}
		}
	}

	public void SetNormalizedTime(float normalizedTime)
	{
		if ((bool)bakedData)
		{
			float time = Mathf.Clamp01(normalizedTime) * bakedData.duration;
			SetTime(time);
		}
	}

	private void PrintDebugInfo()
	{
		if (!bakedData)
		{
			Debug.Log("No baked data assigned");
		}
		else
		{
			_ = LuminApplication.LogEnabled;
		}
	}
}
