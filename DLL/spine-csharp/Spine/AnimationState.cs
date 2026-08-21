using System;
using System.Collections.Generic;
using System.Text;

namespace Spine;

public class AnimationState
{
	public delegate void TrackEntryDelegate(TrackEntry trackEntry);

	public delegate void TrackEntryEventDelegate(TrackEntry trackEntry, Event e);

	internal static readonly Animation EmptyAnimation = new Animation("<empty>", new ExposedList<Timeline>(), 0f);

	internal const int Subsequent = 0;

	internal const int First = 1;

	internal const int HoldSubsequent = 2;

	internal const int HoldFirst = 3;

	internal const int HoldMix = 4;

	internal const int Setup = 1;

	internal const int Current = 2;

	protected AnimationStateData data;

	private readonly ExposedList<TrackEntry> tracks = new ExposedList<TrackEntry>();

	private readonly ExposedList<Event> events = new ExposedList<Event>();

	private readonly EventQueue queue;

	private readonly HashSet<string> propertyIds = new HashSet<string>();

	private bool animationsChanged;

	private float timeScale = 1f;

	private int unkeyedState;

	private readonly Pool<TrackEntry> trackEntryPool = new Pool<TrackEntry>();

	public float TimeScale
	{
		get
		{
			return timeScale;
		}
		set
		{
			timeScale = value;
		}
	}

	public AnimationStateData Data
	{
		get
		{
			return data;
		}
		set
		{
			if (data == null)
			{
				throw new ArgumentNullException("data", "data cannot be null.");
			}
			data = value;
		}
	}

	public ExposedList<TrackEntry> Tracks => tracks;

	public event TrackEntryDelegate Start;

	public event TrackEntryDelegate Interrupt;

	public event TrackEntryDelegate End;

	public event TrackEntryDelegate Dispose;

	public event TrackEntryDelegate Complete;

	public event TrackEntryEventDelegate Event;

	internal void OnStart(TrackEntry entry)
	{
		if (Start != null)
		{
			Start(entry);
		}
	}

	internal void OnInterrupt(TrackEntry entry)
	{
		if (Interrupt != null)
		{
			Interrupt(entry);
		}
	}

	internal void OnEnd(TrackEntry entry)
	{
		if (End != null)
		{
			End(entry);
		}
	}

	internal void OnDispose(TrackEntry entry)
	{
		if (Dispose != null)
		{
			Dispose(entry);
		}
	}

	internal void OnComplete(TrackEntry entry)
	{
		if (Complete != null)
		{
			Complete(entry);
		}
	}

	internal void OnEvent(TrackEntry entry, Event e)
	{
		if (Event != null)
		{
			Event(entry, e);
		}
	}

	public void AssignEventSubscribersFrom(AnimationState src)
	{
		Event = src.Event;
		Start = src.Start;
		Interrupt = src.Interrupt;
		End = src.End;
		Dispose = src.Dispose;
		Complete = src.Complete;
	}

	public void AddEventSubscribersFrom(AnimationState src)
	{
		Event += src.Event;
		Start += src.Start;
		Interrupt += src.Interrupt;
		End += src.End;
		Dispose += src.Dispose;
		Complete += src.Complete;
	}

	public AnimationState(AnimationStateData data)
	{
		if (data == null)
		{
			throw new ArgumentNullException("data", "data cannot be null.");
		}
		this.data = data;
		queue = new EventQueue(this, delegate
		{
			animationsChanged = true;
		}, trackEntryPool);
	}

