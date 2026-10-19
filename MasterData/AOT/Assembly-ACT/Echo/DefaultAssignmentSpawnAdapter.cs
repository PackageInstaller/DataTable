using System;
using Bamboo;
using Bamboo.Command;

namespace Echo;

public sealed class DefaultAssignmentSpawnAdapter : ISpawnAdapter
{
	public string Name => "Default";

	public bool Has(int assignmentID)
	{
		if (assignmentID == 1)
		{
			return true;
		}
		return false;
	}

	public BaseAssignment SpawnAssignment(int assignmentID)
	{
		return null;
	}

	public BaseAssignment SpawnAssignment<T>(int assignmentID, T arg)
	{
		return null;
	}

	public BaseAssignment SpawnAssignment<T1, T2>(int assignmentID, T1 arg1, T2 arg2)
	{
		return null;
	}

	public BaseAssignment SpawnAssignment<T1, T2, T3>(int assignmentID, T1 arg1, T2 arg2, T3 arg3)
	{
		return null;
	}

	private void CheckTypeValidity<TSOURCE, TTARGET>()
	{
		if (TypeCache<TSOURCE>.TYPE == TypeCache<TTARGET>.TYPE)
		{
			return;
		}
		throw new ArgumentException($"source type is {TypeCache<TSOURCE>.TYPE}, but target type is {TypeCache<TTARGET>.TYPE}");
	}
}
