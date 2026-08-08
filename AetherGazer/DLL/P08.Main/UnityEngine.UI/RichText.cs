using System;
using System.Collections.Generic;
using System.Reflection;
using System.Text;
using System.Text.RegularExpressions;
using UnityEngine.EventSystems;

namespace UnityEngine.UI;

[ExecuteInEditMode]
public class RichText : Text, IPointerClickHandler, IEventSystemHandler
{
	[Serializable]
	public struct SpriteName
	{
		public string name;

		public Sprite sprite;
	}

	private class IconInfo
	{
		public string name;

		public bool still;

		public Color color;

		public Vector2 position;

		public Vector2 size;

		public int vertice;

		public int showVertice;

		public int vlength;

		public string e;

		public string args;

		public int startCharIndex => vertice / 4;

		public int endCharIndex => startCharIndex + vlength / 4 - 1;
	}

	private class Event
	{
		public Rect rect;

		public string name;

		public string args;
	}

	private class TextInterpreter
	{
		private static readonly Regex TagReg = new Regex("</*material[^>]*>");

		private static readonly Regex CommonTagReg = new Regex("<[^>]*>");

		private const string TagSuffix = "</material>";

		private List<Tag> close;

		private Stack<InterpretInfo> open;

		private static int[] indexMap = new int[8192];

		public TextInterpreter()
		{
			close = new List<Tag>();
			open = new Stack<InterpretInfo>();
		}

		public void Parse(string richText, List<int> extra_space, out List<Tag> tags)
		{
			int length = richText.Length;
			for (int i = 0; i < length; i++)
			{
				indexMap[i] = (char.IsWhiteSpace(richText[i]) ? (-1) : 0);
			}
			foreach (int item in extra_space)
			{
				indexMap[item] = 0;
			}
			Match match = CommonTagReg.Match(richText);
			while (match.Success)
			{
				for (int j = match.Index; j < match.Index + match.Length; j++)
				{
					indexMap[j] = -1;
				}
				match = match.NextMatch();
			}
			int num = 0;
			for (int k = 0; k < length; k++)
			{
				if (indexMap[k] == 0)
				{
					indexMap[k] = num++;
				}
			}
			close.Clear();
			open.Clear();
			Match match2 = TagReg.Match(richText);
			while (match2.Success)
			{
				if (match2.Value == "</material>")
				{
					if (open.Count > 0)
					{
						InterpretInfo interpretInfo = open.Pop();
						interpretInfo.end = match2.Index - 1;
						if (interpretInfo.end >= interpretInfo.start)
						{
							Tag tag = interpretInfo.ToTag();
							tag.start = indexMap[tag.start];
							tag.end = indexMap[tag.end];
							if (tag != null)
							{
								close.Add(tag);
							}
						}
					}
				}
				else
				{
					InterpretInfo interpretInfo2 = new InterpretInfo();
					interpretInfo2.str = match2.Value;
					interpretInfo2.start = match2.Index + match2.Length;
					open.Push(interpretInfo2);
				}
				match2 = match2.NextMatch();
			}
			tags = close;
		}
	}

	private class InterpretInfo
	{
		private static readonly Regex TagReg = new Regex("<material=([^>\\s]+)([^>]*)>");

		private static readonly Regex ItemReg = new Regex("(\\w+)=([^\\s]+)");

		public string str;

		public int start;

		public int end;

		public Tag ToTag()
		{
			Tag tag = null;
			Match match = TagReg.Match(str);
			if (match.Success)
			{
				string value = match.Groups[1].Value;
				if (!value.StartsWith("#"))
				{
					MatchCollection matchCollection = ItemReg.Matches(match.Groups[2].Value);
					switch (value)
					{
					case "shadow":
						tag = new Shadow();
						break;
					case "outline":
						tag = new Outline();
						break;
					case "gradient":
						tag = new GradientL();
						break;
					case "underline":
						tag = new Underline();
						break;
					case "strike":
						tag = new Strike();
						break;
					}
					if (tag != null)
					{
						tag.start = start;
						tag.end = end;
						for (int i = 0; i < matchCollection.Count; i++)
						{
							string value2 = matchCollection[i].Groups[1].Value;
							string value3 = matchCollection[i].Groups[2].Value;
							tag.SetValue(value2, value3);
						}
					}
				}
			}
			return tag;
		}
	}

