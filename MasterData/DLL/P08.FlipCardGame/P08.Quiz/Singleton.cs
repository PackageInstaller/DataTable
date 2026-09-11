namespace P08.Quiz;

public class Singleton<T> where T : class, new()
{
	private static readonly T s_Instance = new T();

	public static T Instance => s_Instance;
}
