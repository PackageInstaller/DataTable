using UnityEngine;

namespace MessagePack.Unity.Extension;

public class Vector3ArrayBlitFormatter : UnsafeBlitFormatterBase<Vector3>
{
	protected override sbyte TypeCode => 31;
}
