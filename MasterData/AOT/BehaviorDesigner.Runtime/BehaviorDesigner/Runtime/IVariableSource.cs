using System.Collections.Generic;

namespace BehaviorDesigner.Runtime;

public interface IVariableSource
{
	SharedVariable GetVariable(string name);

	List<SharedVariable> GetAllVariables();

	void SetVariable(string name, SharedVariable sharedVariable);

	void UpdateVariableName(SharedVariable sharedVariable, string name);

	void SetAllVariables(List<SharedVariable> variables);
}
