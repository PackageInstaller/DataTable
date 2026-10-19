namespace UnityEngine.UI.CoroutineTween;

internal interface ITweenValue
{
	bool ignoreTimeScale { get; }

	float duration { get; }

	void TweenValue(float floatPercentage);

	bool ValidTarget();
}
