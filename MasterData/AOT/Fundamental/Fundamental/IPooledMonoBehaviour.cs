namespace Fundamental;

public interface IPooledMonoBehaviour
{
	void OnCreate();

	void OnGet();

	void OnRecycle();
}
