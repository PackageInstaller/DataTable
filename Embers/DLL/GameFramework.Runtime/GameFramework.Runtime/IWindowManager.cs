using System.Collections.Generic;

namespace GameFramework.Runtime;

public interface IWindowManager
{
	bool Activated { get; set; }

	IWindow Current { get; }

	int Count { get; }

	IEnumerator<IWindow> Visibles();

	IWindow Get(int index);

	void Add(IWindow window);

	bool Remove(IWindow window);

	IWindow RemoveAt(int index);

	bool Contains(IWindow window);

	int IndexOf(IWindow window);

	List<IWindow> Find(bool visible);

	T Find<T>() where T : IWindow;

	T Find<T>(string name) where T : IWindow;

	List<T> FindAll<T>() where T : IWindow;

	void Clear();

	ITransition Show(IWindow window);

	ITransition Hide(IWindow window);

	ITransition Dismiss(IWindow window);
}
