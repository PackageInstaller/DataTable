public interface IDeterministicCollisionListener
{
	void OnDeterministicCollisionEnter(DeterministicCollider other);

	void OnDeterministicCollisionStay(DeterministicCollider other);

	void OnDeterministicCollisionExit(DeterministicCollider other);
}
