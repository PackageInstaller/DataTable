namespace Internal.Cryptography.Pal;

internal enum GeneralNameType
{
	OtherName = 0,
	Rfc822Name = 1,
	Email = Rfc822Name,
	DnsName = 2,
	X400Address = 3,
	DirectoryName = 4,
	EdiPartyName = 5,
	UniformResourceIdentifier = 6,
	IPAddress = 7,
	RegisteredId = 8
}
