using System.Collections.Generic;

namespace GameFramework.Runtime;

public interface IUIViewGroup : IUIView, IView
{
	List<IUIView> Views { get; }

	IUIView GetView(string name);

	void AddView(IUIView view, bool worldPositionStays = false);

	void AddView(IUIView view, UILayout layout);

	void RemoveView(IUIView view, bool worldPositionStays = false);
}
