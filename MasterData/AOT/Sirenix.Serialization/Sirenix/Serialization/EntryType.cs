namespace Sirenix.Serialization;

public enum EntryType : byte
{
	Invalid,
	String,
	Guid,
	Integer,
	FloatingPoint,
	Boolean,
	Null,
	StartOfNode,
	EndOfNode,
	InternalReference,
	ExternalReferenceByIndex,
	ExternalReferenceByGuid,
	StartOfArray,
	EndOfArray,
	PrimitiveArray,
	EndOfStream,
	ExternalReferenceByString
}
