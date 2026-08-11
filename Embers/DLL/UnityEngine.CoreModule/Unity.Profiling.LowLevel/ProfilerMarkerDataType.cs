namespace Unity.Profiling.LowLevel;

public enum ProfilerMarkerDataType : byte
{
	Int32 = 2,
	UInt32 = 3,
	Int64 = 4,
	UInt64 = 5,
	Float = 6,
	Double = 7,
	String16 = 9,
	Blob8 = 11
}
