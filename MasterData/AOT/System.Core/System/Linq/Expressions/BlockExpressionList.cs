using System.Collections;
using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.Dynamic.Utils;

namespace System.Linq.Expressions;

internal class BlockExpressionList : IList<Expression>, ICollection<Expression>, IEnumerable<Expression>, IEnumerable
{
	private readonly BlockExpression _block;

	private readonly Expression _arg0;

	public Expression this[int index]
	{
		get
		{
			if (index == 0)
			{
				return _arg0;
			}
			return _block.GetExpression(index);
		}
		[ExcludeFromCodeCoverage]
		set
		{
			throw ContractUtils.Unreachable;
		}
	}

	public int Count => _block.ExpressionCount;

	[ExcludeFromCodeCoverage]
	public bool IsReadOnly
	{
		get
		{
			throw ContractUtils.Unreachable;
		}
	}

	internal BlockExpressionList(BlockExpression provider, Expression arg0)
	{
		_block = provider;
		_arg0 = arg0;
	}

	public int IndexOf(Expression item)
	{
		if (_arg0 == item)
		{
			return 0;
		}
		for (int i = 1; i < _block.ExpressionCount; i++)
		{
			if (_block.GetExpression(i) == item)
			{
				return i;
			}
		}
		return -1;
	}

	[ExcludeFromCodeCoverage]
	public void Insert(int index, Expression item)
	{
		throw ContractUtils.Unreachable;
	}

	[ExcludeFromCodeCoverage]
	public void RemoveAt(int index)
	{
		throw ContractUtils.Unreachable;
	}

	[ExcludeFromCodeCoverage]
	public void Add(Expression item)
	{
		throw ContractUtils.Unreachable;
	}

	[ExcludeFromCodeCoverage]
	public void Clear()
	{
		throw ContractUtils.Unreachable;
	}

	public bool Contains(Expression item)
	{
		return IndexOf(item) != -1;
	}

	public void CopyTo(Expression[] array, int index)
	{
		ContractUtils.RequiresNotNull(array, "array");
		if (index < 0)
		{
			throw Error.ArgumentOutOfRange("index");
		}
		int expressionCount = _block.ExpressionCount;
		if (index + expressionCount > array.Length)
		{
			throw new ArgumentException();
		}
		array[index++] = _arg0;
		for (int i = 1; i < expressionCount; i++)
		{
			array[index++] = _block.GetExpression(i);
		}
	}

	[ExcludeFromCodeCoverage]
	public bool Remove(Expression item)
	{
		throw ContractUtils.Unreachable;
	}

	public IEnumerator<Expression> GetEnumerator()
	{
		yield return _arg0;
		for (int i = 1; i < _block.ExpressionCount; i++)
		{
			yield return _block.GetExpression(i);
		}
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}
}
