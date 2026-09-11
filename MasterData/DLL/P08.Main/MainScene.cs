using System;
using P08Main.Loading;
using UnityEngine;

public class MainScene : MainSceneLoader
{
	public static LoadingImpl customLoading;

	public static bool UseCustomLoading;

	private float _startTime;

	private float _endTime;

	public override void OnBeginLoad()
	{
		base.OnBeginLoad();
		_startTime = Time.realtimeSinceStartup;
	}

	public override void ShowLoadUI()
	{
		if (!UseCustomLoading)
		{
			base.ShowLoadUI();
		}
		else
		{
			CustomLoadingManager.inst.ShowLoadUI(customLoading);
		}
	}

	public override float ShowLoadUIDuration()
	{
		if (UseCustomLoading && customLoading == LoadingImpl.BilliardGame_Loading)
		{
			return 1f;
		}
		return base.ShowLoadUIDuration();
	}

	public override float EndLoadUIDuration()
	{
		if (UseCustomLoading)
		{
			Resources.UnloadUnusedAssets();
			GC.Collect();
			GC.Collect();
			GC.Collect();
			LuaHelper.CallFunction("LuaGcCollect");
			if (customLoading == LoadingImpl.BilliardGame_Loading)
			{
				return 1f;
			}
		}
		return base.EndLoadUIDuration();
	}

	public override float CloseLoadUIDuration()
	{
		if (UseCustomLoading && customLoading == LoadingImpl.BilliardGame_Loading)
		{
			return 0.5f;
		}
		return base.CloseLoadUIDuration();
	}

	protected override void SetUIProgress(float value)
	{
		if (!UseCustomLoading)
		{
			base.SetUIProgress(value);
		}
		else
		{
			CustomLoadingManager.inst.SetUIProgress(customLoading, value);
		}
	}

	public override void CloseLoadUI()
	{
		if (!UseCustomLoading)
		{
			base.CloseLoadUI();
			Resources.UnloadUnusedAssets();
			GC.Collect();
			GC.Collect();
			GC.Collect();
			LuaHelper.CallFunction("LuaGcCollect");
		}
		else
		{
			CustomLoadingManager.inst.CloseLoadUI(customLoading);
			UseCustomLoading = false;
			customLoading = LoadingImpl.Default;
		}
	}

	public override void OnSceneReady()
	{
		base.OnSceneReady();
		_endTime = Time.realtimeSinceStartup;
		int num = (int)(_endTime * 1000f - _startTime * 1000f);
		LuaHelper.CallFunction("StatUILoadTimeToServer", num);
	}
}
