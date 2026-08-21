using System.Collections.Generic;

namespace GameFramework.Runtime;

public interface IBinder
{
	IBinding Bind(IBindingContext bindingContext, object source, object target, BindingDescription bindingDescription);

	IEnumerable<IBinding> Bind(IBindingContext bindingContext, object source, object target, IEnumerable<BindingDescription> bindingDescriptions);
}
