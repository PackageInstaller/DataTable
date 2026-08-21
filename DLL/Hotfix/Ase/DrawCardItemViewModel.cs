using GameFramework.Runtime;

namespace Ase;

public class DrawCardItemViewModel : OptionBase
{
	private DrawCardItemInfo drawCardItemInfo;

	private string convertImgPath;

	private InteractionRequest reLoadObjRequest;

	private bool isNew;

	private int index;

	public int Index => index;

	public DrawCardItemInfo DrawCardItemInfo => drawCardItemInfo;

	public InteractionRequest ReLoadObjRequest => reLoadObjRequest;

	public string ConvertImgPath
	{
		get
		{
			return convertImgPath;
		}
		private set
		{
			Set(ref convertImgPath, value, "ConvertImgPath");
		}
	}

	public bool IsNew
	{
		get
		{
			return isNew;
		}
		private set
		{
			Set(ref isNew, value, "IsNew");
		}
	}

	public DrawCardItemViewModel(OptionBase parent, DrawCardItemInfo drawCardItemInfo)
	{
		base.parent = parent;
		this.drawCardItemInfo = drawCardItemInfo;
		index = drawCardItemInfo.Rarity - 2;
		IsNew = drawCardItemInfo.IsNew;
		convertImgPath = drawCardItemInfo.ConvertImgPath;
		reLoadObjRequest = new InteractionRequest();
	}

	public void AnimationEndEvent(string eventName)
	{
		parent?.ItemOnClick(eventName);
	}

	public bool SetConvertImgPath(int index)
	{
		drawCardItemInfo.Id = drawCardItemInfo.ChooseIds[index];
		drawCardItemInfo.Type = drawCardItemInfo.ChooseTypes[index];
		IsNew = Singleton<ServiceSystem>.Instance.GetService<IDrawCardService>().ChooseResultAddCheckIsNew(drawCardItemInfo);
		if (!IsNew)
		{
			drawCardItemInfo.SetConvertImg();
		}
		drawCardItemInfo.SetLoadObj();
		ConvertImgPath = DrawCardItemInfo.ConvertImgPath;
		reLoadObjRequest.Raise();
		return IsNew;
	}
}
