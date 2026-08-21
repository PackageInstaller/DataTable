namespace GameFramework.Runtime;

public class ConverterRegistry : KeyValueRegistry<string, IConverter>, IConverterRegistry, IKeyValueRegistry<string, IConverter>
{
	public ConverterRegistry()
	{
		Init();
	}

	protected virtual void Init()
	{
	}
}
