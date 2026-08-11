using System.Runtime.CompilerServices;
using UnityEngine;
using Yarn.Markup;

namespace Yarn.Unity;

public class LocalizedLine
{
	public string TextID;

	public string[] Substitutions;

	public string RawText;

	public string[] Metadata;

	public Object Asset;

	[CompilerGenerated]
	private MarkupParseResult _003CText_003Ek__BackingField;

	public string AudioId;

	public string CharacterName
	{
		get
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			MarkupParseResult text = Text;
			MarkupAttribute val = default(MarkupAttribute);
			if (((MarkupParseResult)(ref text)).TryGetAttributeWithName("character", ref val) && ((MarkupAttribute)(ref val)).Properties.TryGetValue("name", out var value))
			{
				return ((MarkupValue)(ref value)).StringValue;
			}
			return null;
		}
	}

	public MarkupParseResult Text
	{
		[CompilerGenerated]
		get
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			return _003CText_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			//IL_0002: Unknown result type (might be due to invalid IL or missing references)
			_003CText_003Ek__BackingField = value;
		}
	}

	public MarkupParseResult TextWithoutCharacterName
	{
		get
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			//IL_0028: Unknown result type (might be due to invalid IL or missing references)
			//IL_0018: Unknown result type (might be due to invalid IL or missing references)
			//IL_001d: Unknown result type (might be due to invalid IL or missing references)
			//IL_0020: Unknown result type (might be due to invalid IL or missing references)
			//IL_0021: Unknown result type (might be due to invalid IL or missing references)
			MarkupParseResult text = Text;
			MarkupAttribute val = default(MarkupAttribute);
			if (((MarkupParseResult)(ref text)).TryGetAttributeWithName("character", ref val))
			{
				text = Text;
				return ((MarkupParseResult)(ref text)).DeleteRange(val);
			}
			return Text;
		}
	}
}
