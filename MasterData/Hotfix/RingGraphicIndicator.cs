using UnityEngine;
using UnityEngine.UI.Extensions;

public class RingGraphicIndicator : BaseGraphicIndicator
{
	public UICircle baseGraphic;

	public UICircle progressGraphic;

	protected float _size = 1f;

	protected float _thickness = 0.25f;

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
			return progressGraphic.ProgressColor;
		}
		set
		{
			progressGraphic.SetProgressColor(value);
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

	public float thickness
	{
		get
		{
			return _thickness;
		}
		set
		{
			_thickness = value;
			RefreshBaseGraphic();
			RefreshProgressGraphic();
		}
	}

	protected override void RefreshBaseGraphic()
	{
		baseGraphic.rectTransform.sizeDelta = new Vector2(_size, _size);
		baseGraphic.Thickness = _thickness;
		baseGraphic.SetVerticesDirty();
	}

	protected override void RefreshProgressGraphic()
	{
		progressGraphic.rectTransform.sizeDelta = baseGraphic.rectTransform.sizeDelta;
		progressGraphic.Thickness = _thickness;
		progressGraphic.Progress = _progress;
		progressGraphic.SetVerticesDirty();
	}
}
