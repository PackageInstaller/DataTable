using System;
using UnityEngine;

namespace ACT.Battle.Configs;

public static class ConfigMotionTimingUtility
{
	public static bool TryGetCurrentTotalFrames(ConfigMotion motion, out int totalFrames, out string reason)
	{
		totalFrames = 0;
		reason = string.Empty;
		if (motion == null)
		{
			reason = "ConfigMotion 为空";
			return false;
		}
		if (motion.clip == null)
		{
			reason = "clip 为空";
			return false;
		}
		if (motion.speed <= 0f)
		{
			reason = "speed 必须大于 0";
			return false;
		}
		totalFrames = Mathf.Max(1, Mathf.RoundToInt(motion.clip.length * motion.clip.frameRate / motion.speed));
		return true;
	}

	public static float FrameToPercent(int frame, int totalFrames)
	{
		if (frame <= 1 || totalFrames <= 1)
		{
			return 0f;
		}
		return Mathf.Clamp01((float)(frame - 1) / (float)(totalFrames - 1));
	}

	public static int PercentToFrame(float percent, int totalFrames)
	{
		if (totalFrames <= 1)
		{
			return 1;
		}
		return Mathf.Clamp(Mathf.RoundToInt(Mathf.Clamp01(percent) * (float)(totalFrames - 1) + 1f), 1, totalFrames);
	}

	public static int TimeToFrame(ConfigMotion motion, float time)
	{
		if (!TryGetCurrentTotalFrames(motion, out var totalFrames, out var _))
		{
			return 1;
		}
		float logicLength = GetLogicLength(motion);
		return PercentToFrame((logicLength > 0f) ? Mathf.Clamp01(time / logicLength) : 0f, totalFrames);
	}

	public static float FrameToTime(ConfigMotion motion, int frame)
	{
		if (!TryGetCurrentTotalFrames(motion, out var totalFrames, out var _))
		{
			return 0f;
		}
		return FrameToPercent(frame, totalFrames) * GetLogicLength(motion);
	}

	public static float GetLogicLength(ConfigMotion motion)
	{
		if (!(motion != null) || !(motion.clip != null) || !(motion.speed > 0f))
		{
			return 0f;
		}
		return motion.clip.length / motion.speed;
	}

	public static float GetStartPercent(ConfigMotion motion, ConfigMotionFrameRange frameRange, float fallback)
	{
		if (!TryGetCurrentTotalFrames(motion, out var totalFrames, out var _) || !frameRange.HasFrame)
		{
			return Mathf.Clamp01(fallback);
		}
		return FrameToPercent(frameRange.startFrame, totalFrames);
	}

	public static float GetEndPercent(ConfigMotion motion, ConfigMotionFrameRange frameRange, float fallbackStart, float fallbackEnd)
	{
		if (TryGetCurrentTotalFrames(motion, out var totalFrames, out var _) && frameRange.HasFrame)
		{
			return FrameToPercent((frameRange.endFrame > 0) ? frameRange.endFrame : frameRange.startFrame, totalFrames);
		}
		if (fallbackEnd < 0f)
		{
			return fallbackEnd;
		}
		return Mathf.Clamp01(Mathf.Max(fallbackStart, fallbackEnd));
	}

	public static void SetMotionTagTiming(ConfigMotionTag item, ConfigMotion motion, float startTime, float endTime)
	{
		if (item != null && TryGetCurrentTotalFrames(motion, out var totalFrames, out var _))
		{
			SetFrameRangeFromTime(motion, ref item.frameRange, startTime, endTime);
			item.start = FrameToPercent(item.frameRange.startFrame, totalFrames);
			item.end = FrameToPercent(item.frameRange.endFrame, totalFrames);
		}
	}

	public static void SetEndureLevelTiming(ConfigEndureLevel item, ConfigMotion motion, float startTime, float endTime)
	{
		if (item != null && TryGetCurrentTotalFrames(motion, out var totalFrames, out var _))
		{
			SetFrameRangeFromTime(motion, ref item.frameRange, startTime, endTime);
			item.start = FrameToPercent(item.frameRange.startFrame, totalFrames);
			item.end = FrameToPercent(item.frameRange.endFrame, totalFrames);
		}
	}

