namespace GameFramework.Runtime;

public interface IFactory
{
	Preferences Create(string name);
}