	public void Update(float delta)
	{
		delta *= timeScale;
		TrackEntry[] items = tracks.Items;
		int i = 0;
		for (int count = tracks.Count; i < count; i++)
		{
			TrackEntry trackEntry = items[i];
			if (trackEntry == null)
			{
				continue;
			}
			trackEntry.animationLast = trackEntry.nextAnimationLast;
			trackEntry.trackLast = trackEntry.nextTrackLast;
			float num = delta * trackEntry.timeScale;
			if (trackEntry.delay > 0f)
			{
				trackEntry.delay -= num;
				if (trackEntry.delay > 0f)
				{
					continue;
				}
				num = 0f - trackEntry.delay;
				trackEntry.delay = 0f;
			}
			TrackEntry trackEntry2 = trackEntry.next;
			if (trackEntry2 != null)
			{
				float num2 = trackEntry.trackLast - trackEntry2.delay;
				if (num2 >= 0f)
				{
					trackEntry2.delay = 0f;
					trackEntry2.trackTime += ((trackEntry.timeScale == 0f) ? 0f : ((num2 / trackEntry.timeScale + delta) * trackEntry2.timeScale));
					trackEntry.trackTime += num;
					SetCurrent(i, trackEntry2, interrupt: true);
					while (trackEntry2.mixingFrom != null)
					{
						trackEntry2.mixTime += delta;
						trackEntry2 = trackEntry2.mixingFrom;
					}
					continue;
				}
			}
			else if (trackEntry.trackLast >= trackEntry.trackEnd && trackEntry.mixingFrom == null)
			{
				items[i] = null;
				queue.End(trackEntry);
				ClearNext(trackEntry);
				continue;
			}
			if (trackEntry.mixingFrom != null && UpdateMixingFrom(trackEntry, delta))
			{
				TrackEntry mixingFrom = trackEntry.mixingFrom;
				trackEntry.mixingFrom = null;
				if (mixingFrom != null)
				{
					mixingFrom.mixingTo = null;
				}
				while (mixingFrom != null)
				{
					queue.End(mixingFrom);
					mixingFrom = mixingFrom.mixingFrom;
				}
			}
			trackEntry.trackTime += num;
		}
		queue.Drain();
	}

	private bool UpdateMixingFrom(TrackEntry to, float delta)
	{
		TrackEntry mixingFrom = to.mixingFrom;
		if (mixingFrom == null)
		{
			return true;
		}
		bool result = UpdateMixingFrom(mixingFrom, delta);
		mixingFrom.animationLast = mixingFrom.nextAnimationLast;
		mixingFrom.trackLast = mixingFrom.nextTrackLast;
		if (to.nextTrackLast != -1f && to.mixTime >= to.mixDuration)
		{
			if (mixingFrom.totalAlpha == 0f || to.mixDuration == 0f)
			{
				to.mixingFrom = mixingFrom.mixingFrom;
				if (mixingFrom.mixingFrom != null)
				{
					mixingFrom.mixingFrom.mixingTo = to;
				}
				to.interruptAlpha = mixingFrom.interruptAlpha;
				queue.End(mixingFrom);
			}
			return result;
		}
		mixingFrom.trackTime += delta * mixingFrom.timeScale;
		to.mixTime += delta;
		return false;
	}

