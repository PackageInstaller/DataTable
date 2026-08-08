using UnityEngine;

public class LTGUI
{
	public enum Element_Type
	{
		Texture,
		Label
	}

	public static int RECT_LEVELS = 5;

	public static int RECTS_PER_LEVEL = 10;

	public static int BUTTONS_MAX = 24;

	private static LTRect[] levels;

	private static int[] levelDepths;

	private static Rect[] buttons;

	private static int[] buttonLevels;

	private static int[] buttonLastFrame;

	private static LTRect r;

	private static Color color = Color.white;

	private static bool isGUIEnabled = false;

	private static int global_counter = 0;

	public static void init()
	{
		if (levels == null)
		{
			levels = new LTRect[RECT_LEVELS * RECTS_PER_LEVEL];
			levelDepths = new int[RECT_LEVELS];
		}
	}

	public static void initRectCheck()
	{
		if (buttons == null)
		{
			buttons = new Rect[BUTTONS_MAX];
			buttonLevels = new int[BUTTONS_MAX];
			buttonLastFrame = new int[BUTTONS_MAX];
			for (int i = 0; i < buttonLevels.Length; i++)
			{
				buttonLevels[i] = -1;
			}
		}
	}

	public static void reset()
	{
		if (isGUIEnabled)
		{
			isGUIEnabled = false;
			for (int i = 0; i < levels.Length; i++)
			{
				levels[i] = null;
			}
			for (int j = 0; j < levelDepths.Length; j++)
			{
				levelDepths[j] = 0;
			}
		}
	}

	public static void update(int updateLevel)
	{
		if (!isGUIEnabled)
		{
			return;
		}
		init();
		if (levelDepths[updateLevel] <= 0)
		{
			return;
		}
		color = GUI.color;
		int num = updateLevel * RECTS_PER_LEVEL;
		int num2 = num + levelDepths[updateLevel];
		for (int i = num; i < num2; i++)
		{
			r = levels[i];
			if (r == null)
			{
				continue;
			}
			if (r.useColor)
			{
				GUI.color = r.color;
			}
			if (r.type == Element_Type.Label)
			{
				if (r.style != null)
				{
					GUI.skin.label = r.style;
				}
				if (r.useSimpleScale)
				{
					GUI.Label(new Rect((r.rect.x + r.margin.x + r.relativeRect.x) * r.relativeRect.width, (r.rect.y + r.margin.y + r.relativeRect.y) * r.relativeRect.height, r.rect.width * r.relativeRect.width, r.rect.height * r.relativeRect.height), r.labelStr);
				}
				else
				{
					GUI.Label(new Rect(r.rect.x + r.margin.x, r.rect.y + r.margin.y, r.rect.width, r.rect.height), r.labelStr);
				}
			}
			else if (r.type == Element_Type.Texture && r.texture != null)
			{
				Vector2 vector = (r.useSimpleScale ? new Vector2(0f, r.rect.height * r.relativeRect.height) : new Vector2(r.rect.width, r.rect.height));
				if (r.sizeByHeight)
				{
					vector.x = (float)r.texture.width / (float)r.texture.height * vector.y;
				}
				if (r.useSimpleScale)
				{
					GUI.DrawTexture(new Rect((r.rect.x + r.margin.x + r.relativeRect.x) * r.relativeRect.width, (r.rect.y + r.margin.y + r.relativeRect.y) * r.relativeRect.height, vector.x, vector.y), r.texture);
				}
				else
				{
					GUI.DrawTexture(new Rect(r.rect.x + r.margin.x, r.rect.y + r.margin.y, vector.x, vector.y), r.texture);
				}
			}
		}
		GUI.color = color;
	}

	public static bool checkOnScreen(Rect rect)
	{
		bool num = rect.x + rect.width < 0f;
		bool flag = rect.x > (float)Screen.width;
		bool flag2 = rect.y > (float)Screen.height;
		bool flag3 = rect.y + rect.height < 0f;
		return !(num | flag | flag2 | flag3);
	}

