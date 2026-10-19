using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.Event;
using ACT.Model;
using ACT.World.Asset;
using ACT.World.StateObject;
using Bamboo.Chronos;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.UI;

public class InteractBtnList : MonoBehaviour, IBattleMainComponent
{
	public RectTransform root;

	public Transform interactRoot;

	public InteractVarietyBtn interactBtnPrefab;

	private Vector2 lastInteractButtonPos;

	private Dictionary<InteractEntry, InteractVarietyBtn> _entryToBtn = new Dictionary<InteractEntry, InteractVarietyBtn>();

	private RectTransform m_InteractRootRectTransform;

	private List<InteractVarietyBtn> _pendingRemoveButtons = new List<InteractVarietyBtn>();

	private const string BarShow = "BarShow";

	private const string BarHide = "BarHide";

	private const string InteractClickSound = "event:/UI/Common/Interaction_Click";

	private int m_interactBtnIndex;

	public int m_Height = 104;

	public int m_MaxSize = 4;

	public float offest = 10f;

	private const float _interactBtnDiameter = 154f;

	private CancellationTokenSource cts;

	private bool _inInteractCoolDown;

	private const int InteractCoolDownTimeMs = 300;

	private Delayer _coolDownDelayer;

	private static readonly ObjectPool<Stack<InteractVarietyBtn>> _interactBtnPoolStack = new ObjectPool<Stack<InteractVarietyBtn>>((Stack<InteractVarietyBtn> x) =>
	{
		new Stack<InteractVarietyBtn>();
	}, (Stack<InteractVarietyBtn> x) =>
	{
		x.Clear();
	});

	private static readonly int Show = Animator.StringToHash("show");

	private Stack<InteractVarietyBtn> _btnPool;

	private bool IsInteractViewVisible
	{
		get
		{
			NewUIManager instance = Singleton<NewUIManager>.instance;
			if (instance == null)
			{
				return false;
			}
			IBaseUIController topActiveUI = instance.GetTopActiveUI();
			if (topActiveUI != null && topActiveUI.UIType == UI_TYPE.UI_BATTLEMAIN)
			{
				return topActiveUI.State == UIState.Opened;
			}
			return false;
		}
	}

	private InteractVarietyBtn PopInstance()
	{
		InteractVarietyBtn btn = ((_btnPool.Count > 0) ? _btnPool.Pop() : UnityEngine.Object.Instantiate(interactBtnPrefab, interactRoot));
		btn.transform.localScale = Vector3.one;
		btn.transform.localPosition = Vector3.zero;
		btn.rectTransform.anchoredPosition3D = Vector3.zero;
		btn.interactEvent.AddListener(() =>
		{
			OnInteractButtonClick(btn.Index);
		});
		InteractVarietyBtn interactVarietyBtn = btn;
		interactVarietyBtn.interactableAddCondition = (Func<bool>)Delegate.Combine(interactVarietyBtn.interactableAddCondition, new Func<bool>(CheckAnim));
		btn.gameObject.SetActive(value: true);
		btn.SetDiameter(154f);
		btn.Apply(btn.normal);
		btn.RefreshInputSwitch(isSelected: false, 0);
		return btn;
	}

	private void PushInstance(InteractVarietyBtn btn)
	{
		btn.interactEvent.RemoveAllListeners();
		btn.interactableAddCondition = (Func<bool>)Delegate.Remove(btn.interactableAddCondition, new Func<bool>(CheckAnim));
		btn.gameObject.SetActive(value: false);
		btn.localizeStringEvent.StringReference.SetReference(null, null);
		btn.localizeStringEvent.OnUpdateString.Invoke(string.Empty);
		btn.Unload();
		_btnPool.Push(btn);
	}

	private void Awake()
	{
		_btnPool = _interactBtnPoolStack.Get();
		m_InteractRootRectTransform = interactRoot.GetComponent<RectTransform>();
	}

	private void OnDestroy()
	{
		RecycleAllInteractButtons();
		if (_btnPool != null)
		{
			_interactBtnPoolStack.Release(_btnPool);
			_btnPool = null;
		}
	}

	private void RecycleAllInteractButtons()
	{
		DisposeCancellationTokenSource();
		_coolDownDelayer.Cancel();
		_inInteractCoolDown = false;
		foreach (KeyValuePair<InteractEntry, InteractVarietyBtn> item in _entryToBtn)
		{
			PushInstance(item.Value);
		}
		_entryToBtn.Clear();
		foreach (InteractVarietyBtn pendingRemoveButton in _pendingRemoveButtons)
		{
			PushInstance(pendingRemoveButton);
		}
		_pendingRemoveButtons.Clear();
	}

