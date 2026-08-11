namespace GameFramework.Runtime;

public class BinaryFilePreferencesFactory : AbstractFactory
{
	public BinaryFilePreferencesFactory()
		: this(null, null)
	{
	}

	public BinaryFilePreferencesFactory(ISerializer serializer)
		: this(serializer, null)
	{
	}

	public BinaryFilePreferencesFactory(ISerializer serializer, IEncryptor encryptor)
		: base(serializer, encryptor)
	{
	}

	public override Preferences Create(string name)
	{
		return new BinaryFilePreferences(name, base.Serializer, base.Encryptor);
	}
}
