using UnityEngine;

public interface IClipPlayer
{
	void UpdateWithoutTimeScale(float realTimeDalta);

	void Update(float normalized);

	void UpdateTransform(Vector3 position, Vector3 forward);

	void Shutdown();

	void Stop(bool isForceClean = true);
}