	public static void destroy(int id)
	{
		int num = id & 0xFFFF;
		int num2 = id >> 16;
		if (id >= 0 && levels[num] != null && levels[num].hasInitiliazed && levels[num].counter == num2)
		{
			levels[num] = null;
		}
	}

	public static void destroyAll(int depth)
	{
		int num = depth * RECTS_PER_LEVEL + RECTS_PER_LEVEL;
		int num2 = depth * RECTS_PER_LEVEL;
		while (levels != null && num2 < num)
		{
			levels[num2] = null;
			num2++;
		}
	}

	public static LTRect label(Rect rect, string label, int depth)
	{
		return LTGUI.label(new LTRect(rect), label, depth);
	}

	public static LTRect label(LTRect rect, string label, int depth)
	{
		rect.type = Element_Type.Label;
		rect.labelStr = label;
		return element(rect, depth);
	}

	public static LTRect texture(Rect rect, Texture texture, int depth)
	{
		return LTGUI.texture(new LTRect(rect), texture, depth);
	}

	public static LTRect texture(LTRect rect, Texture texture, int depth)
	{
		rect.type = Element_Type.Texture;
		rect.texture = texture;
		return element(rect, depth);
	}

	public static LTRect element(LTRect rect, int depth)
	{
		isGUIEnabled = true;
		init();
		int num = depth * RECTS_PER_LEVEL + RECTS_PER_LEVEL;
		int num2 = 0;
		if (rect != null)
		{
			destroy(rect.id);
		}
		if (rect.type == Element_Type.Label && rect.style != null && rect.style.normal.textColor.a <= 0f)
		{
			Debug.LogWarning("Your GUI normal color has an alpha of zero, and will not be rendered.");
		}
		if (rect.relativeRect.width == float.PositiveInfinity)
		{
			rect.relativeRect = new Rect(0f, 0f, Screen.width, Screen.height);
		}
		for (int i = depth * RECTS_PER_LEVEL; i < num; i++)
		{
			r = levels[i];
			if (r == null)
			{
				r = rect;
				r.rotateEnabled = true;
				r.alphaEnabled = true;
				r.setId(i, global_counter);
				levels[i] = r;
				if (num2 >= levelDepths[depth])
				{
					levelDepths[depth] = num2 + 1;
				}
				global_counter++;
				return r;
			}
			num2++;
		}
		Debug.LogError("You ran out of GUI Element spaces");
		return null;
	}

	public static bool hasNoOverlap(Rect rect, int depth)
	{
		initRectCheck();
		bool result = true;
		bool flag = false;
		for (int i = 0; i < buttonLevels.Length; i++)
		{
			if (buttonLevels[i] >= 0)
			{
				if (buttonLastFrame[i] + 1 < Time.frameCount)
				{
					buttonLevels[i] = -1;
				}
				else if (buttonLevels[i] > depth && pressedWithinRect(buttons[i]))
				{
					result = false;
				}
			}
			if (!flag && buttonLevels[i] < 0)
			{
				flag = true;
				buttonLevels[i] = depth;
				buttons[i] = rect;
				buttonLastFrame[i] = Time.frameCount;
			}
		}
		return result;
	}

	public static bool pressedWithinRect(Rect rect)
	{
		Vector2 vector = firstTouch();
		if (vector.x < 0f)
		{
			return false;
		}
		float num = (float)Screen.height - vector.y;
		if (vector.x > rect.x && vector.x < rect.x + rect.width && num > rect.y)
		{
			return num < rect.y + rect.height;
		}
		return false;
	}

	public static bool checkWithinRect(Vector2 vec2, Rect rect)
	{
		vec2.y = (float)Screen.height - vec2.y;
		if (vec2.x > rect.x && vec2.x < rect.x + rect.width && vec2.y > rect.y)
		{
			return vec2.y < rect.y + rect.height;
		}
		return false;
	}

	public static Vector2 firstTouch()
	{
		if (Input.touchCount > 0)
		{
			return Input.touches[0].position;
		}
		if (Input.GetMouseButton(0))
		{
			return Input.mousePosition;
		}
		return new Vector2(float.NegativeInfinity, float.NegativeInfinity);
	}
}
