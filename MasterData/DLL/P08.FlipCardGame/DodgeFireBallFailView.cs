using UnityEngine;
using UnityEngine.UI;

public class DodgeFireBallFailView : MonoBehaviour
{
	[HideInInspector]
	public DodgeFireBallGameManager manager;

	[SerializeField]
	private Button restartButton;

	private void Awake()
	{
		restartButton.onClick.AddListener(Restart);
	}

	private void Restart()
	{
		manager.RestartGame();
		Show(value: false);
	}

	public void Show(bool value)
	{
		base.gameObject.SetActive(value);
		AudioManager.Instance.Play("effect", "minigame_activity_3_10", "minigame_activity_3_10_cook_done02", useStream: false);
	}
}
