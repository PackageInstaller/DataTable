using NetProcol;

[MessageHandler(~AppType.Client, 133)]
public class ClientErrorMessageHandler : AMClientHandler<Op_B2C_ErrorCode>
{
	protected override void Run(Op_B2C_ErrorCode message)
	{
		int code = message.Code;
		if (base.mCallback != null)
		{
			base.mCallback.OnError(code);
		}
	}
}
