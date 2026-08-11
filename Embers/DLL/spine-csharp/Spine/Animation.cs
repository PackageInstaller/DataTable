using System;
using System.Collections.Generic;

namespace Spine;

public class Animation
{
	internal string name;

	internal ExposedList<Timeline> timelines;

	internal HashSet<string> timelineIds;

	internal float duration;

	public ExposedList<Timeline> Timelines
	{
		get
		{
			return timelines;
		}
		set
		{
			SetTimelines(value);
		}
	}

	public float Duration
	{
		get
		{
			return duration;
		}
		set
		{
			duration = value;
		}
	}

	public string Name => name;

	public Animation(string name, ExposedList<Timeline> timelines, float duration)
	{
		if (name == null)
		{
			throw new ArgumentNullException("name", "name cannot be null.");
		}
		this.name = name;
		SetTimelines(timelines);
		this.duration = duration;
	}

	public void SetTimelines(ExposedList<Timeline> timelines)
	{
		if (timelines == null)
		{
			throw new ArgumentNullException("timelines", "timelines cannot be null.");
		}
		this.timelines = timelines;
		int num = 0;
		int count = timelines.Count;
		Timeline[] items = timelines.Items;
		for (int i = 0; i < count; i++)
		{
			num += items[i].PropertyIds.Length;
		}
		string[] array = new string[num];
		int num2 = 0;
		for (int j = 0; j < count; j++)
		{
			string[] propertyIds = items[j].PropertyIds;
			int k = 0;
			for (int num3 = propertyIds.Length; k < num3; k++)
			{
				array[num2++] = propertyIds[k];
			}
		}
		timelineIds = new HashSet<string>(array);
	}

	public bool HasTimeline(string[] propertyIds)
	{
		foreach (string item in propertyIds)
		{
			if (timelineIds.Contains(item))
			{
				return true;
			}
		}
		return false;
	}

	public void Apply(Skeleton skeleton, float lastTime, float time, bool loop, ExposedList<Event> events, float alpha, MixBlend blend, MixDirection direction)
	{
		if (skeleton == null)
		{
			throw new ArgumentNullException("skeleton", "skeleton cannot be null.");
		}
		if (loop && duration != 0f)
		{
			time %= duration;
			if (lastTime > 0f)
			{
				lastTime %= duration;
			}
		}
		Timeline[] items = timelines.Items;
		int i = 0;
		for (int count = timelines.Count; i < count; i++)
		{
			items[i].Apply(skeleton, lastTime, time, events, alpha, blend, direction);
		}
	}

	public override string ToString()
	{
		return name;
	}
}
