using System.Runtime.InteropServices;

namespace System.Runtime.Remoting.Contexts;

[ComVisible(true)]
public interface IContributeDynamicSink
{
	IDynamicMessageSink GetDynamicSink();
}
