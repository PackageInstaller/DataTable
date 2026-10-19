using System.Runtime.InteropServices;
using System.Runtime.Remoting.Activation;

namespace System.Runtime.Remoting.Contexts;

[ComVisible(true)]
public interface IContextAttribute
{
	void GetPropertiesForNewContext(IConstructionCallMessage msg);

	bool IsContextOK(Context ctx, IConstructionCallMessage msg);
}
