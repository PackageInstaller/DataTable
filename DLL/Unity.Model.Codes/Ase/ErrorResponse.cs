using GameFramework.Network;

namespace Ase;

public class ErrorResponse : IResponse, IMessage
{
	public int Error { get; set; }

	public string Message { get; set; }

	public int RpcId { get; set; }
}
