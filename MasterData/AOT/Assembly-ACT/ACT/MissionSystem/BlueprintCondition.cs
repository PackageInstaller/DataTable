using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using Fundamental;
using Unity.VisualScripting;
using UnityEngine;

namespace ACT.MissionSystem;

public class BlueprintCondition : MissionCondition
{
	private AssetLoadHandle handle;

	private GameObject blueprintInstance;

	private ScriptMachine blueprint;

	protected override async void OnInMissionWorld()
	{
		BlueprintConditionParam blueprintConditionParam = Param as BlueprintConditionParam;
		if (string.IsNullOrEmpty(blueprintConditionParam.key))
		{
			return;
		}
		handle = AssetStationManager.BattleStation.LoadAsync<GameObject>("BluePrint/" + blueprintConditionParam.key);
		await handle;
		if (!InMissionWorld)
		{
			return;
		}
		GameObject original = handle.AsGameObject();
		blueprintInstance = Object.Instantiate(original, Fundamental.Singleton<MissionManager>.instance.MissionManagerRoot);
		blueprint = blueprintInstance.GetComponent<ScriptMachine>();
		blueprint.enabled = true;
		do
		{
			if (CheckCondition())
			{
				MarkSuccess();
				break;
			}
			await UniTask.Yield();
		}
		while (!InMissionWorld);
	}

	protected override void OnOutMissionWorld()
	{
		Object.Destroy(blueprintInstance);
		blueprintInstance = null;
		blueprint = null;
		if (handle.IsValid)
		{
			AssetStationManager.BattleStation.Release(handle);
			handle = default;
		}
	}

	private bool CheckCondition()
	{
		return !blueprintInstance;
	}
}
