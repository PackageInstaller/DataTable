using System.Collections;
using System.Runtime.Remoting.Contexts;

namespace System.Runtime.Remoting.Activation;

internal class RemoteActivationAttribute : Attribute, IContextAttribute
{
	private IList _contextProperties;

	public RemoteActivationAttribute(IList contextProperties)
	{
		_contextProperties = contextProperties;
	}

	public bool IsContextOK(Context ctx, IConstructionCallMessage ctor)
	{
		return false;
	}

	public void GetPropertiesForNewContext(IConstructionCallMessage ctor)
	{
		if (_contextProperties == null)
		{
			return;
		}
		foreach (object contextProperty in _contextProperties)
		{
			ctor.ContextProperties.Add(contextProperty);
		}
	}
}
