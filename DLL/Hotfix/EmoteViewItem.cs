using Ase;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class EmoteViewItem : UGuiView, IPointerEnterHandler, IEventSystemHandler, IPointerExitHandler
{
	public LoadUISprite icon;

	private BattleEmoteModel _battleEmoteModel;

	private BattleEmoteView _battleEmoteView;

	public Image emoteBack;

	public Image emoteImage;

	public int EmoteConfigId => _battleEmoteModel.EmoteConfigId;

	public BattleEmoteModel BattleEmoteModel => _battleEmoteModel;

	protected override void OnInit(object userData)
	{
		if (!(icon == null))
		{
			_battleEmoteModel = GetUserData<BattleEmoteModel>(userData);
			emoteImage.sprite = _battleEmoteModel.EmoteSprite;
		}
	}

	public void InitParentWindow(BattleEmoteView battleEmoteView)
	{
		_battleEmoteView = battleEmoteView;
	}

	public void InitRotate(float deg)
	{
		if (!(emoteImage == null))
		{
			emoteImage.GetComponent<RectTransform>().localEulerAngles = new Vector3(0f, 0f, deg);
		}
	}

	public void RefreshImage()
	{
		emoteBack.color = new Color(1f, 1f, 1f, 0f);
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		HighLight();
	}

	public void HighLight()
	{
		emoteBack.color = new Color(1f, 1f, 1f, 1f);
		_battleEmoteView.RefreshImage(_battleEmoteModel.EmoteConfigId);
		_battleEmoteModel.SelectEmote();
	}

	public void OnPointerExit(PointerEventData eventData)
	{
		emoteBack.color = new Color(1f, 1f, 1f, 0f);
		_battleEmoteModel.ClearSelect();
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		if (!_battleEmoteModel.IsNull)
		{
			_battleEmoteView = null;
			GameEntry.Resource.UnloadAsset(AssetUtility.GetTextureAsset(_battleEmoteModel.EmoteIcon));
		}
	}
}
