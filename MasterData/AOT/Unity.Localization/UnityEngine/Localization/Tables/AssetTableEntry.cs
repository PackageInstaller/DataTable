using UnityEngine.ResourceManagement.AsyncOperations;

namespace UnityEngine.Localization.Tables;

public class AssetTableEntry : TableEntry
{
	internal AsyncOperationHandle? AsyncOperation { get; set; }

	public string Guid
	{
		get
		{
			return Data.Localized;
		}
		set
		{
			Data.Localized = value;
		}
	}

	public bool IsEmpty => string.IsNullOrEmpty(Guid);

	internal AssetTableEntry()
	{
	}

	public void RemoveFromTable()
	{
		AssetTable assetTable = Table as AssetTable;
		if (assetTable == null)
		{
			Debug.LogWarning(string.Format("Failed to remove {0} with id {1} and asset guid `{2}` as it does not belong to a table.", "AssetTableEntry", KeyId, Guid));
		}
		else
		{
			assetTable.Remove(KeyId);
		}
	}

	public void SetAssetOverride<T>(T asset) where T : Object
	{
		if (AsyncOperation.HasValue)
		{
			AddressablesInterface.Release(AsyncOperation.Value);
		}
		AsyncOperation = AddressablesInterface.ResourceManager.CreateCompletedOperation(asset, null);
	}
}
