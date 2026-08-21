namespace MessagePack.Unity.Extension;

public class IntArrayBlitFormatter : UnsafeBlitFormatterBase<int>
{
	protected override sbyte TypeCode => 37;
}
