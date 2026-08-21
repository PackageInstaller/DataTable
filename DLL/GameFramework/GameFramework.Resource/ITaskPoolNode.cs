namespace GameFramework.Resource;

public interface ITaskPoolNode<T>
{
	ref T NextNode { get; }
}
