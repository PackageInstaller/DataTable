using System;
using UnityEngine.Internal;
using UnityEngine.Scripting;

namespace UnityEngine;

[RequiredByNativeCode]
[AttributeUsage(AttributeTargets.Field)]
public sealed class SerializeReference : Attribute
{
	[ExcludeFromDocs]
	public SerializeReference()
	{
	}
}
