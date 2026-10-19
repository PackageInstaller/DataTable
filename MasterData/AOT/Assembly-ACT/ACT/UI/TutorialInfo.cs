using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using Bamboo.Collections;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem.DualShock;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class TutorialInfo : UIBehaviour
{
	public GraphicGuideView view;

	[SerializeReference]
	private GameObject imageRoot;

	public BImage curShowImage;

	[SerializeReference]
	private GameObject videoRoot;

	[SerializeReference]
	private VideoPlayerRawImage videoImage;

	public LocalizeStringEvent titleLocalize;

	public LocalizeStringEvent describeLocalize;

	public ActIndexGroup indexGroup;

	public Button preBtn;

	public Button nextBtn;

	public RedDotItem btnRedDot;

	public TutorialReward rewardTip;

	public ScrollRect scrollRect;

	private TutorialModel.TutorialData tutorialData;

	private int indexInCurShowData = -1;

	private int curTutorialId;

	private TutorialMediaType _mediaType;

	private GuideTutorial guideTutorialData;

	private List<int> _imageIdList = new List<int>();

	private BList<int> _shortVideoIds;

	private List<int> _describeIdList = new List<int>();

	private Dictionary<string, object> _tmpVariables;

	private int lastIndex;

	private int curIndex = -1;

	private const int invalidIndex = -1;

	private bool _isPc => MonoECS.instance.ispc;

	public int curInfoIndex => curIndex;

	public int lastInfoIndex => lastIndex;

	protected override void Awake()
	{
		_tmpVariables = DictionaryPool<string, object>.Get();
	}

	protected override void OnDestroy()
	{
		DictionaryPool<string, object>.Release(_tmpVariables);
	}

	public void Init(TutorialModel.TutorialData tutorialData)
	{
		if (curTutorialId == tutorialData.id)
		{
			return;
		}
		curTutorialId = tutorialData.id;
		this.tutorialData = tutorialData;
		indexInCurShowData = view.GetIndexByTutorialData(tutorialData);
		_imageIdList.Clear();
		_describeIdList.Clear();
		imageRoot.SetActive(value: false);
		videoRoot.SetActive(value: false);
		guideTutorialData = CoreUtils.GetData(tutorialData.id, RuntimeConfigs.data.guideTutorials);
		_mediaType = (TutorialMediaType)guideTutorialData.multimediaType;
		DeviceInputMode inputMode = MonoECS.instance.InputMode;
		int[] array = null;
		int[] array2 = null;
		switch (inputMode)
		{
		case DeviceInputMode.TouchScreen:
			array = guideTutorialData.pictureid;
			array2 = guideTutorialData.tutorialDesc;
			break;
		case DeviceInputMode.Gamepad:
			array = guideTutorialData.pictureidHandy;
			array2 = guideTutorialData.tutorialDescHandy;
			break;
		case DeviceInputMode.KeyboardAndMouse:
			array = guideTutorialData.pictureidPC;
			array2 = guideTutorialData.tutorialDescPC;
			break;
		}
		if ((array == null || array2 == null) && LuminApplication.LogEnabled)
		{
			Debug.LogError("百科手册表出问题了");
			return;
		}
		int[] array3;
		if (_mediaType == TutorialMediaType.Image)
		{
			imageRoot.SetActive(value: true);
			array3 = array;
			foreach (int item in array3)
			{
				_imageIdList.Add(item);
			}
		}
		else if (_mediaType == TutorialMediaType.Video)
		{
			videoRoot.SetActive(value: true);
			_shortVideoIds = BListPool<int>.Default.Get();
			array3 = array;
			foreach (int item2 in array3)
			{
				_shortVideoIds.Add(item2);
			}
		}
		array3 = array2;
		foreach (int item3 in array3)
		{
			_describeIdList.Add(item3);
		}
		titleLocalize.StringReference.TableEntryReference = guideTutorialData.tutorialTitle;
		lastIndex = array.Length - 1;
		curIndex = 0;
		btnRedDot.gameObject.SetActive(tutorialData.UnRead());
		indexGroup.Init(lastIndex + 1);
		SetToIndex(curIndex);
	}

	public void UnInit()
	{
		curTutorialId = -1;
		tutorialData = null;
		curIndex = -1;
		BListPool<int>.Default.Recycle(_shortVideoIds);
		_shortVideoIds = null;
	}

	private void SetToIndex(int index)
	{
		if (index >= 0 && index <= lastIndex)
		{
			curIndex = index;
			RefreshDescribe();
			if (_mediaType == TutorialMediaType.Image)
			{
				view.Station.LoadImage(101, _imageIdList[index], curShowImage);
			}
			else if (_mediaType == TutorialMediaType.Video)
			{
				videoImage.PlayVideo(_shortVideoIds[index]);
			}
			indexGroup.SetToIndex(index);
			preBtn.interactable = curIndex > 0;
			nextBtn.interactable = curIndex < lastIndex;
			view.SetTutorialInfoBtnPromptActive(curIndex, lastIndex);
			if (curIndex == lastIndex && tutorialData.UnRead())
			{
				btnRedDot.gameObject.SetActive(value: false);
				Model<TutorialModel>.Interface.ReadTutorialLocal(tutorialData.id);
				view.UpdateCurShowTutorialData(tutorialData.id, TimeManager.ServerTime.NowTimestampSecond);
			}
		}
	}

	public void SetToNextIndex()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Database/Click_2");
		if (curIndex != -1 && curIndex + 1 <= lastIndex)
		{
			SetToIndex(curIndex + 1);
		}
	}

	public void SetToPreIndex()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Database/Click_2");
		if (curIndex != -1 && curIndex - 1 >= 0)
		{
			SetToIndex(curIndex - 1);
		}
	}

	public void RefreshDescribe()
	{
		_tmpVariables.Clear();
		GuideTutorialDes data = CoreUtils.GetData(_describeIdList[curIndex], RuntimeConfigs.data.guideTutorialDess);
		if (data == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"{_describeIdList[curIndex]}在教程描述表里找不到");
			}
			return;
		}
		describeLocalize.StringReference.TableEntryReference = 0L;
		for (int i = 0; i < data.actionPrompt.Length; i++)
		{
			string bindingAction = data.actionPrompt[i];
			if (MonoECS.instance.GetInputDeviceButtonBindingKeyName(bindingAction, out var bindingKeyName))
			{
				if (!string.IsNullOrEmpty(bindingKeyName))
				{
					bindingKeyName = bindingKeyName.Replace("/", "_");
					if (MonoECS.instance.GetPromptIconDevice() is DualShockGamepad)
					{
						bindingKeyName = bindingKeyName.Replace("gamepad", "gamepad_sony");
					}
					_tmpVariables[i.FastToString()] = bindingKeyName;
				}
				else if (!LuminApplication.LogEnabled)
				{
				}
			}
			else
			{
				_ = LuminApplication.LogEnabled;
			}
		}
		describeLocalize.SetTable("longcommon");
		if (_tmpVariables.Count > 0)
		{
			Model<GuideTipModel>.Interface.SetVariables(describeLocalize, _tmpVariables);
		}
		describeLocalize.StringReference.TableEntryReference = data.tutorialTitle;
	}
}
