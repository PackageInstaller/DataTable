using System;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class InteractivePointData : ItemOptionBase
{
	private InteractivePoint.PointInfo _pointInfo = new InteractivePoint.PointInfo(InteractivePoint.PointType.None, 0, string.Empty, Vector2.zero);

	private string icon = "";

	private Vector2 pos;

	private Vector3 scale = Vector3.one;

	private bool isLock;

	private InteractionRequest _playShowAnimation = new InteractionRequest();

	private InteractionRequest _playHideAnimation = new InteractionRequest();

	public InteractivePoint.PointInfo PointInfo
	{
		get
		{
			return _pointInfo;
		}
		set
		{
			Set(ref _pointInfo, value, "PointInfo");
		}
	}

	public string Icon
	{
		get
		{
			return icon;
		}
		set
		{
			Set(ref icon, value, "Icon");
		}
	}

	public Vector2 Pos
	{
		get
		{
			return pos;
		}
		set
		{
			Set(ref pos, value, "Pos");
		}
	}

	public Vector3 Scale
	{
		get
		{
			return scale;
		}
		private set
		{
			Set(ref scale, value, "Scale");
		}
	}

	public bool IsLock
	{
		get
		{
			return isLock;
		}
		set
		{
			Set(ref isLock, value, "IsLock");
		}
	}

	public InteractionRequest PlayShowAnimation => _playShowAnimation;

	public InteractionRequest PlayHideAnimation => _playHideAnimation;

	public InteractivePointData()
	{
	}

	public InteractivePointData(OptionBase parent, InteractivePoint.PointInfo pointInfo)
	{
		base.parent = parent;
		Icon = InteractivePoint.GetPointIcon(pointInfo);
		PointInfo = pointInfo;
		Pos = pointInfo.Pos;
	}

	public virtual void SetScale(float scale)
	{
		Scale = Vector3.one * scale;
	}

	public void OnClick()
	{
		if (!isLock)
		{
			parent?.ItemOnClick(this);
		}
	}

	public void PlayAnimation(InteractivePoint.AnimationType type, Action action = null)
	{
		switch (type)
		{
		case InteractivePoint.AnimationType.Enter:
			_playShowAnimation.Raise(action);
			break;
		case InteractivePoint.AnimationType.Out:
			_playHideAnimation.Raise(action);
			break;
		}
	}
}