	private void RebuildInteractButtons()
	{
		List<InteractEntry> interactEntries = Model<InteractModel>.Interface.InteractEntries;
		for (int i = 0; i < interactEntries.Count; i++)
		{
			InteractEntry interactEntry = interactEntries[i];
			if (interactEntry.ShowType != ShowType.Hide)
			{
				AddInteractEntryInternal(interactEntry);
			}
		}
	}

	public void Initialize(MonoBattleMainBaseView view)
	{
		interactRoot.gameObject.SetActive(value: true);
		RebuildInteractButtons();
		Model<InteractModel>.Interface.HandleInteractBtn += InteractAt;
		Model<InteractModel>.Interface.UpdateInteractBtnSelectIndex += UpdateSelectIndex;
		Model<InteractModel>.Interface.AddInteractBtnEntry += AddInteractEntry;
		Model<InteractModel>.Interface.RemoveInteractBtnEntry += RemoveInteractEntry;
		Model<InteractModel>.Interface.OnSortChanged += RefreshEntries;
		Model<InteractModel>.Interface.RefreshInteractBtnEntry += RefreshInteractEntry;
		Model<InteractModel>.Interface.UpdateInteractBtnSelectIndexByPointUp += OnCommonBtnPointUp;
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.InteractEntry_Refresh, InteractRefresh);
		MonoECS.instance.onInputModeChange.AddListener(OnInputChange);
	}

	public void UnInitialize()
	{
		interactRoot.gameObject.SetActive(value: false);
		RecycleAllInteractButtons();
		Model<InteractModel>.Interface.HandleInteractBtn -= InteractAt;
		Model<InteractModel>.Interface.UpdateInteractBtnSelectIndex -= UpdateSelectIndex;
		Model<InteractModel>.Interface.AddInteractBtnEntry -= AddInteractEntry;
		Model<InteractModel>.Interface.RemoveInteractBtnEntry -= RemoveInteractEntry;
		Model<InteractModel>.Interface.OnSortChanged -= RefreshEntries;
		Model<InteractModel>.Interface.RefreshInteractBtnEntry -= RefreshInteractEntry;
		Model<InteractModel>.Interface.UpdateInteractBtnSelectIndexByPointUp -= OnCommonBtnPointUp;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.InteractEntry_Refresh, InteractRefresh);
		MonoECS.instance.onInputModeChange.RemoveListener(OnInputChange);
	}

	public void PushStack()
	{
		RecycleAllInteractButtons();
	}

	public void PopStack()
	{
		RebuildInteractButtons();
	}

	private void OnInputChange(DeviceInputMode inputMode)
	{
		OnCommonBtnPointUp();
	}

	private void RefreshEntries()
	{
		List<InteractEntry> interactEntries = Model<InteractModel>.Interface.InteractEntries;
		bool flag = false;
		foreach (InteractEntry item in interactEntries)
		{
			if (_entryToBtn.TryGetValue(item, out var value) && (value.Index < 0 || value.Index >= interactEntries.Count || interactEntries[value.Index] != item))
			{
				int siblingIndex = (value.Index = interactEntries.IndexOf(item));
				value.transform.SetSiblingIndex(siblingIndex);
				flag = true;
			}
		}
		if (flag)
		{
			OnInteractChangedRefreshView(add: false);
			OnInteractRefreshData();
		}
	}

	public void OpenComponent()
	{
	}

	public void CloseComponent()
	{
	}

	private void Update()
	{
		if (_btnPool == null || !IsInteractViewVisible)
		{
			return;
		}
		List<InteractEntry> interactEntries = Model<InteractModel>.Interface.InteractEntries;
		for (int i = 0; i < interactEntries.Count; i++)
		{
			InteractEntry interactEntry = interactEntries[i];
			bool flag = interactEntry.ShowType != ShowType.Hide;
			bool flag2 = _entryToBtn.TryGetValue(interactEntry, out var value);
			if (flag && !flag2)
			{
				AddInteractEntryInternal(interactEntry);
			}
			else if (!flag & flag2)
			{
				RemoveInteractEntry(interactEntry);
			}
			else if (flag)
			{
				RefreshInteractBtnImage(interactEntry, value);
			}
		}
	}

	private static void RefreshInteractBtnImage(InteractEntry entry, InteractVarietyBtn btn)
	{
		if (entry != null && !(btn == null) && entry.ShowType != ShowType.Hide)
		{
			if (!entry.TryGetMissionInjectedButtonImage(out var iconConfigId))
			{
				iconConfigId = entry.GetDisplayButtonIconId();
			}
			btn.LoadImage(iconConfigId);
		}
	}

	private void UpdateSelectIndex(int index)
	{
		int count = _entryToBtn.Count;
		foreach (KeyValuePair<InteractEntry, InteractVarietyBtn> item in _entryToBtn)
		{
			bool flag = index == item.Value.Index;
			InteractVarietyBtn value = item.Value;
			if (Model<InteractModel>.Interface.NeedShowSelected)
			{
				value.Apply(flag ? value.selected : value.normal);
			}
			value.RefreshInputSwitch(flag, count);
		}
	}

	private void OnCommonBtnPointUp()
	{
		int count = _entryToBtn.Count;
		foreach (KeyValuePair<InteractEntry, InteractVarietyBtn> item in _entryToBtn)
		{
			bool flag = Model<InteractModel>.Interface.CommonBtnSelectIndex == item.Value.Index;
			InteractVarietyBtn value = item.Value;
			value.Apply((Model<InteractModel>.Interface.NeedShowSelected & flag) ? value.selected : value.normal);
			value.RefreshInputSwitch(flag, count);
		}
	}

	private InteractVarietyBtn AddInteractEntryInternal(InteractEntry interactEntry)
	{
		if (_entryToBtn.TryGetValue(interactEntry, out var value))
		{
			return value;
		}
		EnsureCancellationTokenSource();
		List<InteractEntry> interactEntries = Model<InteractModel>.Interface.InteractEntries;
		InteractVarietyBtn interactVarietyBtn = PopInstance();
		_entryToBtn[interactEntry] = interactVarietyBtn;
		int siblingIndex = (interactVarietyBtn.Index = interactEntries.IndexOf(interactEntry));
		interactVarietyBtn.transform.SetSiblingIndex(siblingIndex);
		Animator anim = interactVarietyBtn.anim;
		OnInteractChangedRefreshView(add: true);
		OnInteractRefreshData();
		interactVarietyBtn.gameObject.SetActive(value: true);
		anim.SetBool(Show, value: true);
		return interactVarietyBtn;
	}

	private void AddInteractEntry(InteractEntry interactEntry)
	{
		if (interactEntry.ShowType != ShowType.Hide && IsInteractViewVisible)
		{
			AddInteractEntryInternal(interactEntry);
		}
	}

	private void RefreshInteractEntry(InteractEntry interactEntry)
	{
		if (_entryToBtn.TryGetValue(interactEntry, out var value))
		{
			value.interactable = interactEntry.Interactable;
			LocalizedString localizedString = interactEntry.LocalizedString;
			if (value.localizeStringEvent.StringReference != localizedString)
			{
				value.localizeStringEvent.StringReference.SetReference(localizedString.TableReference, localizedString.TableEntryReference);
			}
			if (interactEntry.ShowType != ShowType.Hide)
			{
				RefreshInteractBtnImage(interactEntry, value);
			}
		}
	}

	private async void RemoveInteractEntry(InteractEntry interactEntry)
	{
		if (!_entryToBtn.Remove(interactEntry, out var interactBtn))
		{
			return;
		}
		OnInteractChangedRefreshView(add: false);
		OnInteractRefreshData();
		_pendingRemoveButtons.Add(interactBtn);
		Animator anim = interactBtn.anim;
		anim.SetBool(Show, value: false);
		await UniTask.WaitUntil(() =>
		{
			if (!interactBtn.gameObject.activeInHierarchy)
			{
				return true;
			}
			if (!interactBtn.gameObject.activeSelf)
			{
				return true;
			}
			if (anim == null)
			{
				return false;
			}
			AnimatorStateInfo currentAnimatorStateInfo = anim.GetCurrentAnimatorStateInfo(0);
			return currentAnimatorStateInfo.IsName("BarHide") && currentAnimatorStateInfo.normalizedTime >= 1f;
		}, PlayerLoopTiming.Update, cts.Token).SuppressCancellationThrow();
		if (_btnPool != null && _pendingRemoveButtons.Remove(interactBtn))
		{
			PushInstance(interactBtn);
		}
	}

	private void OnInteractChangedRefreshView(bool add)
	{
		List<InteractEntry> interactEntries = Model<InteractModel>.Interface.InteractEntries;
		int num = 0;
		for (int i = 0; i < interactEntries.Count; i++)
		{
			if (interactEntries[i].ShowType != ShowType.Hide)
			{
				num++;
			}
		}
		if (num == 0)
		{
			return;
		}
		int num2 = 0;
		for (int j = 0; j < interactEntries.Count; j++)
		{
			InteractEntry interactEntry = interactEntries[j];
			if (interactEntry.ShowType != ShowType.Hide)
			{
				if (!_entryToBtn.TryGetValue(interactEntry, out var value))
				{
					value = AddInteractEntryInternal(interactEntry);
				}
				InteractVarietyBtn interactVarietyBtn = value;
				interactVarietyBtn.Index = j;
				interactVarietyBtn.interactable = interactEntry.Interactable;
				if (add)
				{
					LocalizedString localizedString = interactEntry.LocalizedString;
					interactVarietyBtn.localizeStringEvent.StringReference.SetReference(localizedString.TableReference, localizedString.TableEntryReference);
					RefreshInteractBtnImage(interactEntry, interactVarietyBtn);
				}
				if (num == 1)
				{
					interactVarietyBtn.DoTransition(new Vector2(lastInteractButtonPos.x, m_Height));
				}
				else
				{
					int num3 = num - num2 - 1;
					interactVarietyBtn.DoTransition(new Vector2(lastInteractButtonPos.x, num3 * m_Height));
				}
				num2++;
			}
		}
	}

	private void OnInteractRefreshData()
	{
		int count = _entryToBtn.Count;
		m_InteractRootRectTransform.sizeDelta = new Vector2(m_InteractRootRectTransform.sizeDelta.x, count * m_Height);
		if (count == 0)
		{
			return;
		}
		foreach (KeyValuePair<InteractEntry, InteractVarietyBtn> item in _entryToBtn)
		{
			bool flag = Model<InteractModel>.Interface.CommonBtnSelectIndex == item.Value.Index;
			InteractVarietyBtn value = item.Value;
			value.Apply((Model<InteractModel>.Interface.NeedShowSelected & flag) ? value.selected : value.normal);
			value.RefreshInputSwitch(flag, count);
		}
	}

	private void OnInteractButtonClick(int index)
	{
		if (!_inInteractCoolDown)
		{
			NetInteract(index);
		}
	}

	private void InteractAt()
	{
		if (!_inInteractCoolDown)
		{
			int commonBtnSelectIndex = Model<InteractModel>.Interface.CommonBtnSelectIndex;
			if (commonBtnSelectIndex != -1)
			{
				NetInteract(commonBtnSelectIndex);
			}
		}
	}

	private void NetInteract(int index)
	{
		List<InteractEntry> interactEntries = Model<InteractModel>.Interface.InteractEntries;
		if (interactEntries.Count == 0)
		{
			return;
		}
		if (index < 0 || index >= interactEntries.Count)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"InteractBtnList.NetInteract 下标越界: index={index}, count={interactEntries.Count}");
			}
			return;
		}
		InteractEntry interactEntry = interactEntries[index];
		if (interactEntry.Interactable && !Singleton<NewUIManager>.instance.IsUIManagerBusy())
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Interaction_Click");
			interactEntry.NetInteract();
			InteractCoolDown();
		}
	}

	private void EnsureCancellationTokenSource()
	{
		CancellationTokenSource cancellationTokenSource = cts;
		if (cancellationTokenSource == null || cancellationTokenSource.IsCancellationRequested)
		{
			cts?.Dispose();
			cts = new CancellationTokenSource();
		}
	}

	private void DisposeCancellationTokenSource()
	{
		cts?.Cancel();
		cts?.Dispose();
		cts = null;
	}

	private bool CheckAnim()
	{
		foreach (KeyValuePair<InteractEntry, InteractVarietyBtn> item in _entryToBtn)
		{
			AnimatorStateInfo currentAnimatorStateInfo = item.Value.anim.GetCurrentAnimatorStateInfo(0);
			if (!currentAnimatorStateInfo.IsName("BarShow") || currentAnimatorStateInfo.normalizedTime < 1f)
			{
				return false;
			}
		}
		return true;
	}

	private void InteractCoolDown()
	{
		_inInteractCoolDown = true;
		_coolDownDelayer = UpdateTimer.Default.DelayMs(300, () =>
		{
			_inInteractCoolDown = false;
		});
	}

	private void InteractRefresh(BaseEventContent obj)
	{
		InteractEntryAdd interactEntryAdd = (InteractEntryAdd)obj;
		if (!(interactEntryAdd.Entry.Data is StandardElevatorData))
		{
			RefreshInteractEntry(interactEntryAdd.Entry);
		}
	}
}
