using UnityEngine;

namespace Unity.VisualScripting;

[IncludeInSettings(false)]
[Singleton(Name = "VisualScripting CoroutineRunner", Automatic = true, Persistent = true)]
[DisableAnnotation]
[AddComponentMenu("")]
public sealed class CoroutineRunner : MonoBehaviour, ISingleton
{
	public static CoroutineRunner instance => Singleton<CoroutineRunner>.instance;

	private void Awake()
	{
		Singleton<CoroutineRunner>.Awake(this);
	}

	private void OnDestroy()
	{
		StopAllCoroutines();
		Singleton<CoroutineRunner>.OnDestroy(this);
	}
}
