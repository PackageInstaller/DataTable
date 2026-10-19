namespace Mono;

internal class SystemDependencyProvider : ISystemDependencyProvider
{
	private static SystemDependencyProvider instance;

	private static object syncRoot = new object();

	public static SystemDependencyProvider Instance
	{
		get
		{
			Initialize();
			return instance;
		}
	}

	ISystemCertificateProvider ISystemDependencyProvider.CertificateProvider => CertificateProvider;

	public SystemCertificateProvider CertificateProvider { get; }

	public X509PalImpl X509Pal => CertificateProvider.X509Pal;

	internal static void Initialize()
	{
		lock (syncRoot)
		{
			if (instance == null)
			{
				instance = new SystemDependencyProvider();
			}
		}
	}

	private SystemDependencyProvider()
	{
		CertificateProvider = new SystemCertificateProvider();
		DependencyInjector.Register(this);
	}
}
