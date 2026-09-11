using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取当前敌人列表", 0)]
[Category("Logic/Spawn")]
[Description("获取当前怪物列表")]
public class GetMonsters : CallableFunctionNode<List<int>>
{
	public override List<int> Invoke()
	{
		return SpawnProcessor.GetAllEnemy();
	}
}
