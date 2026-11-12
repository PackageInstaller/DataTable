using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.SceneManagement;

public class PerformManager : SceneSingleton<PerformManager>
{
	public const int kCloseupPerformanceLayer = 26;

	private Action<bool> _onPerformFinish;

	private TimelinePerformPlayer _timelinePerformPlayer;

	private SettlementPerformPlayer _settlementPerformPlayer;

	public const string SettlementPerformLoadFinishEvent = "SettlementPerformLoadFinish";

	public bool InPerform
	{
		get
		{
			if (_timelinePerformPlayer != null && _timelinePerformPlayer.InPerform)
			{
				return true;
			}
			if (_settlementPerformPlayer != null && _settlementPerformPlayer.IsPlaying)
			{
				return true;
			}
			return false;
		}
	}

	protected void Update()
	{
		if (InPerform)
		{
			if (_timelinePerformPlayer != null && _timelinePerformPlayer.IsPlaying)
			{
				_timelinePerformPlayer.Update();
			}
			if (_settlementPerformPlayer != null && _settlementPerformPlayer.IsPlaying)
			{
				_settlementPerformPlayer.Update();
			}
		}
	}

	protected void OnDisable()
	{
		_timelinePerformPlayer?.Clear();
		_timelinePerformPlayer = null;
		_settlementPerformPlayer?.Clear();
		_settlementPerformPlayer = null;
		_onPerformFinish = null;
	}

	public void PlaySettlementPerform(string sceneName, string outfitSoundStateName, List<int> performActors, Action<bool> onPerformFinish = null)
	{
		if (string.IsNullOrEmpty(sceneName))
		{
			Debug.LogError("结算演出播放失败, 场景路径为空!");
			onPerformFinish?.Invoke(obj: false);
			return;
		}
		if (performActors == null || performActors.Count <= 0 || performActors.Count > 3)
		{
			Debug.LogError("结算演出播放失败, 角色数据有误!");
			onPerformFinish?.Invoke(obj: false);
			return;
		}
		_onPerformFinish = onPerformFinish;
		ModuleController<AdventureModuleController>.Instance.TimeControlReset();
		LockStepManager.InSettlementPerform = true;
		SceneSingleton<AdventurePlayerController>.Instance.InputDisable();
		string scenePath = "Assets/AssetBundles/" + sceneName;
		MonoSingleton<SceneLoaderController>.Instance.LoadSceneAsync(scenePath, LoadSceneMode.Additive, LocalPhysicsMode.None, (string text, int process) =>
		{
			if (process == 200)
			{
				string[] array = text.Split('/');
				string name = array[array.Length - 1];
				if (_settlementPerformPlayer == null)
				{
					_settlementPerformPlayer = new SettlementPerformPlayer();
				}
				else
				{
					_settlementPerformPlayer.Clear();
				}
				MonoSingleton<ClientManager>.Instance.CloseLoadingView(() =>
				{
					MonoSingleton<LuaManager>.Instance?.FireEvent("SettlementPerformLoadFinish");
					_settlementPerformPlayer.Play(name, outfitSoundStateName, performActors, (bool success) =>
					{
						OnPerformEnd(success);
						LockStepManager.InSettlementPerform = false;
					});
				}, 0f, 0f);
				return true;
			}
			return true;
		});
	}

	public void PlayTimelinePerform(GameObject timelineObj, Action<bool> onPerformFinish = null)
	{
		if (timelineObj == null)
		{
			Debug.LogError("未传入Timeline预制体,播放失败!");
			onPerformFinish?.Invoke(obj: false);
			return;
		}
		if (!timelineObj.TryGetComponent<PlayableDirector>(out var component))
		{
			Debug.LogError("未找到PlayableDirector组件,播放失败!");
			onPerformFinish?.Invoke(obj: false);
			return;
		}
		if (!timelineObj.TryGetComponent<TimelinePerformConfig>(out var component2))
		{
			Debug.LogError("未找到Timeline演出配置,播放失败!");
			onPerformFinish?.Invoke(obj: false);
			return;
		}
		component2.Setup();
		if (_timelinePerformPlayer == null)
		{
			_timelinePerformPlayer = new TimelinePerformPlayer();
		}
		else
		{
			_timelinePerformPlayer.Clear();
		}
		_timelinePerformPlayer.Play(component, component2, onPerformFinish);
	}

	public void PauseTimeLinePerform(bool isPause)
	{
		if (isPause)
		{
			_timelinePerformPlayer?.Pause();
		}
		else
		{
			_timelinePerformPlayer?.Resume();
		}
	}

	public void StopTimeLinePerform()
	{
		_timelinePerformPlayer?.Stop();
	}

	protected void OnPerformEnd(bool seccessed)
	{
		_onPerformFinish?.Invoke(seccessed);
		_onPerformFinish = null;
	}
}
