using UnityEngine;

namespace Bamboo.HeartBeat;

public abstract class BaseDriver<T> : MonoBehaviour where T : BaseDriver<T>
{
	private static T _instance;

	public static T Instance
	{
		get
		{
			if (null == _instance)
			{
				_instance = Object.FindObjectOfType<T>();
				if (null == _instance)
				{
					GameObject gameObject = new GameObject(typeof(T).ToString());
					_instance = gameObject.AddComponent<T>();
					Object.DontDestroyOnLoad(gameObject);
				}
			}
			return _instance;
		}
	}

	public static void Destroy()
	{
		if (!(null == _instance))
		{
			Object.Destroy(_instance.gameObject);
			_instance = null;
		}
	}
}