	private enum TagType
	{
		None,
		Shadow,
		Outline,
		Gradient,
		Underline,
		Strike
	}

	private abstract class Tag
	{
		public int start;

		public int end;

		public virtual TagType type => TagType.None;

		public virtual void SetValue(string name, string value)
		{
		}
	}

	private class Shadow : Tag
	{
		public Color c = Color.black;

		public float x = 1f;

		public float y = -1f;

		public override TagType type => TagType.Shadow;

		public override void SetValue(string name, string value)
		{
			base.SetValue(name, value);
			switch (name)
			{
			case "c":
				ColorUtility.TryParseHtmlString(value, out c);
				break;
			case "x":
				float.TryParse(value, out x);
				break;
			case "y":
				float.TryParse(value, out y);
				break;
			}
		}
	}

	private class Outline : Shadow
	{
		public override TagType type => TagType.Outline;
	}

	private class GradientL : Tag
	{
		public Color from = Color.white;

		public Color to = Color.black;

		public float x;

		public float y = -1f;

		public override TagType type => TagType.Gradient;

		public override void SetValue(string name, string value)
		{
			base.SetValue(name, value);
			switch (name)
			{
			case "from":
				ColorUtility.TryParseHtmlString(value, out from);
				break;
			case "to":
				ColorUtility.TryParseHtmlString(value, out to);
				break;
			case "x":
				float.TryParse(value, out x);
				break;
			case "y":
				float.TryParse(value, out y);
				break;
			}
		}
	}

	private class Underline : Tag
	{
		public Color c = Color.white;

		public float h = 1.5f;

		public string e;

		public string args;

		public override TagType type => TagType.Underline;

		public override void SetValue(string name, string value)
		{
			base.SetValue(name, value);
			switch (name)
			{
			case "c":
				ColorUtility.TryParseHtmlString(value, out c);
				break;
			case "h":
				float.TryParse(value, out h);
				break;
			case "event":
				e = value;
				break;
			case "args":
				args = value;
				break;
			}
		}
	}

	private class Strike : Tag
	{
		public Color c = Color.white;

		public float h = 1.5f;

		public string e;

		public string args;

		public override TagType type => TagType.Strike;

		public override void SetValue(string name, string value)
		{
			base.SetValue(name, value);
			switch (name)
			{
			case "c":
				ColorUtility.TryParseHtmlString(value, out c);
				break;
			case "h":
				float.TryParse(value, out h);
				break;
			case "event":
				e = value;
				break;
			case "args":
				args = value;
				break;
			}
		}
	}

	private FontData fontData;

	private UIVertex[] tempVerts;

	private TextInterpreter textInterpreter = new TextInterpreter();

	private Action<string, string> clickHandler = delegate
	{
	};

	private Action<string[], string[]> _onEventListUpdate;

	private static readonly Regex IconReg = new Regex("<icon name=([^>\\s]+)([^>]*)/>");

	private static readonly Regex ItemReg = new Regex("(\\w+)=([^\\s]+)");

	private const char ReplaceChar = '\u00a0';

	private const char ReplaceVerticeChar = ';';

	public SpriteName[] inspectorSpriteList;

	[SerializeField]
	private bool fitSpriteHeight;

	private Dictionary<string, Sprite> spriteList = new Dictionary<string, Sprite>();

	private List<Image> imagePool = new List<Image>();

	private List<IconInfo> icons = new List<IconInfo>();

	private bool imageDirty;

	private bool vertsDirty;

	private List<Event> eventList = new List<Event>();

	private const string materialTagBegin = "<material";

	private const string materialTagBeginCloseEnd = ">";

	private const string materialTagEnd = "</material>";

	private const string colorTagBegin = "<color";

	private const string colorTagBeginCloseEnd = ">";

	private const string colorTagEnd = "</color>";

	private string realContent = "";

	public override float preferredHeight
	{
		get
		{
			if (vertsDirty)
			{
				vertsDirty = false;
				realContent = CalculateLayoutWithImage(text, out var _);
			}
			TextGenerationSettings generationSettings = GetGenerationSettings(new Vector2(GetPixelAdjustedRect().size.x, 0f));
			return base.cachedTextGeneratorForLayout.GetPreferredHeight(realContent, generationSettings) / base.pixelsPerUnit;
		}
	}

