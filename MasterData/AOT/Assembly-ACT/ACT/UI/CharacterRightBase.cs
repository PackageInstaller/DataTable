using System.Threading;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.Sound;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public abstract class CharacterRightBase : MonoBehaviour
{
	public int pageIndex;

	public BaseUIView parentUi;

	protected Character m_Character;

	public Animator anim;

	public BetterAnimation betteranim;

	public CommonUILifeCycle lifeCycle;

	public CancellationToken Token;

	public bool isOperating
	{
		get
		{
			if (lifeCycle != CommonUILifeCycle.Opening)
			{
				return lifeCycle == CommonUILifeCycle.Closing;
			}
			return true;
		}
	}

	public bool isNormal => lifeCycle == CommonUILifeCycle.Normal;

	public bool isHidden => lifeCycle == CommonUILifeCycle.Hidden;

	public virtual void AddEventListener()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_Character_ChangePage, OnChangePage);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_Character_ChangeCharacter, OnChangeCharacter);
	}

	public virtual void RemoveEventListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_Character_ChangePage, OnChangePage);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_Character_ChangeCharacter, OnChangeCharacter);
	}

	protected void OnChangePage(BaseEventContent baseEvent)
	{
		CharacterPageChangeEvt characterPageChangeEvt = (CharacterPageChangeEvt)baseEvent;
		if (characterPageChangeEvt.currentPageIndex == pageIndex)
		{
			Token = characterPageChangeEvt.token;
			m_Character = characterPageChangeEvt.character;
			gameObject.SetActive(value: true);
			Init();
			UICharacterScene.instance.ChangePage(pageIndex);
		}
	}

	private void OnChangeCharacter(BaseEventContent evt)
	{
		CharacterChangeEvt characterChangeEvt = (CharacterChangeEvt)evt;
		m_Character = characterChangeEvt.c;
		if (gameObject.activeInHierarchy && characterChangeEvt.curPageIndex == pageIndex)
		{
			Init();
			EntityCharacterData entityCharacterData = RuntimeConfigs.data.entityCharacterDatas[m_Character.Id];
			Singleton<GameManager>.instance.audioManager.PlaySound(entityCharacterData.viewSound, new AudioPlayOptions
			{
				attachTarget = parentUi.transform
			});
		}
	}

	protected abstract void Init();

	public virtual void UnLoad()
	{
		gameObject.SetActive(value: false);
	}

	public virtual void CloseBagPanel()
	{
	}

	public virtual async void PlayOpenAnim()
	{
		if (betteranim != null)
		{
			betteranim.GetSequence("Show")?.Play();
		}
	}

	public virtual async UniTask PlayCloseAnim(CancellationToken token)
	{
		if (betteranim != null)
		{
			betteranim.GetSequence("Hide")?.Play();
		}
	}

	public virtual void ShowStart()
	{
		lifeCycle = CommonUILifeCycle.Opening;
	}

	public virtual void ShowFinish()
	{
		lifeCycle = CommonUILifeCycle.Normal;
	}

	public virtual void CloseStart()
	{
		lifeCycle = CommonUILifeCycle.Closing;
	}

	public virtual void CloseFinish()
	{
		lifeCycle = CommonUILifeCycle.Hidden;
	}
}
