using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

namespace RogueCard;

public class RogueCardStoryBaseUI : MonoBehaviour
{
	public ControllerExCollection mainEx;

	public Image falseImg;

	public Image trueImg;

	public GameObject allProgressGo;

	public RollingNumber allProgressText;

	protected ControllerEx storyTypeCon;

	protected int selectIndex = -1;

	protected RogueCardStageCfg stageCfg;

	public virtual void Init()
	{
	}

	public virtual void SetData()
	{
	}

	public virtual void RefreshUI()
	{
	}

	public virtual void OnDispose()
	{
	}

	public virtual void OnFinishNormalStage()
	{
	}

	public virtual void OnFinishChallengeStage()
	{
	}

	public virtual void OnStartNormalStage()
	{
	}

	public virtual void OnStartChallengeState()
	{
	}

	public virtual void PlayAllAni()
	{
	}

	public virtual void SelectItem(int index, bool useLastText = false)
	{
	}

	public virtual void SetAll()
	{
	}
}
