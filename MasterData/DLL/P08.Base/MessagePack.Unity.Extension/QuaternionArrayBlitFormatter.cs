using UnityEngine;

namespace MessagePack.Unity.Extension;

public class QuaternionArrayBlitFormatter : UnsafeBlitFormatterBase<Quaternion>
{
	protected override sbyte TypeCode => 33;
}
