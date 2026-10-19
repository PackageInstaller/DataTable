using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class PostureBarMulti : PostureBarBase
{
	[SerializeField]
	private BetterAnimation barAnimation;

	[SerializeField]
	private LayoutElement layoutElement;

	[SerializeField]
	private string initAnimation;

	[SerializeField]
	private string postureChangeAnimation;

	[SerializeField]
	private string weakEnterAnimation;

	private int _index;

	private static readonly Color LockedFrontColor = new Color32(160, 160, 158, byte.MaxValue);

	private Color _frontOriginalColor;

	private bool _frontColorCached;

	public override void Init(EntityUIInfo entityUIInfo, bool playInitAnimation = true)
	{
		base.Init(entityUIInfo, playInitAnimation);
		layoutElement.flexibleWidth = ((_index == 0) ? EntityUIInfo.PosturePartsVal[_index] : (EntityUIInfo.PosturePartsVal[_index] - EntityUIInfo.PosturePartsVal[_index - 1]));
		int curPartsIndex = EntityUIInfo.CurPartsIndex;
		if (_index < curPartsIndex)
		{
			InitBarVal(1f);
		}
		else if (_index == curPartsIndex)
		{
			InitBarVal(GetPartVal() / GetPartMaxVal());
		}
		else
		{
			InitBarVal(0f);
		}
		SetFrontLocked(EntityUIInfo.InWeak);
		mainAnimation?.GetSequence(initAnimation)?.Play()?.Complete();
	}

	public void SetIndex(int index)
	{
		_index = index;
	}

	public override void OnPostureValChange()
	{
		base.OnPostureValChange();
		if (_index == EntityUIInfo.CurPartsIndex)
		{
			bar.TargetValue = GetPartVal() / GetPartMaxVal();
			barAnimation?.GetSequence(postureChangeAnimation)?.Play();
		}
	}

	public override void OnEnterWeak()
	{
		mainAnimation?.GetSequence(weakEnterAnimation)?.Play();
	}

	public void SetFrontLocked(bool locked)
	{
		if (bar == null || bar.images == null)
		{
			return;
		}
		if (locked)
		{
			for (int i = 0; i < bar.images.Length; i++)
			{
				Image ui = bar.images[i].ui;
				if (!(ui == null))
				{
					if (!_frontColorCached)
					{
						_frontOriginalColor = ui.color;
						_frontColorCached = true;
					}
					ui.color = LockedFrontColor;
				}
			}
		}
		else
		{
			if (!_frontColorCached)
			{
				return;
			}
			for (int j = 0; j < bar.images.Length; j++)
			{
				Image ui2 = bar.images[j].ui;
				if (!(ui2 == null))
				{
					ui2.color = _frontOriginalColor;
				}
			}
		}
	}

	private float GetPartVal()
	{
		return EntityUIInfo.CurPosturePercentage - ((_index == 0) ? 0f : EntityUIInfo.PosturePartsVal[_index - 1]);
	}

	private float GetPartMaxVal()
	{
		return EntityUIInfo.PosturePartsVal[_index] - ((_index == 0) ? 0f : EntityUIInfo.PosturePartsVal[_index - 1]);
	}
}
