using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.Video;

namespace Ase;

public class UIGuidanceViewModel : OptionBase
{
	private bool isVaild;

	private RectTransform guidanceTarget;

	private int guidanceType;

	private float delayTime;

	private Vector2 centerPosition;

	private Vector2 size;

	private Vector2 offset;

	private int tipType;

	private Vector2 tipPosition;

	private Vector2 fingerShifting;

	private int fingerDirection;

	private string tipCharacterName;

	private string tipCharacter;

	private string tipText;

	private bool videoClipOpen;

	private string videoClipName;

	private VideoClip videoClip;

	private string videoName;

	private float waitTime;

	private bool isFinish;

	private Color alpha;

	private int teachManualId;

	private int stepIndex;

	private bool openWindowEnable = true;

	private InteractionRequest onCharacterIconRequest;

	private InteractionRequest onVideoPlayRequest;

	private InteractionRequest onCloseRequest;

	public int StepId => stepIndex;

	public bool IsVaild => isVaild;

	public int GuidanceType
	{
		get
		{
			return guidanceType;
		}
		set
		{
			Set(ref guidanceType, value, "GuidanceType");
		}
	}

	public float DelayTime
	{
		get
		{
			return delayTime;
		}
		set
		{
			Set(ref delayTime, value, "DelayTime");
		}
	}

	public RectTransform GuidanceTarget
	{
		get
		{
			return guidanceTarget;
		}
		set
		{
			Set(ref guidanceTarget, value, "GuidanceTarget");
		}
	}

	public Vector2 CenterPosition
	{
		get
		{
			return centerPosition;
		}
		set
		{
			Set(ref centerPosition, value, "CenterPosition");
		}
	}

	public Vector2 Size
	{
		get
		{
			return size;
		}
		set
		{
			Set(ref size, value, "Size");
		}
	}

	public Vector2 Offset
	{
		get
		{
			return offset;
		}
		set
		{
			Set(ref offset, value, "Offset");
		}
	}

	public int TipType
	{
		get
		{
			return tipType;
		}
		set
		{
			Set(ref tipType, value, "TipType");
		}
	}

	public Vector2 TipPosition
	{
		get
		{
			return tipPosition;
		}
		set
		{
			Set(ref tipPosition, value, "TipPosition");
		}
	}

	public Vector2 FingerShifting
	{
		get
		{
			return fingerShifting;
		}
		set
		{
			Set(ref fingerShifting, value, "FingerShifting");
		}
	}

	public int FingerDirection
	{
		get
		{
			return fingerDirection;
		}
		set
		{
			Set(ref fingerDirection, value, "FingerDirection");
		}
	}

	public string TipCharacterName
	{
		get
		{
			return tipCharacterName;
		}
		set
		{
			Set(ref tipCharacterName, value, "TipCharacterName");
		}
	}

	public string TipCharacter
	{
		get
		{
			return tipCharacter;
		}
		set
		{
			Set(ref tipCharacter, value, "TipCharacter");
		}
	}

	public string TipText
	{
		get
		{
			return tipText;
		}
		set
		{
			Set(ref tipText, value, "TipText");
		}
	}

	public bool VideoClipOpen
	{
		get
		{
			return videoClipOpen;
		}
		set
		{
			Set(ref videoClipOpen, value, "VideoClipOpen");
		}
	}

	public string VideoClipName
	{
		get
		{
			return videoClipName;
		}
		set
		{
			Set(ref videoClipName, value, "VideoClipName");
		}
	}

	public VideoClip VideoClip
	{
		get
		{
			return videoClip;
		}
		set
		{
			Set(ref videoClip, value, "VideoClip");
		}
	}

	public string VideoName
	{
		get
		{
			return videoName;
		}
		set
		{
			Set(ref videoName, value, "VideoName");
		}
	}

	public float WaitTime
	{
		get
		{
			return waitTime;
		}
		set
		{
			Set(ref waitTime, value, "WaitTime");
		}
	}

	public Color Alpha
	{
		get
		{
			return alpha;
		}
		set
		{
			Set(ref alpha, value, "Alpha");
		}
	}

	public int TeachManualId
	{
		get
		{
			return teachManualId;
		}
		set
		{
			Set(ref teachManualId, value, "TeachManualId");
		}
	}

	public bool IsFinish
	{
		get
		{
			return isFinish;
		}
		set
		{
			Set(ref isFinish, value, "IsFinish");
		}
	}

	public IInteractionRequest OnCharacterIconRequest => onCharacterIconRequest;

	public IInteractionRequest OnVideoPlayRequest => onVideoPlayRequest;

	public IInteractionRequest OnCloseRequest => onCloseRequest;

	public UIGuidanceViewModel()
	{
	}

