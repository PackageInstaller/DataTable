using System;

namespace ACT;

[Serializable]
internal class DownloadCallbackInfo
{
	public int status;

	public TaskInfo[] taskArray;

	public int Index;

	public string ErrorCode;

	public string Message;
}
