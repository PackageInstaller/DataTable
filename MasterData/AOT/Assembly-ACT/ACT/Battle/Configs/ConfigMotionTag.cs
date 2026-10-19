using System;
using System.Collections.Generic;
using System.Linq;
using Sirenix.OdinInspector;
using UnityEngine;

namespace ACT.Battle.Configs;

[Serializable]
public class ConfigMotionTag
{
	public float start;

	public float end;

	public ConfigMotionFrameRange frameRange;

	[HideInInspector]
	public MotionTag tag;

	public List<MotionTag_backUp> activeTags = new List<MotionTag_backUp>();

	public ulong FinalTagMask
	{
		get
		{
			ulong num = 0uL;
			if (activeTags != null)
			{
				foreach (MotionTag_backUp activeTag in activeTags)
				{
					num |= (ulong)(1L << (int)activeTag);
				}
			}
			return num;
		}
	}

	private static IEnumerable<ValueDropdownItem<MotionTag_backUp>> GetTagOptions()
	{
		Type enumType = typeof(MotionTag_backUp);
		foreach (MotionTag_backUp value in Enum.GetValues(enumType))
		{
			string text = value.ToString();
			if (enumType.GetField(text).GetCustomAttributes(typeof(LabelTextAttribute), inherit: false).FirstOrDefault() is LabelTextAttribute labelTextAttribute)
			{
				text = labelTextAttribute.Text;
			}
			yield return new ValueDropdownItem<MotionTag_backUp>(text, value);
		}
	}

	public bool HasTag(MotionTag_backUp checkTag)
	{
		return (FinalTagMask & (ulong)(1L << (int)checkTag)) != 0;
	}
}
