namespace Spine;

public class EventTimeline : Timeline
{
	private static readonly string[] propertyIds = new string[1] { 13.ToString() };

	private readonly Event[] events;

	public Event[] Events => events;

	public EventTimeline(int frameCount)
		: base(frameCount, propertyIds)
	{
		events = new Event[frameCount];
	}

	public void SetFrame(int frame, Event e)
	{
		frames[frame] = e.time;
		events[frame] = e;
	}

	public override void Apply(Skeleton skeleton, float lastTime, float time, ExposedList<Event> firedEvents, float alpha, MixBlend blend, MixDirection direction)
	{
		if (firedEvents == null)
		{
			return;
		}
		float[] array = frames;
		int num = array.Length;
		if (lastTime > time)
		{
			Apply(skeleton, lastTime, 2.1474836E+09f, firedEvents, alpha, blend, direction);
			lastTime = -1f;
		}
		else if (lastTime >= array[num - 1])
		{
			return;
		}
		if (time < array[0])
		{
			return;
		}
		int i;
		if (lastTime < array[0])
		{
			i = 0;
		}
		else
		{
			i = Timeline.Search(array, lastTime) + 1;
			float num2 = array[i];
			while (i > 0 && array[i - 1] == num2)
			{
				i--;
			}
		}
		for (; i < num && time >= array[i]; i++)
		{
			firedEvents.Add(events[i]);
		}
	}
}
