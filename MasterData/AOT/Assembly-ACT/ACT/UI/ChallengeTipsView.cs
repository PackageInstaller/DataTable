using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.UI;

public class ChallengeTipsView : BaseUIView
{
	private ChallengeTipsViewData m_data;

	public BetterAnimation FinshTipsbetterAnimation;

	protected override void AddEventListener()
	{
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		m_data = uiViewData as ChallengeTipsViewData;
	}

	protected override void Init()
	{
		base.Init();
		Show();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}

	public void Show()
	{
		if (m_data.type == 0)
		{
			FinshTipsbetterAnimation.GetSequence("ChallengeSuccess").OnComplete((AnimationBuilder a) =>
			{
				Close();
			}).Play();
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Challenge_Success");
		}
		else
		{
			FinshTipsbetterAnimation.GetSequence("ChallengeFailed").OnComplete((AnimationBuilder a) =>
			{
				Close();
			}).Play();
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Challenge_Fail");
		}
	}
}
