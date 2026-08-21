namespace GameFramework.Runtime;

public abstract class AbstractFactory : IFactory
{
	private IEncryptor encryptor;

	private ISerializer serializer;

	public IEncryptor Encryptor
	{
		get
		{
			return encryptor;
		}
		protected set
		{
			encryptor = value;
		}
	}

	public ISerializer Serializer
	{
		get
		{
			return serializer;
		}
		protected set
		{
			serializer = value;
		}
	}

	public AbstractFactory()
		: this(null, null)
	{
	}

	public AbstractFactory(ISerializer serializer)
		: this(serializer, null)
	{
	}

	public AbstractFactory(ISerializer serializer, IEncryptor encryptor)
	{
		this.serializer = serializer;
		this.encryptor = encryptor;
		if (this.serializer == null)
		{
			this.serializer = new DefaultSerializer();
		}
		if (this.encryptor == null)
		{
			this.encryptor = new DefaultEncryptor();
		}
	}

	public abstract Preferences Create(string name);
}
