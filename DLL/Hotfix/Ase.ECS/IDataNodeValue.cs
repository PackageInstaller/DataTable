namespace Ase.ECS;

public interface IDataNodeValue<T>
{
	T GetValue();

	void SetValue(IDataNodeValue<T> value);
}
