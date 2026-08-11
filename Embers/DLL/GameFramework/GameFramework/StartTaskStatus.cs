namespace GameFramework;

public enum StartTaskStatus : byte
{
	Done,
	CanResume,
	HasToWait,
	UnknownError
}
