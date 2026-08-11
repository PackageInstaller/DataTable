namespace NodeCanvas.Framework;

public interface IGraphElement
{
	string name { get; }

	string UID { get; }

	Graph graph { get; }

	Status status { get; }
}
