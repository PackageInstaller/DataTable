public interface IAsyncAsset
{
	bool Release();

	bool IsDone();

	string GetAssetName();

	int GetRefCount();
}