	public static void SetTimelineItemTiming(TimelineItem item, ConfigMotion motion, float startTime, float endTime)
	{
		if (item != null && TryGetCurrentTotalFrames(motion, out var totalFrames, out var _))
		{
			SetFrameRangeFromTime(motion, ref item.frameRange, startTime, endTime);
			item.time = FrameToPercent(item.frameRange.startFrame, totalFrames);
			item.end = FrameToPercent(item.frameRange.endFrame, totalFrames);
		}
	}

	public static ConfigMotionTimingStatus Analyze(ConfigMotion motion)
	{
		ConfigMotionTimingStatus status = new ConfigMotionTimingStatus();
		if (!TryGetCurrentTotalFrames(motion, out status.currentTotalFrames, out status.invalidReason))
		{
			return status;
		}
		status.valid = true;
		VisitTimingItems(motion, (string label, ConfigMotionFrameRange range, float _, float _, TimelineItem _) =>
		{
			status.timingItemCount++;
			if (range.HasFrame)
			{
				status.anchoredItemCount++;
				if (range.sourceTotalFrames <= 0 || range.sourceTotalFrames != status.currentTotalFrames)
				{
					status.changedSourceFrameCount++;
					if (status.firstChangedSourceTotalFrames <= 0)
					{
						status.firstChangedSourceTotalFrames = range.sourceTotalFrames;
					}
				}
			}
			else
			{
				status.missingFrameRangeCount++;
			}
		});
		return status;
	}

	public static bool NeedsPercentRefresh(ConfigMotion motion, out ConfigMotionTimingStatus status)
	{
		status = Analyze(motion);
		if (status.valid)
		{
			return status.changedSourceFrameCount > 0;
		}
		return false;
	}

	public static bool RefreshAll(ConfigMotion motion, bool migrateMissingFrameRanges, bool refreshPercentFromFrames, ConfigMotionTimingRefreshReport report = null)
	{
		if (!TryGetCurrentTotalFrames(motion, out var totalFrames, out var reason))
		{
			report?.details.Add(GetMotionName(motion) + " 跳过：" + reason);
			if (report != null)
			{
				report.skippedItems++;
			}
			return false;
		}
		bool changed = false;
		RefreshMotionTagArray(motion.motionTags, totalFrames, migrateMissingFrameRanges, refreshPercentFromFrames, report, ref changed);
		RefreshEndureLevelArray(motion.endureLevels, totalFrames, migrateMissingFrameRanges, refreshPercentFromFrames, report, ref changed);
		RefreshTimelineItemArray(motion.attacks, totalFrames, migrateMissingFrameRanges, refreshPercentFromFrames, report, ref changed);
		RefreshTimelineItemArray(motion.compensations, totalFrames, migrateMissingFrameRanges, refreshPercentFromFrames, report, ref changed);
		RefreshTimelineItemArray(motion.performances, totalFrames, migrateMissingFrameRanges, refreshPercentFromFrames, report, ref changed);
		RefreshTimelineItemArray(motion.triggerAbilities, totalFrames, migrateMissingFrameRanges, refreshPercentFromFrames, report, ref changed);
		RefreshTimelineItemArray(motion.physicsOverrides, totalFrames, migrateMissingFrameRanges, refreshPercentFromFrames, report, ref changed);
		RefreshTimelineItemArray(motion.ecm2Overrides, totalFrames, migrateMissingFrameRanges, refreshPercentFromFrames, report, ref changed);
		RefreshTimelineItemArray(motion.volumeClips, totalFrames, migrateMissingFrameRanges, refreshPercentFromFrames, report, ref changed);
		return changed;
	}

	private static void SetFrameRangeFromTime(ConfigMotion motion, ref ConfigMotionFrameRange frameRange, float startTime, float endTime)
	{
		if (TryGetCurrentTotalFrames(motion, out var totalFrames, out var _))
		{
			frameRange.startFrame = TimeToFrame(motion, startTime);
			frameRange.endFrame = TimeToFrame(motion, Mathf.Max(startTime, endTime));
			frameRange.sourceTotalFrames = totalFrames;
		}
	}