	public UIGuidanceViewModel(GuidanceManager.GuidanceStep guidanceStep)
	{
		isVaild = false;
		if (guidanceStep != null)
		{
			RectTransform targetUI = guidanceStep.GetTargetUI();
			if (targetUI != null)
			{
				GuidanceTarget = targetUI;
				CenterPosition = targetUI.position;
			}
			GuidanceType = guidanceStep.GuidanceType;
			DelayTime = guidanceStep.DelayTime;
			Size = guidanceStep.Size;
			Offset = guidanceStep.Offset;
			TipType = guidanceStep.TipType;
			TipPosition = guidanceStep.TipPosition;
			FingerShifting = guidanceStep.FingerShifting;
			FingerDirection = guidanceStep.FingerDirection;
			TipCharacterName = guidanceStep.TipCharacterName;
			TipCharacter = guidanceStep.TipCharacter;
			TipText = guidanceStep.TipText;
			VideoClipOpen = !string.IsNullOrEmpty(guidanceStep.VideoFileName);
			videoClipName = guidanceStep.VideoFileName;
			VideoClip = guidanceStep.VideoClip;
			VideoName = guidanceStep.VideoName;
			WaitTime = guidanceStep.WaitTime;
			Alpha = (guidanceStep.Alpha ? new Color(0f, 0f, 0f, 0f) : new Color(0f, 0f, 0f, 0.698f));
			TeachManualId = guidanceStep.TeachManualId;
			stepIndex = guidanceStep.StepID;
			IsFinish = false;
			isVaild = true;
			onCharacterIconRequest = new InteractionRequest();
			onVideoPlayRequest = new InteractionRequest();
			onCloseRequest = new InteractionRequest();
		}
	}

	public UIGuidanceViewModel(GuidanceManager.LevelGuidanceStep guidanceStep)
	{
		isVaild = false;
		if (guidanceStep != null)
		{
			RectTransform targetUI = guidanceStep.GetTargetUI();
			if ((bool)targetUI)
			{
				GuidanceTarget = targetUI;
				CenterPosition = targetUI.position;
			}
			GuidanceType = guidanceStep.GuidanceType;
			DelayTime = 0f;
			Size = guidanceStep.Size;
			Offset = guidanceStep.Offset;
			TipType = guidanceStep.TipType;
			TipPosition = guidanceStep.TipPosition;
			FingerShifting = guidanceStep.FingerShifting;
			FingerDirection = guidanceStep.FingerDirection;
			TipCharacterName = guidanceStep.TipCharacterName;
			TipCharacter = guidanceStep.TipCharacter;
			TipText = guidanceStep.TipText;
			VideoClipOpen = !string.IsNullOrEmpty(guidanceStep.VideoFileName);
			videoClipName = guidanceStep.VideoFileName;
			VideoClip = guidanceStep.VideoClip;
			VideoName = guidanceStep.VideoName;
			WaitTime = guidanceStep.WaitTime;
			Alpha = (guidanceStep.Alpha ? new Color(0f, 0f, 0f, 0f) : new Color(0f, 0f, 0f, 0.698f));
			TeachManualId = 0;
			IsFinish = false;
			isVaild = true;
			onCharacterIconRequest = new InteractionRequest();
			onVideoPlayRequest = new InteractionRequest();
			onCloseRequest = new InteractionRequest();
		}
	}

	public async void OnShowTip()
	{
		if (DelayTime > 0f)
		{
			await new WaitForSecondsRealtime(DelayTime);
			DelayTime = 0f;
		}
		if (onCharacterIconRequest != null)
		{
			onCharacterIconRequest.Raise();
		}
		if (onVideoPlayRequest != null && VideoClipOpen)
		{
			onVideoPlayRequest.Raise();
		}
		if (WaitTime > 0f)
		{
			await new WaitForSecondsRealtime(WaitTime);
			WaitTime = 0f;
		}
	}

	public void OpenTeachingPageWindow()
	{
		if (!openWindowEnable || TeachManualId <= 0)
		{
			return;
		}
		DRManual dataRow = GameEntry.DataTable.GetDataRow<DRManual>(TeachManualId);
		if (dataRow != null)
		{
			openWindowEnable = false;
			TeachingManualPageViewModel teachingManualPageViewModel = new TeachingManualPageViewModel(this, new TeachingPoint(dataRow));
			openWindowRequest.Raise(new OpenViewArg(typeof(TeachingManualPageWindow), teachingManualPageViewModel, "UIGuidance", isOpenWindow: true, "GUIDE"), delegate
			{
				IsFinish = true;
				openWindowEnable = true;
			});
			Singleton<GuidanceManager>.Instance.AddGuidanceWindowData(teachingManualPageViewModel);
			Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.SetManualOpenState(TeachManualId);
		}
	}

	public new void Close()
	{
		if (onCloseRequest != null)
		{
			onCloseRequest.Raise();
		}
	}
}
