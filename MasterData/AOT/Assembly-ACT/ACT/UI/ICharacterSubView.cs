using ACT.Core;
using ACT.Event;
using Bamboo.ImageCenter;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public interface ICharacterSubView : ISubUIView, IBaseUIComponent
{
	CharacterView CharacterView { get; }

	bool FreezeCharacterOSA => false;

	int Depth { get; }

	ICharacterSubView lastSubView { get; set; }

	CharacterViewScene.CvSceneType SceneType { get; }

	object Context { get; set; }

	bool NeedBlur => false;

	bool AfterAnimation
	{
		get
		{
			return false;
		}
		set
		{
			if (value)
			{
				SendAfterAnimationEvent();
			}
		}
	}

	void Init(CharacterView characterView);

	void SendAfterAnimationEvent()
	{
		CharacterSecondOpenEvent evt = Singleton<EventManager>.instance.GetEvt<CharacterSecondOpenEvent>();
		evt.type = SceneType;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Character_SecondViewOpen, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	void Show(int characterId, ImageAssetStation station, ICharacterSource characterSource);

	void Hide();

	void Freeze();

	void UnFreeze(int characterId);

	void OnSelectCharacter(ICharacterSource characterSource);

	void OnPushStack()
	{
	}

	void OnPopStack()
	{
	}

	void OnConfirm()
	{
	}

	void OnNavigate(Vector2 value)
	{
	}

	void OnRightStickNavigate(Vector2 value)
	{
	}

	void OnClickView()
	{
	}

	void OnLeftStickPress()
	{
	}

	void OnRightStickPressed()
	{
	}
}
