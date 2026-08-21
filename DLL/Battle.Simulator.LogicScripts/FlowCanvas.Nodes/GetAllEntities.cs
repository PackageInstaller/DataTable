using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取所有的Entity(不要用)", 0)]
[Category("Logic/Abilities")]
[Description("获取所有的Entity")]
public class GetAllEntities : PureFunctionNode<List<int>, List<int>>
{
	public override List<int> Invoke(List<int> a)
	{
		a.Clear();
		SimEntity[] entities = base.parentNode.mSimContext.GetEntities();
		for (int i = 0; i < entities.Length; i++)
		{
			a.Add(entities[i].creationIndex);
		}
		return a;
	}
}
