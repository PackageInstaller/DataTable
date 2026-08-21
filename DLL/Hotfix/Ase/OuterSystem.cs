#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class OuterSystem : Singleton<OuterSystem>
{
	public const string OUTER_SCENE_NAME = "Outer/Outer";

	private ISubscription<AccounetNotifyMessager> accounetDisconnectSubscription;

	public OuterSystem()
	{
		accounetDisconnectSubscription = Context.GetApplicationContext().GetService<IMessenger>().Subscribe<AccounetNotifyMessager>(OnAccounetNotify);
	}

	private void OnAccounetNotify(AccounetNotifyMessager msg)
	{
		if (Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().GetGameProcess() == GameProcessType.Outer)
		{
			Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().BacktiTitle("Outer/Outer");
		}
	}

	public int GetConstantConfigInt(int confId, int defaultValue = 0)
	{
		DRConstantConfig dataRow = GameEntry.DataTable.GetDataRow<DRConstantConfig>(confId);
		if (dataRow == null)
		{
			Log.Error($"ConstantConfig表找不到Id为【{confId}】的配置，请检查！");
			return defaultValue;
		}
		return (int)dataRow.Value;
	}

	public string SavePlayerPrefs(string k, string v)
	{
		long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
		PlayerPrefs.SetString($"{k}_{uid}", v);
		return v;
	}

	public string LoadPlayerPrefs(string k)
	{
		long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
		return PlayerPrefs.GetString($"{k}_{uid}", "");
	}

	public override void Dispose()
	{
		base.Dispose();
		if (accounetDisconnectSubscription != null)
		{
			accounetDisconnectSubscription.Dispose();
			accounetDisconnectSubscription = null;
		}
	}
}
