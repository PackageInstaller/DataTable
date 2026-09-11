using UnityEngine;

namespace MessagePack.Unity.Extension;

public class ColorArrayBlitFormatter : UnsafeBlitFormatterBase<Color>
{
	protected override sbyte TypeCode => 34;
}
