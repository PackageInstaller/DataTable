using System;

namespace UnityEngine;

public class PlayerPrefsException : Exception
{
	public PlayerPrefsException(string error)
		: base(error)
	{
	}
}