	public bool Apply(Skeleton skeleton)
	{
		if (skeleton == null)
		{
			throw new ArgumentNullException("skeleton", "skeleton cannot be null.");
		}
		if (animationsChanged)
		{
			AnimationsChanged();
		}
		ExposedList<Event> exposedList = events;
		bool result = false;
		TrackEntry[] items = tracks.Items;
		int i = 0;
		for (int count = tracks.Count; i < count; i++)
		{
			TrackEntry trackEntry = items[i];
			if (trackEntry == null || trackEntry.delay > 0f)
			{
				continue;
			}
			result = true;
			MixBlend mixBlend = ((i == 0) ? MixBlend.First : trackEntry.mixBlend);
			float num = trackEntry.alpha;
			if (trackEntry.mixingFrom != null)
			{
				num *= ApplyMixingFrom(trackEntry, skeleton, mixBlend);
			}
			else if (trackEntry.trackTime >= trackEntry.trackEnd && trackEntry.next == null)
			{
				num = 0f;
			}
			bool attachments = num >= trackEntry.alphaAttachmentThreshold;
			float animationLast = trackEntry.animationLast;
			float animationTime = trackEntry.AnimationTime;
			float num2 = animationTime;
			ExposedList<Event> exposedList2 = exposedList;
			if (trackEntry.reverse)
			{
				num2 = trackEntry.animation.duration - num2;
				exposedList2 = null;
			}
			int count2 = trackEntry.animation.timelines.Count;
			Timeline[] items2 = trackEntry.animation.timelines.Items;
			if ((i == 0 && num == 1f) || mixBlend == MixBlend.Add)
			{
				if (i == 0)
				{
					attachments = true;
				}
				for (int j = 0; j < count2; j++)
				{
					Timeline timeline = items2[j];
					if (timeline is AttachmentTimeline)
					{
						ApplyAttachmentTimeline((AttachmentTimeline)timeline, skeleton, num2, mixBlend, attachments);
					}
					else
					{
						timeline.Apply(skeleton, animationLast, num2, exposedList2, num, mixBlend, MixDirection.In);
					}
				}
			}
			else
			{
				int[] items3 = trackEntry.timelineMode.Items;
				bool shortestRotation = trackEntry.shortestRotation;
				bool flag = !shortestRotation && trackEntry.timelinesRotation.Count != count2 << 1;
				if (flag)
				{
					trackEntry.timelinesRotation.Resize(count2 << 1);
				}
				float[] items4 = trackEntry.timelinesRotation.Items;
				for (int k = 0; k < count2; k++)
				{
					Timeline timeline2 = items2[k];
					MixBlend blend = ((items3[k] == 0) ? mixBlend : MixBlend.Setup);
					RotateTimeline rotateTimeline = timeline2 as RotateTimeline;
					if (!shortestRotation && rotateTimeline != null)
					{
						ApplyRotateTimeline(rotateTimeline, skeleton, num2, num, blend, items4, k << 1, flag);
					}
					else if (timeline2 is AttachmentTimeline)
					{
						ApplyAttachmentTimeline((AttachmentTimeline)timeline2, skeleton, num2, mixBlend, attachments);
					}
					else
					{
						timeline2.Apply(skeleton, animationLast, num2, exposedList2, num, blend, MixDirection.In);
					}
				}
			}
			QueueEvents(trackEntry, animationTime);
			exposedList.Clear(clearArray: false);
			trackEntry.nextAnimationLast = animationTime;
			trackEntry.nextTrackLast = trackEntry.trackTime;
		}
		int num3 = unkeyedState + 1;
		Slot[] items5 = skeleton.slots.Items;
		int l = 0;
		for (int count3 = skeleton.slots.Count; l < count3; l++)
		{
			Slot slot = items5[l];
			if (slot.attachmentState == num3)
			{
				string attachmentName = slot.data.attachmentName;
				slot.Attachment = ((attachmentName == null) ? null : skeleton.GetAttachment(slot.data.index, attachmentName));
			}
		}
		unkeyedState += 2;
		queue.Drain();
		return result;
	}

	public bool ApplyEventTimelinesOnly(Skeleton skeleton, bool issueEvents = true)
	{
		if (skeleton == null)
		{
			throw new ArgumentNullException("skeleton", "skeleton cannot be null.");
		}
		ExposedList<Event> exposedList = events;
		bool result = false;
		TrackEntry[] items = tracks.Items;
		int i = 0;
		for (int count = tracks.Count; i < count; i++)
		{
			TrackEntry trackEntry = items[i];
			if (trackEntry == null || trackEntry.delay > 0f)
			{
				continue;
			}
			result = true;
			if (trackEntry.mixingFrom != null)
			{
				ApplyMixingFromEventTimelinesOnly(trackEntry, skeleton, issueEvents);
			}
			float animationLast = trackEntry.animationLast;
			float animationTime = trackEntry.AnimationTime;
			if (issueEvents)
			{
				int count2 = trackEntry.animation.timelines.Count;
				Timeline[] items2 = trackEntry.animation.timelines.Items;
				for (int j = 0; j < count2; j++)
				{
					Timeline timeline = items2[j];
					if (timeline is EventTimeline)
					{
						timeline.Apply(skeleton, animationLast, animationTime, exposedList, 1f, MixBlend.Setup, MixDirection.In);
					}
				}
				QueueEvents(trackEntry, animationTime);
				exposedList.Clear(clearArray: false);
			}
			trackEntry.nextAnimationLast = animationTime;
			trackEntry.nextTrackLast = trackEntry.trackTime;
		}
		if (issueEvents)
		{
			queue.Drain();
		}
		return result;
	}

