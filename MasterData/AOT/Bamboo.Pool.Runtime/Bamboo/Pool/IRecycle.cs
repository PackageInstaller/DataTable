namespace Bamboo.Pool;

public interface IRecycle
{
	bool IsRecycled { get; set; }

	void Recycle();
}
