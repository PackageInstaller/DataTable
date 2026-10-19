using ACT.Model;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class ChallengePromptsView : BaseUIView
{
	private ChallengePromptsModel _model;

	private ChallengePromptsViewData m_data;

	public BetterAnimation Gochallengeprompts;

	public GameObject Gomainprompts;

	public LocalizeStringEvent Textmainprompts;

	public GameObject Gosecondaryprompts;

	public LocalizeStringEvent Textsecondaryprompts;

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
		m_data = uiViewData as ChallengePromptsViewData;
		_model = Model<ChallengePromptsModel>.Interface;
	}

	protected override void Init()
	{
		base.Init();
		OnShowPrompts();
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

	private void OnShowPrompts()
	{
		int num = (_model.useString ? _model.stringList.Count : _model.eventList.Count);
		Gomainprompts.SetActive(num > 0);
		Gosecondaryprompts.SetActive(num > 1);
		if (num > 0)
		{
			LocalizedString sourceString = (_model.useString ? _model.stringList[0] : _model.eventList[0].StringReference);
			SetLocalizedText(Textmainprompts, sourceString);
		}
		if (num > 1)
		{
			LocalizedString sourceString2 = (_model.useString ? _model.stringList[1] : _model.eventList[1].StringReference);
			SetLocalizedText(Textsecondaryprompts, sourceString2);
		}
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/SFX/Interact/ParkourCoin_ChallengeBegins");
		Gochallengeprompts.GetSequence("ChallengePromptsShow").OnComplete((AnimationBuilder a) =>
		{
			Close();
		}).Play();
	}

	private void SetLocalizedText(LocalizeStringEvent localizeEvent, LocalizedString sourceString)
	{
		localizeEvent.StringReference = sourceString;
		if (sourceString.Values.Count > 0)
		{
			for (int i = 0; i < sourceString.Values.Count; i++)
			{
				string text = i.ToString();
				localizeEvent.StringReference.GetVariable<string>(text).Value = sourceString.GetVariable<string>(text).Value;
			}
		}
	}
}
