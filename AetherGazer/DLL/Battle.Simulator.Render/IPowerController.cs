public interface IPowerController
{
	void SetPower(int power, int max);

	void SetSlowPower(int power, int max);

	void SetActive(bool active);

	void UpdatePowerMax(int max);
}
