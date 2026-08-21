using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("展示CastingShadow", 0)]
[Description("根据提供的参数设置场景中的投射阴影显示。")]
[Category("✫ DragonLost/Scene")]
public class ShowCastingShadowAction : ActionTaskBase
{
	[RequiredField]
	[Name("是否显示", 0)]
	[Description("设置为 true 则显示投射阴影，设置为 false 则隐藏投射阴影。")]
	public BBParameter<bool> isShow;

	[RequiredField]
	[Name("开始值", 0)]
	[Description("投射阴影的开始值。")]
	public BBParameter<float> fromValue = new BBParameter<float>(-1f);

	[RequiredField]
	[Name("结束值", 0)]
	[Description("投射阴影的结束值。")]
	public BBParameter<float> toValue = new BBParameter<float>(0f);

	[RequiredField]
	[Name("时间", 0)]
	[Description("渐变效果的持续时间。")]
	public BBParameter<float> duration = new BBParameter<float>(1f);

	[RequiredField]
	[Name("行为树结束是否恢复", 0)]
	[Description("指示行为树结束时是否恢复投射阴影的状态。")]
	public BBParameter<bool> isTreeStopRecover;

	private bool _recodeCastingState;

	private float _correctionStartValue;

	private float _correctionEndValue;

	private float _correctionValue = 1f;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (ownerEntity == null)
		{
			EndAction();
			return;
		}
		WorldBase world = ownerEntity.GetWorld();
		if (ownerEntity.Id != world.ActorId)
		{
			EndAction();
			return;
		}
		_correctionStartValue = fromValue.value + _correctionValue;
		_correctionEndValue = toValue.value + _correctionValue;
		ownerEntity.GetSystem<SceneSystem>()?.OpenCameraShadow(isShow.value, _correctionEndValue, duration.value);
		EndAction();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (ownerEntity != null && isTreeStopRecover.value)
		{
			ownerEntity.GetSystem<SceneSystem>()?.OpenCameraShadow(isOpen: false, _correctionStartValue, duration.value);
		}
	}
}
