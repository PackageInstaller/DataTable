using System.Text;

namespace System.Net;

internal class ResponseDescription
{
	internal bool Multiline;

	internal int Status = -1;

	internal string StatusDescription;

	internal StringBuilder StatusBuffer = new StringBuilder();

	internal string StatusCodeString;

	internal bool PositiveIntermediate
	{
		get
		{
			if (Status >= 100)
			{
				return Status <= 199;
			}
			return false;
		}
	}

	internal bool PositiveCompletion
	{
		get
		{
			if (Status >= 200)
			{
				return Status <= 299;
			}
			return false;
		}
	}

	internal bool TransientFailure
	{
		get
		{
			if (Status >= 400)
			{
				return Status <= 499;
			}
			return false;
		}
	}

	internal bool PermanentFailure
	{
		get
		{
			if (Status >= 500)
			{
				return Status <= 599;
			}
			return false;
		}
	}

	internal bool InvalidStatusCode
	{
		get
		{
			if (Status >= 100)
			{
				return Status > 599;
			}
			return true;
		}
	}
}
