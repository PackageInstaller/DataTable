using System.Collections.Generic;
using System.Text;

namespace System.Security.Cryptography.X509Certificates;

internal abstract class X509Certificate2Impl : X509CertificateImpl
{
	public abstract IEnumerable<X509Extension> Extensions { get; }

	public abstract X500DistinguishedName IssuerName { get; }

	public abstract AsymmetricAlgorithm PrivateKey { get; set; }

	public abstract string SignatureAlgorithm { get; }

	public abstract X500DistinguishedName SubjectName { get; }

	public abstract int Version { get; }

	internal abstract X509CertificateImplCollection IntermediateCertificates { get; }

	public abstract string GetNameInfo(X509NameType nameType, bool forIssuer);

	public abstract bool Verify(X509Certificate2 thisCertificate);

	public abstract void AppendPrivateKeyInfo(StringBuilder sb);
}