	protected RichText()
	{
		fontData = typeof(Text).GetField("m_FontData", BindingFlags.Instance | BindingFlags.NonPublic).GetValue(this) as FontData;
		tempVerts = typeof(Text).GetField("m_TempVerts", BindingFlags.Instance | BindingFlags.NonPublic).GetValue(this) as UIVertex[];
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		UpdateSpriteList();
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		ClearSprite();
		imagePool = null;
		inspectorSpriteList = null;
		spriteList = null;
		clickHandler = null;
	}

	public override void SetVerticesDirty()
	{
		base.SetVerticesDirty();
		vertsDirty = true;
	}

	public void UpdateSpriteList()
	{
		spriteList.Clear();
		if (inspectorSpriteList != null && inspectorSpriteList.Length != 0)
		{
			SpriteName[] array = inspectorSpriteList;
			for (int i = 0; i < array.Length; i++)
			{
				SpriteName spriteName = array[i];
				spriteList[spriteName.name] = spriteName.sprite;
			}
		}
	}

	public void AddSprite(string name, Sprite sprite)
	{
		List<SpriteName> list = new List<SpriteName>(inspectorSpriteList);
		list.RemoveAll((SpriteName each) => each.name == name);
		list.Add(new SpriteName
		{
			name = name,
			sprite = sprite
		});
		inspectorSpriteList = list.ToArray();
		spriteList[name] = sprite;
	}

	public void ClearSprite()
	{
		foreach (Image item in imagePool)
		{
			if ((bool)item)
			{
				item.sprite = null;
			}
		}
		imagePool.Clear();
		spriteList.Clear();
		inspectorSpriteList = null;
	}

	public void AddListener(Action<string, string> callBack)
	{
		clickHandler = (Action<string, string>)Delegate.Combine(clickHandler, callBack);
	}

	public void AddEventListUpdateListener(Action<string[], string[]> dlg)
	{
		_onEventListUpdate = (Action<string[], string[]>)Delegate.Combine(_onEventListUpdate, dlg);
	}

	public void RemoveAllListeners()
	{
		clickHandler = delegate
		{
		};
		_onEventListUpdate = null;
	}

	protected void SetImageDirty()
	{
		imageDirty = true;
	}

