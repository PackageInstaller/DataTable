using System;

namespace GameFramework.Runtime.Parameters;

public interface ICommandParameter
{
	object GetValue();

	Type GetValueType();
}