	private float ApplyMixingFrom(TrackEntry to, Skeleton skeleton, MixBlend blend)
	{
		TrackEntry mixingFrom = to.mixingFrom;
		if (mixingFrom.mixingFrom != null)
		{
			ApplyMixingFrom(mixingFrom, skeleton, blend);
		}
		float num;
		if (to.mixDuration == 0f)
		{
			num = 1f;
			if (blend == MixBlend.First)
			{
				blend = MixBlend.Setup;
			}
		}
		else
		{
			num = to.mixTime / to.mixDuration;
			if (num > 1f)
			{
				num = 1f;
			}
			if (blend != MixBlend.First)
			{
				blend = mixingFrom.mixBlend;
			}
		}
		bool flag = num < mixingFrom.mixAttachmentThreshold;
		bool flag2 = num < mixingFrom.mixDrawOrderThreshold;
		int count = mixingFrom.animation.timelines.Count;
		Timeline[] items = mixingFrom.animation.timelines.Items;
		float num2 = mixingFrom.alpha * to.interruptAlpha;
		float num3 = num2 * (1f - num);
		float animationLast = mixingFrom.animationLast;
		float animationTime = mixingFrom.AnimationTime;
		float num4 = animationTime;
		ExposedList<Event> exposedList = null;
		if (mixingFrom.reverse)
		{
			num4 = mixingFrom.animation.duration - num4;
		}
		else if (num < mixingFrom.eventThreshold)
		{
			exposedList = events;
		}
		if (blend == MixBlend.Add)
		{
			for (int i = 0; i < count; i++)
			{
				items[i].Apply(skeleton, animationLast, num4, exposedList, num3, blend, MixDirection.Out);
			}
		}
		else
		{
			int[] items2 = mixingFrom.timelineMode.Items;
			TrackEntry[] items3 = mixingFrom.timelineHoldMix.Items;
			bool shortestRotation = mixingFrom.shortestRotation;
			bool flag3 = !shortestRotation && mixingFrom.timelinesRotation.Count != count << 1;
			if (flag3)
			{
				mixingFrom.timelinesRotation.Resize(count << 1);
			}
			float[] items4 = mixingFrom.timelinesRotation.Items;
			mixingFrom.totalAlpha = 0f;
			for (int j = 0; j < count; j++)
			{
				Timeline timeline = items[j];
				MixDirection direction = MixDirection.Out;
				MixBlend mixBlend;
				float num5;
				switch (items2[j])
				{
				case 0:
					if (!flag2 && timeline is DrawOrderTimeline)
					{
						continue;
					}
					mixBlend = blend;
					num5 = num3;
					break;
				case 1:
					mixBlend = MixBlend.Setup;
					num5 = num3;
					break;
				case 2:
					mixBlend = blend;
					num5 = num2;
					break;
				case 3:
					mixBlend = MixBlend.Setup;
					num5 = num2;
					break;
				default:
				{
					mixBlend = MixBlend.Setup;
					TrackEntry trackEntry = items3[j];
					num5 = num2 * Math.Max(0f, 1f - trackEntry.mixTime / trackEntry.mixDuration);
					break;
				}
				}
				mixingFrom.totalAlpha += num5;
				RotateTimeline rotateTimeline = timeline as RotateTimeline;
				if (!shortestRotation && rotateTimeline != null)
				{
					ApplyRotateTimeline(rotateTimeline, skeleton, num4, num5, mixBlend, items4, j << 1, flag3);
					continue;
				}
				if (timeline is AttachmentTimeline)
				{
					ApplyAttachmentTimeline((AttachmentTimeline)timeline, skeleton, num4, mixBlend, flag && num5 >= mixingFrom.alphaAttachmentThreshold);
					continue;
				}
				if (flag2 && timeline is DrawOrderTimeline && mixBlend == MixBlend.Setup)
				{
					direction = MixDirection.In;
				}
				timeline.Apply(skeleton, animationLast, num4, exposedList, num5, mixBlend, direction);
			}
		}
		if (to.mixDuration > 0f)
		{
			QueueEvents(mixingFrom, animationTime);
		}
		events.Clear(clearArray: false);
		mixingFrom.nextAnimationLast = animationTime;
		mixingFrom.nextTrackLast = mixingFrom.trackTime;
		return num;
	}

