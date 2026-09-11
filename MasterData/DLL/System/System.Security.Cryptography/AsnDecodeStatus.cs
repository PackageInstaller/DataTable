namespace System.Security.Cryptography;

internal enum AsnDecodeStatus
{
	NotDecoded = -1,
	Ok,
	BadAsn,
	BadTag,
	BadLength,
	InformationNotAvailable
}
