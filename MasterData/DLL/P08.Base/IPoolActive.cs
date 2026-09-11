public interface IPoolActive
{
	bool mIsRunning { get; set; }

	bool mReuseOldestGameobject { get; set; }

	float mSimulatorTime { get; set; }

	void SetActive(bool active);

	void Stop();
}
