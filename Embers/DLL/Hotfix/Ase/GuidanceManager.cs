#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;
using UnityEngine.Video;

namespace Ase;

public class GuidanceManager : Singleton<GuidanceManager>, ISingletonUpdate
{
	public class GuidanceStep
	{
		private DRGuidanceStep drGuidanceStep;

		private bool isVaild;

		private int guidanceType;

		private float delayTime;

		private bool isCheckTop;

		private string targetUIFullKey;

		private string childPath;

		private bool checkChild;

		private int childIndex;

		private Vector2 size;

		private Vector2 offset;

		private int tipType;

		private Vector2 tipPosition;

		private Vector2 fingerShifting;

		private int fingerDirection;

		private string tipCharacterName;

		private string tipCharacter;

		private string tipText;

		private VideoClip videoClip;

		private string videoFileName;

		private string videoName;

		private float waitTime;

		private bool alpha;

		private int teachManualId;

		private int stepId;

		public bool IsVaild => isVaild;

		public int GuidanceType => guidanceType;

		public float DelayTime => delayTime;

		public bool IsCheckTop => isCheckTop;

		public string TargetUIFullKey => targetUIFullKey;

		public string ChildPath => childPath;

		public bool CheckChild => checkChild;

		public int ChildIndex => childIndex;

		public Vector2 Size => size;

		public Vector2 Offset => offset;

		public int TipType => tipType;

		public Vector2 TipPosition => tipPosition;

		public Vector2 FingerShifting => fingerShifting;

		public int FingerDirection => fingerDirection;

		public string TipCharacterName => tipCharacterName;

		public string TipCharacter => tipCharacter;

		public string TipText => tipText;

		public VideoClip VideoClip => videoClip;

		public string VideoFileName => videoFileName;

		public string VideoName => videoName;

		public float WaitTime => waitTime;

		public bool Alpha => alpha;

		public int TeachManualId => teachManualId;

		public int StepID => stepId;

		public GuidanceStep(DRGuidanceStep drGuidanceStep)
		{
			this.drGuidanceStep = drGuidanceStep;
			isVaild = this.drGuidanceStep != null;
			guidanceType = this.drGuidanceStep.GuidanceType;
			delayTime = this.drGuidanceStep.DelayTime;
			isCheckTop = this.drGuidanceStep.IsCheck;
			string[] array = this.drGuidanceStep.UIKey.Split('|');
			targetUIFullKey = (string.IsNullOrEmpty(this.drGuidanceStep.WindowName) ? string.Empty : (this.drGuidanceStep.WindowName + "-" + array[0]));
			if (array.Length > 1)
			{
				childPath = array[1];
			}
			else
			{
				childPath = string.Empty;
			}
			checkChild = this.drGuidanceStep.CheckChild;
			childIndex = this.drGuidanceStep.ChildIndex;
			size = this.drGuidanceStep.WindowSize.ToVector2();
			offset = this.drGuidanceStep.WindowShifting.ToVector2();
			tipType = this.drGuidanceStep.TipType;
			tipPosition = this.drGuidanceStep.TipPosition.ToVector2();
			fingerShifting = this.drGuidanceStep.FingerShifting.ToVector2();
			fingerDirection = this.drGuidanceStep.FingerDirection;
			tipCharacterName = this.drGuidanceStep.TipCharacterName;
			tipCharacter = this.drGuidanceStep.TipCharacter;
			tipText = this.drGuidanceStep.TipText;
			videoClip = null;
			videoFileName = this.drGuidanceStep.VideoClip;
			videoName = this.drGuidanceStep.VideoName;
			waitTime = this.drGuidanceStep.WaitTime;
			alpha = this.drGuidanceStep.Alpha;
			teachManualId = this.drGuidanceStep.ManualId;
			stepId = this.drGuidanceStep.Id;
		}

		public async Task LoadClip()
		{
		}

		public RectTransform GetTargetUI()
		{
			if (!UIWindowHelper.UIControls.TryGetValue(TargetUIFullKey, out var value) || value == null)
			{
				return null;
			}
			if (!CheckChild)
			{
				if (!string.IsNullOrEmpty(ChildPath))
				{
					return value.Find(ChildPath).GetComponent<RectTransform>();
				}
				return value;
			}
			if (value.childCount <= ChildIndex || ChildIndex < 0)
			{
				return null;
			}
			value = (RectTransform)value.GetChild(ChildIndex);
			if (!string.IsNullOrEmpty(ChildPath))
			{
				value = value.Find(ChildPath).GetComponent<RectTransform>();
			}
			if (!value.TryGetComponent<Selectable>(out var component))
			{
				component = value.GetComponentInChildren<Selectable>();
				if (component != null)
				{
					value = (RectTransform)component.transform;
				}
			}
			return value;
		}

