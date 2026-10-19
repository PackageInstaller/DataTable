using System.Collections.Generic;
using Fundamental;

namespace ACT.Model.Jump;

public struct JumpResult
{
	public enum JumpShowType
	{
		OnlyText,
		CanJump,
		Hide,
		Forbidden
	}

	public JumpShowType ShowType { get; set; }

	public string Message { get; set; }

	public List<string> Messages { get; private set; }

	public JumpResult(JumpShowType showType, string message)
	{
		ShowType = showType;
		Message = message;
		Messages = ListPool<string>.Get();
	}

	public void SetMessages(IList<string> messages)
	{
		if (Messages == null)
		{
			List<string> list = (Messages = ListPool<string>.Get());
		}
		Messages.Clear();
		Message = null;
		if (messages == null)
		{
			return;
		}
		foreach (string message in messages)
		{
			if (!string.IsNullOrEmpty(message))
			{
				Messages.Add(message);
			}
		}
	}

	public readonly void Release()
	{
		if (Messages != null)
		{
			ListPool<string>.Release(Messages);
		}
	}
}
