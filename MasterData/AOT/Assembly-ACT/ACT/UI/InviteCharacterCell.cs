using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Fundamental;
using Runtime.Model;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class InviteCharacterCell : LoopScrollBaseItem
{
	[SerializeField]
	private LocalizeStringEvent characterNameLocalize;

	[SerializeField]
	private BImage _characterHeadImage;

	[SerializeField]
	private Image _characterStateRoot;

	[SerializeField]
	private TextMeshProUGUI _characterStateTxt;

	[SerializeField]
	private Image _characterPlotImage;

	[SerializeField]
	private Image _characterPlotDarkImage;

	[SerializeField]
	private Image _chatImage;

	[SerializeField]
	private Image _chatDarkImage;

	[SerializeField]
	private Image _chatAndPlotImage;

	[SerializeField]
	private Image _chatAndPlotDarkImage;

	[SerializeField]
	private FavorabilityProgressPreviewComponent _favorabilityProgressPreviewComponent;

	[SerializeField]
	private Image _selectImage;

	[SerializeField]
	private PublicToggle toggle;

	[SerializeField]
	private Image _joinPointImage;

	[SerializeField]
	private Image _joinPointImage2;

	[SerializeField]
	private GameObject black;

	[SerializeField]
	private GameObject handle;

	private ImageAssetStation station;

	private LoungeInteractPointUseType useType;

	private int curIdx = -1;

	private List<Character> characters;

	private int invitePointId;

	private const float GamepadRevealEpsilon = 1f;

	public override void ScrollCellIndex(int idx)
	{
		invitePointId = Model<InviteCharacterModel>.Interface.SingleInviteCharacterPointId;
		characters = Model<InviteCharacterModel>.Interface.SortCharactersList(invitePointId);
		gameObject.SetActive(value: true);
		index = (curIdx = idx);
		Character character = characters[index];
		if (character != null)
		{
			RefreshToggleState(idx);
			int id = character.Id;
			if (RuntimeConfigs.data.entityDatas.TryGetValue(id, out var value))
			{
				characterNameLocalize.StringReference.TableEntryReference = value.nameLocal;
			}
			if (station == null)
			{
				station = GetComponentInParent<IBaseUIView>().Station;
			}
			station.LoadImage(126, CharacterSkinRuntimeUtility.ResolveBagCharacterSkinId(id), _characterHeadImage);
			(int, int) characterFavorInfo = Model<LoungeModel>.Interface.GetCharacterFavorInfo(id);
			int item = characterFavorInfo.Item1;
			int item2 = characterFavorInfo.Item2;
			int favorabilityEachLv = Model<FavorabilityModel>.Interface.GetFavorabilityEachLv(item, id);
			_favorabilityProgressPreviewComponent.RefreshFavorabilityUI(id, item, Mathf.Floor(item2), favorabilityEachLv, station);
			ResetCharacterStateVisual();
			useType = ResolveUseType(id);
			int pointId = ResolveCharacterPointId(id);
			switch (useType)
			{
			case LoungeInteractPointUseType.LoungeInteractPointUseInvite:
			case LoungeInteractPointUseType.LoungeInteractPointUseRand:
				RefreshCheckedInState(id, pointId);
				break;
			case LoungeInteractPointUseType.LoungeInteractPointUseGlobal:
				RefreshGlobalStoryState();
				break;
			default:
				RefreshFreeCharacterState(id);
				break;
			}
			RefreshTempInviteState(id);
			RefreshGamepadHandleVisual();
		}
	}

	public void SetGamepadHandleVisible(bool visible)
	{
		if (handle != null)
		{
			handle.SetActive(visible);
		}
	}

	private void RefreshGamepadHandleVisual()
	{
		bool flag = MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
		bool flag2 = curIdx >= 0 && curIdx == Model<InviteCharacterModel>.Interface.CurrSelectIndex;
		SetGamepadHandleVisible(flag & flag2);
	}

	public void OnClickToggle()
	{
		Model<InviteCharacterModel>.Interface.CurrSelectIndex = curIdx;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_InviteCharacterRefresh, null);
	}

	private void RefreshToggleState(int idx)
	{
		bool flag = idx == Model<InviteCharacterModel>.Interface.CurrSelectIndex;
		if (toggle.isOn != flag)
		{
			toggle.isOn = flag;
		}
	}

	private void ResetCharacterStateVisual()
	{
		ResetSideIcons();
		_characterStateRoot.gameObject.SetActive(value: false);
		_characterStateTxt.gameObject.SetActive(value: false);
		black.SetActive(value: false);
		_joinPointImage.gameObject.SetActive(value: false);
		_joinPointImage2.gameObject.SetActive(value: false);
	}

	private LoungeInteractPointUseType ResolveUseType(int characterId)
	{
		if (Model<LoungeModel>.Interface.CurGlobalStoryId != 0)
		{
			LoungeStory data = CoreUtils.GetData(Model<LoungeModel>.Interface.CurGlobalStoryId, RuntimeConfigs.data.loungeStorys);
			if (data != null && data.characterId.Contains(characterId))
			{
				return LoungeInteractPointUseType.LoungeInteractPointUseGlobal;
			}
		}
		if (Model<LoungeModel>.Interface.CharacterToIndex.TryGetValue(characterId, out var value) && Model<LoungeModel>.Interface.IndexToCharacter.TryGetValue(value, out var value2))
		{
			return value2.useType;
		}
		return LoungeInteractPointUseType.LoungeInteractPointUseEmpty;
	}

	private static int ResolveCharacterPointId(int characterId)
	{
		return Model<InviteCharacterModel>.Interface.GetCharacterLoungePointId(characterId);
	}

	private void RefreshCheckedInState(int characterId, int pointId)
	{
		_characterStateRoot.gameObject.SetActive(value: true);
		_characterStateTxt.gameObject.SetActive(value: true);
		black.SetActive(value: true);
		Model<InviteCharacterModel>.Interface.GetSideIconDisplay(characterId, pointId, out var plotBright, out var plotDark, out var chatBright, out var chatDark);
		ApplySideIconVisual(plotBright, plotDark, chatBright, chatDark);
		_characterStateTxt.text = (plotBright ? LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2361) : LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2362));
	}

	private void RefreshGlobalStoryState()
	{
		_characterStateRoot.gameObject.SetActive(value: true);
		_characterStateTxt.gameObject.SetActive(value: true);
		black.SetActive(value: true);
		_characterPlotDarkImage.gameObject.SetActive(value: true);
		_characterStateTxt.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2361);
	}

	private void RefreshFreeCharacterState(int characterId)
	{
		if (invitePointId == 0)
		{
			RefreshDefaultSideIconDisplay(characterId);
		}
		else
		{
			RefreshSideIconDisplay(characterId, invitePointId);
		}
	}

	private void RefreshTempInviteState(int characterId)
	{
		if (invitePointId != 0)
		{
			return;
		}
		LoungeInteractPointUseType characterStateInLounge = Model<InviteCharacterModel>.Interface.GetCharacterStateInLounge(characterId);
		if (characterStateInLounge == LoungeInteractPointUseType.LoungeInteractPointUseInvite || characterStateInLounge == LoungeInteractPointUseType.LoungeInteractPointUseRand || characterStateInLounge == LoungeInteractPointUseType.LoungeInteractPointUseGlobal)
		{
			return;
		}
		foreach (TempInviteCharacter tempInviteCharacter in Model<InviteCharacterModel>.Interface.TempInviteCharacterList)
		{
			if (tempInviteCharacter.characterId == characterId)
			{
				_joinPointImage.gameObject.SetActive(value: true);
				_joinPointImage2.gameObject.SetActive(value: true);
				RefreshSideIconDisplay(characterId, tempInviteCharacter.pointId);
				break;
			}
		}
	}

	private void RefreshSideIconDisplay(int characterId, int pointId)
	{
		Model<InviteCharacterModel>.Interface.GetSideIconDisplay(characterId, pointId, out var plotBright, out var plotDark, out var chatBright, out var chatDark);
		ApplySideIconVisual(plotBright, plotDark, chatBright, chatDark);
	}

	private void RefreshDefaultSideIconDisplay(int characterId)
	{
		bool plotBright = false;
		bool chatBright = false;
		foreach (KeyValuePair<int, LoungePoint> item in Model<LoungeModel>.Interface.IndexToCharacter)
		{
			switch (Model<InviteCharacterModel>.Interface.GetCharacterRoomPointState(characterId, item.Key))
			{
			case InviteCharacterRoomPointEnum.ChatAndStory:
				ApplySideIconVisual(plotBright: true, plotDark: false, chatBright: true, chatDark: false);
				return;
			case InviteCharacterRoomPointEnum.Story:
				plotBright = true;
				break;
			case InviteCharacterRoomPointEnum.Chat:
				chatBright = true;
				break;
			}
		}
		ApplySideIconVisual(plotBright, plotDark: false, chatBright, chatDark: false);
	}

	private void ApplySideIconVisual(bool plotBright, bool plotDark, bool chatBright, bool chatDark)
	{
		ResetSideIcons();
		if (plotBright & chatBright)
		{
			_chatAndPlotImage.gameObject.SetActive(value: true);
			return;
		}
		if (plotDark & chatDark)
		{
			_chatAndPlotDarkImage.gameObject.SetActive(value: true);
			return;
		}
		if (plotBright)
		{
			_characterPlotImage.gameObject.SetActive(value: true);
		}
		if (plotDark)
		{
			_characterPlotDarkImage.gameObject.SetActive(value: true);
		}
		if (chatBright)
		{
			_chatImage.gameObject.SetActive(value: true);
		}
		if (chatDark)
		{
			_chatDarkImage.gameObject.SetActive(value: true);
		}
	}

	private void ResetSideIcons()
	{
		_characterPlotImage.gameObject.SetActive(value: false);
		_characterPlotDarkImage.gameObject.SetActive(value: false);
		_chatImage.gameObject.SetActive(value: false);
		_chatDarkImage.gameObject.SetActive(value: false);
		_chatAndPlotImage.gameObject.SetActive(value: false);
		_chatAndPlotDarkImage.gameObject.SetActive(value: false);
	}

	public static void RevealForGamepad(LoopScrollRect scroll, int index)
	{
		if (scroll == null || index < 0)
		{
			return;
		}
		scroll.StopAllCoroutines();
		scroll.StopMovement();
		if (IsListBoundary(scroll, index))
		{
			scroll.verticalNormalizedPosition = ((index == 0) ? 1f : 0f);
			if (scroll.GetItem(index) is Component cell)
			{
				RevealExistingCell(cell);
			}
		}
		else if (scroll.GetItem(index) is Component cell2)
		{
			RevealExistingCell(cell2);
		}
		else if (!TryBringIndexIntoView(scroll, index))
		{
			scroll.ScrollToCell(index, 3000f);
		}
		else if (scroll.GetItem(index) is Component cell3)
		{
			RevealExistingCell(cell3);
		}
	}

	private static bool IsListBoundary(LoopScrollRect scroll, int index)
	{
		if (scroll.totalCount > 0)
		{
			if (index != 0)
			{
				return index >= scroll.totalCount - 1;
			}
			return true;
		}
		return false;
	}

	private static void RevealExistingCell(Component cell)
	{
		SelectionUGUI component = cell.GetComponent<SelectionUGUI>();
		if (!(component == null) && component.ScrollToShow)
		{
			component.ScrollTargetToShow(cell.transform);
		}
	}

	private static bool TryBringIndexIntoView(LoopScrollRect scroll, int index)
	{
		if (!TryGetNeighbor(scroll, index, out var neighbor, out var neighborIndex))
		{
			return false;
		}
		RectTransform rectTransform = neighbor.transform as RectTransform;
		RectTransform rectTransform2 = ((scroll.viewport != null) ? scroll.viewport : (scroll.transform as RectTransform));
		RectTransform content = scroll.content;
		if (rectTransform == null || rectTransform2 == null || content == null)
		{
			return false;
		}
		Bounds boundsInViewport = GetBoundsInViewport(rectTransform2, rectTransform);
		float num = content.GetComponent<VerticalLayoutGroup>()?.spacing ?? 0f;
		float num2 = Mathf.Max(1f, boundsInViewport.size.y);
		int num3 = index - neighborIndex;
		float num4 = boundsInViewport.max.y - (float)num3 * (num2 + num);
		float num5 = num4 - num2;
		float num6 = 0f;
		if (num5 < rectTransform2.rect.yMin)
		{
			num6 = rectTransform2.rect.yMin - num5 + 1f;
		}
		else if (num4 > rectTransform2.rect.yMax)
		{
			num6 = rectTransform2.rect.yMax - num4 - 1f;
		}
		if (Mathf.Abs(num6) < 0.5f)
		{
			return false;
		}
		MoveContentY(scroll, content, num6);
		if (scroll.GetItem(index) != null)
		{
			return true;
		}
		MoveContentY(scroll, content, Mathf.Sign(num6) * num2);
		return scroll.GetItem(index) != null;
	}

	private static bool TryGetNeighbor(LoopScrollRect scroll, int index, out Component neighbor, out int neighborIndex)
	{
		if (scroll.GetItem(index - 1) is Component component)
		{
			neighbor = component;
			neighborIndex = index - 1;
			return true;
		}
		if (scroll.GetItem(index + 1) is Component component2)
		{
			neighbor = component2;
			neighborIndex = index + 1;
			return true;
		}
		neighbor = null;
		neighborIndex = -1;
		return false;
	}

	private static void MoveContentY(LoopScrollRect scroll, RectTransform content, float delta)
	{
		Vector2 anchoredPosition = content.anchoredPosition;
		anchoredPosition.y += delta;
		content.anchoredPosition = anchoredPosition;
		scroll.velocity = Vector2.zero;
		scroll.UpdateBounds(updateItems: true);
		ClampVerticalNormalizedPosition(scroll);
	}

	private static void ClampVerticalNormalizedPosition(LoopScrollRect scroll)
	{
		if (!(scroll == null) && scroll.vertical)
		{
			float verticalNormalizedPosition = scroll.verticalNormalizedPosition;
			float num = Mathf.Clamp01(verticalNormalizedPosition);
			if (Mathf.Abs(num - verticalNormalizedPosition) > 0.001f)
			{
				scroll.verticalNormalizedPosition = num;
			}
		}
	}

	private static Bounds GetBoundsInViewport(RectTransform viewport, RectTransform target)
	{
		Vector3[] array = new Vector3[4];
		target.GetWorldCorners(array);
		Vector3 center = viewport.InverseTransformPoint(array[0]);
		Bounds result = new Bounds(center, Vector3.zero);
		for (int i = 1; i < array.Length; i++)
		{
			result.Encapsulate(viewport.InverseTransformPoint(array[i]));
		}
		return result;
	}
}
