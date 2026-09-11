namespace MessagePack.Unity.Extension;

public class DoubleArrayBlitFormatter : UnsafeBlitFormatterBase<double>
{
	protected override sbyte TypeCode => 39;
}