		public bool Check()
		{
			if (string.IsNullOrEmpty(TargetUIFullKey))
			{
				return true;
			}
			RectTransform targetUI = GetTargetUI();
			if (targetUI != null && targetUI.gameObject.activeInHierarchy && ChekClickVaild(targetUI))
			{
				return true;
			}
			return false;
		}

		private bool ChekClickVaild(RectTransform target)
		{
			if (!IsCheckTop)
			{
				return true;
			}
			Vector2 vector = RectTransformUtility.WorldToScreenPoint(UIUtilly.GetUICamera(), target.TransformPoint(target.rect.center + offset));
			if (!RectTransformUtility.RectangleContainsScreenPoint(GameEntry.UI.RootTransform, vector, UIUtilly.GetUICamera()))
			{
				return false;
			}
			PointerEventData pointerEventData = new PointerEventData(EventSystem.current);
			pointerEventData.position = vector;
			pointerEventData.pressPosition = pointerEventData.position;
			List<RaycastResult> list = new List<RaycastResult>();
			EventSystem.current.RaycastAll(pointerEventData, list);
			while (list.Count > 0 && CheckOtherUI(list[0].gameObject.transform))
			{
				list.RemoveAt(0);
			}
			if (list.Count > 0 && list[0].gameObject == target.gameObject)
			{
				return true;
			}
			return false;
		}

		public bool CheckOtherUI(Transform transform)
		{
			Transform parent = transform.parent;
			if (!parent.name.Equals("UIGuidanceWindow") && !parent.parent.name.Equals("UIGuidanceWindow") && !parent.name.Equals("TeachingManualPageWindow") && !parent.parent.name.Equals("TeachingManualPageWindow") && !parent.parent.name.Equals("PROGRESS"))
			{
				return transform.name.Equals("ScreenDimmed");
			}
			return true;
		}
	}

	public class GuidanceGroup
	{
		public bool isVaild;

		private DRGuidance drGuidance;

		private List<GuidanceStep> guidanceSteps = new List<GuidanceStep>();

		private int stepIndex;

		private bool isExcuting;

		public bool IsForce;

		public bool IsVaild => isVaild;

		public bool IsExcuting => isExcuting;

		public int GuidanceGroupId => drGuidance.Id;

		public int Priority => drGuidance.Priority;

		public bool IsSave => drGuidance.IsSave;

		public List<int> NextGuidance => drGuidance.NextGuidance;

		public GuidanceGroup(DRGuidance drGuidance)
		{
			this.drGuidance = drGuidance;
			isVaild = false;
			guidanceSteps = new List<GuidanceStep>();
			foreach (int guidanceStep in this.drGuidance.GuidanceSteps)
			{
				DRGuidanceStep dataRow = GameEntry.DataTable.GetDataRow<DRGuidanceStep>(guidanceStep);
				if (dataRow != null)
				{
					isVaild = true;
					isExcuting = false;
					guidanceSteps.Add(new GuidanceStep(dataRow));
				}
				else
				{
					Log.Error($"没有找到引导步骤[{guidanceStep}]的配置");
				}
			}
			stepIndex = 0;
		}

		public bool Check()
		{
			if (stepIndex < guidanceSteps.Count)
			{
				return guidanceSteps[stepIndex].Check();
			}
			return false;
		}

		public bool NextStep()
		{
			stepIndex++;
			isExcuting = false;
			if (stepIndex >= guidanceSteps.Count)
			{
				return false;
			}
			return true;
		}

		public bool RegisterNextGroups()
		{
			if (NextGuidance.Count > 0)
			{
				foreach (int item in NextGuidance)
				{
					Singleton<GuidanceManager>.Instance.RegisterGuidance(item);
				}
				return true;
			}
			return false;
		}

		public void Excute()
		{
			isExcuting = true;
		}

		public GuidanceStep GetGuidanceStep()
		{
			if (stepIndex < guidanceSteps.Count)
			{
				return guidanceSteps[stepIndex];
			}
			return null;
		}

		public void Stop()
		{
			isExcuting = false;
			stepIndex = 0;
		}
	}

	[Serializable]
	public class LevelGuidanceStep
	{
		[SerializeField]
		private int guidanceType = 2;

		[SerializeField]
		private string checkWindowName;