	protected override void OnPopulateMesh(VertexHelper toFill)
	{
		vertsDirty = false;
		if (base.font == null)
		{
			return;
		}
		m_DisableFontTextureRebuiltCallback = true;
		string richText = text;
		IList<UIVertex> verts = null;
		eventList.Clear();
		try
		{
			richText = (realContent = CalculateLayoutWithImage(richText, out verts));
		}
		catch (Exception ex)
		{
			Debug.LogWarning(ex.ToString());
			return;
		}
		List<UIVertex> list = new List<UIVertex>(verts);
		for (int num = list.Count - 1; num > 0; num -= 4)
		{
			if (list[num].position.Equals(list[num - 1].position))
			{
				list.RemoveAt(num);
				list.RemoveAt(num - 1);
				list.RemoveAt(num - 2);
				list.RemoveAt(num - 3);
			}
		}
		int num2 = list.Count - 4;
		List<Tag> tags = null;
		List<int> list2 = new List<int>();
		for (int i = 0; i < icons.Count; i++)
		{
			IconInfo iconInfo = icons[i];
			int vertice = iconInfo.vertice;
			int vlength = iconInfo.vlength;
			for (int j = vertice / 4; j < (vertice + vlength) / 4; j++)
			{
				list2.Add(j);
			}
		}
		textInterpreter.Parse(richText, list2, out tags);
		if (tags.Count > 0)
		{
			List<UIVertex> list3 = list;
			if (list3 != null)
			{
				int num3 = 0;
				for (int k = 0; k < tags.Count; k++)
				{
					Tag tag = tags[k];
					switch (tag.type)
					{
					case TagType.Shadow:
						num3 += (tag.end - tag.start) * 4;
						break;
					case TagType.Outline:
						num3 += (tag.end - tag.start) * 4 * 5;
						break;
					}
				}
				if (num3 > 0)
				{
					num3 = Mathf.Max(num3, 16);
					list3.Capacity += num3;
				}
			}
			for (int l = 0; l < tags.Count; l++)
			{
				Tag tag2 = tags[l];
				try
				{
					switch (tag2.type)
					{
					case TagType.Outline:
						ApplyOutlineEffect(tag2 as Outline, list);
						break;
					case TagType.Gradient:
						ApplyGradientEffect(tag2 as GradientL, list);
						break;
					case TagType.Underline:
						ApplyUnderlineEffect(tag2 as Underline, list);
						break;
					}
				}
				catch (Exception ex2)
				{
					Debug.LogWarning(ex2.ToString());
					return;
				}
			}
		}
		NotifyEventListUpdate();
		num2 = list.Count;
		float num4 = 1f / base.pixelsPerUnit;
		Rect rect = base.rectTransform.rect;
		Vector2 textAnchorPivot = Text.GetTextAnchorPivot(fontData.alignment);
		Vector2 zero = Vector2.zero;
		zero.x = ((textAnchorPivot.x == 1f) ? rect.xMax : rect.xMin);
		zero.y = ((textAnchorPivot.y == 0f) ? rect.yMin : rect.yMax);
		Vector2 vector = PixelAdjustPoint(zero) - zero;
		toFill.Clear();
		if (vector != Vector2.zero)
		{
			for (int m = 0; m < num2; m++)
			{
				int num5 = m & 3;
				tempVerts[num5] = list[m];
				tempVerts[num5].position *= num4;
				tempVerts[num5].position.x += vector.x;
				tempVerts[num5].position.y += vector.y;
				if (num5 == 3)
				{
					toFill.AddUIVertexQuad(tempVerts);
				}
			}
		}
		else
		{
			for (int n = 0; n < num2; n++)
			{
				int num6 = n & 3;
				tempVerts[num6] = list[n];
				tempVerts[num6].position *= num4;
				if (num6 == 3)
				{
					toFill.AddUIVertexQuad(tempVerts);
				}
			}
		}
		m_DisableFontTextureRebuiltCallback = false;
	}

	private static int CountMaterialContentBeforeIndex(string input, int targetIndex)
	{
		int num = 0;
		int num2 = 0;
		while (num2 < targetIndex && num2 != -1)
		{
			int num3 = input.IndexOf("<material", num2, StringComparison.Ordinal);
			if (num3 == -1 || num3 > targetIndex)
			{
				break;
			}
			int num4 = input.IndexOf(">", num3);
			if (num4 == -1 || num4 > targetIndex)
			{
				break;
			}
			int num5 = input.IndexOf("</material>", num4, StringComparison.Ordinal);
			if (num5 == -1)
			{
				break;
			}
			int num6 = num4 - num3 + 1 + "</material>".Length;
			if (num6 > 0)
			{
				num += num6;
			}
			num2 = num5 + "</material>".Length;
		}
		return num;
	}

	private static int CountColorContentBeforeIndex(string input, int targetIndex)
	{
		int num = 0;
		int num2 = 0;
		while (num2 < targetIndex && num2 != -1)
		{
			int num3 = input.IndexOf("<color", num2, StringComparison.Ordinal);
			if (num3 == -1 || num3 > targetIndex)
			{
				break;
			}
			int num4 = input.IndexOf(">", num3);
			if (num4 == -1 || num4 > targetIndex)
			{
				break;
			}
			int num5 = input.IndexOf("</color>", num4, StringComparison.Ordinal);
			if (num5 == -1)
			{
				break;
			}
			int num6 = num4 - num3 + 1 + "</color>".Length;
			if (num6 > 0)
			{
				num += num6;
			}
			num2 = num5 + "</color>".Length;
		}
		return num;
	}

