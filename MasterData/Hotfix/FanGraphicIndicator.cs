using UnityEngine;
using UnityEngine.UI.Extensions;

public class FanGraphicIndicator : BaseGraphicIndicator
{
	public UICircle baseGraphic;

	public UICircle progressGraphic;

	protected float _size = 1f;

	protected float _angle = 45f;

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
			_size = value;
			RefreshBaseGraphic();
			RefreshProgressGraphic();
		}
	}

	public float angle
	{
		get
		{
			return _angle;
		}
		set
		{
			_angle = value;
			RefreshBaseGraphic();
			RefreshProgressGraphic();
		}
	}

	protected override void RefreshBaseGraphic()
	{
		baseGraphic.rectTransform.sizeDelta = new Vector2(_size * 2f, _size * 2f);
		baseGraphic.Arc = _angle / 360f;
		baseGraphic.ArcRotation = Mathf.RoundToInt(90f - _angle / 2f);
		baseGraphic.SetVerticesDirty();
	}

	protected override void RefreshProgressGraphic()
	{
		progressGraphic.rectTransform.sizeDelta = new Vector2(_size * 2f * _progress, _size * 2f * _progress);
		progressGraphic.Arc = _angle / 360f;
		progressGraphic.ArcRotation = Mathf.RoundToInt(90f - _angle / 2f);
		progressGraphic.SetVerticesDirty();
	}
}
