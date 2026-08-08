using UnityEngine;

public class ShootGameToLuaBridge : MonoBehaviour
{
	public static void StartGame()
	{
		ShootGameControl.Instance.StartGame();
	}

	public static float GetMaxTime()
	{
		return ShootGameControl.Instance.MaxGameTime;
	}

	public static float GetEnemyHit()
	{
		return ShootGameControl.Instance.hitNum1;
	}

	public static float GetFriendHit()
	{
		return ShootGameControl.Instance.hitNum2;
	}

	public static float GetCurTime()
	{
		return ShootGameControl.Instance.GetNowLeftTime();
	}

	public static float GetNowCd()
	{
		return ShootGameControl.Instance.GetNowCd();
	}

	public static float GetAnger()
	{
		return ShootGameControl.Instance.GetAnger();
	}

	public static float GetCostAnger()
	{
		return ShootGameControl.Instance.GetCostAnger();
	}

	public static float GetMaxAnger()
	{
		return ShootGameControl.Instance.GetMaxAnger();
	}

	public static void PlaySkill()
	{
		ShootGameControl.Instance.PlaySkill();
	}

	public static float GetMaxCd()
	{
		return ShootGameControl.Instance.GetMaxCd();
	}

	public static void PauseGame()
	{
		ShootGameControl.Instance.PauseGame();
	}

	public static void ReStartGame()
	{
		ShootGameControl.Instance.RestartGame();
	}

	public static void Shoot()
	{
		ShootGameControl.Instance.Shoot();
	}
}