		[SerializeField]
		private string windowName;

		[SerializeField]
		private string uikey;

		[SerializeField]
		private bool checkChild;

		[SerializeField]
		private int childIndex;

		[SerializeField]
		private Vector2 size;

		[SerializeField]
		private Vector2 offset;

		[SerializeField]
		private int tipType;

		[SerializeField]
		private Vector2 tipPosition;

		[SerializeField]
		private Vector2 fingerShifting;

		[SerializeField]
		private int fingerDirection;

		[SerializeField]
		private string tipCharacterName;

		[SerializeField]
		private string tipCharacter;

		[SerializeField]
		private string tipText;

		[SerializeField]
		private VideoClip videoClip;

		[SerializeField]
		private string videoFileName;

		[SerializeField]
		private string videoName;

		[SerializeField]
		private float waitTime;

		public int GuidanceType => guidanceType;

		public string CheckWindowName => checkWindowName;

		public string TargetUIFullKey
		{
			get
			{
				if (!string.IsNullOrEmpty(windowName))
				{
					return windowName + "-" + uikey;
				}
				return string.Empty;
			}
		}

		public bool CheckChild => checkChild;

		public int ChildIndex => childIndex;

		public Vector2 Size => size;

		public Vector2 Offset => offset;

		public int TipType => tipType;

		public Vector2 TipPosition => tipPosition;

		public Vector2 FingerShifting => fingerShifting;

		public int FingerDirection => fingerDirection;

		public string TipCharacterName => tipCharacterName;

		public string TipCharacter => tipCharacter;

		public string TipText => tipText;

		public VideoClip VideoClip => videoClip;

		public string VideoFileName => videoFileName;

		public string VideoName => videoName;

		public float WaitTime => waitTime;

		public bool Alpha => false;

		public RectTransform GetTargetUI()
		{
			if (UIWindowHelper.UIControls.TryGetValue(TargetUIFullKey, out var value) && CheckChild)
			{
				if (value.childCount > ChildIndex && ChildIndex >= 0)
				{
					return (RectTransform)value.GetChild(ChildIndex);
				}
				return null;
			}
			return value;
		}

		public bool Check()
		{
			if (string.IsNullOrEmpty(TargetUIFullKey))
			{
				return true;
			}
			if (UIWindowHelper.UIControls.TryGetValue(TargetUIFullKey, out var value))
			{
				if (CheckChild)
				{
					value = ((value.childCount <= ChildIndex || ChildIndex < 0) ? null : ((RectTransform)value.GetChild(ChildIndex)));
				}
				if (value != null && value.gameObject.activeInHierarchy)
				{
					return true;
				}
			}
			return false;
		}
	}

	[Serializable]
	public class GuidanceUIConfig
	{
		public string uiKey;

		public RectTransform targetUI;
	}

	public static bool skip;

	private List<int> finishedGuidanceIds = new List<int>();

	private List<int> waittingGuidanceIds = new List<int>();

	private PriorityQueue<GuidanceGroup> waittingGuidances = new PriorityQueue<GuidanceGroup>(new GuidancePriorityCompare());

	private GuidanceGroup excutingGuidanceGroup;

	private UIGuidanceWindow uiGuidanceWindow;

	private List<OptionBase> guidanceWindowDatas = new List<OptionBase>();

	private float startStepTime;

	private float checkTime = 3f;

	public void AddGuidanceWindowData(OptionBase windowData)
	{
		guidanceWindowDatas.Add(windowData);
	}

	private void ReleaseOpenedWindows()
	{
		if (guidanceWindowDatas != null)
		{
			for (int num = guidanceWindowDatas.Count - 1; num >= 0; num--)
			{
				guidanceWindowDatas[num]?.Close();
			}
			guidanceWindowDatas.Clear();
		}
	}

