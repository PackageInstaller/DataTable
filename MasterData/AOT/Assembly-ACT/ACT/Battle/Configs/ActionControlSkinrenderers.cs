using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行控制Skinrenderers", "Action", new string[] { "control", "skinrenderers", "state", "status", "tag" })]
public class ActionControlSkinrenderers : ConfigAction
{
	public string[] array;

	public bool result;

	public override void Do(ActionMemory memory)
	{
		Renderer[] renderers = memory.target.entity.GetMono().renderers;
		string[] array = this.array;
		foreach (string text in array)
		{
			Renderer[] array2 = renderers;
			foreach (Renderer renderer in array2)
			{
				if (renderer.name == text)
				{
					renderer.enabled = result;
				}
			}
		}
	}
}
