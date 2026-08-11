namespace NodeCanvas.Framework;

public interface IHaveNodeReference : IGraphElement
{
	INodeReference targetReference { get; }
}
