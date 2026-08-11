using GameFramework;

public class SkillPriority : IReference
{
	public int dataTablePriority;

	public int modificationPriority;

	public void Init(int priority)
	{
		dataTablePriority = priority;
		modificationPriority = priority;
	}

	public void Init(int originalPriority, int tempPriority)
	{
		dataTablePriority = originalPriority;
		modificationPriority = tempPriority;
	}

	public void Restore()
	{
		modificationPriority = dataTablePriority;
	}

	public void Clear()
	{
		dataTablePriority = 0;
		modificationPriority = 0;
	}
}
