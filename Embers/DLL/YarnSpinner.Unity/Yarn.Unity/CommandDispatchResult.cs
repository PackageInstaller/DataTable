using System;

namespace Yarn.Unity;

internal struct CommandDispatchResult
{
	internal enum StatusType
	{
		SucceededAsync,
		SucceededSync,
		NoTargetFound,
		TargetMissingComponent,
		InvalidParameterCount,
		CommandUnknown,
		[Obsolete("Use a more specific enum case", true)]
		Success,
		[Obsolete("Use a more specific enum case", true)]
		Failed
	}

	internal StatusType Status;

	internal string Message;

	internal bool IsSuccess
	{
		get
		{
			if (Status != StatusType.SucceededAsync)
			{
				return Status == StatusType.SucceededSync;
			}
			return true;
		}
	}
}