	private static void RefreshMotionTagArray(ConfigMotionTag[] items, int totalFrames, bool migrateMissingFrameRanges, bool refreshPercentFromFrames, ConfigMotionTimingRefreshReport report, ref bool changed)
	{
		if (items == null)
		{
			return;
		}
		for (int i = 0; i < items.Length; i++)
		{
			ConfigMotionTag configMotionTag = items[i];
			if (configMotionTag != null)
			{
				changed |= RefreshFrameRangePercent(ref configMotionTag.frameRange, ref configMotionTag.start, ref configMotionTag.end, totalFrames, migrateMissingFrameRanges, refreshPercentFromFrames, report, $"motionTags[{i}]");
			}
		}
	}

	private static void RefreshEndureLevelArray(ConfigEndureLevel[] items, int totalFrames, bool migrateMissingFrameRanges, bool refreshPercentFromFrames, ConfigMotionTimingRefreshReport report, ref bool changed)
	{
		if (items == null)
		{
			return;
		}
		for (int i = 0; i < items.Length; i++)
		{
			ConfigEndureLevel configEndureLevel = items[i];
			if (configEndureLevel != null)
			{
				changed |= RefreshFrameRangePercent(ref configEndureLevel.frameRange, ref configEndureLevel.start, ref configEndureLevel.end, totalFrames, migrateMissingFrameRanges, refreshPercentFromFrames, report, $"endureLevels[{i}]");
			}
		}
	}

	private static void RefreshTimelineItemArray<T>(T[] items, int totalFrames, bool migrateMissingFrameRanges, bool refreshPercentFromFrames, ConfigMotionTimingRefreshReport report, ref bool changed) where T : TimelineItem
	{
		if (items == null)
		{
			return;
		}
		for (int i = 0; i < items.Length; i++)
		{
			T val = items[i];
			if (val != null)
			{
				changed |= RefreshTimelineItem(val, totalFrames, migrateMissingFrameRanges, refreshPercentFromFrames, report, $"{typeof(T).Name}[{i}]");
			}
		}
	}

	private static bool RefreshTimelineItem(TimelineItem item, int totalFrames, bool migrateMissingFrameRanges, bool refreshPercentFromFrames, ConfigMotionTimingRefreshReport report, string label)
	{
		bool flag = RefreshFrameRangePercent(ref item.frameRange, ref item.time, ref item.end, totalFrames, migrateMissingFrameRanges, refreshPercentFromFrames, report, label);
		if (!(item is CameraNoiseItem cameraNoiseItem))
		{
			if (!(item is GamepadRumbleItem gamepadRumbleItem))
			{
				if (item is CameraFOVItem cameraFOVItem)
				{
					flag |= RefreshExtraEndTime(ref cameraFOVItem.endTimeFrame, ref cameraFOVItem.endTime, totalFrames, migrateMissingFrameRanges, refreshPercentFromFrames, report, label + ".endTime");
				}
			}
			else
			{
				flag |= RefreshExtraEndTime(ref gamepadRumbleItem.endTimeFrame, ref gamepadRumbleItem.endTime, totalFrames, migrateMissingFrameRanges, refreshPercentFromFrames, report, label + ".endTime");
			}
		}
		else
		{
			flag |= RefreshExtraEndTime(ref cameraNoiseItem.endTimeFrame, ref cameraNoiseItem.endTime, totalFrames, migrateMissingFrameRanges, refreshPercentFromFrames, report, label + ".endTime");
		}
		return flag;
	}

	private static bool RefreshFrameRangePercent(ref ConfigMotionFrameRange frameRange, ref float start, ref float end, int totalFrames, bool migrateMissingFrameRanges, bool refreshPercentFromFrames, ConfigMotionTimingRefreshReport report, string label)
	{
		bool result = false;
		if (!frameRange.HasFrame)
		{
			if (!migrateMissingFrameRanges)
			{
				return false;
			}
			frameRange.startFrame = PercentToFrame(start, totalFrames);
			frameRange.endFrame = ((!(end < 0f)) ? PercentToFrame(GetEffectiveEndPercent(start, end), totalFrames) : 0);
			frameRange.sourceTotalFrames = totalFrames;
			if (report != null)
			{
				report.migratedItems++;
			}
			report?.details.Add($"{label} 生成帧锚点 {frameRange.startFrame}-{frameRange.endFrame}");
			result = true;
		}
		if (!refreshPercentFromFrames)
		{
			return result;
		}
		float num = FrameToPercent(frameRange.startFrame, totalFrames);
		float num2 = ((frameRange.endFrame > 0) ? FrameToPercent(frameRange.endFrame, totalFrames) : end);
		if (frameRange.endFrame <= 0 && end >= 0f)
		{
			num2 = num;
		}
		if (!Mathf.Approximately(start, num) || !Mathf.Approximately(end, num2) || frameRange.sourceTotalFrames != totalFrames)
		{
			start = num;
			end = num2;
			frameRange.sourceTotalFrames = totalFrames;
			if (report != null)
			{
				report.refreshedItems++;
			}
			result = true;
		}
		return result;
	}

