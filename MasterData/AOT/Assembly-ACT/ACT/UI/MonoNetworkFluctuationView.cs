using UnityEngine;

namespace ACT.UI;

public class MonoNetworkFluctuationView : MonoBehaviour
{
	public BetterAnimation networkFluctuationAnim;

	public void Init()
	{
		gameObject.SetActive(value: true);
	}

	public void UnInit()
	{
		gameObject.SetActive(value: false);
	}

	private void OnEnable()
	{
		networkFluctuationAnim?.GetSequence("Show")?.Play();
	}

	private void OnDisable()
	{
		networkFluctuationAnim?.GetSequence("Hide")?.Play();
	}
}
