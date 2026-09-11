using Config;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("得到芯片技能常规CD配置(pure)", 0)]
[Category("Logic/芯片技能")]
[Description("得到芯片技能的配置冷却时长")]
public class GetMasterSkillComCDPure : PureFunctionNode<int, int>
{
	public override int Invoke(int aichipID)
	{
		if (ConfigHelper.GetInstance().TryGetConfig<ai_chip>(aichipID, out var config))
		{
			return config.CooldownCom * 1000;
		}
		Debug.LogError("=====>>>>> 未找到配置 " + aichipID);
		return 0;
	}
}
