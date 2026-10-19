using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.UI;

public static class RichTextTag
{
	public enum TagType
	{
		Color,
		Size
	}

	public static readonly Dictionary<TagType, Type> tags = new Dictionary<TagType, Type>
	{
		[TagType.Color] = typeof(Color),
		[TagType.Size] = typeof(float)
	};

	public static IEnumerable<TagType> GetAllRichTags()
	{
		return tags.Keys;
	}
}
