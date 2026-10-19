using System.Collections;
using UnityEngine;

namespace ACT.LocalLoader;

public class VersionCheckOption : IEnumerator
{
	public bool IsDone { get; private set; }

	public bool IsSuccess { get; private set; }

	public VersionCheckState State { get; private set; }

	object IEnumerator.Current => null;

	public void Check(MonoBehaviour mono)
	{
		if (LuminApplication.Resource.IsLocalSimulation())
		{
			IsDone = true;
			IsSuccess = true;
			return;
		}
		VersionConfig version = LuminApplication.RemoteConfig.GetVersionConfig();
		LuminApplication.RefreshRemoteConfig(mono, (bool success, RemoteConfig config) =>
		{
			if (success)
			{
				JudgeVersion(version);
			}
			else
			{
				State = VersionCheckState.RefreshFail;
			}
			IsDone = true;
			IsSuccess = success;
		});
	}

	public void CheckWithoutRefresh()
	{
		JudgeVersion(default);
		IsDone = true;
		IsSuccess = true;
	}

	private void JudgeVersion(VersionConfig preVersion)
	{
		State = VersionCheckState.None;
		if (LuminApplication.Resource.IsLocalSimulation())
		{
			return;
		}
		if (LuminApplication.IsLocalVersion || LuminApplication.RemoteConfig == null)
		{
			State = VersionCheckState.RefreshFail;
		}
		else if (LuminApplication.RemoteConfig.UpdateType == ClientUpdateType.Full)
		{
			State = VersionCheckState.Full;
		}
		else if (LuminApplication.RemoteConfig.UpdateType == ClientUpdateType.Patch)
		{
			if (!LuminApplication.RemoteConfig.GetVersionConfig().Equals(preVersion))
			{
				State = VersionCheckState.HotUpdateWithPatch;
			}
			else
			{
				State = VersionCheckState.Patch;
			}
		}
		else if (LuminApplication.RemoteConfig.UpdateType == ClientUpdateType.Forbidden)
		{
			State = VersionCheckState.Forbidden;
		}
		else if (!LuminApplication.RemoteConfig.GetVersionConfig().Equals(preVersion))
		{
			State = VersionCheckState.HotUpdate;
		}
	}

	bool IEnumerator.MoveNext()
	{
		return !IsDone;
	}

	void IEnumerator.Reset()
	{
	}
}
