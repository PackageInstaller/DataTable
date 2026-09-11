using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("遍历敌人阵营(Do可接Break)(逻辑)", 0)]
[Category("Logic/PosAndRot")]
[Description("遍历所有 Enemy 阵营的实体")]
public class ForeachEnemiesWithBreak : FlowControlNode
{
	private FlowOutput m_do;

	private FlowOutput m_done;

	private int m_entityID;

	private bool _break;

	protected override void RegisterPorts()
	{
		m_do = AddFlowOutput("Do", "do");
		m_done = AddFlowOutput("Done", "done");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			List<int> allEnemy = SpawnProcessor.GetAllEnemy(base.mSimContext);
			for (int num = allEnemy.Count - 1; num >= 0; num--)
			{
				m_entityID = allEnemy[num];
				m_do.Call(f);
				_break = false;
				f.breakCall = delegate
				{
					_break = true;
				};
				if (_break)
				{
					break;
				}
			}
			m_done.Call(f);
		});
		AddValueOutput("实体ID", "entityID", () => m_entityID);
	}
}
