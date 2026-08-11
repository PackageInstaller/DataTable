namespace UnityEngine.Rendering;

public static class ComponentSingleton<TType> where TType : Component
{
	private static TType s_Instance;

	public static TType instance
	{
		get
		{
			if (s_Instance == null)
			{
				GameObject gameObject = new GameObject("Default " + typeof(TType).Name);
				gameObject.hideFlags = HideFlags.HideAndDontSave;
				gameObject.SetActive(value: false);
				s_Instance = gameObject.AddComponent<TType>();
			}
			return s_Instance;
		}
	}

	public static void Release()
	{
		if (s_Instance != null)
		{
			CoreUtils.Destroy(s_Instance.gameObject);
			s_Instance = null;
		}
	}
}
