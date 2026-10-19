using UnityEngine;

namespace ACT;

public abstract class ConnectionSO : ScriptableObject
{
}
public abstract class ConnectionSO<T> : ConnectionSO, IConnectionSO<T>
{
	public abstract IConnection<T> CreateConnection(ISettingWithValue<T> owner);
}
