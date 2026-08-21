using System;
using System.Collections.Generic;
using UnityEngine;

public static class SummerRaceCombatAudioEventRouter
{
	private static readonly List<ISummerRaceCombatAudioSink> SinkBuffer = new List<ISummerRaceCombatAudioSink>(4);

	public static void Publish(Transform sourceTransform, SummerRaceCombatAudioEvent audioEvent)
	{
		if (!ResolveSinks(sourceTransform, SinkBuffer))
		{
			return;
		}
		try
		{
			for (int i = 0; i < SinkBuffer.Count; i++)
			{
				ISummerRaceCombatAudioSink summerRaceCombatAudioSink = SinkBuffer[i];
				if (summerRaceCombatAudioSink != null)
				{
					try
					{
						summerRaceCombatAudioSink.HandleCombatAudioEvent(audioEvent);
					}
					catch (Exception ex)
					{
						SummerRaceRuntimeLog.Error("[SummerRace][Audio] audio sink dispatch failed. sink=" + summerRaceCombatAudioSink.GetType().Name + " source=" + ((sourceTransform != null) ? sourceTransform.name : "<null>") + " kind=" + audioEvent.Kind.ToString() + "\n" + ex);
					}
				}
			}
		}
		finally
		{
			SinkBuffer.Clear();
		}
	}

	private static bool ResolveSinks(Transform sourceTransform, List<ISummerRaceCombatAudioSink> sinks)
	{
		sinks.Clear();
		if (sourceTransform == null)
		{
			return false;
		}
		MonoBehaviour[] componentsInParent = sourceTransform.GetComponentsInParent<MonoBehaviour>(includeInactive: true);
		for (int i = 0; i < componentsInParent.Length; i++)
		{
			if (componentsInParent[i] is ISummerRaceCombatAudioSink item)
			{
				sinks.Add(item);
			}
		}
		return sinks.Count > 0;
	}
}
