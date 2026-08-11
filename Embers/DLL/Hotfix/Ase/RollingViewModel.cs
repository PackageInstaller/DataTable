using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class RollingViewModel : OptionBase
{
	private int index;

	private string imagePath;

	private List<string> imageList;

	private List<TabItemNormalData> pointList;

	private TabItemNormalData curPoint;

	private Timer timer;

	private float durationTimeConfig;

	private float durationTime;

	private bool canSlider;

	private InteractionRequest refreshImgRequest;

	private int type;

	private int loadType;

	private float scale;

	private string assetTag;

	public string ImagePath
	{
		get
		{
			return imagePath;
		}
		set
		{
			Set(ref imagePath, value, "ImagePath");
		}
	}

	public List<TabItemNormalData> PointList => pointList;

	public int Index => index;

	public InteractionRequest RefreshImgRequest => refreshImgRequest;

	public int Type => type;

	public int LoadType => loadType;

	public List<string> ImageList => imageList;

	public bool CanSlider => canSlider;

	public float Scale => scale;

	public string AssetTag => assetTag;

	public RollingViewModel(OptionBase parent, List<string> imagePathList, int type, int loadType = 1, int defaultIndex = 0, float scale = 1f, string assetTag = "")
	{
		base.parent = parent;
		refreshImgRequest = new InteractionRequest();
		imageList = imagePathList;
		this.type = type;
		this.loadType = loadType;
		this.scale = scale;
		this.assetTag = assetTag;
		pointList = new List<TabItemNormalData>();
		for (int i = 0; i < imageList.Count; i++)
		{
			pointList.Add(new TabItemNormalData(this, "empty"));
		}
		index = defaultIndex;
		canSlider = true;
		SwitchPoint();
	}

	private void SwitchPoint()
	{
		curPoint?.SetSelected(value: false);
		if (pointList.Count > index)
		{
			curPoint = pointList[index];
			curPoint.SetSelected(value: true);
		}
		if (imageList.Count > index)
		{
			ImagePath = imageList[index];
		}
		refreshImgRequest.Raise();
		parent?.ItemOnClick(this);
	}

	public void SetCanSlider(bool value)
	{
		canSlider = value;
	}

	public void Left()
	{
		durationTime = durationTimeConfig;
		index = ((index - 1 < 0) ? (imageList.Count - 1) : (index - 1));
		SwitchPoint();
	}

	public void Right()
	{
		durationTime = durationTimeConfig;
		index = ((index + 1 < imageList.Count) ? (index + 1) : 0);
		SwitchPoint();
	}

	public void SetConfig(float durationTime)
	{
		durationTimeConfig = durationTime;
		this.durationTime = durationTime;
	}

	public void StartTimer()
	{
		timer = Timer.Register(0.5f, Rolling, null, isLooped: true, useRealTime: true);
	}

	private void Rolling()
	{
		if (durationTime <= 0f)
		{
			Right();
		}
		else
		{
			durationTime -= 0.5f;
		}
	}

	public override void Close()
	{
		CancelTimer();
		base.Close();
	}

	private void CancelTimer()
	{
		Timer.Cancel(timer);
		timer = null;
	}
}
