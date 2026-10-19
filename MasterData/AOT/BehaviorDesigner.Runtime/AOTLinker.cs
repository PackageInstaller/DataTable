using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

public class AOTLinker : MonoBehaviour
{
	public void Linker()
	{
		new BehaviorManager.BehaviorTree();
		new BehaviorManager.BehaviorTree.ConditionalReevaluate();
		new BehaviorManager.TaskAddData();
		new BehaviorManager.TaskAddData.OverrideFieldValue();
		new UnknownTask();
	}
}
