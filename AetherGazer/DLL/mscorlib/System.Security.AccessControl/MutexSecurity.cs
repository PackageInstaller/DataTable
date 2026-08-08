namespace System.Security.AccessControl;

public sealed class MutexSecurity : NativeObjectSecurity
{
	public MutexSecurity()
		: base(isContainer: false, ResourceType.KernelObject)
	{
	}

	public void AddAccessRule(MutexAccessRule rule)
	{
		AddAccessRule((AccessRule)rule);
	}
}
