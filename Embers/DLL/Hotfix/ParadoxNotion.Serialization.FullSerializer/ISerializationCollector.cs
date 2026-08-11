namespace ParadoxNotion.Serialization.FullSerializer;

public interface ISerializationCollector : ISerializationCollectable
{
	void OnPush(ISerializationCollector parent);

	void OnCollect(ISerializationCollectable child, int depth);

	void OnPop(ISerializationCollector parent);
}
