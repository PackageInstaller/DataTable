using System;

namespace Telepathy;

public static class Log
{
	public static Action<string> Info = Console.WriteLine;

	public static Action<string> Warning = Console.WriteLine;

	public static Action<string> Error = Console.Error.WriteLine;
}