	private float ApplyMixingFromEventTimelinesOnly(TrackEntry to, Skeleton skeleton, bool issueEvents)
	{
		TrackEntry mixingFrom = to.mixingFrom;
		if (mixingFrom.mixingFrom != null)
		{
			ApplyMixingFromEventTimelinesOnly(mixingFrom, skeleton, issueEvents);
		}
		float num;
		if (to.mixDuration == 0f)
		{
			num = 1f;
		}
		else
		{
			num = to.mixTime / to.mixDuration;
			if (num > 1f)
			{
				num = 1f;
			}
		}
		ExposedList<Event> exposedList = ((num < mixingFrom.eventThreshold) ? events : null);
		if (exposedList == null)
		{
			return num;
		}
		float animationLast = mixingFrom.animationLast;
		float animationTime = mixingFrom.AnimationTime;
		if (issueEvents)
		{
			int count = mixingFrom.animation.timelines.Count;
			Timeline[] items = mixingFrom.animation.timelines.Items;
			for (int i = 0; i < count; i++)
			{
				Timeline timeline = items[i];
				if (timeline is EventTimeline)
				{
					timeline.Apply(skeleton, animationLast, animationTime, exposedList, 0f, MixBlend.Setup, MixDirection.Out);
				}
			}
			if (to.mixDuration > 0f)
			{
				QueueEvents(mixingFrom, animationTime);
			}
			events.Clear(clearArray: false);
		}
		mixingFrom.nextAnimationLast = animationTime;
		mixingFrom.nextTrackLast = mixingFrom.trackTime;
		return num;
	}

	private void ApplyAttachmentTimeline(AttachmentTimeline timeline, Skeleton skeleton, float time, MixBlend blend, bool attachments)
	{
		Slot slot = skeleton.slots.Items[timeline.SlotIndex];
		if (!slot.bone.active)
		{
			return;
		}
		float[] frames = timeline.frames;
		if (time < frames[0])
		{
			if (blend == MixBlend.Setup || blend == MixBlend.First)
			{
				SetAttachment(skeleton, slot, slot.data.attachmentName, attachments);
			}
		}
		else
		{
			SetAttachment(skeleton, slot, timeline.AttachmentNames[Timeline.Search(frames, time)], attachments);
		}
		if (slot.attachmentState <= unkeyedState)
		{
			slot.attachmentState = unkeyedState + 1;
		}
	}

	private void SetAttachment(Skeleton skeleton, Slot slot, string attachmentName, bool attachments)
	{
		slot.Attachment = ((attachmentName == null) ? null : skeleton.GetAttachment(slot.data.index, attachmentName));
		if (attachments)
		{
			slot.attachmentState = unkeyedState + 2;
		}
	}

	private static void ApplyRotateTimeline(RotateTimeline timeline, Skeleton skeleton, float time, float alpha, MixBlend blend, float[] timelinesRotation, int i, bool firstFrame)
	{
		if (firstFrame)
		{
			timelinesRotation[i] = 0f;
		}
		if (alpha == 1f)
		{
			timeline.Apply(skeleton, 0f, time, null, 1f, blend, MixDirection.In);
			return;
		}
		Bone bone = skeleton.bones.Items[timeline.BoneIndex];
		if (!bone.active)
		{
			return;
		}
		float[] frames = timeline.frames;
		float num;
		float num2;
		if (time < frames[0])
		{
			switch (blend)
			{
			default:
				return;
			case MixBlend.Setup:
				bone.rotation = bone.data.rotation;
				return;
			case MixBlend.First:
				break;
			}
			num = bone.rotation;
			num2 = bone.data.rotation;
		}
		else
		{
			num = ((blend == MixBlend.Setup) ? bone.data.rotation : bone.rotation);
			num2 = bone.data.rotation + timeline.GetCurveValue(time);
		}
		float num3 = num2 - num;
		num3 -= (float)Math.Ceiling(num3 / 360f - 0.5f) * 360f;
		float num4;
		if (num3 == 0f)
		{
			num4 = timelinesRotation[i];
		}
		else
		{
			float num5;
			float value;
			if (firstFrame)
			{
				num5 = 0f;
				value = num3;
			}
			else
			{
				num5 = timelinesRotation[i];
				value = timelinesRotation[i + 1];
			}
			float num6 = num5 - num5 % 360f;
			num4 = num3 + num6;
			bool flag = num3 >= 0f;
			bool flag2 = num5 >= 0f;
			if (Math.Abs(value) <= 90f && Math.Sign(value) != Math.Sign(num3))
			{
				if (Math.Abs(num5 - num6) > 180f)
				{
					num4 += (float)(360 * Math.Sign(num5));
					flag2 = flag;
				}
				else if (num6 != 0f)
				{
					num4 -= (float)(360 * Math.Sign(num5));
				}
				else
				{
					flag2 = flag;
				}
			}
			if (flag2 != flag)
			{
				num4 += (float)(360 * Math.Sign(num5));
			}
			timelinesRotation[i] = num4;
		}
		timelinesRotation[i + 1] = num3;
		bone.rotation = num + num4 * alpha;
	}

