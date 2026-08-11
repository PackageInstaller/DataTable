namespace NodeCanvas.Framework;

public interface ITaskAssignable : IGraphElement
{
	Task task { get; set; }
}
public interface ITaskAssignable<T> : ITaskAssignable, IGraphElement where T : Task
{
}
