namespace GameFramework.Runtime;

public interface IBindingFactory
{
	IBinding Create(IBindingContext bindingContext, object source, object target, BindingDescription bindingDescription);
}
