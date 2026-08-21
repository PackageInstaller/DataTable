using System;
using System.Collections.Generic;
using System.Reflection;
using UnityEngine;

namespace Ase;

public static class SpineFusionExtension
{
	private static GUIContent tempContent;

	public static string EmDash => "—";

	public static TrackData Clone(this TrackData target)
	{
		TrackData result = default(TrackData);
		result.trackIndex = target.trackIndex;
		result.tracks = new List<FusionTrackEntryData>();
		result.tracks = ((target.tracks == null) ? new List<FusionTrackEntryData>() : target.tracks.ToList());
		return result;
	}

	public static FusionTrackEntryData Clone(this FusionTrackEntryData target)
	{
		return new FusionTrackEntryData
		{
			aniName = target.aniName,
			startFrame = target.startFrame,
			frameRate = target.frameRate,
			transitionDuration = target.transitionDuration,
			timeScale = target.timeScale,
			startTime = target.startTime,
			isLoop = target.isLoop,
			endTime = target.endTime
		};
	}

	public static void Copy(this FusionData target, FusionData raw)
	{
		target.name = raw.name;
		target.length = raw.length;
		target.mainTrack = raw.mainTrack.Clone();
		target.faceTrack = raw.faceTrack.Clone();
		target.talkTrack = raw.talkTrack.Clone();
		target.bubbleData = raw.bubbleData;
		target.extraTracks = new List<TrackData>();
		foreach (TrackData extraTrack in raw.extraTracks)
		{
			target.extraTracks.Add(extraTrack.Clone());
		}
		target.audioTracksDatas = new List<AudioClipData>(raw.audioTracksDatas);
	}

	public static FusionData Clone(this FusionData target)
	{
		FusionData fusionData = new FusionData();
		fusionData.Copy(target);
		return fusionData;
	}

	internal static GUIContent TempContent(string text, Texture2D image = null, string tooltip = null)
	{
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_0011: Expected O, but got Unknown
		if (tempContent == null)
		{
			tempContent = new GUIContent();
		}
		tempContent.text = text;
		tempContent.image = image;
		tempContent.tooltip = tooltip;
		return tempContent;
	}

	public static List<FieldInfo> ScanFieldsWithAttribute<TAttribute>(Assembly assembly, bool includeNonPublic = false) where TAttribute : Attribute
	{
		BindingFlags bindingFlags = BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public;
		if (includeNonPublic)
		{
			bindingFlags |= BindingFlags.NonPublic;
		}
		List<FieldInfo> list = new List<FieldInfo>();
		Type[] types = assembly.GetTypes();
		foreach (Type type in types)
		{
			try
			{
				List<FieldInfo> collection = from f in type.GetFields(bindingFlags)
					where f.GetCustomAttributes(typeof(TAttribute), inherit: false).Length != 0
					select f;
				list.AddRange(collection);
			}
			catch (ReflectionTypeLoadException)
			{
			}
		}
		return list;
	}

	public static List<FieldInfo> ScanFieldsWithAttribute<TAttribute>(bool includeNonPublic = false) where TAttribute : Attribute
	{
		return ScanFieldsWithAttribute<TAttribute>(Assembly.GetExecutingAssembly(), includeNonPublic);
	}
}
