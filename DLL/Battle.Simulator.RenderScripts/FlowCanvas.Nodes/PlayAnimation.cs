using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("播放某个动画", 0)]
[Category("Render/Asset")]
[Description("逻辑结束之后,由表现自己控制播放哪个动画")]
public class PlayAnimation : CallableActionNode<string>
{
	public override void Invoke(string animationName)
	{
		Animator component = (NScene.GetCurrentScene() as BattleScene).GetPlayerAgent().gameObject.GetComponent<Animator>();
		if (component != null)
		{
			component.Play(animationName);
		}
	}
}
