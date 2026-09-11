namespace System.Reflection;

internal sealed class SignatureArrayType : SignatureHasElementType
{
	private readonly int _rank;

	private readonly bool _isMultiDim;

	public sealed override bool IsSZArray => !_isMultiDim;

	public sealed override bool IsVariableBoundArray => _isMultiDim;

	protected sealed override string Suffix
	{
		get
		{
			if (!_isMultiDim)
			{
				return "[]";
			}
			if (_rank == 1)
			{
				return "[*]";
			}
			return "[" + new string(',', _rank - 1) + "]";
		}
	}

	internal SignatureArrayType(SignatureType elementType, int rank, bool isMultiDim)
		: base(elementType)
	{
		_rank = rank;
		_isMultiDim = isMultiDim;
	}

	protected sealed override bool IsArrayImpl()
	{
		return true;
	}

	protected sealed override bool IsByRefImpl()
	{
		return false;
	}

	protected sealed override bool IsPointerImpl()
	{
		return false;
	}

	public sealed override int GetArrayRank()
	{
		return _rank;
	}
}