	private void QueueEvents(TrackEntry entry, float animationTime)
	{
		float animationStart = entry.animationStart;
		float animationEnd = entry.animationEnd;
		float num = animationEnd - animationStart;
		float num2 = entry.trackLast % num;
		Event[] items = events.Items;
		int i = 0;
		int count;
		for (count = events.Count; i < count; i++)
		{
			Event obj = items[i];
			if (obj.time < num2)
			{
				break;
			}
			if (!(obj.time > animationEnd))
			{
				queue.Event(entry, obj);
			}
		}
		bool flag = false;
		if (entry.loop)
		{
			if (num == 0f)
			{
				flag = true;
			}
			else
			{
				int num3 = (int)(entry.trackTime / num);
				flag = num3 > 0 && num3 > (int)(entry.trackLast / num);
			}
		}
		else
		{
			flag = animationTime >= animationEnd && entry.animationLast < animationEnd;
		}
		if (flag)
		{
			queue.Complete(entry);
		}
		for (; i < count; i++)
		{
			if (!(items[i].time < animationStart))
			{
				queue.Event(entry, items[i]);
			}
		}
	}

	public void ClearTracks()
	{
		bool drainDisabled = queue.drainDisabled;
		queue.drainDisabled = true;
		int i = 0;
		for (int count = tracks.Count; i < count; i++)
		{
			ClearTrack(i);
		}
		tracks.Clear();
		queue.drainDisabled = drainDisabled;
		queue.Drain();
	}

	public void ClearTrack(int trackIndex)
	{
		if (trackIndex >= tracks.Count)
		{
			return;
		}
		TrackEntry trackEntry = tracks.Items[trackIndex];
		if (trackEntry == null)
		{
			return;
		}
		queue.End(trackEntry);
		ClearNext(trackEntry);
		TrackEntry trackEntry2 = trackEntry;
		while (true)
		{
			TrackEntry mixingFrom = trackEntry2.mixingFrom;
			if (mixingFrom == null)
			{
				break;
			}
			queue.End(mixingFrom);
			trackEntry2.mixingFrom = null;
			trackEntry2.mixingTo = null;
			trackEntry2 = mixingFrom;
		}
		tracks.Items[trackEntry.trackIndex] = null;
		queue.Drain();
	}

	private void SetCurrent(int index, TrackEntry current, bool interrupt)
	{
		TrackEntry trackEntry = ExpandToIndex(index);
		tracks.Items[index] = current;
		current.previous = null;
		if (trackEntry != null)
		{
			if (interrupt)
			{
				queue.Interrupt(trackEntry);
			}
			current.mixingFrom = trackEntry;
			trackEntry.mixingTo = current;
			current.mixTime = 0f;
			if (trackEntry.mixingFrom != null && trackEntry.mixDuration > 0f)
			{
				current.interruptAlpha *= Math.Min(1f, trackEntry.mixTime / trackEntry.mixDuration);
			}
			trackEntry.timelinesRotation.Clear();
		}
		queue.Start(current);
	}

	public TrackEntry SetAnimation(int trackIndex, string animationName, bool loop)
	{
		Animation animation = data.skeletonData.FindAnimation(animationName);
		if (animation == null)
		{
			throw new ArgumentException("Animation not found: " + animationName, "animationName");
		}
		return SetAnimation(trackIndex, animation, loop);
	}

