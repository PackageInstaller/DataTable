using UnityEngine;

namespace GameFramework.Runtime;

public abstract class GameFrameworkComponent : MonoBehaviour
{
	protected virtual void Awake()
	{
		GameEntryRuntime.RegisterComponent(this);
	}

	public virtual void Init()
	{
	}

	public virtual void Shutdown()
	{
	}
}
