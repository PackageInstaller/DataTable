using Ase.ECS;
using Cysharp.Threading.Tasks;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase;

[Name("打开交互物Shader插值过渡", 0)]
[Description("根据指定的状态打开或关闭交互物体的Shader插值过渡效果。")]
[Category("✫ DragonLost/Interactive")]
public class ChangeInteractiveOccluing : ActionTaskBase
{
	[Name("溶解状态", 0)]
	[Description("指示是否要打开（true）或关闭（false）交互物体的过渡效果。")]
	public bool occluding = true;

	[Name("初始值", 0)]
	[Description("初始值。")]
	public BBParameter<float> m_fadeFrom = 1f;

	[Name("目标值", 0)]
	[Description("目标值。")]
	public BBParameter<float> m_fadeTo = 0f;

	[Name("变化速度", 0)]
	[Description("透明度变化的速度。（速度等于0的时候 不进行插值 直接设置成【目标值】）")]
	public BBParameter<float> m_alphaChangeSpeed = 3f;

	[Name("Shader变量名称", 0)]
	[Description("用于控制效果的Shader变量名称。")]
	public string m_shaderVariableName = "_Alpha";

	protected override async void OnExecute()
	{
		base.OnExecute();
		if (GetOwnerEntity().IsInteractiveEntity)
		{
			InteractiveView view = GetOwnerEntity().GetComponent<EntityViewComponent>().EntityView as InteractiveView;
			if (view != null)
			{
				if (m_alphaChangeSpeed.value == 0f)
				{
					view.SetOccludingValue(m_fadeTo.value, m_shaderVariableName);
				}
				else
				{
					view.SetOccluding(occluding, m_fadeFrom.value, m_fadeTo.value, m_alphaChangeSpeed.value, m_shaderVariableName);
					await UniTask.WaitUntil(() => view == null || !view.GetOccludingState());
				}
				OnActionFinish();
			}
		}
		OnActionFinish();
	}
}
