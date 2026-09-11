using System.Collections.Generic;

namespace System.Linq.Expressions.Interpreter;

internal sealed class LabelInfo
{
	private readonly LabelTarget _node;

	private BranchLabel _label;

	private object _definitions;

	private readonly List<LabelScopeInfo> _references = new List<LabelScopeInfo>();

	private bool _acrossBlockJump;

	private bool HasDefinitions => _definitions != null;

	private bool HasMultipleDefinitions => _definitions is HashSet<LabelScopeInfo>;

	internal LabelInfo(LabelTarget node)
	{
		_node = node;
	}

	internal BranchLabel GetLabel(LightCompiler compiler)
	{
		EnsureLabel(compiler);
		return _label;
	}

	internal void Reference(LabelScopeInfo block)
	{
		_references.Add(block);
		if (HasDefinitions)
		{
			ValidateJump(block);
		}
	}

	internal void Define(LabelScopeInfo block)
	{
		for (LabelScopeInfo labelScopeInfo = block; labelScopeInfo != null; labelScopeInfo = labelScopeInfo.Parent)
		{
			if (labelScopeInfo.ContainsTarget(_node))
			{
				throw Error.LabelTargetAlreadyDefined(_node.Name);
			}
		}
		AddDefinition(block);
		block.AddLabelInfo(_node, this);
		if (HasDefinitions && !HasMultipleDefinitions)
		{
			foreach (LabelScopeInfo reference in _references)
			{
				ValidateJump(reference);
			}
			return;
		}
		if (_acrossBlockJump)
		{
			throw Error.AmbiguousJump(_node.Name);
		}
		_label = null;
	}

	private void ValidateJump(LabelScopeInfo reference)
	{
		for (LabelScopeInfo labelScopeInfo = reference; labelScopeInfo != null; labelScopeInfo = labelScopeInfo.Parent)
		{
			if (DefinedIn(labelScopeInfo))
			{
				return;
			}
			if (labelScopeInfo.Kind == LabelScopeKind.Finally || labelScopeInfo.Kind == LabelScopeKind.Filter)
			{
				break;
			}
		}
		_acrossBlockJump = true;
		if (_node != null && _node.Type != typeof(void))
		{
			throw Error.NonLocalJumpWithValue(_node.Name);
		}
		if (HasMultipleDefinitions)
		{
			throw Error.AmbiguousJump(_node.Name);
		}
		LabelScopeInfo labelScopeInfo2 = FirstDefinition();
		LabelScopeInfo labelScopeInfo3 = CommonNode(labelScopeInfo2, reference, (LabelScopeInfo b) => b.Parent);
		for (LabelScopeInfo labelScopeInfo4 = reference; labelScopeInfo4 != labelScopeInfo3; labelScopeInfo4 = labelScopeInfo4.Parent)
		{
			if (labelScopeInfo4.Kind == LabelScopeKind.Finally)
			{
				throw Error.ControlCannotLeaveFinally();
			}
			if (labelScopeInfo4.Kind == LabelScopeKind.Filter)
			{
				throw Error.ControlCannotLeaveFilterTest();
			}
		}
		for (LabelScopeInfo labelScopeInfo5 = labelScopeInfo2; labelScopeInfo5 != labelScopeInfo3; labelScopeInfo5 = labelScopeInfo5.Parent)
		{
			if (!labelScopeInfo5.CanJumpInto)
			{
				if (labelScopeInfo5.Kind == LabelScopeKind.Expression)
				{
					throw Error.ControlCannotEnterExpression();
				}
				throw Error.ControlCannotEnterTry();
			}
		}
	}

	internal void ValidateFinish()
	{
		if (_references.Count > 0 && !HasDefinitions)
		{
			throw Error.LabelTargetUndefined(_node.Name);
		}
	}

	private void EnsureLabel(LightCompiler compiler)
	{
		if (_label == null)
		{
			_label = compiler.Instructions.MakeLabel();
		}
	}

	private bool DefinedIn(LabelScopeInfo scope)
	{
		if (_definitions == scope)
		{
			return true;
		}
		if (_definitions is HashSet<LabelScopeInfo> hashSet)
		{
			return hashSet.Contains(scope);
		}
		return false;
	}

	private LabelScopeInfo FirstDefinition()
	{
		if (_definitions is LabelScopeInfo result)
		{
			return result;
		}
		using (HashSet<LabelScopeInfo>.Enumerator enumerator = ((HashSet<LabelScopeInfo>)_definitions).GetEnumerator())
		{
			if (enumerator.MoveNext())
			{
				return enumerator.Current;
			}
		}
		throw new InvalidOperationException();
	}

	private void AddDefinition(LabelScopeInfo scope)
	{
		if (_definitions == null)
		{
			_definitions = scope;
			return;
		}
		HashSet<LabelScopeInfo> hashSet = _definitions as HashSet<LabelScopeInfo>;
		if (hashSet == null)
		{
			HashSet<LabelScopeInfo> obj = new HashSet<LabelScopeInfo> { (LabelScopeInfo)_definitions };
			hashSet = obj;
			_definitions = obj;
		}
		hashSet.Add(scope);
	}

	internal static T CommonNode<T>(T first, T second, Func<T, T> parent) where T : class
	{
		EqualityComparer<T> equalityComparer = EqualityComparer<T>.Default;
		if (equalityComparer.Equals(first, second))
		{
			return first;
		}
		HashSet<T> hashSet = new HashSet<T>(equalityComparer);
		for (T val = first; val != null; val = parent(val))
		{
			hashSet.Add(val);
		}
		for (T val2 = second; val2 != null; val2 = parent(val2))
		{
			if (hashSet.Contains(val2))
			{
				return val2;
			}
		}
		return null;
	}
}
