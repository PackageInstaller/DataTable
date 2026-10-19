using System;

namespace ACT;

public abstract class FlowLogger
{
	internal abstract void Log(string message);

	internal abstract void Warning(string message);

	internal abstract void Error(string message);

	internal abstract void Exception(Exception exception);
}
