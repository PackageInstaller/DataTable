using BilliardGame.Runtime;
using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

namespace BilliardGame;

public class BilliardGameEnemyHpBar : BilliardGameHud
{
	public Image hpBar;

	public Image shieldBar;

	public Image mechhpBar;

	public Image mechshieldBar;

	public ControllerExCollection controllerEx;

	public GameObject specialBuff;

	private bool isBallGame = BilliardGameDataManager.IsBallGame();

	public void RefreshEnemyHp(int curHp, int maxHp, int curShield)
	{
		if (curHp + curShield >= maxHp)
		{
			float fillAmount = (isBallGame ? ((float)curHp / ((float)curHp + (float)curShield)) : ((float)curHp / (float)maxHp));
			hpBar.fillAmount = fillAmount;
			mechhpBar.fillAmount = fillAmount;
			shieldBar.fillAmount = (isBallGame ? 1f : ((float)curShield / (float)maxHp));
			mechshieldBar.fillAmount = 1f;
			return;
		}
		hpBar.fillAmount = (float)curHp / (float)maxHp;
		mechhpBar.fillAmount = (float)curHp / (float)maxHp;
		if (isBallGame)
		{
			shieldBar.fillAmount = ((float)curHp + (float)curShield) / (float)maxHp;
		}
		else
		{
			shieldBar.fillAmount = (float)curShield / (float)maxHp;
		}
		mechshieldBar.fillAmount = ((float)curHp + (float)curShield) / (float)maxHp;
	}

	public void SetBarType(bool isMech)
	{
		ControllerEx controller = controllerEx.GetController("state");
		if (isMech)
		{
			controller.SetSelectedIndex(1);
		}
		else
		{
			controller.SetSelectedIndex(0);
		}
	}

	public void ShowSpecialBuff(bool isShowSpecialBuff)
	{
		if (specialBuff != null)
		{
			specialBuff.SetActive(isShowSpecialBuff);
		}
	}
}
