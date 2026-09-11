namespace MessagePack.Unity.Extension;

public class FloatArrayBlitFormatter : UnsafeBlitFormatterBase<float>
{
	protected override sbyte TypeCode => 38;
}
