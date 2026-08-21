using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("后处理特殊效果：黑白闪", 0)]
[Category("✫ DragonLost/Effect")]
[Description("播放后处理黑白闪效果，同一玩家视角内只保留一个生效实例。")]
public class PlayMonochromeFlashPostProcess : ActionTaskBase
{
	[Name("延迟时间", 0)]
	[Description("对应预制体粒子的 Start Delay。")]
	public BBParameter<float> Delay = 0f;

	[Name("持续时间", 0)]
	[Description("对应预制体粒子的 Start Lifetime。")]
	public BBParameter<float> Lifetime = 0.267f;

	[Name("是否使用自定义曲线", 0)]
	[Description("开启后使用自定义曲线替换默认曲线。")]
	public bool UseCustomCurve;

	[Name("曲线（>0.5为白）", 0)]
	[ShowIf("UseCustomCurve", true)]
	[Description("对应预制体粒子 Custom Data 参数 W 的曲线。")]
	public BBParameter<AnimationCurve> Curve = new BBParameter<AnimationCurve>();

	[Name("是否使用自定义颜色", 0)]
	[Description("开启后使用自定义颜色替换默认白色。")]
	public bool UseCustomColor;

	[Name("颜色（替换白色）", 0)]
	[ShowIf("UseCustomColor", true)]
	[Description("对应预制体粒子 shader 参数 Base Color。")]
	public BBParameter<Color> Color = UnityEngine.Color.white;

	[Name("是否影响其他玩家", 0)]
	[Description("默认 false，false 时本次效果仅播放者自己可见。")]
	public bool AffectOtherPlayers;

	[Name("是否为所有玩家播放", 0)]
	[Description("默认 false，true 时为所有玩家播放。")]
	[ShowIf("AffectOtherPlayers", true)]
	public bool PlayForAllPlayers;

	[Name("玩家列表", 0)]
	[Description("本次效果只影响这个列表内的玩家角色。")]
	[ShowIf("PlayForAllPlayers", false)]
	public BBParameter<List<int>> PlayerList = new BBParameter<List<int>>();

	protected override bool IsDisplayNode => true;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (ownerEntity == null)
		{
			OnActionFinish();
			return;
		}
		if (!CanPlayForLocalActor())
		{
			OnActionFinish();
			return;
		}
		PostProcessEffectSystem system = ownerEntity.GetSystem<PostProcessEffectSystem>();
		if (system == null)
		{
			OnActionFinish();
			return;
		}
		system.PlayMonochromeFlash(new MonochromeFlashPostProcessData
		{
			Delay = Delay.value,
			Lifetime = Lifetime.value,
			UseCustomCurve = UseCustomCurve,
			Curve = Curve.value,
			UseCustomColor = UseCustomColor,
			Color = Color.value
		});
		OnActionFinish();
	}

	private bool CanPlayForLocalActor()
	{
		int actorId = ownerEntity.GetWorld().ActorId;
		if (!AffectOtherPlayers)
		{
			return ownerEntity.Id == actorId;
		}
		if (PlayForAllPlayers)
		{
			return true;
		}
		if (PlayerList.value != null)
		{
			return PlayerList.value.Contains(actorId);
		}
		return false;
	}
}
