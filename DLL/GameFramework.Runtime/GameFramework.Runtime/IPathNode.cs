using System.Text;

namespace GameFramework.Runtime;

public interface IPathNode
{
	bool IsStatic { get; }

	void AppendTo(StringBuilder output);
}
