using System;
using UnityEngine;

namespace Com.ForbiddenByte.OSA.Core.SubComponents;

public class SimpleViewportSnapshot
{
	private IOSA _OSA;

	private int _FirstVisVHIndex = -1;

	private double _FirstVisVHInset;

	private Vector2? _Velocity;

	public SimpleViewportSnapshot(IOSA osa, bool velocity = true)
	{
		_OSA = osa;
		BaseItemViewsHolder baseItemViewsHolder = osa.GetBaseItemViewsHolder(1);
		if (baseItemViewsHolder == null)
		{
			baseItemViewsHolder = osa.GetBaseItemViewsHolder(0);
		}
		if (baseItemViewsHolder != null)
		{
			_FirstVisVHIndex = baseItemViewsHolder.ItemIndex;
			_FirstVisVHInset = osa.GetItemRealInsetFromParentStart(baseItemViewsHolder.root);
			if (velocity)
			{
				_Velocity = osa.Velocity;
			}
		}
	}

	public bool Restore()
	{
		if (_FirstVisVHIndex == -1)
		{
			return false;
		}
		RestorePos();
		int num = 10;
		while (num-- > 0)
		{
			BaseItemViewsHolder baseItemViewsHolderIfVisible = _OSA.GetBaseItemViewsHolderIfVisible(_FirstVisVHIndex);
			bool flag = baseItemViewsHolderIfVisible == null;
			if (!flag)
			{
				flag = Math.Abs((double)_OSA.GetItemRealInsetFromParentStart(baseItemViewsHolderIfVisible.root) - _FirstVisVHInset) > 1.0;
			}
			if (flag)
			{
				RestorePos();
			}
		}
		if (_Velocity.HasValue)
		{
			_OSA.Velocity = _Velocity.Value;
		}
		return true;
	}

	private void RestorePos()
	{
		float height = _OSA.BaseParameters.Content.rect.height;
		double num = _FirstVisVHInset / (double)height;
		_OSA.ScrollTo(_FirstVisVHIndex, (float)num);
	}
}
