using System.Runtime.InteropServices;

namespace System.Runtime.Remoting.Messaging;

[Serializable]
[ComVisible(true)]
public class Header
{
	public string HeaderNamespace;

	public bool MustUnderstand;

	public string Name;

	public object Value;
}
