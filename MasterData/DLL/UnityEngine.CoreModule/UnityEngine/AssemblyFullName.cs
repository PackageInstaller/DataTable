using System;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[RequiredByNativeCode(GenerateProxy = true)]
[NativeHeader("Runtime/Mono/AssemblyFullName.h")]
internal struct AssemblyFullName
{
	[NativeName("name")]
	public string Name;

	[NativeName("version")]
	public AssemblyVersion Version;

	[NativeName("publicKeyToken")]
	public string PublicKeyToken;

	[NativeName("culture")]
	public string Culture;

	public override bool Equals(object other)
	{
		return other is AssemblyFullName assemblyFullName && Name == assemblyFullName.Name && Version == assemblyFullName.Version && PublicKeyToken == assemblyFullName.PublicKeyToken && Culture == assemblyFullName.Culture;
	}

	public override int GetHashCode()
	{
		return HashCode.Combine(Name, Version, PublicKeyToken, Culture);
	}

	public override string ToString()
	{
		return string.Format("{0}, Version={1}, Culture={2}, PublicKeyToken={3}", Name, Version, string.IsNullOrEmpty(Culture) ? "neutral" : Culture, PublicKeyToken);
	}
}
