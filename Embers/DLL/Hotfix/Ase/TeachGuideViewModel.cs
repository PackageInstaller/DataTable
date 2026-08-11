using System;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class TeachGuideViewModel : OptionBase
{
	private int guidanceType;

	private Vector2 centerPosition;

	private Vector2 size;

	private Vector2 offset;

	public DRTeaching TeachConfig;

	public string VideoURL;

	public string VideoName;

	private string showImageName;

	private string showDesContent;

	private string showTitleContent;

	private string frameText;

	public Transform FrameTrans;

	public float DelayShowTime;

	public Action<int, bool> ShowSkillBtnAction;

	public Action<int, float> CloseTeachGuideAction;

	public Action GamePause;

	public Action GameResume;

	public Func<int, Vector3> GetTargetPosAction;

	public bool IsPause;

	private bool isSaveData;

	private bool canSaveData;

	public bool PlayBlackScreenBlend;

	private Action uiShowAction;

	private InteractionRequest titlePlayAn;

	private InteractionRequest desPlayAn;

	private InteractionRequest closeUIRequest;

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

	public string ShowImageName
	{
		get
		{
			return showImageName;
		}
		set
		{
			Set(ref showImageName, value, "ShowImageName");
		}
	}

	public string ShowDesContent
	{
		get
		{
			return showDesContent;
		}
		set
		{
			Set(ref showDesContent, value, "ShowDesContent");
		}
	}

	public string ShowTitleContent
	{
		get
		{
			return showTitleContent;
		}
		set
		{
			Set(ref showTitleContent, value, "ShowTitleContent");
		}
	}

	public string FrameText
	{
		get
		{
			return frameText;
		}
		set
		{
			Set(ref frameText, value, "FrameText");
		}
	}

	public InteractionRequest TitlePlayAnRequest => titlePlayAn;

	public InteractionRequest DesPlayAnRequest => desPlayAn;

	public InteractionRequest CloseUIRequest => closeUIRequest;

	public TeachGuideViewModel(int guideId, Transform frameTrans, Action showAction)
	{
		DRTeaching dataRow = GameEntry.DataTable.GetDataRow<DRTeaching>(guideId);
		if (dataRow != null)
		{
			TeachConfig = dataRow;
			GuidanceType = dataRow.TeachingType;
			size = dataRow.FrameSize.ToVector2();
			offset = dataRow.FrameShifting.ToVector2();
			FrameText = dataRow.FrameText;
			FrameTrans = frameTrans;
			canSaveData = dataRow.SaveData;
			titlePlayAn = new InteractionRequest(this);
			desPlayAn = new InteractionRequest(this);
			closeUIRequest = new InteractionRequest(this);
			uiShowAction = showAction;
		}
	}

	public void ShowAction()
	{
		uiShowAction?.Invoke();
	}

	public void ChangePage(int page, string lastVideo, string lastImage)
	{
		string text = string.Empty;
		string text2 = string.Empty;
		if (VideoURL == string.Empty && showImageName == string.Empty)
		{
			PlayBlackScreenBlend = true;
		}
		if (TeachConfig.PopupConfigure[page - 1] == 1)
		{
			VideoURL = string.Empty;
			VideoName = string.Empty;
			switch (page)
			{
			case 1:
				ShowImageName = TeachConfig.PopupPicture1;
				text = TeachConfig.PopupText1;
				text2 = TeachConfig.PopupTitle1;
				break;
			case 2:
				ShowImageName = TeachConfig.PopupPicture2;
				text = TeachConfig.PopupText2;
				text2 = TeachConfig.PopupTitle2;
				break;
			case 3:
				ShowImageName = TeachConfig.PopupPicture3;
				text = TeachConfig.PopupText3;
				text2 = TeachConfig.PopupTitle3;
				break;
			}
		}
		else if (TeachConfig.PopupConfigure[page - 1] == 2)
		{
			ShowImageName = string.Empty;
			switch (page)
			{
			case 1:
				VideoURL = GetVideoURL(TeachConfig.PopupVideo1);
				VideoName = TeachConfig.PopupVideo1;
				text = TeachConfig.PopupText1;
				text2 = TeachConfig.PopupTitle1;
				break;
			case 2:
				VideoURL = GetVideoURL(TeachConfig.PopupVideo2);
				VideoName = TeachConfig.PopupVideo2;
				text = TeachConfig.PopupText2;
				text2 = TeachConfig.PopupTitle2;
				break;
			case 3:
				VideoURL = GetVideoURL(TeachConfig.PopupVideo3);
				VideoName = TeachConfig.PopupVideo3;
				text = TeachConfig.PopupText3;
				text2 = TeachConfig.PopupTitle3;
				break;
			}
		}
		bool num = showDesContent != string.Empty && showDesContent != text;
		ShowDesContent = text;
		if (num)
		{
			desPlayAn.Raise();
		}
		bool num2 = showTitleContent != string.Empty && showTitleContent != text2;
		ShowTitleContent = text2;
		if (num2)
		{
			titlePlayAn.Raise();
		}
		PlayBlackScreenBlend = false;
		if (VideoURL != string.Empty && lastVideo != VideoURL)
		{
			PlayBlackScreenBlend = true;
		}
		if (ShowImageName != string.Empty && ShowImageName != lastImage)
		{
			PlayBlackScreenBlend = true;
		}
	}

	public void ReResume()
	{
		if (IsPause)
		{
			GameResume?.Invoke();
			IsPause = false;
		}
	}

	public void SaveTeachGuide()
	{
		if (canSaveData && !isSaveData)
		{
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().TeachGuideDataChangeSave(TeachConfig.Id, isAdd: true);
			isSaveData = true;
		}
	}

	private string GetVideoURL(string videoFileName)
	{
		return Application.streamingAssetsPath + "/" + ("video/" + videoFileName + ".mp4").Replace("\\", "/");
	}

	public void CloseUI()
	{
		closeUIRequest.Raise();
	}

	public Vector3 GetFrameEntityPos(int type)
	{
		return GetTargetPosAction(type);
	}

	public override void Close()
	{
		ReResume();
		base.Close();
	}
}
