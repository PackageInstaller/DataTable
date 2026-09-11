using UnityEngine;

namespace P08.Quiz;

public class MonoSingleton<T> : MonoBehaviour where T : MonoSingleton<T>
{
	public static T Instance { get; protected set; }

	protected virtual void Awake()
	{
		if (Instance != null)
		{
			Object.Destroy(base.gameObject);
		}
		else
		{
			Instance = (T)this;
		}
	}

	protected virtual void OnDestroy()
	{
		if (Instance == this)
		{
			Instance = null;
		}
	}
}
