using GameFramework.Runtime;

namespace Ase;

public class NumericalBase : ViewModelBase
{
	protected NumericalProperty numericalProperty;

	public NumericalProperty NumericalProperty => numericalProperty;

	public NumericalBase()
	{
		numericalProperty = new NumericalProperty(this);
	}
}
