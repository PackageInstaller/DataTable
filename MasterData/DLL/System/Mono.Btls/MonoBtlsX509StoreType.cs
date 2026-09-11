namespace Mono.Btls;

internal enum MonoBtlsX509StoreType
{
	Custom,
	MachineTrustedRoots,
	MachineIntermediateCA,
	MachineUntrusted,
	UserTrustedRoots,
	UserIntermediateCA,
	UserUntrusted
}
