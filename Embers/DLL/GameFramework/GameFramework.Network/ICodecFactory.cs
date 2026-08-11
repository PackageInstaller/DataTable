namespace GameFramework.Network;

public interface ICodecFactory<TMessage>
{
	IMessageEncoder<TMessage> CreateEncoder();

	IMessageDecoder<TMessage> CreateDecoder();
}