	protected string CalculateLayoutWithImage(string richText, out IList<UIVertex> verts)
	{
		Vector2 size = base.rectTransform.rect.size;
		TextGenerationSettings generationSettings = GetGenerationSettings(size);
		float num = 1f / base.pixelsPerUnit;
		float num2 = base.cachedTextGenerator.GetPreferredWidth('\u00a0'.ToString(), generationSettings) * num;
		float num3 = base.cachedTextGenerator.GetPreferredHeight('\u00a0'.ToString(), generationSettings) * num;
		float num4 = (float)base.fontSize * 0.5f;
		icons.Clear();
		Match match = null;
		StringBuilder stringBuilder = new StringBuilder();
		while ((match = IconReg.Match(richText)).Success)
		{
			IconInfo iconInfo = new IconInfo();
			iconInfo.name = match.Groups[1].Value;
			iconInfo.size = new Vector2(num4, num4);
			float result = 1f;
			float result2 = 1f;
			string e = null;
			string args = null;
			string value = match.Groups[2].Value;
			if (!string.IsNullOrEmpty(value))
			{
				Match match2 = ItemReg.Match(value);
				while (match2.Success)
				{
					string value2 = match2.Groups[1].Value;
					string value3 = match2.Groups[2].Value;
					switch (value2)
					{
					case "w":
						float.TryParse(value3, out result);
						break;
					case "h":
						float.TryParse(value3, out result2);
						break;
					case "event":
						e = value3;
						break;
					case "args":
						args = value3;
						break;
					}
					match2 = match2.NextMatch();
				}
			}
			if (spriteList.ContainsKey(iconInfo.name))
			{
				Sprite sprite = spriteList[iconInfo.name];
				if (sprite != null)
				{
					iconInfo.size = new Vector2(sprite.rect.width * result, sprite.rect.height * result2);
				}
			}
			iconInfo.e = e;
			iconInfo.args = args;
			iconInfo.vertice = match.Index * 4;
			int num5 = Mathf.CeilToInt(iconInfo.size.x / num2);
			iconInfo.vlength = num5 * 4;
			iconInfo.vertice = match.Index * 4;
			stringBuilder.Length = 0;
			stringBuilder.Append(richText, 0, match.Index);
			int num6 = CountMaterialContentBeforeIndex(richText, match.Index);
			int num7 = CountColorContentBeforeIndex(richText, match.Index);
			stringBuilder.Append(';', num5);
			stringBuilder.Append(richText, match.Index + match.Length, richText.Length - match.Index - match.Length);
			richText = stringBuilder.ToString();
			iconInfo.showVertice = (match.Index - num6 - num7) * 4;
			icons.Add(iconInfo);
		}
		stringBuilder = new StringBuilder(richText);
		base.cachedTextGeneratorForLayout.Populate(stringBuilder.ToString(), generationSettings);
		verts = base.cachedTextGeneratorForLayout.verts;
		int num8 = verts.Count - 4;
		for (int i = 0; i < icons.Count; i++)
		{
			IconInfo iconInfo2 = icons[i];
			int vertice = iconInfo2.vertice;
			int vlength = iconInfo2.vlength;
			int num9 = Mathf.Min(vertice + vlength, num8);
			if (num9 - 2 >= 0 && verts[num9 - 2].position.x * num > base.rectTransform.rect.xMax)
			{
				stringBuilder.Insert(vertice / 4, "\r\n");
				for (int j = i; j < icons.Count; j++)
				{
					icons[j].vertice += 8;
				}
				base.cachedTextGeneratorForLayout.Populate(stringBuilder.ToString(), generationSettings);
				verts = base.cachedTextGeneratorForLayout.verts;
				num8 = verts.Count - 4;
			}
		}
		if (fitSpriteHeight)
		{
			IList<UILineInfo> lines = base.cachedTextGeneratorForLayout.lines;
			List<IconInfo> list = new List<IconInfo>();
			int num10 = 0;
			int length = stringBuilder.Length;
			int k = 0;
			for (int count = lines.Count; k < count; k++)
			{
				UILineInfo uILineInfo = lines[k];
				int num11 = ((k == lines.Count - 1) ? (length - 1) : (lines[k + 1].startCharIdx - 1));
				int num12 = 0;
				list.Clear();
				for (int l = 0; l < icons.Count; l++)
				{
					IconInfo iconInfo3 = icons[l];
					if (iconInfo3.startCharIndex >= uILineInfo.startCharIdx && iconInfo3.endCharIndex <= num11)
					{
						int val = Mathf.CeilToInt(iconInfo3.size.y / num3);
						num12 = Math.Max(num12, val);
						list.Add(iconInfo3);
					}
				}
				if (num12 <= 0)
				{
					continue;
				}
				int index = lines[k].startCharIdx + num10;
				int num13 = ((num12 % 2 == 0) ? Mathf.FloorToInt(num12 / 2) : Mathf.CeilToInt(num12 / 2));
				int num14 = Mathf.FloorToInt(num12 / 2);
				stringBuilder.Insert(index, "\r\n", num13);
				num10 += num13 * 2;
				foreach (IconInfo item in list)
				{
					item.vertice += num10 * 4;
				}
				int index2 = num11 + num10 + 1;
				stringBuilder.Insert(index2, "\r\n", num14);
				num10 += num14 * 2;
			}
			base.cachedTextGeneratorForLayout.Populate(stringBuilder.ToString(), generationSettings);
			verts = base.cachedTextGeneratorForLayout.verts;
			num8 = verts.Count - 4;
		}
		richText = stringBuilder.ToString();
		for (int num15 = icons.Count - 1; num15 >= 0; num15--)
		{
			IconInfo iconInfo4 = icons[num15];
			int showVertice = iconInfo4.showVertice;
			stringBuilder.Replace(';', '\u00a0', iconInfo4.startCharIndex, iconInfo4.endCharIndex - iconInfo4.startCharIndex + 1);
			if (showVertice < num8)
			{
				Vector2 position = verts[showVertice].position;
				position *= num;
				position += new Vector2(iconInfo4.size.x * 0.5f, num4 * 0.5f);
				position += new Vector2(base.rectTransform.sizeDelta.x * (base.rectTransform.pivot.x - 0.5f), base.rectTransform.sizeDelta.y * (base.rectTransform.pivot.y - 0.5f));
				iconInfo4.position = position;
				iconInfo4.color = Color.white;
				if (!string.IsNullOrEmpty(iconInfo4.e))
				{
					Event obj = new Event();
					obj.name = iconInfo4.e;
					obj.args = iconInfo4.args;
					obj.rect = new Rect(verts[showVertice].position.x * num, verts[showVertice].position.y * num + (num4 - iconInfo4.size.y) * 0.5f, iconInfo4.size.x, iconInfo4.size.y);
					eventList.Add(obj);
				}
			}
			else
			{
				icons.RemoveAt(num15);
			}
		}
		richText = stringBuilder.ToString();
		stringBuilder = new StringBuilder(richText);
		base.cachedTextGenerator.Invalidate();
		base.cachedTextGenerator.Populate(stringBuilder.ToString(), generationSettings);
		verts = base.cachedTextGenerator.verts;
		SetImageDirty();
		SetLayoutDirty();
		return richText;
	}

