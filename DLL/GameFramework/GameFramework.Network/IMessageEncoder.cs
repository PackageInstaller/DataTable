using Cysharp.Threading.Tasks;

namespace GameFramework.Network;

public interface IMessageEncoder<TMessage>
{
	UniTask Encode(IMessage message, BinaryWriter writer);
}
