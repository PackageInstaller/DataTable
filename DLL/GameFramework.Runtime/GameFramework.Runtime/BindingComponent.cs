#define ENABLE_ERROR_AND_ABOVE_LOG
namespace GameFramework.Runtime;

public class BindingComponent : GameFrameworkComponent
{
	private BindingServiceBundle bindingService;

	public override void Init()
	{
		BaseComponent component = GameEntryRuntime.GetComponent<BaseComponent>();
		if (component == null)
		{
			Log.Error("Base component is invalid.");
			return;
		}
		bindingService = new BindingServiceBundle(component.ApplicationServiceContainer);
		bindingService.Start();
	}

	public override void Shutdown()
	{
		bindingService.Stop();
		bindingService = null;
	}
}