	protected void Update()
	{
		if (imageDirty)
		{
			imageDirty = false;
			imagePool.RemoveAll((Image image2) => image2 == null);
			if (imagePool.Count == 0)
			{
				GetComponentsInChildren(includeInactive: true, imagePool);
			}
			for (int num = imagePool.Count; num < icons.Count; num++)
			{
				imagePool.Add(NewImage());
			}
			for (int num2 = 0; num2 < icons.Count; num2++)
			{
				string text = icons[num2].name;
				Vector2 position = icons[num2].position;
				Vector2 size = icons[num2].size;
				bool still = icons[num2].still;
				Color color = icons[num2].color;
				Image image = imagePool[num2];
				bool flag = !string.IsNullOrEmpty(text) && spriteList.ContainsKey(text);
				image.sprite = (flag ? spriteList[text] : null);
				image.enabled = flag | still;
				image.color = color;
				image.rectTransform.anchoredPosition = position;
				image.rectTransform.sizeDelta = size;
			}
			for (int num3 = icons.Count; num3 < imagePool.Count; num3++)
			{
				imagePool[num3].sprite = null;
				imagePool[num3].enabled = false;
			}
		}
	}

	private Image NewImage()
	{
		GameObject gameObject = DefaultControls.CreateImage(default(DefaultControls.Resources));
		if (Application.isPlaying)
		{
			Object.DontDestroyOnLoad(gameObject);
		}
		gameObject.layer = base.gameObject.layer;
		RectTransform rectTransform = gameObject.transform as RectTransform;
		if ((bool)rectTransform)
		{
			rectTransform.SetParent(base.rectTransform);
			rectTransform.localPosition = Vector3.zero;
			rectTransform.localRotation = Quaternion.identity;
			rectTransform.localScale = Vector3.one;
		}
		Image component = gameObject.GetComponent<Image>();
		component.raycastTarget = false;
		return component;
	}

