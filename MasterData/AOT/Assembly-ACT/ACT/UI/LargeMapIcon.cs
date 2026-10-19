using UnityEngine;
using UnityEngine.Events;

namespace ACT.UI;

public class LargeMapIcon : MapIconBase
{
	public ActButton selectBtn;

	public GameObject isTrace;

	private UnityAction<LargeMapIcon> _clickAction;

	public Vector3 worldPos = Vector3.zero;

	public override void UnInit()
	{
		base.UnInit();
		UnbindClickAction();
		DeAccurateSelectEffect();
		DeVagueSelectEffect();
	}

	public void BindClickAction(UnityAction<LargeMapIcon> clickAction)
	{
		_clickAction = clickAction;
		selectBtn.OnClick.AddListener(ClickIcon);
	}

	public void UnbindClickAction()
	{
		selectBtn.OnClick.RemoveListener(ClickIcon);
	}

	private void ClickIcon()
	{
		_clickAction(this);
	}

	public virtual void AccurateSelectEffect()
	{
	}

	public virtual void DeAccurateSelectEffect()
	{
	}

	public virtual void VagueSelectEffect()
	{
	}

	public virtual void DeVagueSelectEffect()
	{
	}

	public override void SetIsTrack(bool isTrack)
	{
		base.SetIsTrack(isTrack);
		isTrace?.gameObject.SetActive(isTrack);
	}
}
