namespace System.Reflection;

internal sealed class SignatureGenericMethodParameterType : SignatureGenericParameterType
{
	public sealed override bool IsGenericTypeParameter => false;

	public sealed override bool IsGenericMethodParameter => true;

	public sealed override string Name => "!!" + GenericParameterPosition;

	internal SignatureGenericMethodParameterType(int position)
		: base(position)
	{
	}
}
