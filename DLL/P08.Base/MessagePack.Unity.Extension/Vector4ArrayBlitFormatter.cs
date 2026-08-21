using UnityEngine;

namespace MessagePack.Unity.Extension;

public class Vector4ArrayBlitFormatter : UnsafeBlitFormatterBase<Vector4>
{
	protected override sbyte TypeCode => 32;
}
