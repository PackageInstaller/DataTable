using ACT;
using ACT.Battle;
using ACT.Event;
using ACT.UI;
using Fundamental;
using UnityEngine;

namespace Runtime.UI;

public class BloodHit : MonoBehaviour
{
	[SerializeField]
	private BetterAnimation animation;

	private const string HitDrop = "Hit";

	private const string HitLight = "HitLit";

	private const string HitHeavy = "HitM";

	private void Awake()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_EntityGetHit, OnCharacterHit);
	}

	private void OnDestroy()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_EntityGetHit, OnCharacterHit);
	}

	private void OnCharacterHit(BaseEventContent content)
	{
		if (content is UIEntityGetHitEvt uIEntityGetHitEvt && GameManager.entities.GetEntity(uIEntityGetHitEvt.uid) == MonoECS.instance.mainEntity)
		{
			PlayAni(uIEntityGetHitEvt.cmdHit.hitType);
		}
	}

	private void PlayAni(int type)
	{
		string text = "";
		switch (type)
		{
		case 2:
			text = "HitM";
			break;
		case 4:
			text = "Hit";
			break;
		case 5:
			text = "Hit";
			break;
		}
		if (!string.IsNullOrEmpty(text))
		{
			animation.GetSequence(text)?.Play();
		}
	}
}
