using UnityEngine;

namespace MessagePack.Unity.Extension;

public class Vector2ArrayBlitFormatter : UnsafeBlitFormatterBase<Vector2>
{
	protected override sbyte TypeCode => 30;
}
