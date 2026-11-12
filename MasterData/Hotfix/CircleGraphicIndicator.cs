using UnityEngine;
using UnityEngine.UI.Extensions;

public class CircleGraphicIndicator : BaseGraphicIndicator
{
	public UICircle baseGraphic;

	public UICircle progressGraphic;

	protected float _size = 1f;

	public override Color baseColor
	{
		get
		{
			return baseGraphic.color;
		}
		set
		{
			baseGraphic.SetBaseColor(value);
		}
	}

	public override Color progressColor
	{
		get
		{
			return progressGraphic.color;
		}
		set
		{
			progressGraphic.SetBaseColor(value);
		}
	}

	public float size
	{
		get
		{
			return _size;
		}
		set
		{
			if (_size != value)
			{
				_size = value;
				RefreshBaseGraphic();
				RefreshProgressGraphic();
			}
		}
	}

	protected override void RefreshBaseGraphic()
	{
		baseGraphic.rectTransform.sizeDelta = new Vector2(_size, _size);
		baseGraphic.SetVerticesDirty();
	}

	protected override void RefreshProgressGraphic()
	{
		progressGraphic.rectTransform.sizeDelta = new Vector2(_size * _progress, _size * _progress);
		progressGraphic.SetVerticesDirty();
	}
}
