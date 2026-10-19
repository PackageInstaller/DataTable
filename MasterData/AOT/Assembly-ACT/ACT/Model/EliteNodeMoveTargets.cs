namespace ACT.Model;

public readonly struct EliteNodeMoveTargets
{
	public EliteNodeId Up { get; }

	public EliteNodeId Down { get; }

	public EliteNodeId Left { get; }

	public EliteNodeId Right { get; }

	public EliteNodeMoveTargets(EliteNodeId up, EliteNodeId down, EliteNodeId left, EliteNodeId right)
	{
		Up = up;
		Down = down;
		Left = left;
		Right = right;
	}

	public bool TryGetTarget(EliteNodeMoveDirection direction, out EliteNodeId target)
	{
		switch (direction)
		{
		case EliteNodeMoveDirection.Up:
			target = Up;
			break;
		case EliteNodeMoveDirection.Down:
			target = Down;
			break;
		case EliteNodeMoveDirection.Left:
			target = Left;
			break;
		case EliteNodeMoveDirection.Right:
			target = Right;
			break;
		default:
			target = EliteNodeId.Invalid;
			break;
		}
		return target.IsValid;
	}
}
