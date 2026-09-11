using System;
using System.Collections.Generic;

public class SimStateFrame : IFramePooledObject
{
	private const int kDefaultMappingListCapacity = 25;

	private const int kEntityTypeMappingDefaultCapacity = 200;

	private const int kNumExpectedStateFrameTypes = 20;

	internal bool Released;

	public bool IsPrediction;

	public List<NEventBase> Events;

	public uint FrameNumber;

	public Checksum Checksum;

	public List<SimPersistentState> AllEntityStates = new List<SimPersistentState>();

	public SimStateFrame()
	{
	}

	internal SimStateFrame(uint frameNumber, IList<SimPersistentState> frameStates, List<NEventBase> eventsForFrame, Checksum frameChecksum)
	{
		for (int i = 0; i < frameStates.Count; i++)
		{
			AllEntityStates[i] = frameStates[i];
		}
		FrameNumber = frameNumber;
		Events = eventsForFrame;
		Checksum = frameChecksum;
	}

	private static void AddStateToEntityLookup(Dictionary<int, List<SimPersistentState>> entityMapping, Dictionary<Type, List<SimPersistentState>> typeMapping, SimPersistentState state)
	{
		List<SimPersistentState> value = null;
		if (!entityMapping.TryGetValue(state.EntityID, out value))
		{
			value = new List<SimPersistentState>(25);
			entityMapping.Add(state.EntityID, value);
		}
		value.Add(state);
		value = null;
		Type type = state.GetType();
		if (!typeMapping.TryGetValue(type, out value))
		{
			value = new List<SimPersistentState>(25);
			typeMapping.Add(type, value);
		}
		value.Add(state);
	}

	public override string ToString()
	{
		string text = string.Empty;
		for (int i = 0; i < AllEntityStates.Count; i++)
		{
			text = text + AllEntityStates[i].EntityID + ", ";
		}
		return text;
	}

	public static SimStateFrame Claim()
	{
		SimStateFrame simStateFrame = FrameObjectPool<SimStateFrame>.Claim();
		simStateFrame.Released = false;
		return simStateFrame;
	}

	public void Release()
	{
		FrameObjectPool<SimStateFrame>.Release(this);
	}

	public void OnEnterPool()
	{
		for (int i = 0; i < AllEntityStates.Count; i++)
		{
			AllEntityStates[i].Release();
		}
		AllEntityStates.Clear();
		for (int j = 0; j < Events.Count; j++)
		{
			Events[j].Release();
		}
		Events.Clear();
		Released = true;
		IsPrediction = false;
		FrameNumber = 0u;
	}
}
