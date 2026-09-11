using System;
using System.Runtime.InteropServices;

public class CriAudioWriteStream
{
	[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
	private delegate uint InternalDelegate(IntPtr cbobj, IntPtr data, uint numSamples);

	public delegate uint Delegate(float[][] buffer, uint numSamples);

	private InternalDelegate internalDelegate;

	public IntPtr callbackFunction { get; private set; }

	public IntPtr callbackPointer { get; private set; }

	public CriAudioWriteStream(IntPtr callbackFunction, IntPtr callbackPointer)
	{
		this.callbackFunction = callbackFunction;
		this.callbackPointer = callbackPointer;
	}

	public CriAudioWriteStream(Delegate callback, int numChannels, int bufferSize = 256)
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
			for (int j = 0; j < numChannels; j++)
			{
				Marshal.Copy(Marshal.ReadIntPtr(data, IntPtr.Size * j), buffer[j], 0, (int)numSamples);
			}
			numSamples = callback(buffer, numSamples);
			return numSamples;
		};
		callbackFunction = Marshal.GetFunctionPointerForDelegate(internalDelegate);
	}
}
