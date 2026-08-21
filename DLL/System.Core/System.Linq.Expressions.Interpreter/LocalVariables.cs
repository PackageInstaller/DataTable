using System.Collections.Generic;

namespace System.Linq.Expressions.Interpreter;

internal sealed class LocalVariables
{
	private sealed class VariableScope
	{
		public readonly int Start;

		public int Stop = int.MaxValue;

		public readonly LocalVariable Variable;

		public readonly VariableScope Parent;

		public List<VariableScope> ChildScopes;

		public VariableScope(LocalVariable variable, int start, VariableScope parent)
		{
			Variable = variable;
			Start = start;
			Parent = parent;
		}
	}

	private readonly HybridReferenceDictionary<ParameterExpression, VariableScope> _variables = new HybridReferenceDictionary<ParameterExpression, VariableScope>();

	private Dictionary<ParameterExpression, LocalVariable> _closureVariables;

	private int _localCount;

	private int _maxLocalCount;

	public int LocalCount => _maxLocalCount;

	internal Dictionary<ParameterExpression, LocalVariable> ClosureVariables => _closureVariables;

	public LocalDefinition DefineLocal(ParameterExpression variable, int start)
	{
		LocalVariable localVariable = new LocalVariable(_localCount++, closure: false);
		_maxLocalCount = Math.Max(_localCount, _maxLocalCount);
		VariableScope variableScope;
		if (_variables.TryGetValue(variable, out var value))
		{
			variableScope = new VariableScope(localVariable, start, value);
			if (value.ChildScopes == null)
			{
				value.ChildScopes = new List<VariableScope>();
			}
			value.ChildScopes.Add(variableScope);
		}
		else
		{
			variableScope = new VariableScope(localVariable, start, null);
		}
		_variables[variable] = variableScope;
		return new LocalDefinition(localVariable.Index, variable);
	}

	public void UndefineLocal(LocalDefinition definition, int end)
	{
		VariableScope variableScope = _variables[definition.Parameter];
		variableScope.Stop = end;
		if (variableScope.Parent != null)
		{
			_variables[definition.Parameter] = variableScope.Parent;
		}
		else
		{
			_variables.Remove(definition.Parameter);
		}
		_localCount--;
	}

	internal void Box(ParameterExpression variable, InstructionList instructions)
	{
		VariableScope variableScope = _variables[variable];
		LocalVariable variable2 = variableScope.Variable;
		_variables[variable].Variable.IsBoxed = true;
		int num = 0;
		for (int i = variableScope.Start; i < variableScope.Stop && i < instructions.Count; i++)
		{
			if (variableScope.ChildScopes != null && variableScope.ChildScopes[num].Start == i)
			{
				i = variableScope.ChildScopes[num].Stop;
				num++;
			}
			else
			{
				instructions.SwitchToBoxed(variable2.Index, i);
			}
		}
	}

	public bool TryGetLocalOrClosure(ParameterExpression var, out LocalVariable local)
	{
		if (_variables.TryGetValue(var, out var value))
		{
			local = value.Variable;
			return true;
		}
		if (_closureVariables != null && _closureVariables.TryGetValue(var, out local))
		{
			return true;
		}
		local = null;
		return false;
	}

	internal LocalVariable AddClosureVariable(ParameterExpression variable)
	{
		if (_closureVariables == null)
		{
			_closureVariables = new Dictionary<ParameterExpression, LocalVariable>();
		}
		LocalVariable localVariable = new LocalVariable(_closureVariables.Count, closure: true);
		_closureVariables.Add(variable, localVariable);
		return localVariable;
	}
}
