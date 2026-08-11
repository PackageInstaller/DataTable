using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using FMOD.Studio;
using FMODUnity;

namespace Ase;

public static class AudioHelper
{
	public const string AudioLanguageInfoChannel = "AudioLanguageInfoChannel";

	public static List<AudioParameterSerializable> GetParameterListByConfigData(List<string> keys, List<int> values)
	{
		List<AudioParameterSerializable> list = new List<AudioParameterSerializable>();
		if (keys != null && values != null)
		{
			for (int i = 0; i < keys.Count && values.Count > i; i++)
			{
				list.Add(new AudioParameterSerializable
				{
					Key = keys[i],
					Value = values[i]
				});
			}
		}
		return list;
	}

	public static async UniTask LoadBanksByType(int bankType)
	{
		DRBankGroup[] dataRows = GameEntry.DataTable.GetDataRows((DRBankGroup data) => data.GroupType == bankType);
		List<BankGroupData> bankGroupDatas = new List<BankGroupData>();
		DRBankGroup[] array = dataRows;
		foreach (DRBankGroup dRBankGroup in array)
		{
			BankGroupData item = new BankGroupData
			{
				Id = dRBankGroup.Id,
				GroupType = dRBankGroup.GroupType,
				Banks = dRBankGroup.Banks
			};
			bankGroupDatas.Add(item);
		}
		for (int i = 0; i < bankGroupDatas.Count; i++)
		{
			await GameEntry.Audio.LoadBankByGroup(bankGroupDatas[i]);
			await UniTask.Yield();
			GameEntry.Resource.UnloadUnusedAssets(performGCCollect: false);
			await UniTask.Yield();
		}
	}

	public static async UniTask LoadBanksByGroup(DRBankGroup bankGroup)
	{
		await GameEntry.Audio.LoadBankByGroup(new BankGroupData
		{
			Id = bankGroup.Id,
			GroupType = bankGroup.GroupType,
			Banks = bankGroup.Banks
		});
		await UniTask.Yield();
		GameEntry.Resource.UnloadUnusedAssets(performGCCollect: false);
		await UniTask.Yield();
	}

	public static void UnloadBankByGroup(DRBankGroup bankGroup)
	{
		GameEntry.Audio.UnloadBankByGroup(new BankGroupData
		{
			Id = bankGroup.Id,
			GroupType = bankGroup.GroupType,
			Banks = bankGroup.Banks
		});
	}

	public static void SetGlobalGenderParameter()
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0005: Unknown result type (might be due to invalid IL or missing references)
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		System studioSystem = RuntimeManager.StudioSystem;
		((System)(ref studioSystem)).setParameterByName("protagonist gender", (float)StoryUtility.GetCharacterIndex(), false);
	}
}
