using UnityEngine;

public class AssetBundleLoadAssetOperationSimulation<T> : AssetBundleLoadAssetOperation<T> where T : Object
{
	private Object m_SimulatedObject;

	public AssetBundleLoadAssetOperationSimulation(Object simulatedObject, OnVoidHandler<T> callback)
	{
		m_SimulatedObject = simulatedObject;
		callback(m_SimulatedObject as T);
	}

	public override T GetAsset()
	{
		return m_SimulatedObject as T;
	}

	public override bool Update()
	{
		return false;
	}

	public override bool IsDone()
	{
		return true;
	}

	public override void Finish()
	{
	}

	public override string ToString()
	{
		return string.Empty;
	}
}
