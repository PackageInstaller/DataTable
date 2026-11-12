using UnityEngine;
using UnityEngine.UI;

public class RectangleGraphicIndicator : BaseGraphicIndicator
{
	public Image baseGraphic;

	public Image progressGraphic;

	protected float _width = 1f;

	protected float _height = 2f;

	public override Color baseColor
	{
		get
		{
			return baseGraphic.color;
		}
		set
		{
			baseGraphic.color = value;
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
			progressGraphic.color = value;
		}
	}

	public float width
	{
		get
		{
			return _width;
		}
		set
		{
			_width = value;
			RefreshBaseGraphic();
			RefreshProgressGraphic();
		}
	}

	public float height
	{
		get
		{
			return _height;
		}
		set
		{
			_height = value;
			RefreshBaseGraphic();
			RefreshProgressGraphic();
		}
	}

	protected override void Awake()
	{
		baseGraphic.rectTransform.pivot = new Vector2(0.5f, 0f);
		progressGraphic.rectTransform.anchorMin = new Vector2(0.5f, 0f);
		progressGraphic.rectTransform.anchorMax = new Vector2(0.5f, 0f);
		progressGraphic.rectTransform.pivot = new Vector2(0.5f, 0f);
		base.Awake();
	}

	protected override void RefreshBaseGraphic()
	{
		baseGraphic.rectTransform.sizeDelta = new Vector2(_width, _height);
		baseGraphic.SetVerticesDirty();
	}

	protected override void RefreshProgressGraphic()
	{
		progressGraphic.rectTransform.sizeDelta = new Vector2(_width, _height * _progress);
		progressGraphic.SetVerticesDirty();
	}
}
