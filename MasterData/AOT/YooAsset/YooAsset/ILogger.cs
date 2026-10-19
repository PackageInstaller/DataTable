using System;

namespace YooAsset;

public interface ILogger
{
	void Log(string message);

	void Warning(string message);

	void Error(string message);

	void Exception(Exception exception);
}
