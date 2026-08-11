using System;

namespace GameFramework;

public interface IDataProvider<T>
{
	event EventHandler<ReadDataSuccessEventArgs> ReadDataSuccess;

	event EventHandler<ReadDataFailureEventArgs> ReadDataFailure;

	event EventHandler<ReadDataUpdateEventArgs> ReadDataUpdate;

	event EventHandler<ReadDataDependencyAssetEventArgs> ReadDataDependencyAsset;

	void ReadData(string dataAssetName);

	void ReadData(string dataAssetName, int priority);

	void ReadData(string dataAssetName, object userData);

	void ReadData(string dataAssetName, int priority, object userData, string packageName);

	bool ParseData(string dataString);

	bool ParseData(string dataString, object userData);

	bool ParseData(byte[] dataBytes);

	bool ParseData(byte[] dataBytes, object userData);

	bool ParseData(byte[] dataBytes, int startIndex, int length);

	bool ParseData(byte[] dataBytes, int startIndex, int length, object userData);
}
