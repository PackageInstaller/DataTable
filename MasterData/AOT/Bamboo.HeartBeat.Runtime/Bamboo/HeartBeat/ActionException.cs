using System;

namespace Bamboo.HeartBeat;

public class ActionException : Exception
{
	public ActionException(string message)
		: base(message)
	{
	}
}
