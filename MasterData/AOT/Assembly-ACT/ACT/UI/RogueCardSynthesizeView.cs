using ACT.Model;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class RogueCardSynthesizeView : BaseUIView
{
	private RogueCardSynthesizeViewData m_data;

	public LoopScrollRect RogueCardScrollRect;

	public GameObject GoRogueCardList;

	public Button Btnconfirm;

	public Button Btnsynthesize;

	[Header("主卡")]
	public RogueSynthesizeCard MainCard;

	[Header("副卡")]
	public RogueSynthesizeCard VicerogueCard;

	[Header("合成完成")]
	public GameObject GoFinsh;

	public RogueSynthesizeCard FinshShowCard;

	private int CurrentMainCardId;

	private int CurrentVicerogueCardId;

	private bool isMain;

	private bool isVicerogue;

	private int CurrentSelectCardId;

	public int GetCurrentMainCardId => CurrentMainCardId;

	public int GetCurrentVicerogueCardId => CurrentVicerogueCardId;

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
		ClearAllCardId();
	}

	protected override void Init()
	{
		base.Init();
	}

	public void ShowCard(RogueCard card)
	{
		if (isMain)
		{
			if (CurrentMainCardId == card.id)
			{
				return;
			}
			ShowCard(MainCard, card);
		}
		if (isVicerogue)
		{
			if (CurrentVicerogueCardId == card.id)
			{
				return;
			}
			ShowCard(VicerogueCard, card);
		}
		CurrentSelectCardId = card.id;
	}

	public void MainCardBtnClick()
	{
		isMain = true;
		Btnconfirm.gameObject.SetActive(value: true);
		CreateRogueCardSynthesizeItem();
		Btnsynthesize.gameObject.SetActive(value: false);
	}

	public void VicerogueCardBtnClick()
	{
		isVicerogue = true;
		Btnconfirm.gameObject.SetActive(value: true);
		CreateRogueCardSynthesizeItem();
		Btnsynthesize.gameObject.SetActive(value: false);
	}

	public void Confirm()
	{
		if (isMain)
		{
			CurrentMainCardId = CurrentSelectCardId;
			isMain = false;
		}
		if (isVicerogue)
		{
			CurrentVicerogueCardId = CurrentSelectCardId;
			isVicerogue = false;
		}
		Btnconfirm.gameObject.SetActive(value: false);
		GoRogueCardList.gameObject.SetActive(value: false);
		Btnsynthesize.gameObject.SetActive(value: true);
	}

	private void IsMainBack()
	{
		if (CurrentMainCardId != 0)
		{
			if (CurrentSelectCardId != CurrentMainCardId)
			{
				ShowCard(MainCard, Model<RoGueModel>.Interface.GetRogueCardById(CurrentMainCardId));
			}
			isMain = false;
		}
		else
		{
			SetMainCardReset();
		}
	}

	private void IsVicerogueBack()
	{
		if (CurrentVicerogueCardId != 0)
		{
			if (CurrentSelectCardId != CurrentVicerogueCardId)
			{
				ShowCard(VicerogueCard, Model<RoGueModel>.Interface.GetRogueCardById(CurrentVicerogueCardId));
			}
			isVicerogue = false;
		}
		else
		{
			SetVicerogueCardReset();
		}
	}

	private void SetMainCardReset()
	{
		MainCard.SetState(isNormal: false);
		isMain = false;
	}

	private void SetVicerogueCardReset()
	{
		VicerogueCard.SetState(isNormal: false);
		isVicerogue = false;
	}

	public void Back()
	{
		if (isMain)
		{
			IsMainBack();
		}
		if (isVicerogue)
		{
			IsVicerogueBack();
		}
		Btnconfirm.gameObject.SetActive(value: false);
		Btnsynthesize.gameObject.SetActive(value: true);
		GoRogueCardList.gameObject.SetActive(value: false);
	}

	public void CreateRogueCardSynthesizeItem()
	{
		Model<RoGueModel>.Interface.RefreshCardList();
		RogueCardScrollRect.totalCount = Model<RoGueModel>.Interface._RogueCards.Count;
		RogueCardScrollRect.RefillCells();
		GoRogueCardList.gameObject.SetActive(value: true);
	}

	public void SynthesizeBack()
	{
		GoFinsh.SetActive(value: false);
	}

	public void OnSynthesize()
	{
		if (CurrentMainCardId != 0 && CurrentVicerogueCardId != 0)
		{
			RogueCard rogueCard = Model<RoGueModel>.Interface.CompositeRogueCard(MainCard.RogueCard, VicerogueCard.RogueCard);
			GoFinsh.SetActive(value: true);
			ShowCard(FinshShowCard, new RogueCard(rogueCard.id, rogueCard.triggerId, rogueCard.effects, rogueCard.level, rogueCard.suitid));
			ClearAllCardId();
		}
	}

	private void ClearAllCardId()
	{
		SetMainCardReset();
		SetVicerogueCardReset();
		CurrentMainCardId = 0;
		CurrentSelectCardId = 0;
		CurrentVicerogueCardId = 0;
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

	public void ShowCard(RogueSynthesizeCard item, RogueCard data)
	{
		item.Init(data);
	}
}
