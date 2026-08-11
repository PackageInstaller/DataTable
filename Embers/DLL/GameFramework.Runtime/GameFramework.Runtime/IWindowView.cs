namespace GameFramework.Runtime;

public interface IWindowView : IUIViewGroup, IUIView, IView
{
	IAnimation ActivationAnimation { get; set; }

	IAnimation PassivationAnimation { get; set; }
}
