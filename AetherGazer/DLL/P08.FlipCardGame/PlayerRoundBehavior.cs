using System;
using P08.Quiz;
using Unity.Mathematics;
using UnityEngine;
using UnityEngine.EventSystems;

public class PlayerRoundBehavior : ICardBehavior
{
	public bool CanDrag => true;

	public bool CanClick => true;

	public void OnBeginDrag(Card card, PointerEventData eventData)
	{
	}

	public void OnDrag(Card card, PointerEventData eventData)
	{
		if (card.place == BloodCardEnum.PlaceType.HAND)
		{
			HighlightOverlappingCell(card);
		}
	}

	public void OnEndDrag(Card card, PointerEventData eventData)
	{
		if (card.place != BloodCardEnum.PlaceType.HAND)
		{
			return;
		}
		BloodCardBoard board = MonoSingleton<BloodCardManager>.Instance.Board;
		if (MonoSingleton<BloodCardManager>.Instance.CurrentStatus != BloodCardEnum.GameStatus.PLAYERROUND || !MonoSingleton<BloodCardManager>.Instance.playingEffectDone)
		{
			return;
		}
		if (board.HightLightCell != null && MonoSingleton<BloodCardManager>.Instance.placingIndex == -1)
		{
			if (board.HightLightCell.lockPut)
			{
				return;
			}
			if (board.HightLightCell.CurrentCard != null && board.HightLightCell.CurrentCard.belongs == BloodCardEnum.PlayerRole.ENEMY)
			{
				LuaHelper.CallFunction("ShowTips", "ACTIVITY_BLOOD_CARD_GAME_BLOCK_ALREADY_OCCUPIED_BY_RIVAL");
				MonoSingleton<BloodCardManager>.Instance.placingIndex = -1;
			}
			else if (board.HightLightCell.CurrentCard != null && card.Data().type == 1)
			{
				LuaHelper.CallFunction("ShowTips", "ACTIVITY_BLOOD_CARD_GAME_BLOCK_ALREADY_OCCUPIED");
				MonoSingleton<BloodCardManager>.Instance.placingIndex = -1;
			}
			else if (card.Data().type == 2 && board.HightLightCell.CurrentCard == null)
			{
				LuaHelper.CallFunction("ShowTips", "ACTIVITY_BLOOD_CARD_GAME_NEED_TO_COVER_AN_EXISTED_CARD");
				MonoSingleton<BloodCardManager>.Instance.placingIndex = -1;
			}
			else if (card.Data().needPoint > board.HightLightCell.SelfPoint)
			{
				LuaHelper.CallFunction("ShowTips", "ACTIVITY_BLOOD_CARD_GAME_LACK_OF_OCCUPY_POINT");
				MonoSingleton<BloodCardManager>.Instance.placingIndex = -1;
			}
			else
			{
				MonoSingleton<BloodCardManager>.Instance.SendPlaceCard(card.Data().id, board.HightLightCell.index);
				MonoSingleton<BloodCardManager>.Instance.placingIndex = board.HightLightCell.index;
				MonoSingleton<BloodCardManager>.Instance.placingCard = card;
			}
			if (MonoSingleton<BloodCardManager>.Instance.placingIndex == -1)
			{
				AudioManager.Instance.Play("effect", BloodCardManager.CUE_NAME, "minigame_activity_3_10_card_down", useStream: false);
			}
			foreach (CardCell effectHightLightCell in board.EffectHightLightCells)
			{
				effectHightLightCell.ResetState();
			}
			board.EffectHightLightCells.Clear();
			foreach (CardCell cell in board.ConHightLightCells)
			{
				cell.ResetState();
				cell.pointController.SetSelectedState("0");
				cell.selfController.SetSelectedState("true");
				LeanTween.alphaCanvas(cell.pointCanvasGroup, 0.5f, 0.2f).setOnComplete((Action)delegate
				{
					cell.pointController.SetSelectedState(math.max(cell.SelfPoint, cell.EnemyPoint).ToString());
					cell.selfController.SetSelectedState((cell.SelfPoint >= cell.EnemyPoint) ? "true" : "false");
					LeanTween.alphaCanvas(cell.pointCanvasGroup, 1f, 0.3f);
				});
			}
			board.ConHightLightCells.Clear();
			board.HightLightCell.ResetState();
			board.HightLightCell = null;
		}
		else if (MonoSingleton<BloodCardManager>.Instance.placingIndex != -1)
		{
			LuaHelper.CallFunction("ShowTips", "ACTIVITY_BLOOD_CARD_GAME_HAVE_ALREADY_PLACED");
		}
	}

	public void OnPointerEnter(Card card, PointerEventData eventData)
	{
	}

	public void OnPointerExit(Card card, PointerEventData eventData)
	{
	}

	public void OnPointerDown(Card card, PointerEventData eventData)
	{
	}

	public void OnPointerUp(Card card, PointerEventData eventData)
	{
	}