	private void ApplyShadowEffect(Shadow tag, IList<UIVertex> verts)
	{
		int num = tag.start * 4;
		int num2 = Mathf.Min(tag.end * 4 + 4, verts.Count);
		for (int i = num; i < num2; i++)
		{
			UIVertex uIVertex = verts[i];
			verts.Add(uIVertex);
			Vector3 position = uIVertex.position;
			position.x += tag.x;
			position.y += tag.y;
			uIVertex.position = position;
			Color c = tag.c;
			c.a = c.a * (float)(int)verts[i].color.a / 255f;
			uIVertex.color = c;
			verts[i] = uIVertex;
		}
	}

	private void ApplyOutlineEffect(Outline tag, IList<UIVertex> verts)
	{
		int num = tag.start * 4;
		int num2 = Mathf.Min(tag.end * 4 + 4, verts.Count);
		for (int i = -1; i <= 1; i += 2)
		{
			for (int j = -1; j <= 1; j += 2)
			{
				for (int k = num; k < num2; k++)
				{
					UIVertex item = verts[k];
					Vector3 position = item.position;
					position.x += tag.x * (float)i;
					position.y += tag.y * (float)j;
					item.position = position;
					Color c = tag.c;
					c.a = c.a * (float)(int)verts[k].color.a / 255f;
					item.color = c;
					verts.Add(item);
				}
			}
		}
		for (int l = num; l < num2; l++)
		{
			verts.Add(verts[l]);
		}
	}

	private void ApplyGradientEffect(GradientL tag, IList<UIVertex> verts)
	{
		int num = tag.start * 4;
		int num2 = Mathf.Min(tag.end * 4 + 4, verts.Count);
		float num3 = float.MaxValue;
		float num4 = float.MinValue;
		Vector2 vector = new Vector2(tag.x, tag.y);
		for (int i = num; i < num2; i++)
		{
			float num5 = Vector3.Dot(verts[i].position, vector);
			if (num5 > num4)
			{
				num4 = num5;
			}
			else if (num5 < num3)
			{
				num3 = num5;
			}
		}
		float num6 = num4 - num3;
		for (int j = num; j < num2; j++)
		{
			UIVertex value = verts[j];
			value.color = Color32.Lerp(tag.from, tag.to, (Vector3.Dot(value.position, vector) - num3) / num6);
			verts[j] = value;
		}
	}

	private void ApplyUnderlineEffect(Underline tag, IList<UIVertex> verts)
	{
		int num = tag.start * 4;
		int num2 = Mathf.Min(tag.end * 4 + 4, verts.Count);
		if (verts.Count <= num + 3)
		{
			return;
		}
		float unitsPerPixel = 1f / base.pixelsPerUnit;
		float num3 = (float)base.fontSize * 0.9f;
		float num4 = float.MaxValue;
		float num5 = float.MinValue;
		float num6 = float.MaxValue;
		float num7 = float.MinValue;
		float num8 = verts[num].position.y;
		for (int i = num; i < num2; i += 4)
		{
			float y = verts[i].position.y;
			if (Mathf.Abs(y - num8) > num3)
			{
				EmitUnderline(tag, num4, num5, num6, num7, unitsPerPixel);
				num4 = float.MaxValue;
				num5 = float.MinValue;
				num6 = float.MaxValue;
				num7 = float.MinValue;
				num8 = y;
			}
			for (int j = 0; j < 4; j++)
			{
				Vector3 position = verts[i + j].position;
				num4 = Mathf.Min(num4, position.x);
				num5 = Mathf.Max(num5, position.x);
				num6 = Mathf.Min(num6, position.y);
				num7 = Mathf.Max(num7, position.y);
			}
		}
		EmitUnderline(tag, num4, num5, num6, num7, unitsPerPixel);
	}

