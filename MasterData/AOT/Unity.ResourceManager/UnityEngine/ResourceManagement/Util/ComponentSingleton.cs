namespace UnityEngine.ResourceManagement.Util;

[ExecuteInEditMode]
public abstract class ComponentSingleton<T> : MonoBehaviour where T : ComponentSingleton<T>
{
	private static T s_Instance;

	public static bool Exists => s_Instance != null;

	public static T Instance
	{
		get
		{
			if (s_Instance == null)
			{
				s_Instance = FindInstance() ?? CreateNewSingleton();
			}
			return s_Instance;
		}
	}

	private static T FindInstance()
	{
		return Object.FindObjectOfType<T>();
	}

	protected virtual string GetGameObjectName()
	{
		return typeof(T).Name;
	}

	private static T CreateNewSingleton()
	{
		GameObject gameObject = new GameObject();
		if (Application.isPlaying)
		{
			Object.DontDestroyOnLoad(gameObject);
			gameObject.hideFlags = HideFlags.DontSaveInEditor | HideFlags.DontSaveInBuild;
		}
		else
		{
			gameObject.hideFlags = HideFlags.HideAndDontSave;
		}
		T val = gameObject.AddComponent<T>();
		gameObject.name = val.GetGameObjectName();
		return val;
	}

	private void Awake()
	{
		if (s_Instance != null && s_Instance != this)
		{
			Object.DestroyImmediate(gameObject);
		}
		else
		{
			s_Instance = this as T;
		}
	}

	public static void DestroySingleton()
	{
		if (Exists)
		{
			Object.DestroyImmediate(Instance.gameObject);
			s_Instance = null;
		}
	}
}
