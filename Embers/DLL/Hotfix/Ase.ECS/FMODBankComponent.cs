using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using FMODUnity;

namespace Ase.ECS;

public class FMODBankComponent : BaseComponent
{
	public static string FMOD_BANK_GROUPS = "FMOD_BANK_GROUPS";

	private List<int> bankGroupIds;

	public override async void OnAwake(object data = null)
	{
		base.OnAwake(data);
		bankGroupIds = GetData<List<int>>(FMOD_BANK_GROUPS);
		if (bankGroupIds == null)
		{
			return;
		}
		DRBankGroup[] dataRows = GameEntry.DataTable.GetDataRows((DRBankGroup dRBankGroup) => bankGroupIds.Contains(dRBankGroup.Id));
		if (dataRows != null)
		{
			DRBankGroup[] array = dataRows;
			for (int num = 0; num < array.Length; num++)
			{
				await AudioHelper.LoadBanksByGroup(array[num]);
			}
		}
	}

	public override void OnEntityRelease()
	{
		base.OnEntityRelease();
		if (bankGroupIds == null)
		{
			return;
		}
		DRBankGroup[] dataRows = GameEntry.DataTable.GetDataRows((DRBankGroup data) => bankGroupIds.Contains(data.Id));
		if (dataRows != null)
		{
			DRBankGroup[] array = dataRows;
			for (int num = 0; num < array.Length; num++)
			{
				AudioHelper.UnloadBankByGroup(array[num]);
			}
		}
	}

	public async UniTask WaitUntilBankGroupsLoadedAsync()
	{
		await UniTask.WaitUntil(() => BankGroupsAreLoaded());
	}

	private bool BankGroupsAreLoaded()
	{
		if (bankGroupIds == null)
		{
			return true;
		}
		DRBankGroup[] dataRows = GameEntry.DataTable.GetDataRows((DRBankGroup data) => bankGroupIds.Contains(data.Id));
		if (dataRows == null)
		{
			return true;
		}
		DRBankGroup[] array = dataRows;
		foreach (DRBankGroup bankGroup in array)
		{
			if (!BankGroupIsLoaded(bankGroup))
			{
				return false;
			}
		}
		return true;
	}

	private bool BankGroupIsLoaded(DRBankGroup bankGroup)
	{
		if (bankGroup == null)
		{
			return true;
		}
		foreach (string bank in bankGroup.Banks)
		{
			if (!RuntimeManager.HasBankLoaded(AssetUtility.GetMusicAsset(bank)))
			{
				return false;
			}
		}
		return true;
	}
}
