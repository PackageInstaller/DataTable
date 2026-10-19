namespace UnityEngine.UI;

public interface ICanvasElement
{
	Transform transform { get; }

	void Rebuild(CanvasUpdate executing);

	void LayoutComplete();

	void GraphicUpdateComplete();

	bool IsDestroyed();
}
