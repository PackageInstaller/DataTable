using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("初始化傀儡(新)", 0)]
[Category("Render/Asset")]
[Description("初始化傀儡")]
public class InitPuppet2 : CallableActionNode<int>
{
	public override void Invoke(int puppetID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(puppetID);
		if (entityWithEntityID == null || !entityWithEntityID.hasEntityPuppet)
		{
			return;
		}
		NAgent agent = ((BattleScene)NScene.GetCurrentScene()).GetAgentManager().GetAgent(puppetID);
		NAgent agent2 = ((BattleScene)NScene.GetCurrentScene()).GetAgentManager().GetAgent(entityWithEntityID.entityPuppet.mParent);
		if (agent != null && agent2 != null)
		{
			Puppet component = agent.GetComponent<Puppet>();
			component.Initialize(agent2);
			ComponentPendant component2 = agent2.GetComponent<ComponentPendant>();
			if (component2 != null)
			{
				component2.AddPendant(component);
			}
		}
	}
}
