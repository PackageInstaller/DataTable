using UnityEngine.Events;

namespace ACT.UI;

public class AnimateToggle : PublicToggle, IUIFrameElement
{
	private bool isClick;

	private UnityAction m_CachedCallBack;

	private bool _curToggleIsOn;

	protected override void Awake()
	{
		base.Awake();
		m_CachedCallBack = () =>
		{
			isClick = true;
		};
		onMouseClick.AddListener(m_CachedCallBack);
		onValueChanged.AddListener(PlayAnimator);
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		if (m_CachedCallBack != null)
		{
			onMouseClick.RemoveListener(m_CachedCallBack);
		}
		onValueChanged.RemoveListener(PlayAnimator);
	}

	private void PlayAnimator(bool isOn)
	{
		if (_curToggleIsOn & isOn)
		{
			return;
		}
		_curToggleIsOn = isOn;
		if (!anim.gameObject.activeInHierarchy)
		{
			return;
		}
		if (isClick)
		{
			if (isOn)
			{
				anim.GetSequence("open").Play();
			}
			else
			{
				anim.GetSequence("close").Play();
			}
		}
		else
		{
			ForcedChangeAnimStateTo();
		}
	}

	private void ForcedChangeAnimStateTo()
	{
		if (isOn)
		{
			anim.GetSequence("open").Play().Complete();
		}
		else
		{
			anim.GetSequence("close").Play().Complete();
		}
	}

	private new void OnEnable()
	{
	}
}
