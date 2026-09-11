using UnityEngine;

namespace MessagePack.Unity.Extension;

public class BoundsArrayBlitFormatter : UnsafeBlitFormatterBase<Bounds>
{
	protected override sbyte TypeCode => 35;
}
