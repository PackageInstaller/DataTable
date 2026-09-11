using System.Runtime.InteropServices;

namespace System;

[Serializable]
[ComVisible(false)]
public sealed class ApplicationIdentity
{
	private string _fullName;

	public string FullName => _fullName;
}
