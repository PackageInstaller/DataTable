public interface IQWCBehavior
{
	void Initialize();

	void ActiveBehavior();

	void UpdateBehavior();

	void LateUpdateBehavior();

	void ResetBehavior();

	void DestroyBehavior();

	void FixedUpdateBehavior();
}
