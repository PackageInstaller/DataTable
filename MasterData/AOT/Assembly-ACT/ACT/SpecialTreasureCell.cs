using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT;

public class SpecialTreasureCell : LoopScrollBaseItem, ISubmitHandler, IEventSystemHandler
{
	[SerializeField]
	private TreasureUIComponent _treasureUIComponent;

	[SerializeField]
	private TextMeshProUGUI _treasureName;

	[SerializeField]
	private TextMeshProUGUI _collectedTxt;

	[SerializeField]
	private ActButton _btn_goto;

	[SerializeField]
	private GameObject _unlockGO;

	[SerializeField]
	private BImage _specialTreasureImage;

	[SerializeField]
	private Image _specialTreasureIcon;

	private IReadOnlyList<Treasure> _specialTreasureList;

	private int treasureId;

	private int typeId;

	private ImageAssetStation _station;

	public void OnSubmit(BaseEventData eventData)
	{
		if (_btn_goto.gameObject.activeSelf && _btn_goto.IsInteractable())
		{
			_btn_goto.OnSubmit(eventData);
		}
	}

	public override void ScrollCellIndex(int idx)
	{
		gameObject.SetActive(value: true);
		index = idx;
		_specialTreasureList = Model<TreasureModel>.Interface.GetAllSpecialTreasures();
		Treasure treasure = _specialTreasureList[index];
		treasureId = treasure.TreasureId;
		if (_station == null)
		{
			_station = GetComponentInParent<IBaseUIView>().Station;
		}
		Item item = new Item();
		item.Id = treasureId;
		_treasureUIComponent.Station = _station;
		_treasureUIComponent.SetData(item, 0L);
		_treasureUIComponent.gameObject.SetActive(value: true);
		_treasureUIComponent.IsHighLight = false;
		_treasureUIComponent.UpdatePerformance();
		ItemTreasureData data = CoreUtils.GetData(treasureId, RuntimeConfigs.data.itemTreasureDatas);
		typeId = data.type;
		ItemData data2 = CoreUtils.GetData(data.itemId, RuntimeConfigs.data.itemDatas);
		bool flag = Model<TreasureModel>.Interface.HasGain(treasureId);
		if (flag)
		{
			_treasureName.SetText(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, data2.nameLocal));
			_unlockGO.SetActive(value: false);
			_specialTreasureIcon.gameObject.SetActive(value: true);
			_station.LoadItemIconAsync(data.itemId, _specialTreasureImage).Forget();
		}
		else
		{
			_treasureName.SetText("???");
			_unlockGO.SetActive(value: true);
			_specialTreasureIcon.gameObject.SetActive(value: false);
		}
		_collectedTxt.SetText(flag ? LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 1638) : LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2246));
		ColorUtility.TryParseHtmlString(flag ? Model<WorldLevelModel>.Interface.GetTextColorString(WorldLevelColorEnum.BrightChartreuse) : Model<WorldLevelModel>.Interface.GetTextColorString(WorldLevelColorEnum.Dark), out var color);
		_collectedTxt.color = color;
		_btn_goto.gameObject.SetActive(!flag && Model<TreasureModel>.Interface.IsSpecialTreasure(treasureId));
		_btn_goto.SetBtnClick(GotoTreasureView);
	}

	private void GotoTreasureView()
	{
		TreasureJumpToSpecificEvt evt = Singleton<EventManager>.instance.GetEvt<TreasureJumpToSpecificEvt>();
		evt.OpenType = typeId;
		evt.JumpTargetTreasureId = treasureId;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.TreasureJumpToSpecific, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		GetComponentInParent<TreasureAdditionsView>()?.Close();
	}
}