	public async UniTask<bool> RequestGuidanceData()
	{
		C2H_GetGuideListRequest request = C2H_GetGuideListRequest.Create();
		H2C_GetGuideListResponse h2CGetGuideListResponse = null;
		try
		{
			h2CGetGuideListResponse = await Singleton<NetworkSystem>.Instance.Call<H2C_GetGuideListResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(h2CGetGuideListResponse, "获取引导数据", "获取引导数据失败"))
			{
				waittingGuidances = new PriorityQueue<GuidanceGroup>(new GuidancePriorityCompare());
				waittingGuidanceIds = new List<int>();
				finishedGuidanceIds = new List<int>();
				foreach (PbGuideInfo guide in h2CGetGuideListResponse.Guides)
				{
					if (guide.GuideStatus == 1)
					{
						finishedGuidanceIds.Add(guide.GuideId);
					}
					else if (!waittingGuidanceIds.Contains(guide.GuideId))
					{
						GuidanceGroup guidanceGroup = CreateGuidance(guide.GuideId);
						if (guidanceGroup != null && guidanceGroup.IsVaild)
						{
							waittingGuidances.Push(guidanceGroup);
							waittingGuidanceIds.Add(guidanceGroup.GuidanceGroupId);
						}
					}
				}
				return true;
			}
		}
		catch (Exception)
		{
			return false;
		}
		finally
		{
			request.Dispose();
			h2CGetGuideListResponse?.Dispose();
		}
		return false;
	}

	public async void RegisterGuidance(int guidanceGroupId, bool force = false)
	{
		RegisterGuidance(new List<int> { guidanceGroupId }, force);
	}

	public async void RegisterGuidance(List<int> guidanceGroupIds, bool force = false)
	{
		if (guidanceGroupIds == null || guidanceGroupIds.Count <= 0)
		{
			return;
		}
		List<int> list = new List<int>();
		for (int i = 0; i < guidanceGroupIds.Count; i++)
		{
			if ((finishedGuidanceIds.Contains(guidanceGroupIds[i]) && !force) || waittingGuidanceIds.Contains(guidanceGroupIds[i]))
			{
				continue;
			}
			GuidanceGroup guidanceGroup = CreateGuidance(guidanceGroupIds[i]);
			guidanceGroup.IsForce = force;
			if (guidanceGroup != null && guidanceGroup.IsVaild)
			{
				if (guidanceGroup.IsSave)
				{
					list.Add(guidanceGroupIds[i]);
				}
				waittingGuidances.Push(guidanceGroup);
				waittingGuidanceIds.Add(guidanceGroup.GuidanceGroupId);
			}
		}
		if (force)
		{
			return;
		}
		C2H_AcceptGuideRequest request = C2H_AcceptGuideRequest.Create();
		request.GuideIds = list;
		S2C_DefaultActorResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2C_DefaultActorResponse>(request);
			Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "引导注册", "引导注册失败");
		}
		catch (Exception)
		{
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
	}

	public void RegisterGuidanceUIs(string windowName, List<GuidanceUIConfig> windowGuidanceUIs)
	{
		foreach (GuidanceUIConfig windowGuidanceUI in windowGuidanceUIs)
		{
			string key = windowName + "-" + windowGuidanceUI.uiKey;
			if (UIWindowHelper.UIControls.ContainsKey(key))
			{
				UIWindowHelper.UIControls[key] = windowGuidanceUI.targetUI;
			}
			else
			{
				UIWindowHelper.UIControls.Add(key, windowGuidanceUI.targetUI);
			}
		}
	}

	public void UnRegisterGuidanceUIs(string windowName, List<GuidanceUIConfig> windowGuidanceUIs)
	{
		foreach (GuidanceUIConfig windowGuidanceUI in windowGuidanceUIs)
		{
			string key = windowName + "-" + windowGuidanceUI.uiKey;
			if (UIWindowHelper.UIControls.ContainsKey(key))
			{
				UIWindowHelper.UIControls.Remove(key);
			}
		}
	}

	public async Task<UIGuidanceWindow> GetUIGuidancWindow()
	{
		if (uiGuidanceWindow == null)
		{
			uiGuidanceWindow = await GameEntry.UI.OpenWindow<UIGuidanceWindow>("Guide/UIGuidanceWindow", "GUIDE");
		}
		return uiGuidanceWindow;
	}

	public GuidanceGroup CreateGuidance(int guidanceGroupId)
	{
		DRGuidance dataRow = GameEntry.DataTable.GetDataRow<DRGuidance>(guidanceGroupId);
		if (dataRow != null)
		{
			return new GuidanceGroup(dataRow);
		}
		Log.Error($"没有找到引导组[{guidanceGroupId}]的配置");
		return null;
	}

	public void Update()
	{
		if (excutingGuidanceGroup != null && excutingGuidanceGroup.IsExcuting)
		{
			if (uiGuidanceWindow != null && !uiGuidanceWindow.Visibility)
			{
				uiGuidanceWindow.Show(ignoreAnimation: true);
			}
			return;
		}
		if (excutingGuidanceGroup != null && !excutingGuidanceGroup.IsExcuting)
		{
			if (excutingGuidanceGroup.Check())
			{
				checkTime = 3f;
				ExecuteGuidanceStep();
				return;
			}
			checkTime -= Time.deltaTime;
			if (checkTime <= 0f)
			{
				checkTime = 3f;
				excutingGuidanceGroup.Stop();
				SaveFinishGuideGroup();
				if ((bool)uiGuidanceWindow)
				{
					uiGuidanceWindow.CloseGuidanceWindow();
				}
			}
			return;
		}
		for (int i = 0; i < waittingGuidances.Count; i++)
		{
			if (waittingGuidances.Element(i).Check() && waittingGuidanceIds.Contains(waittingGuidances.Element(i).GuidanceGroupId))
			{
				excutingGuidanceGroup = waittingGuidances.Element(i);
				ExecuteGuidanceStep();
				break;
			}
		}
	}

	public void CloseNetworkNotify()
	{
		waittingGuidances.Clear();
		waittingGuidanceIds.Clear();
		finishedGuidanceIds.Clear();
		if ((bool)uiGuidanceWindow)
		{
			uiGuidanceWindow.CloseGuidanceWindow();
		}
		ReleaseOpenedWindows();
		if (excutingGuidanceGroup != null)
		{
			excutingGuidanceGroup.Stop();
			excutingGuidanceGroup = null;
		}
	}

	private async void ExecuteGuidanceStep()
	{
		startStepTime = Time.realtimeSinceStartup;
		excutingGuidanceGroup.Excute();
		UIGuidanceViewModel uiGuidanceViewModel = new UIGuidanceViewModel(excutingGuidanceGroup.GetGuidanceStep());
		if (uiGuidanceWindow == null)
		{
			uiGuidanceWindow = await GameEntry.UI.OpenWindow<UIGuidanceWindow>("Guide/UIGuidanceWindow", "GUIDE");
		}
		uiGuidanceWindow.BindGuidance(uiGuidanceViewModel);
		await UniTask.WaitUntil(() => uiGuidanceViewModel.IsFinish || excutingGuidanceGroup == null || !excutingGuidanceGroup.Check());
		if (excutingGuidanceGroup == null)
		{
			uiGuidanceViewModel.Close();
		}
		else if (uiGuidanceViewModel.IsFinish)
		{
			GuideStepReport(uiGuidanceViewModel.StepId);
			if (!excutingGuidanceGroup.NextStep())
			{
				SaveFinishGuideGroup(delegate
				{
					uiGuidanceViewModel.Close();
				});
			}
		}
		else
		{
			uiGuidanceViewModel.Close();
			excutingGuidanceGroup.Stop();
		}
	}

	private void GuideStepReport(int stepId)
	{
		TDAHandler.Instance.OuterGuideStepReport(Time.realtimeSinceStartup - startStepTime, stepId);
	}

	private async void SaveFinishGuideGroup(Action action = null)
	{
		if (excutingGuidanceGroup != null && excutingGuidanceGroup.IsSave && !excutingGuidanceGroup.IsForce)
		{
			C2H_UpdateGuideRequest request = C2H_UpdateGuideRequest.Create();
			S2C_DefaultActorResponse response = null;
			try
			{
				try
				{
					request.GuideId = excutingGuidanceGroup.GuidanceGroupId;
					response = await Singleton<NetworkSystem>.Instance.Call<S2C_DefaultActorResponse>(request);
					if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "引导完成记录", "引导完成记录失败"))
					{
						if (action != null)
						{
							action();
							await UniTask.Yield();
						}
						RegisterNextGroups();
					}
				}
				catch (Exception ex)
				{
					_ = ex;
					if (action != null)
					{
						action();
						await UniTask.Yield();
					}
					RegisterNextGroups();
				}
				return;
			}
			finally
			{
				request.Dispose();
				response?.Dispose();
			}
		}
		if (action != null)
		{
			action();
			await UniTask.Yield();
		}
		RegisterNextGroups();
	}

	private void RegisterNextGroups()
	{
		if (excutingGuidanceGroup != null)
		{
			excutingGuidanceGroup.RegisterNextGroups();
			finishedGuidanceIds.Add(excutingGuidanceGroup.GuidanceGroupId);
			waittingGuidanceIds.Remove(excutingGuidanceGroup.GuidanceGroupId);
			excutingGuidanceGroup = null;
		}
	}

	public bool CheckGuidanceFinish(int guidanceId)
	{
		for (int i = 0; i < finishedGuidanceIds.Count; i++)
		{
			if (finishedGuidanceIds[i] == guidanceId)
			{
				return true;
			}
		}
		return false;
	}
}
