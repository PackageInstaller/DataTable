using System;
using UnityEngine;

[Serializable]
public class LTRect
{
	public Rect _rect;

	public float alpha = 1f;

	public float rotation;

	public Vector2 pivot;

	public Vector2 margin;

	public Rect relativeRect = new Rect(0f, 0f, float.PositiveInfinity, float.PositiveInfinity);

	public bool rotateEnabled;

	[HideInInspector]
	public bool rotateFinished;

	public bool alphaEnabled;

	public string labelStr;

	public LTGUI.Element_Type type;

	public GUIStyle style;

	public bool useColor;

	public Color color = Color.white;

	public bool fontScaleToFit;

	public bool useSimpleScale;

	public bool sizeByHeight;

	public Texture texture;

	private int _id = -1;

	[HideInInspector]
	public int counter;

	public static bool colorTouched;

	public bool hasInitiliazed => _id != -1;

	public int id => _id | (counter << 16);

	public float x
	{
		get
		{
			return _rect.x;
		}
		set
		{
			_rect.x = value;
		}
	}

	public float y
	{
		get
		{
			return _rect.y;
		}
		set
		{
			_rect.y = value;
		}
	}

	public float width
	{
		get
		{
			return _rect.width;
		}
		set
		{
			_rect.width = value;
		}
	}

	public float height
	{
		get
		{
			return _rect.height;
		}
		set
		{
			_rect.height = value;
		}
	}

	public Rect rect
	{
		get
		{
			if (colorTouched)
			{
				colorTouched = false;
				GUI.color = new Color(GUI.color.r, GUI.color.g, GUI.color.b, 1f);
			}
			if (rotateEnabled)
			{
				if (rotateFinished)
				{
					rotateFinished = false;
					rotateEnabled = false;
					pivot = Vector2.zero;
				}
				else
				{
					GUIUtility.RotateAroundPivot(rotation, pivot);
				}
			}
			if (alphaEnabled)
			{
				GUI.color = new Color(GUI.color.r, GUI.color.g, GUI.color.b, alpha);
				colorTouched = true;
			}
			if (fontScaleToFit)
			{
				if (useSimpleScale)
				{
					style.fontSize = (int)(_rect.height * relativeRect.height);
				}
				else
				{
					style.fontSize = (int)_rect.height;
				}
			}
			return _rect;
		}
		set
		{
			_rect = value;
		}
	}

	public LTRect()
	{
		reset();
		rotateEnabled = (alphaEnabled = true);
		_rect = new Rect(0f, 0f, 1f, 1f);
	}

	public LTRect(Rect rect)
	{
		_rect = rect;
		reset();
	}

	public LTRect(float x, float y, float width, float height)
	{
		_rect = new Rect(x, y, width, height);
		alpha = 1f;
		rotation = 0f;
		rotateEnabled = (alphaEnabled = false);
	}

	public LTRect(float x, float y, float width, float height, float alpha)
	{
		_rect = new Rect(x, y, width, height);
		this.alpha = alpha;
		rotation = 0f;
		rotateEnabled = (alphaEnabled = false);
	}

	public LTRect(float x, float y, float width, float height, float alpha, float rotation)
	{
		_rect = new Rect(x, y, width, height);
		this.alpha = alpha;
		this.rotation = rotation;
		rotateEnabled = (alphaEnabled = false);
		if (rotation != 0f)
		{
			rotateEnabled = true;
			resetForRotation();
		}
	}

	public void setId(int id, int counter)
	{
		_id = id;
		this.counter = counter;
	}

	public void reset()
	{
		alpha = 1f;
		rotation = 0f;
		rotateEnabled = (alphaEnabled = false);
		margin = Vector2.zero;
		sizeByHeight = false;
		useColor = false;
	}

	public void resetForRotation()
	{
		Vector3 vector = new Vector3(GUI.matrix[0, 0], GUI.matrix[1, 1], GUI.matrix[2, 2]);
		if (pivot == Vector2.zero)
		{
			pivot = new Vector2((_rect.x + _rect.width * 0.5f) * vector.x + GUI.matrix[0, 3], (_rect.y + _rect.height * 0.5f) * vector.y + GUI.matrix[1, 3]);
		}
	}

	public LTRect setStyle(GUIStyle style)
	{
		this.style = style;
		return this;
	}

	public LTRect setFontScaleToFit(bool fontScaleToFit)
	{
		this.fontScaleToFit = fontScaleToFit;
		return this;
	}

	public LTRect setColor(Color color)
	{
		this.color = color;
		useColor = true;
		return this;
	}

	public LTRect setAlpha(float alpha)
	{
		this.alpha = alpha;
		return this;
	}

	public LTRect setLabel(string str)
	{
		labelStr = str;
		return this;
	}

	public LTRect setUseSimpleScale(bool useSimpleScale, Rect relativeRect)
	{
		this.useSimpleScale = useSimpleScale;
		this.relativeRect = relativeRect;
		return this;
	}

	public LTRect setUseSimpleScale(bool useSimpleScale)
	{
		this.useSimpleScale = useSimpleScale;
		relativeRect = new Rect(0f, 0f, Screen.width, Screen.height);
		return this;
	}

	public LTRect setSizeByHeight(bool sizeByHeight)
	{
		this.sizeByHeight = sizeByHeight;
		return this;
	}

	public override string ToString()
	{
		return "x:" + _rect.x + " y:" + _rect.y + " width:" + _rect.width + " height:" + _rect.height;
	}
}
