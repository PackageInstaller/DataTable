namespace NodeCanvas.Framework;

public interface IGraphAssignable
{
	Graph nestedGraph { get; set; }

	Graph[] GetInstances();
}
