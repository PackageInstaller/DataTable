namespace GameFramework.Network;

public interface IRequest : IMessage
{
	int RpcId { get; set; }
}
