using TrueSync;
using UnityEngine;

[AddComponentMenu("Game/Adventure/AreaEffect/AreaEffectComponents/区域效果组件_播放反馈效果")]
[RequireComponent(typeof(AreaEffectEntity))]
public class AreaEffect_PlayFeedbackEffectComponent : AreaEffect_Component
{
	public AdventurePlayerFeedbackEffectConfigureData feedbackEffectConfigureData;

	public FP delayTime = 0;

	private FP _delayTime;

	private bool _isPlayed;

	protected override bool ShowCheckTag => false;

	protected override void OnStartLogic()
	{
		base.OnStartLogic();
		_delayTime = 0;
		if (delayTime > 0)
		{
			_delayTime = delayTime;
			_isPlayed = false;
		}
		else
		{
			_context.PlayFeedbackEffect(feedbackEffectConfigureData);
			_delayTime = delayTime;
			_isPlayed = true;
		}
	}

	protected override void OnLogicUpdate(FP logicDeltaTime)
	{
		base.OnLogicUpdate(logicDeltaTime);
		if (_delayTime > 0)
		{
			_delayTime -= logicDeltaTime;
		}
		else if (!_isPlayed)
		{
			_context.PlayFeedbackEffect(feedbackEffectConfigureData);
			_isPlayed = true;
		}
	}
}
