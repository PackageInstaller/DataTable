using System.Runtime.InteropServices;

namespace DG.Tweening.Plugins.Options;

[StructLayout(LayoutKind.Sequential, Size = 1)]
public struct NoOptions : IPlugOptions
{
	public void Reset()
	{
	}
}
