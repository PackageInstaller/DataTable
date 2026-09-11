using UnityEngine;

namespace MessagePack.Unity.Extension;

public class RectArrayBlitFormatter : UnsafeBlitFormatterBase<Rect>
{
	protected override sbyte TypeCode => 36;
}
