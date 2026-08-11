namespace GameFramework.Resource;

public enum LoadResourceStatus : byte
{
	Success,
	NotExist,
	NotReady,
	DependencyError,
	TypeError,
	AssetError
}
