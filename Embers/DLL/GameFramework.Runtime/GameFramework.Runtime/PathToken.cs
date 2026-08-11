using System;
using System.Text;

namespace GameFramework.Runtime;

[Serializable]
public class PathToken
{
	private Path path;

	private int pathIndex;

	private PathToken nextToken;

	public Path Path => path;

	public int Index => pathIndex;

	public IPathNode Current => path[pathIndex];

	public PathToken(Path path, int pathIndex)
	{
		this.path = path;
		this.pathIndex = pathIndex;
	}

	public bool HasNext()
	{
		if (path.Count <= 0 || pathIndex >= path.Count - 1)
		{
			return false;
		}
		return true;
	}

	public PathToken NextToken()
	{
		if (!HasNext())
		{
			throw new IndexOutOfRangeException();
		}
		if (nextToken == null)
		{
			nextToken = new PathToken(path, pathIndex + 1);
		}
		return nextToken;
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		Current.ToString();
		stringBuilder.Append(Current.ToString()).Append(" pathIndex:").Append(pathIndex);
		return stringBuilder.ToString();
	}
}