	public TrackEntry SetAnimation(int trackIndex, Animation animation, bool loop)
	{
		if (animation == null)
		{
			throw new ArgumentNullException("animation", "animation cannot be null.");
		}
		bool interrupt = true;
		TrackEntry trackEntry = ExpandToIndex(trackIndex);
		if (trackEntry != null)
		{
			if (trackEntry.nextTrackLast == -1f)
			{
				tracks.Items[trackIndex] = trackEntry.mixingFrom;
				queue.Interrupt(trackEntry);
				queue.End(trackEntry);
				ClearNext(trackEntry);
				trackEntry = trackEntry.mixingFrom;
				interrupt = false;
			}
			else
			{
				ClearNext(trackEntry);
			}
		}
		TrackEntry trackEntry2 = NewTrackEntry(trackIndex, animation, loop, trackEntry);
		SetCurrent(trackIndex, trackEntry2, interrupt);
		queue.Drain();
		return trackEntry2;
	}

	public TrackEntry AddAnimation(int trackIndex, string animationName, bool loop, float delay)
	{
		Animation animation = data.skeletonData.FindAnimation(animationName);
		if (animation == null)
		{
			throw new ArgumentException("Animation not found: " + animationName, "animationName");
		}
		return AddAnimation(trackIndex, animation, loop, delay);
	}

	public TrackEntry AddAnimation(int trackIndex, Animation animation, bool loop, float delay)
	{
		if (animation == null)
		{
			throw new ArgumentNullException("animation", "animation cannot be null.");
		}
		TrackEntry trackEntry = ExpandToIndex(trackIndex);
		if (trackEntry != null)
		{
			while (trackEntry.next != null)
			{
				trackEntry = trackEntry.next;
			}
		}
		TrackEntry trackEntry2 = NewTrackEntry(trackIndex, animation, loop, trackEntry);
		if (trackEntry == null)
		{
			SetCurrent(trackIndex, trackEntry2, interrupt: true);
			queue.Drain();
			if (delay < 0f)
			{
				delay = 0f;
			}
		}
		else
		{
			trackEntry.next = trackEntry2;
			trackEntry2.previous = trackEntry;
			if (delay <= 0f)
			{
				delay = Math.Max(delay + trackEntry.TrackComplete - trackEntry2.mixDuration, 0f);
			}
		}
		trackEntry2.delay = delay;
		return trackEntry2;
	}

	public TrackEntry SetEmptyAnimation(int trackIndex, float mixDuration)
	{
		TrackEntry trackEntry = SetAnimation(trackIndex, EmptyAnimation, loop: false);
		trackEntry.mixDuration = mixDuration;
		trackEntry.trackEnd = mixDuration;
		return trackEntry;
	}

	public TrackEntry AddEmptyAnimation(int trackIndex, float mixDuration, float delay)
	{
		TrackEntry trackEntry = AddAnimation(trackIndex, EmptyAnimation, loop: false, delay);
		if (delay <= 0f)
		{
			trackEntry.delay = Math.Max(trackEntry.delay + trackEntry.mixDuration - mixDuration, 0f);
		}
		trackEntry.mixDuration = mixDuration;
		trackEntry.trackEnd = mixDuration;
		return trackEntry;
	}

	public void SetEmptyAnimations(float mixDuration)
	{
		bool drainDisabled = queue.drainDisabled;
		queue.drainDisabled = true;
		TrackEntry[] items = tracks.Items;
		int i = 0;
		for (int count = tracks.Count; i < count; i++)
		{
			TrackEntry trackEntry = items[i];
			if (trackEntry != null)
			{
				SetEmptyAnimation(trackEntry.trackIndex, mixDuration);
			}
		}
		queue.drainDisabled = drainDisabled;
		queue.Drain();
	}

	private TrackEntry ExpandToIndex(int index)
	{
		if (index < tracks.Count)
		{
			return tracks.Items[index];
		}
		tracks.Resize(index + 1);
		return null;
	}