	private static bool RefreshExtraEndTime(ref int endTimeFrame, ref float endTime, int totalFrames, bool migrateMissingFrameRanges, bool refreshPercentFromFrames, ConfigMotionTimingRefreshReport report, string label)
	{
		if (endTime < 0f)
		{
			return false;
		}
		bool result = false;
		if (endTimeFrame <= 0)
		{
			if (!migrateMissingFrameRanges)
			{
				return false;
			}
			endTimeFrame = PercentToFrame(endTime, totalFrames);
			if (report != null)
			{
				report.migratedItems++;
			}
			report?.details.Add($"{label} 生成结束帧 {endTimeFrame}");
			result = true;
		}
		if (!refreshPercentFromFrames)
		{
			return result;
		}
		float num = FrameToPercent(endTimeFrame, totalFrames);
		if (!Mathf.Approximately(endTime, num))
		{
			endTime = num;
			if (report != null)
			{
				report.refreshedItems++;
			}
			result = true;
		}
		return result;
	}

	private static float GetEffectiveEndPercent(float start, float end)
	{
		if (end <= 0f || Mathf.Approximately(start, end))
		{
			return start;
		}
		return Mathf.Max(start, end);
	}

	private static void VisitTimingItems(ConfigMotion motion, Action<string, ConfigMotionFrameRange, float, float, TimelineItem> visitor)
	{
		if (!(motion == null))
		{
			VisitMotionTags(motion.motionTags, visitor);
			VisitEndureLevels(motion.endureLevels, visitor);
			VisitTimelineItems(motion.attacks, visitor);
			VisitTimelineItems(motion.compensations, visitor);
			VisitTimelineItems(motion.performances, visitor);
			VisitTimelineItems(motion.triggerAbilities, visitor);
			VisitTimelineItems(motion.physicsOverrides, visitor);
			VisitTimelineItems(motion.ecm2Overrides, visitor);
			VisitTimelineItems(motion.volumeClips, visitor);
		}
	}

	private static void VisitMotionTags(ConfigMotionTag[] items, Action<string, ConfigMotionFrameRange, float, float, TimelineItem> visitor)
	{
		if (items == null)
		{
			return;
		}
		for (int i = 0; i < items.Length; i++)
		{
			ConfigMotionTag configMotionTag = items[i];
			if (configMotionTag != null)
			{
				visitor($"motionTags[{i}]", configMotionTag.frameRange, configMotionTag.start, configMotionTag.end, null);
			}
		}
	}

	private static void VisitEndureLevels(ConfigEndureLevel[] items, Action<string, ConfigMotionFrameRange, float, float, TimelineItem> visitor)
	{
		if (items == null)
		{
			return;
		}
		for (int i = 0; i < items.Length; i++)
		{
			ConfigEndureLevel configEndureLevel = items[i];
			if (configEndureLevel != null)
			{
				visitor($"endureLevels[{i}]", configEndureLevel.frameRange, configEndureLevel.start, configEndureLevel.end, null);
			}
		}
	}

	private static void VisitTimelineItems<T>(T[] items, Action<string, ConfigMotionFrameRange, float, float, TimelineItem> visitor) where T : TimelineItem
	{
		if (items == null)
		{
			return;
		}
		for (int i = 0; i < items.Length; i++)
		{
			T val = items[i];
			if (val != null)
			{
				visitor($"{typeof(T).Name}[{i}]", val.frameRange, val.time, val.end, val);
			}
		}
	}

	private static string GetMotionName(ConfigMotion motion)
	{
		if (!(motion != null))
		{
			return "ConfigMotion";
		}
		return motion.name;
	}
}
