namespace System.Runtime.ConstrainedExecution;

public enum Consistency
{
	MayCorruptProcess,
	MayCorruptAppDomain,
	MayCorruptInstance,
	WillNotCorruptState
}
