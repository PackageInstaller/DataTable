using System.Collections.Generic;
using UnityEngine.Pool;

namespace ACT.UI;

public class InputControllerContainer
{
	private readonly List<IInputController> _inputContainer = new List<IInputController>();

	private readonly List<ISubUIView> _pendingSubViews = new List<ISubUIView>();

	private int _subViewSyncDepth;

	private IInputController _currentInputController;

	private bool _active = true;

	public bool Active
	{
		get
		{
			return _active;
		}
		set
		{
			_active = value;
			SetCurrentController();
		}
	}

	public void AddInputController(IInputController inputController)
	{
		if (inputController != null)
		{
			if (_inputContainer.Contains(inputController))
			{
				_inputContainer.Remove(inputController);
			}
			_inputContainer.Add(inputController);
			SetCurrentController();
		}
	}

	public void RemoveInputController(IInputController inputController)
	{
		_inputContainer.Remove(inputController);
		SetCurrentController();
	}

	private void SetCurrentController()
	{
		object obj;
		if (!_active || _inputContainer.Count <= 0)
		{
			obj = null;
		}
		else
		{
			List<IInputController> inputContainer = _inputContainer;
			obj = inputContainer[inputContainer.Count - 1];
		}
		IInputController inputController = (IInputController)obj;
		if (_currentInputController != inputController)
		{
			SetControllerActive(_currentInputController, active: false);
			_currentInputController = inputController;
			SetControllerActive(inputController, active: true);
		}
	}

	private void SetControllerActive(IInputController inputController, bool active)
	{
		bool flag = _subViewSyncDepth > 0;
		List<ISubUIView> list = (flag ? CollectionPool<List<ISubUIView>, ISubUIView>.Get() : _pendingSubViews);
		_subViewSyncDepth++;
		try
		{
			CopySubViews(inputController?.GetUIController?.ActivateSubViews, list);
			if (active)
			{
				inputController?.Activate();
			}
			else
			{
				inputController?.Deactivate();
			}
			SyncSubViewInputState(inputController?.GetUIController?.ActivateSubViews, list, active);
		}
		finally
		{
			_subViewSyncDepth--;
			list.Clear();
			if (flag)
			{
				CollectionPool<List<ISubUIView>, ISubUIView>.Release(list);
			}
		}
	}

	private static void SyncSubViewInputState(IReadOnlyCollection<ISubUIView> liveSubViews, List<ISubUIView> pendingSubViews, bool active)
	{
		int num = 0;
		for (int i = 0; i < 16; i++)
		{
			CopyNewSubViews(liveSubViews, pendingSubViews);
			bool flag = false;
			while (num < pendingSubViews.Count)
			{
				if (TrySetSubViewInputActive(pendingSubViews[num++], active))
				{
					flag = true;
					CopyNewSubViews(liveSubViews, pendingSubViews);
				}
			}
			if (flag)
			{
				num = 0;
				continue;
			}
			break;
		}
	}

	private static void CopySubViews(IReadOnlyCollection<ISubUIView> liveSubViews, List<ISubUIView> pendingSubViews)
	{
		if (liveSubViews == null || liveSubViews.Count == 0)
		{
			return;
		}
		if (liveSubViews is List<ISubUIView> list)
		{
			int i = 0;
			for (int count = list.Count; i < count; i++)
			{
				pendingSubViews.Add(list[i]);
			}
		}
		else
		{
			pendingSubViews.AddRange(liveSubViews);
		}
	}

	private static void CopyNewSubViews(IReadOnlyCollection<ISubUIView> liveSubViews, List<ISubUIView> pendingSubViews)
	{
		if (liveSubViews == null || liveSubViews.Count == 0)
		{
			return;
		}
		if (liveSubViews is List<ISubUIView> list)
		{
			int i = 0;
			for (int count = list.Count; i < count; i++)
			{
				ISubUIView subUIView = list[i];
				if (subUIView != null && !pendingSubViews.Contains(subUIView))
				{
					pendingSubViews.Add(subUIView);
				}
			}
			return;
		}
		foreach (ISubUIView liveSubView in liveSubViews)
		{
			if (liveSubView != null && !pendingSubViews.Contains(liveSubView))
			{
				pendingSubViews.Add(liveSubView);
			}
		}
	}

	private static bool TrySetSubViewInputActive(ISubUIView subView, bool active)
	{
		IInputController inputController = subView?.InputController;
		if (inputController == null || inputController.IsActive == active)
		{
			return false;
		}
		if (active)
		{
			subView.ActivateInputController();
		}
		else
		{
			subView.DeactivateInputController();
		}
		return true;
	}

	public IInputController GetCurrentController()
	{
		return _currentInputController;
	}

	public void Reset()
	{
		_inputContainer.Clear();
		SetCurrentController();
	}

	public IInputController GetTopController()
	{
		if (_inputContainer.Count > 0)
		{
			List<IInputController> inputContainer = _inputContainer;
			return inputContainer[inputContainer.Count - 1];
		}
		return null;
	}
}