	private TrackEntry NewTrackEntry(int trackIndex, Animation animation, bool loop, TrackEntry last)
	{
		TrackEntry trackEntry = trackEntryPool.Obtain();
		trackEntry.trackIndex = trackIndex;
		trackEntry.animation = animation;
		trackEntry.loop = loop;
		trackEntry.holdPrevious = false;
		trackEntry.eventThreshold = 0f;
		trackEntry.alphaAttachmentThreshold = 0f;
		trackEntry.mixAttachmentThreshold = 0f;
		trackEntry.mixDrawOrderThreshold = 0f;
		trackEntry.animationStart = 0f;
		trackEntry.animationEnd = animation.Duration;
		trackEntry.animationLast = -1f;
		trackEntry.nextAnimationLast = -1f;
		trackEntry.delay = 0f;
		trackEntry.trackTime = 0f;
		trackEntry.trackLast = -1f;
		trackEntry.nextTrackLast = -1f;
		trackEntry.trackEnd = float.MaxValue;
		trackEntry.timeScale = 1f;
		trackEntry.alpha = 1f;
		trackEntry.interruptAlpha = 1f;
		trackEntry.mixTime = 0f;
		trackEntry.mixDuration = ((last == null) ? 0f : data.GetMix(last.animation, animation));
		trackEntry.mixBlend = MixBlend.Replace;
		return trackEntry;
	}

	public void ClearNext(TrackEntry entry)
	{
		for (TrackEntry next = entry.next; next != null; next = next.next)
		{
			queue.Dispose(next);
		}
		entry.next = null;
	}

	private void AnimationsChanged()
	{
		animationsChanged = false;
		propertyIds.Clear();
		int count = tracks.Count;
		TrackEntry[] items = tracks.Items;
		for (int i = 0; i < count; i++)
		{
			TrackEntry trackEntry = items[i];
			if (trackEntry == null)
			{
				continue;
			}
			while (trackEntry.mixingFrom != null)
			{
				trackEntry = trackEntry.mixingFrom;
			}
			do
			{
				if (trackEntry.mixingTo == null || trackEntry.mixBlend != MixBlend.Add)
				{
					ComputeHold(trackEntry);
				}
				trackEntry = trackEntry.mixingTo;
			}
			while (trackEntry != null);
		}
	}

	private void ComputeHold(TrackEntry entry)
	{
		TrackEntry mixingTo = entry.mixingTo;
		Timeline[] items = entry.animation.timelines.Items;
		int count = entry.animation.timelines.Count;
		int[] items2 = entry.timelineMode.Resize(count).Items;
		entry.timelineHoldMix.Clear();
		TrackEntry[] items3 = entry.timelineHoldMix.Resize(count).Items;
		HashSet<string> set = propertyIds;
		if (mixingTo != null && mixingTo.holdPrevious)
		{
			for (int i = 0; i < count; i++)
			{
				items2[i] = (set.AddAll(items[i].PropertyIds) ? 3 : 2);
			}
			return;
		}
		for (int j = 0; j < count; j++)
		{
			Timeline timeline = items[j];
			string[] addSet = timeline.PropertyIds;
			if (!set.AddAll(addSet))
			{
				items2[j] = 0;
				continue;
			}
			if (mixingTo == null || timeline is AttachmentTimeline || timeline is DrawOrderTimeline || timeline is EventTimeline || !mixingTo.animation.HasTimeline(addSet))
			{
				items2[j] = 1;
				continue;
			}
			TrackEntry mixingTo2 = mixingTo.mixingTo;
			while (true)
			{
				if (mixingTo2 != null)
				{
					if (mixingTo2.animation.HasTimeline(addSet))
					{
						mixingTo2 = mixingTo2.mixingTo;
						continue;
					}
					if (mixingTo2.mixDuration > 0f)
					{
						items2[j] = 4;
						items3[j] = mixingTo2;
						break;
					}
				}
				items2[j] = 3;
				break;
			}
		}
	}

	public TrackEntry GetCurrent(int trackIndex)
	{
		if (trackIndex >= tracks.Count)
		{
			return null;
		}
		return tracks.Items[trackIndex];
	}

	public void ClearListenerNotifications()
	{
		queue.Clear();
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		TrackEntry[] items = tracks.Items;
		int i = 0;
		for (int count = tracks.Count; i < count; i++)
		{
			TrackEntry trackEntry = items[i];
			if (trackEntry != null)
			{
				if (stringBuilder.Length > 0)
				{
					stringBuilder.Append(", ");
				}
				stringBuilder.Append(trackEntry.ToString());
			}
		}
		if (stringBuilder.Length == 0)
		{
			return "<none>";
		}
		return stringBuilder.ToString();
	}
}
