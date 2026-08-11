using Cysharp.Threading.Tasks;

namespace GameFramework.Network;

public interface IMessageDecoder<TMessage>
{
	UniTask<TMessage> Decode(BinaryReader reader);
}
