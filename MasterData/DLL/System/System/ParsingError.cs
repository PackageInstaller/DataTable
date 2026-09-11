namespace System;

internal enum ParsingError
{
	None = 0,
	BadFormat = 1,
	BadScheme = 2,
	BadAuthority = 3,
	EmptyUriString = 4,
	LastRelativeUriOkErrIndex = EmptyUriString,
	SchemeLimit = 5,
	SizeLimit = 6,
	MustRootedPath = 7,
	BadHostName = 8,
	NonEmptyHost = 9,
	BadPort = 10,
	BadAuthorityTerminator = 11,
	CannotCreateRelative = 12
}
