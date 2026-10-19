using System;
using System.Threading;
using ACT.UI.Interface;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.UI;

public abstract class BaseTabContent : BaseTabContent<TabContentInputController>
{
}
public abstract class BaseTabContent<T> : SubUIView<T>, ITabContent where T : class, ISubInputController, new()
{
	private static readonly Vector3 HiddenPosition = new Vector3(100000f, 100000f, 0f);

	protected ITabItem _tabItem;

	private bool _isTabContentActive;

	private bool _cachedVisiblePosition;

	private Vector3 _visibleLocalPosition;

	public BetterAnimation anim;

	public ITabItem Tab
	{
		get
		{
			return _tabItem;
		}
		set
		{
			if (_tabItem == value)
			{
				return;
			}
			ITabItem tabItem = _tabItem;
			_tabItem = value;
			if (value != null)
			{
				value.Content = this;
				if (value is BaseTabToggle baseTabToggle)
				{
					baseTabToggle.OnTabActiveCallback = (Action<BaseTabToggle>)Delegate.Combine(baseTabToggle.OnTabActiveCallback, new Action<BaseTabToggle>(OnTabActive));
					baseTabToggle.OnTabDeActiveCallback = (Action<BaseTabToggle>)Delegate.Combine(baseTabToggle.OnTabDeActiveCallback, new Action<BaseTabToggle>(OnTabDeActive));
				}
			}
			OnBindTabChanged(tabItem, value);
		}
	}

	public bool IsActive
	{
		get
		{
			if ((bool)gameObject)
			{
				return _isTabContentActive;
			}
			return false;
		}
	}

	public virtual void PlayOpenAnim()
	{
		if (anim != null)
		{
			anim.GetSequence("Show")?.Play();
		}
	}

	public virtual void PlayCloseAnim(Action onComplete = null)
	{
		AnimationBuilder animationBuilder = anim?.GetSequence("Hide");
		if (animationBuilder != null)
		{
			animationBuilder.OnComplete((AnimationBuilder _) =>
			{
				onComplete?.Invoke();
			}).Play();
		}
		else
		{
			onComplete?.Invoke();
		}
	}

	public virtual async UniTask PlayCloseAnim(CancellationToken token)
	{
		if (anim != null)
		{
			await anim.GetSequence("Hide").Play().AwaitComplete();
		}
	}

	public void Release()
	{
		OnRelease();
	}

	protected virtual void OnRelease()
	{
	}

	protected virtual void OnTabActive(ITabItem tabItem)
	{
		_tabItem = tabItem;
		SetContentVisible(visible: true);
		PlayOpenAnim();
		NotifyInputControllerTabActive(tabItem);
	}

	protected virtual void OnTabDeActive(ITabItem tabItem)
	{
		try
		{
			PlayCloseAnim(() =>
			{
				SetContentVisible(visible: false);
			});
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
			SetContentVisible(visible: false);
		}
		NotifyInputControllerTabDeActive(tabItem);
	}

	public void SetContentVisible(bool visible)
	{
		if (visible)
		{
			if (!gameObject.activeSelf)
			{
				gameObject.SetActive(value: true);
			}
			_isTabContentActive = true;
			if (_cachedVisiblePosition)
			{
				transform.localPosition = _visibleLocalPosition;
			}
		}
		else
		{
			if (!_cachedVisiblePosition)
			{
				_visibleLocalPosition = transform.localPosition;
				_cachedVisiblePosition = true;
			}
			_isTabContentActive = false;
			transform.localPosition = HiddenPosition;
		}
	}

	private void NotifyInputControllerTabActive(ITabItem tabItem)
	{
		if (CreateInputBindingController() is ITabContentInputController tabContentInputController)
		{
			tabContentInputController.OnTabActive(tabItem);
		}
	}

	private void NotifyInputControllerTabDeActive(ITabItem tabItem)
	{
		if (GetController() is ITabContentInputController tabContentInputController)
		{
			tabContentInputController.OnTabDeActive(tabItem);
		}
	}

	protected virtual void OnBindTabChanged(ITabItem oldTab, ITabItem newTab)
	{
	}

	public virtual void OnPushStack()
	{
		PlayCloseAnim();
	}

	public virtual void OnPopStack()
	{
		PlayOpenAnim();
	}
}
