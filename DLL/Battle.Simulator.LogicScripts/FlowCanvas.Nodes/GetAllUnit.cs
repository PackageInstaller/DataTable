using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取所有的单位", 0)]
[Category("Logic/Abilities")]
[Description("获取所有的单位(玩家，队友和敌人)")]
public class GetAllUnit : PureFunctionNode<List<int>, List<int>>
{
	public override List<int> Invoke(List<int> a)
	{
		if (a == null)
		{
			return null;
		}
		a.Clear();
		GetAllUnits(base.parentNode.mSimContext, a);
		return a;
	}

	public static void GetAllUnits(SimContext simContext, List<int> units)
	{
		Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = CommonProcessor.GetWorldState().mRoomMembers.GetEnumerator();
		while (enumerator.MoveNext())
		{
			if (simContext.GetEntityWithEntityID(enumerator.Current.Value.mEntityID) != null)
			{
				units.Add(enumerator.Current.Value.mEntityID);
			}
		}
		List<int> allEnemy = SpawnProcessor.GetAllEnemy(simContext);
		for (int i = 0; i < allEnemy.Count; i++)
		{
			units.Add(allEnemy[i]);
		}
	}
}
