using Runtime;
using UnityEngine;

namespace ACT.Initialize.Flow;

internal class InitDeviceGrade : RuntimeLoadFlow
{
	private MonoBehaviour _root;

	public InitDeviceGrade(MonoBehaviour root)
		: base("InitDeviceGrade")
	{
		_root = root;
	}

	protected override void OnStart()
	{
		base.OnStart();
		if (_root == null)
		{
			return;
		}
		float ts = Time.realtimeSinceStartup;
		WaitInitializer.Start(1L);
		GameSettingsProvider settingsProvider = _root.GetComponent<SettingsManager>()?.SettingsProviderAsset;
		DeviceGradeInfo.SetupDeviceGradeSetting(_root, () =>
		{
			WaitInitializer.CompleteOne();
			if (LuminApplication.LogEnabled)
			{
				float num = Time.realtimeSinceStartup - ts;
				Debug.Log($"获取设备分级信息耗时: {num}ms");
			}
			_root = null;
		}, settingsProvider);
	}
}
