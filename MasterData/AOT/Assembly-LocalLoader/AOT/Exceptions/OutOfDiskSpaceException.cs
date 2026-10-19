using System;

namespace AOT.Exceptions;

public class OutOfDiskSpaceException : Exception
{
	private long _SpaceLeft;

	private long _SpaceNeed;

	public OutOfDiskSpaceException(long spaceLeft, long spaceNeed)
	{
		_SpaceLeft = spaceLeft;
		_SpaceNeed = spaceNeed;
	}

	public override string ToString()
	{
		return $"OutOfDiskSpace!The space left {_SpaceLeft} and need {_SpaceNeed}";
	}
}
