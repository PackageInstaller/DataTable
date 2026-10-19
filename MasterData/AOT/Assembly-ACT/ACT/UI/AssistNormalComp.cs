using Bamboo.ECS;
using UnityEngine;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace ACT.UI;

public class AssistNormalComp : AssistComp
{
	[FormerlySerializedAs("image")]
	[SerializeField]
	private Image _image;

	[FormerlySerializedAs("animation")]
	[SerializeField]
	private BetterAnimation _animation;

	protected override void SetValOnInit()
	{
		_image.fillAmount = _data.assistPercent;
		if (Mathf.Approximately(_data.assistPercent, 1f))
		{
			_animation.GetSequence("Filled").Play().Complete();
		}
		else
		{
			_animation.GetSequence("NormalStatus").Play().Complete();
		}
	}

	protected override void SetVal(float val)
	{
		_image.fillAmount = val;
		if (Mathf.Approximately(val, 1f))
		{
			_animation.GetSequence("Filled").Play();
		}
		else if (Mathf.Approximately(val, 0f))
		{
			_animation.GetSequence("NormalStatus").Play();
		}
	}

	public override void OnCharacterChange(Entity entity)
	{
		float num = entity.GetCompAbility()?.AssistPercent ?? 0f;
		if (Mathf.Approximately(_data.assistPercent, num))
		{
			SetVal(num);
		}
		else
		{
			_data.UpdateAssistPercent(num);
		}
	}
}
