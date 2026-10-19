using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行显示轨迹特效", "Action", new string[] { "show", "trajectory", "effect", "fx", "particle" })]
public class ActionShowTrajectoryEffect : ConfigAction
{
	public bool isShow;

	public override void Do(ActionMemory memory)
	{
		GameObject gameObject = memory.target.entity.GetCompBehave().behaveHandle.AsGameObject();
		if (gameObject != null)
		{
			gameObject.SetActive(isShow);
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"角色{memory.caster}的子弹{memory.target.entity}还没加载出来就设置隐藏？检查下配置");
		}
	}
}
