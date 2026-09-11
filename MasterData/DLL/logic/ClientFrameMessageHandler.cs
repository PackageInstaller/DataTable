using NetProcol;

[MessageHandler(~AppType.Client, 124)]
public class ClientFrameMessageHandler : AMClientHandler<Op_B2C_Server_Frame>
{
	protected override void Run(Op_B2C_Server_Frame message)
	{
	}
}
