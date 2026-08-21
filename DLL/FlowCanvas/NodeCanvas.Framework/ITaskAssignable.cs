namespace NodeCanvas.Framework;

public interface ITaskAssignable
{
	Task task { get; set; }
}
public interface ITaskAssignable<T> : ITaskAssignable where T : Task
{
}
