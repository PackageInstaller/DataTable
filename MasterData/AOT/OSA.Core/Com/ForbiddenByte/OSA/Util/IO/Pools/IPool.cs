namespace Com.ForbiddenByte.OSA.Util.IO.Pools;

public interface IPool
{
	int Capacity { get; }

	object Get(object key);

	void Put(object key, object value);

	void Clear();
}