	public void HighlightOverlappingCell(Card card)
	{
		BloodCardBoard board = MonoSingleton<BloodCardManager>.Instance.Board;
		CardCell overlappingCell = board.GetOverlappingCell(card.transform.position, card.rectTransform.sizeDelta, board.transform);
		CardCell hightLightCell = board.HightLightCell;
		if (overlappingCell != null)
		{
			if (overlappingCell.lockPut)
			{
				return;
			}
			if (hightLightCell == null || hightLightCell != overlappingCell)
			{
				AudioManager.Instance.Play("effect", BloodCardManager.CUE_NAME, "minigame_activity_3_10_card_stand", useStream: false);
			}
			if (hightLightCell != null && hightLightCell != overlappingCell)
			{
				overlappingCell.selectController.SetSelectedState("false");
				overlappingCell.noController.SetSelectedState("false");
			}
			if (card.Data().type == 2)
			{
				if (overlappingCell.CurrentCard == null || overlappingCell.CurrentCard.belongs == BloodCardEnum.PlayerRole.ENEMY)
				{
					overlappingCell.selectController.SetSelectedState("true");
					overlappingCell.noController.SetSelectedState("true");
				}
				else
				{
					overlappingCell.selectController.SetSelectedState("false");
					overlappingCell.noController.SetSelectedState("false");
					overlappingCell.CurrentCard.cardVisual.effectGameObjectList[1].SetActive(value: true);
					HighlightEffectCell(card);
				}
			}
			else if (card.Data().needPoint > overlappingCell.SelfPoint || overlappingCell.CurrentCard != null)
			{
				overlappingCell.selectController.SetSelectedState("false");
				overlappingCell.noController.SetSelectedState("true");
			}
			else
			{
				overlappingCell.selectController.SetSelectedState("true");
				overlappingCell.noController.SetSelectedState("false");
				HighlightEffectCell(card);
			}
			CardCell[] cardCells = board.cardCells;
			foreach (CardCell cardCell in cardCells)
			{
				if ((!board.ConHightLightCells.Contains(cardCell) && !board.EffectHightLightCells.Contains(cardCell) && cardCell != board.HightLightCell) || board.HightLightCell != overlappingCell)
				{
					cardCell.ResetState();
				}
			}
			board.HightLightCell = overlappingCell;
		}
		else if (hightLightCell != null)
		{
			board.HightLightCell = null;
			CardCell[] cardCells = board.cardCells;
			for (int i = 0; i < cardCells.Length; i++)
			{
				cardCells[i].ResetState();
			}
		}
	}

	public void HighlightEffectCell(Card card)
	{
		BloodCardBoard board = MonoSingleton<BloodCardManager>.Instance.Board;
		CardCell hightLightCell = board.HightLightCell;
		if (hightLightCell == null)
		{
			return;
		}
		CardData cardData = card.Data();
		int index = hightLightCell.index;
		if (!(hightLightCell != null))
		{
			return;
		}
		board.ConHightLightCells.Clear();
		foreach (Vector2 controllEffect in cardData.controllEffects)
		{
			int num = MonoSingleton<BloodCardManager>.Instance.ConverPosToIndex(index, controllEffect, board.rows, board.columns - 2);
			if (num != -1)
			{
				CardCell cardCell = board.cardCells[num];
				if (cardCell.latticeController.GetSelectedState() == "false")
				{
					cardCell.latticeController.SetSelectedState("true");
					cardCell.PlayAni(cardCell.latticeAni, "UI_set_glow");
				}
				cardCell.pointController.SetSelectedState((card.belongs == BloodCardEnum.PlayerRole.SELF) ? math.min(cardCell.SelfPoint + 1, 3).ToString() : math.min(cardCell.EnemyPoint + 1, 3).ToString());
				cardCell.selfController.SetSelectedState((card.belongs == BloodCardEnum.PlayerRole.SELF) ? "true" : "false");
				board.ConHightLightCells.Add(cardCell);
			}
		}
		board.EffectHightLightCells.Clear();
		foreach (Effect effect in cardData.effects)
		{
			if (effect.effectPosList == null)
			{
				continue;
			}
			foreach (Vector2 effectPos in effect.effectPosList)
			{
				int num2 = MonoSingleton<BloodCardManager>.Instance.ConverPosToIndex(index, effectPos, board.rows, board.columns - 2);
				if (num2 != -1)
				{
					CardCell cardCell2 = board.cardCells[num2];
					cardCell2.lightController.SetSelectedState("true");
					board.EffectHightLightCells.Add(cardCell2);
					EffectData effectData = LazySingleton<LuaEffectLoader>.Instance.GetEffectData(effect.id);
					if (effectData != null && effectData.type == 3)
					{
						cardCell2.CurrentCard?.cardVisual?.effectGameObjectList[1].SetActive(value: true);
					}
				}
			}
		}
	}
}
