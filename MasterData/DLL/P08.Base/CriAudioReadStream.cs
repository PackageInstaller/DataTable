using System;
using System.Runtime.InteropServices;

public class CriAudioReadStream
{
	[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
	private delegate uint InternalDelegate(IntPtr cbobj, IntPtr data, uint numSamples);

	public delegate uint Delegate(float[][] buffer, uint numSamples);

	private InternalDelegate internalDelegate;

	public IntPtr callbackFunction { get; private set; }

	public IntPtr callbackPointer { get; private set; }

	public CriAudioReadStream(IntPtr callbackFunction, IntPtr callbackPointer)
	{
		this.callbackFunction = callbackFunction;
		this.callbackPointer = callbackPointer;
	}

	public CriAudioReadStream(Delegate callback, int numChannels, int bufferSize = 256)
	{
		float[][] buffer = new float[numChannels][];
		for (int i = 0; i < numChannels; i++)
		{
			buffer[i] = new float[bufferSize];
		}
		internalDelegate = delegate(IntPtr cbobj, IntPtr data, uint numSamples)
		{
			if (numSamples > bufferSize)
			{
				numSamples = (uint)bufferSize;
			}
			numSamples = callback(buffer, numSamples);
			for (int j = 0; j < numChannels; j++)
			{
				Marshal.Copy(buffer[j], 0, Marshal.ReadIntPtr(data, IntPtr.Size * j), (int)numSamples);
			}
			return numSamples;
		};
		callbackFunction = Marshal.GetFunctionPointerForDelegate(internalDelegate);
	}
}
