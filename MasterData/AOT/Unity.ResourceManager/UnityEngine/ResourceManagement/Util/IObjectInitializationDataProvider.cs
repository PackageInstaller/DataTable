namespace UnityEngine.ResourceManagement.Util;

public interface IObjectInitializationDataProvider
{
	string Name { get; }

	ObjectInitializationData CreateObjectInitializationData();
}
