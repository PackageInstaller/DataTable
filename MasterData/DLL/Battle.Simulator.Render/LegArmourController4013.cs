using UnityEngine;

public class LegArmourController4013 : MonoBehaviour
{
	public string m_CloseAnimationName = "close";

	public string m_OpenAnimationName = "open";

	public En_LegArmourState m_curState = En_LegArmourState.Close;

	public CharacterRenderController m_CharacterRenderController;

	public Animation m_Animation;

	public void SetRendersActive(bool enable)
	{
		if (m_CharacterRenderController != null)
		{
			m_CharacterRenderController.SetAllRendersActive(enable);
		}
	}

	public void ChangeState(En_LegArmourState targetState)
	{
		if (m_curState != targetState)
		{
			switch (targetState)
			{
			case En_LegArmourState.Close:
				PlayLegArmourAnimation(m_CloseAnimationName);
				break;
			case En_LegArmourState.Open:
				PlayLegArmourAnimation(m_OpenAnimationName);
				break;
			default:
				Debug.LogError("====>>>> 腿部装甲设置了异常状态");
				break;
			}
			m_curState = targetState;
		}
	}

	public void PlayLegArmourAnimation(string animationName)
	{
		if (!(m_Animation == null))
		{
			m_Animation.Play(animationName);
		}
	}
}
