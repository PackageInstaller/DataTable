namespace Mono;

internal interface ISystemDependencyProvider
{
	ISystemCertificateProvider CertificateProvider { get; }
}
