using System;

namespace Spine;

public class DrawOrderTimeline : Timeline
{
	private static readonly string[] propertyIds = new string[1] { 14.ToString() };

	private readonly int[][] drawOrders;

	public int[][] DrawOrders => drawOrders;

	public DrawOrderTimeline(int frameCount)
		: base(frameCount, propertyIds)
	{
		drawOrders = new int[frameCount][];
	}

	public void SetFrame(int frame, float time, int[] drawOrder)
	{
		frames[frame] = time;
		drawOrders[frame] = drawOrder;
	}

	public override void Apply(Skeleton skeleton, float lastTime, float time, ExposedList<Event> firedEvents, float alpha, MixBlend blend, MixDirection direction)
	{
		if (direction == MixDirection.Out)
		{
			if (blend == MixBlend.Setup)
			{
				Array.Copy(skeleton.slots.Items, 0, skeleton.drawOrder.Items, 0, skeleton.slots.Count);
			}
			return;
		}
		float[] array = frames;
		if (time < array[0])
		{
			if (blend == MixBlend.Setup || blend == MixBlend.First)
			{
				Array.Copy(skeleton.slots.Items, 0, skeleton.drawOrder.Items, 0, skeleton.slots.Count);
			}
			return;
		}
		int[] array2 = drawOrders[Timeline.Search(array, time)];
		if (array2 == null)
		{
			Array.Copy(skeleton.slots.Items, 0, skeleton.drawOrder.Items, 0, skeleton.slots.Count);
			return;
		}
		Slot[] items = skeleton.slots.Items;
		Slot[] items2 = skeleton.drawOrder.Items;
		int i = 0;
		for (int num = array2.Length; i < num; i++)
		{
			items2[i] = items[array2[i]];
		}
	}
}
