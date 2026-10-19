namespace ACT;

internal abstract class OperationBase
{
	internal string ErrorInfo;

	internal OptionState State { get; set; }

	internal bool IsDone
	{
		get
		{
			if (State != OptionState.Failed)
			{
				return State == OptionState.Succeed;
			}
			return true;
		}
	}

	internal bool IsSuccess => State == OptionState.Succeed;

	internal abstract void OnStart();

	internal abstract void OnUpdate();
}
