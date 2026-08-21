namespace GameFramework.Resource;

public delegate void LoadAssetDependencyAssetCallback(string assetName, string dependencyAssetName, int loadedCount, int totalCount, object userData);
