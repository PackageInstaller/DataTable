namespace GameFramework.Runtime;

public class PlayerPrefsPreferencesFactory : AbstractFactory
{
	public PlayerPrefsPreferencesFactory()
		: this(null, null)
	{
	}

	public PlayerPrefsPreferencesFactory(ISerializer serializer)
		: this(serializer, null)
	{
	}

	public PlayerPrefsPreferencesFactory(ISerializer serializer, IEncryptor encryptor)
		: base(serializer, encryptor)
	{
	}

	public override Preferences Create(string name)
	{
		return new PlayerPrefsPreferences(name, base.Serializer, base.Encryptor);
	}
}
