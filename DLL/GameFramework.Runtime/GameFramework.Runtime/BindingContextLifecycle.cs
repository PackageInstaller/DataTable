using UnityEngine;

namespace GameFramework.Runtime;

public class BindingContextLifecycle : MonoBehaviour
{
	private IBindingContext bindingContext;

	public IBindingContext BindingContext
	{
		get
		{
			return bindingContext;
		}
		set
		{
			if (bindingContext != value)
			{
				if (bindingContext != null)
				{
					bindingContext.Dispose();
				}
				bindingContext = value;
			}
		}
	}

	protected virtual void OnDestroy()
	{
		if (bindingContext != null)
		{
			bindingContext.Dispose();
			bindingContext = null;
		}
	}
}
