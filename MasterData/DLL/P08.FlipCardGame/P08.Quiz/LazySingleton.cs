using System;

namespace P08.Quiz;

public class LazySingleton<T> where T : class, new()
{
	private static readonly Lazy<T> lazyInstance = new Lazy<T>(() => new T());

	public static T Instance => lazyInstance.Value;
}
