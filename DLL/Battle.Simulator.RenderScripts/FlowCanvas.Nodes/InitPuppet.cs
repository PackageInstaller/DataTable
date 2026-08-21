using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("初始化傀儡", 0)]
[Category("Render/Asset")]
[Description("初始化傀儡")]
public class InitPuppet : CallableActionNode<int>
{
	public override void Invoke(int hostID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(hostID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityPuppetHost)
		{
			NAgent agent = ((BattleScene)NScene.GetCurrentScene()).GetAgentManager().GetAgent(hostID);
			for (int i = 0; i < entityWithEntityID.entityPuppetHost.mPuppets.Count; i++)
			{
				((BattleScene)NScene.GetCurrentScene()).GetAgentManager().GetAgent(entityWithEntityID.entityPuppetHost.mPuppets[i]).GetComponent<Puppet>()
					.Initialize(agent);
			}
		}
	}
}
