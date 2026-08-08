using UnityEngine;

public class AchievementForBattlePanel : MonoBehaviour
{
	public float ShowTime = 2f;

	public float EnterTime = 0.5f;

	public float ExitTime = 0.5f;

	private bool _isShowing;

	private float _showTime;

	public void OnEnable()
	{
		LeanTween.moveX(base.gameObject, 261f, EnterTime).setOnComplete(OnEnterComplete);
	}

	private void OnEnterComplete()
	{
		_showTime = ShowTime;
		_isShowing = true;
	}

	private void OnExitComplete()
	{
		_isShowing = false;
		base.gameObject.SetActive(value: false);
	}

	public void Update()
	{
		if (_isShowing)
		{
			_showTime -= Time.deltaTime;
			if (0f >= _showTime)
			{
				LeanTween.moveX(base.gameObject, -261f, EnterTime).setOnComplete(OnExitComplete);
			}
		}
	}
}
