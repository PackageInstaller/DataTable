using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class DrawCardTenViewModel : OptionBase
{
	private List<DrawCardItemViewModel> drawCardItemViewModels;

	private bool isSkip;

	private InteractionRequest playLightAnimationRequest;

	private InteractionRequest playConvertRequest;

	private InteractionRequest playLoadRequest;

	private InteractionRequest playAnimationRequest;

	private InteractionRequest playEnterRequest;

	private int index;

	private string animationName;

	private bool canClose;

	public bool IsSkip => isSkip;

	public List<DrawCardItemViewModel> DrawCardItemViewModels => drawCardItemViewModels;

	public InteractionRequest PlayLightAnimationRequest => playLightAnimationRequest;

	public InteractionRequest PlayLoadRequest => playLoadRequest;

	public InteractionRequest PlayConvertRequest => playConvertRequest;

	public InteractionRequest PlayAnimationRequest => playAnimationRequest;

	public InteractionRequest PlayEnterRequest => playEnterRequest;

	public int Index => index;

	public string AnimationName => animationName;

	public bool CanClose
	{
		get
		{
			return canClose;
		}
		private set
		{
			Set(ref canClose, value, "CanClose");
		}
	}

	public DrawCardTenViewModel(OptionBase parent, List<DrawCardItemViewModel> drawCardItemViewModels, bool isSkip)
	{
		base.parent = parent;
		this.drawCardItemViewModels = drawCardItemViewModels;
		playLightAnimationRequest = new InteractionRequest();
		playLoadRequest = new InteractionRequest();
		playConvertRequest = new InteractionRequest();
		playAnimationRequest = new InteractionRequest();
		playEnterRequest = new InteractionRequest();
		this.isSkip = isSkip;
		CanClose = false;
	}

	public void PlayAllLightAnimation()
	{
		playLightAnimationRequest.Raise();
	}

	public void PlayAllLoadAnimation()
	{
		playLoadRequest.Raise();
	}

	public void PlayAllConvertAnimation()
	{
		playConvertRequest.Raise();
		CanClose = true;
	}

	public void PlayEnterAnimation()
	{
		playAnimationRequest.Raise();
	}

	public void PlayAnimation(int index, string animationName)
	{
		this.index = index;
		this.animationName = animationName;
		playAnimationRequest.Raise();
	}

	public bool SetConvertImg(int itemIndex, int selectedIndex)
	{
		if (drawCardItemViewModels != null && drawCardItemViewModels.Count >= itemIndex)
		{
			return drawCardItemViewModels[itemIndex].SetConvertImgPath(selectedIndex);
		}
		return false;
	}

	public void OnShow()
	{
		parent.ItemOnClick("TenWindowShow");
	}

	public void PlayLight()
	{
		parent.ItemOnClick("PlayLight");
	}

	public override void Close()
	{
		if (CanClose)
		{
			parent?.ItemOnClick(this);
			base.Close();
		}
	}
}
