using System;
using System.Runtime.InteropServices;

[StructLayout(LayoutKind.Sequential, Size = 1)]
internal struct CriDurationMeasurementScope : IDisposable
{
	public CriDurationMeasurementScope(string name)
	{
	}

	public void Dispose()
	{
	}
}
