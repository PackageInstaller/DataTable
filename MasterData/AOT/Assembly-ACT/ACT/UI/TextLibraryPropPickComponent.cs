using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Config;
using ACT.Model;
using Cysharp.Threading.Tasks;
using DG.Tweening;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class TextLibraryPropPickComponent : BaseUIComponent, IBattleMainComponent
{
	public TextLibraryPropPickTitle title;

	[SerializeField]
	private BetterAnimation anim;

	[Header("ScrollView 相关")]
	[SerializeField]
	private ScrollRect scrollRect;

	[Header("cell 生成相关")]
	[SerializeField]
	private GameObject cellPrefab;

	[SerializeField]
	private float _reMainTime;

	[Header("动画")]
	[SerializeField]
	private float moveUpDuration = 0.25f;

	private List<TextLibraryPropPickCell> _activeCells = new List<TextLibraryPropPickCell>();

	private Queue<TextLibraryPropPickCell> _waitQueue = new Queue<TextLibraryPropPickCell>();

	private int _seatLimit;

	private float _cellHeight;

	private float _verticalSpacing;

	private int _contentHeightByCellNum;

	private bool _isShowing;

	private bool _waitHide;

	private CancellationTokenSource cts;

	private CancellationToken ct;

	private bool loopRunning;

	private TextLibraryManager _manager => Singleton<TextLibraryManager>.instance;

	public bool isShowing => _isShowing;

	private void Awake()
	{
		if (scrollRect != null && scrollRect.content != null)
		{
			VerticalLayoutGroup component = scrollRect.content.GetComponent<VerticalLayoutGroup>();
			if (component != null)
			{
				_verticalSpacing = component.spacing;
			}
		}
		if (cellPrefab != null)
		{
			_cellHeight = ((RectTransform)cellPrefab.transform).sizeDelta.y;
		}
	}

	protected override void OnUnityDestroy()
	{
		if (loopRunning)
		{
			loopRunning = false;
		}
		cts?.Cancel();
		cts?.Dispose();
	}

	public void Init(TextLibraryPropPickData curNeedShowData, Action openFail)
	{
		onClose = ((openFail != null) ? ((Action)(() =>
		{
			Model<BattleMainModel>.Interface.HudPositionUIDequeue(UIPosition.LeftBottom);
		})) : null);
		try
		{
			_isShowing = true;
			_seatLimit = Mathf.Max(0, curNeedShowData.seatLimit);
			title?.Init();
			ResetState();
			StartLoopIfNeeded();
			gameObject.SetActive(value: true);
			anim?.GetSequence("Show").Play();
		}
		catch (Exception arg)
		{
			onClose = null;
			openFail?.Invoke();
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"词条PropPick打开失败：{arg}");
			}
			Uninit();
		}
	}

	private void ResetState()
	{
		cts?.Cancel();
		cts?.Dispose();
		cts = new CancellationTokenSource();
		ct = cts.Token;
		scrollRect.verticalNormalizedPosition = 1f;
		ClearAllCells();
		_contentHeightByCellNum = Mathf.Max(1, _seatLimit);
		UpdateContentHeight(_contentHeightByCellNum);
	}

	private void ClearAllCells()
	{
		for (int i = 0; i < _activeCells.Count; i++)
		{
			if (_activeCells[i] != null)
			{
				_manager.ReleaseInPool(_activeCells[i]);
			}
		}
		_activeCells.Clear();
		while (_waitQueue.Count > 0)
		{
			TextLibraryPropPickCell textLibraryPropPickCell = _waitQueue.Dequeue();
			if (textLibraryPropPickCell != null)
			{
				_manager.ReleaseInPool(textLibraryPropPickCell);
			}
		}
	}

	private void StartLoopIfNeeded()
	{
		if (_seatLimit > 0 && (_manager.HasData || _manager.HasPendingNew))
		{
			if (cts == null)
			{
				cts = new CancellationTokenSource();
				ct = cts.Token;
			}
			if (!loopRunning)
			{
				loopRunning = true;
				RunLoop().Forget();
			}
		}
	}

	private async UniTaskVoid RunLoop()
	{
		_ = 4;
		try
		{
			if (!(await FillSeats()))
			{
				Uninit();
				return;
			}
			while (!ct.IsCancellationRequested)
			{
				if (_activeCells.Count == 0 && !_manager.HasPendingNew && _waitQueue.Count == 0)
				{
					Uninit();
					break;
				}
				if (_activeCells.Count < _seatLimit && (_waitQueue.Count > 0 || _manager.HasPendingNew))
				{
					if (!(await FillSeats()))
					{
						Uninit();
						break;
					}
				}
				else if (_activeCells.Count > 0)
				{
					await UniTask.Delay(TimeSpan.FromSeconds(_reMainTime), ignoreTimeScale: false, PlayerLoopTiming.Update, ct);
					if (!(await MoveUpOne()))
					{
						Uninit();
						break;
					}
				}
				else
				{
					await UniTask.Yield(ct);
				}
			}
		}
		catch (OperationCanceledException)
		{
		}
		finally
		{
			loopRunning = false;
		}
	}

	private async UniTask<bool> FillSeats()
	{
		bool needsFill = _activeCells.Count < _seatLimit && (_waitQueue.Count > 0 || _manager.HasPendingNew);
		int activeCountBefore = _activeCells.Count;
		if (!UpdateWaitQueue())
		{
			return false;
		}
		while (_activeCells.Count < _seatLimit && _waitQueue.Count != 0)
		{
			TextLibraryPropPickCell textLibraryPropPickCell = _waitQueue.Dequeue();
			if (textLibraryPropPickCell == null)
			{
				return false;
			}
			textLibraryPropPickCell.gameObject.SetActive(value: true);
			textLibraryPropPickCell.canvasGroup.alpha = 1f;
			textLibraryPropPickCell.transform.SetParent(scrollRect.content, worldPositionStays: false);
			_activeCells.Add(textLibraryPropPickCell);
			_contentHeightByCellNum = Mathf.Max(_contentHeightByCellNum, _activeCells.Count);
			UpdateContentHeight(_contentHeightByCellNum);
			await UniTask.Yield(ct);
		}
		if (needsFill && _activeCells.Count == activeCountBefore)
		{
			return false;
		}
		return true;
	}

	private bool UpdateWaitQueue()
	{
		if (_manager == null)
		{
			return false;
		}
		if (scrollRect == null || scrollRect.content == null)
		{
			return false;
		}
		TextLibraryContent data;
		while (_manager.TryDequeuePendingNew(out data))
		{
			TextLibraryPropPickCell textLibraryPropPickCell = _manager.Get(cellPrefab, scrollRect.content);
			if (textLibraryPropPickCell == null)
			{
				return false;
			}
			if (data != null)
			{
				textLibraryPropPickCell.Init(data);
			}
			textLibraryPropPickCell.gameObject.SetActive(value: false);
			textLibraryPropPickCell.canvasGroup.alpha = 1f;
			textLibraryPropPickCell.transform.SetParent(scrollRect.viewport, worldPositionStays: false);
			_waitQueue.Enqueue(textLibraryPropPickCell);
		}
		return true;
	}

	private float GetContentHeight(int cellNum)
	{
		if (cellNum <= 0)
		{
			return 0f;
		}
		return (float)cellNum * _cellHeight + (float)(cellNum - 1) * _verticalSpacing;
	}

	private void UpdateContentHeight(int cellNum)
	{
		if (!(scrollRect == null) && !(scrollRect.content == null))
		{
			scrollRect.content.sizeDelta = new Vector2(scrollRect.content.sizeDelta.x, GetContentHeight(cellNum));
		}
	}

	private async UniTask<bool> MoveUpOne()
	{
		if (scrollRect == null)
		{
			return false;
		}
		if (_activeCells.Count == 0)
		{
			return false;
		}
		if (!UpdateWaitQueue())
		{
			return false;
		}
		if (_activeCells.Count < _seatLimit + 1 && _waitQueue.Count > 0)
		{
			TextLibraryPropPickCell textLibraryPropPickCell = _waitQueue.Dequeue();
			if (textLibraryPropPickCell == null)
			{
				return false;
			}
			textLibraryPropPickCell.gameObject.SetActive(value: true);
			textLibraryPropPickCell.canvasGroup.alpha = 1f;
			textLibraryPropPickCell.transform.SetParent(scrollRect.content, worldPositionStays: true);
			_activeCells.Add(textLibraryPropPickCell);
		}
		_contentHeightByCellNum++;
		UpdateContentHeight(_contentHeightByCellNum);
		float num = _cellHeight + _verticalSpacing;
		RectTransform viewport = ((scrollRect.viewport != null) ? scrollRect.viewport : ((RectTransform)scrollRect.transform));
		float num2 = Mathf.Max(0.0001f, scrollRect.content.sizeDelta.y - viewport.rect.height);
		float num3 = num / num2;
		float endValue = Mathf.Clamp01(1f - num3);
		await scrollRect.DOVerticalNormalizedPos(endValue, moveUpDuration).SetEase(Ease.Linear).ToUniTask(TweenCancelBehaviour.KillAndCancelAwait, ct);
		scrollRect.verticalNormalizedPosition = 1f;
		TextLibraryPropPickCell textLibraryPropPickCell2 = _activeCells[0];
		_activeCells.RemoveAt(0);
		if (textLibraryPropPickCell2 != null)
		{
			textLibraryPropPickCell2.gameObject.SetActive(value: false);
			textLibraryPropPickCell2.canvasGroup.alpha = 0f;
			textLibraryPropPickCell2.transform.SetParent(viewport, worldPositionStays: false);
		}
		if (_manager != null)
		{
			_manager.RemoveFirst();
		}
		return await FillSeats();
	}

	public void Uninit()
	{
		if (!_isShowing)
		{
			return;
		}
		_isShowing = false;
		cts?.Cancel();
		cts?.Dispose();
		cts = null;
		onClose?.Invoke();
		onClose = null;
		if (_activeCells.Count > 0)
		{
			for (int i = 0; i < _activeCells.Count; i++)
			{
				_manager.ReleaseInPool(_activeCells[i]);
			}
			_activeCells.Clear();
		}
		while (_waitQueue.Count > 0)
		{
			TextLibraryPropPickCell textLibraryPropPickCell = _waitQueue.Dequeue();
			if (textLibraryPropPickCell != null)
			{
				_manager.ReleaseInPool(textLibraryPropPickCell);
			}
		}
		if (_manager.HasData)
		{
			_manager.ClearAll();
		}
		if (scrollRect != null && scrollRect.content != null)
		{
			scrollRect.verticalNormalizedPosition = 1f;
			scrollRect.content.anchoredPosition = Vector2.zero;
			scrollRect.content.sizeDelta = new Vector2(scrollRect.content.sizeDelta.x, 0f);
		}
		_waitHide = true;
		anim?.GetSequence("Hide")?.OnComplete((AnimationBuilder _) =>
		{
			FinishHide();
		}).Play();
	}

	private void FinishHide()
	{
		if (_waitHide)
		{
			_waitHide = false;
			if (!_isShowing && gameObject.activeSelf)
			{
				gameObject.SetActive(value: false);
			}
		}
	}

	private void OnDisable()
	{
		FinishHide();
	}

	public void Initialize(MonoBattleMainBaseView view)
	{
	}

	public void UnInitialize()
	{
		Uninit();
	}

	public void OpenComponent()
	{
	}

	public void CloseComponent()
	{
	}

	public void PushStack()
	{
	}

	public void PopStack()
	{
	}
}
