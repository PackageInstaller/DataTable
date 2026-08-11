using System.Collections;
using System.Runtime.InteropServices;

namespace System.Runtime.Remoting.Channels;

[ComVisible(true)]
public class SinkProviderData
{
	private string sinkName;

	private ArrayList children;

	private Hashtable properties;

	public IList Children => children;

	public IDictionary Properties => properties;

	public SinkProviderData(string name)
	{
		sinkName = name;
		children = new ArrayList();
		properties = new Hashtable();
	}
}
