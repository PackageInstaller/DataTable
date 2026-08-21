using System;
using UnityEngine.Internal;
using UnityEngine.Scripting;

namespace UnityEngine;

[AttributeUsage(AttributeTargets.Field)]
[RequiredByNativeCode]
public sealed class SerializeReference : Attribute
{
	[ExcludeFromDocs]
	public SerializeReference()
	{
	}
}