	private void EmitUnderline(Underline tag, float minX, float maxX, float minY, float maxY, float unitsPerPixel)
	{
		if (!(maxX <= minX))
		{
			IconInfo iconInfo = new IconInfo();
			iconInfo.still = true;
			iconInfo.size = new Vector2((maxX - minX) * unitsPerPixel, tag.h);
			Vector2 position = new Vector2(minX, minY);
			position *= unitsPerPixel;
			position += new Vector2(iconInfo.size.x * 0.5f, (0f - tag.h) * 0.5f);
			position += new Vector2(base.rectTransform.sizeDelta.x * (base.rectTransform.pivot.x - 0.5f), base.rectTransform.sizeDelta.y * (base.rectTransform.pivot.y - 0.5f));
			iconInfo.position = position;
			iconInfo.color = ((tag.c == Color.white) ? color : tag.c);
			icons.Add(iconInfo);
			if (!string.IsNullOrEmpty(tag.e))
			{
				Event obj = new Event();
				obj.name = tag.e;
				obj.args = tag.args;
				obj.rect = new Rect(minX * unitsPerPixel, minY * unitsPerPixel, (maxX - minX) * unitsPerPixel, (maxY - minY) * unitsPerPixel);
				eventList.Add(obj);
			}
		}
	}

	private void ApplyStrikeEffect(Strike tag, IList<UIVertex> verts)
	{
		float num = (float)base.fontSize * 0.5f;
		float num2 = 1f / base.pixelsPerUnit;
		int num3 = tag.start * 4;
		int num4 = Mathf.Min(tag.end * 4 + 4, verts.Count);
		UIVertex uIVertex = verts[num3 + 3];
		float a = uIVertex.position.y;
		float num5 = verts[num3].position.y;
		for (int i = num3 + 2; i <= num4 - 2; i += 4)
		{
			UIVertex uIVertex2 = verts[i];
			bool flag = Mathf.Abs(uIVertex2.position.y - uIVertex.position.y) > num;
			if (flag || i == num4 - 2)
			{
				IconInfo iconInfo = new IconInfo();
				iconInfo.still = true;
				int num6 = ((!flag && i == num4 - 2) ? i : (i - 4));
				uIVertex2 = verts[num6];
				a = Mathf.Min(a, uIVertex2.position.y);
				num5 = Mathf.Max(num5, verts[num6 - 1].position.y);
				iconInfo.size = new Vector2((uIVertex2.position.x - uIVertex.position.x) * num2, tag.h);
				Vector2 position = new Vector2(uIVertex.position.x, a * 0.6f + num5 * 0.4f);
				position *= num2;
				position += new Vector2(iconInfo.size.x * 0.5f, (0f - tag.h) * 0.5f);
				position += new Vector2(base.rectTransform.sizeDelta.x * (base.rectTransform.pivot.x - 0.5f), base.rectTransform.sizeDelta.y * (base.rectTransform.pivot.y - 0.5f));
				iconInfo.position = position;
				iconInfo.color = ((tag.c == Color.white) ? color : tag.c);
				icons.Add(iconInfo);
				if (!string.IsNullOrEmpty(tag.e))
				{
					Event obj = new Event();
					obj.name = tag.e;
					obj.args = tag.args;
					obj.rect = new Rect(uIVertex.position.x * num2, a * num2, iconInfo.size.x, (num5 - a) * num2);
					eventList.Add(obj);
				}
				uIVertex = verts[i + 1];
				a = uIVertex.position.y;
				if (flag && i == num4 - 2)
				{
					i -= 4;
				}
			}
			else
			{
				a = Mathf.Min(a, uIVertex2.position.y);
				num5 = Mathf.Max(num5, verts[i - 1].position.y);
			}
		}
	}

	public void OnPointerClick(PointerEventData eventData)
	{
		RectTransformUtility.ScreenPointToLocalPointInRectangle(base.rectTransform, eventData.position, eventData.pressEventCamera, out var localPoint);
		for (int num = eventList.Count - 1; num >= 0; num--)
		{
			Event obj = eventList[num];
			if (obj.rect.Contains(localPoint))
			{
				clickHandler(obj.name, obj.args);
				break;
			}
		}
	}

	private void NotifyEventListUpdate()
	{
		if (_onEventListUpdate != null)
		{
			string[] array = new string[eventList.Count];
			string[] array2 = new string[eventList.Count];
			int count = eventList.Count;
			for (int i = 0; i < count; i++)
			{
				Event obj = eventList[i];
				array[i] = obj.name;
				array2[i] = obj.args;
			}
			_onEventListUpdate(array, array2);
		}
	}
}
