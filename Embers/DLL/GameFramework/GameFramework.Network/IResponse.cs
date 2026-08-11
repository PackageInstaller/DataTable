namespace GameFramework.Network;

public interface IResponse : IMessage
{
	int Error { get; set; }

	string Message { get; set; }

	int RpcId { get; set; }
}
