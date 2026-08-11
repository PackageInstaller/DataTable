using System.Runtime.InteropServices;

namespace System.Runtime.Remoting.Contexts;

[ComVisible(true)]
public interface IContextProperty
{
	string Name { get; }

	void Freeze(Context newContext);

	bool IsNewContextOK(Context newCtx);
}
