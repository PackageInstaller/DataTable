namespace Bamboo.Command;

public interface ISpawnAdapter
{
	string Name { get; }

	bool Has(int assignmentID);

	BaseAssignment SpawnAssignment(int assignmentID);

	BaseAssignment SpawnAssignment<T>(int assignmentID, T arg);

	BaseAssignment SpawnAssignment<T1, T2>(int assignmentID, T1 arg1, T2 arg2);

	BaseAssignment SpawnAssignment<T1, T2, T3>(int assignmentID, T1 arg1, T2 arg2, T3 arg3);
}
