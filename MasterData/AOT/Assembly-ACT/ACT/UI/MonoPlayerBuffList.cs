using ACT.Battle;
using ACT.Event;
using ACT.Model;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class MonoPlayerBuffList : BaseBuffList, IUIFrameElement
{
	private Entity _entity => MonoECS.instance.mainEntity;

	public void Initialize()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_UpdateCustomUIScheme, OnUpdateCustomUIScheme);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BattleCharacterChange, OnBattleCharacterChange);
		SetTransform(Model<CustomUIModel>.Interface.GetCurScheme().BuffListTransform);
		_station = ((IUIFrameElement)this).GetParentView()?.Station;
		GetObjectPool();
		_data = new EntityBuffIconData(_entity);
		UpdateUIFromEntityData(_data);
	}

	public void UnInitialize()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_UpdateCustomUIScheme, OnUpdateCustomUIScheme);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BattleCharacterChange, OnBattleCharacterChange);
		ClearAllBuffUIs();
		ReleaseObjectPool();
		_data = null;
	}

	private void OnBattleCharacterChange(BaseEventContent eventContent)
	{
		if (eventContent is BattleCharacterChangeEvt)
		{
			ClearAllBuffUIs();
			_data = new EntityBuffIconData(_entity);
			UpdateUIFromEntityData(_data);
		}
	}

	private void OnUpdateCustomUIScheme(BaseEventContent eventContent)
	{
		if (eventContent is UpdateCustomUISchemeEvt updateCustomUISchemeEvt)
		{
			SetTransform(updateCustomUISchemeEvt.scheme.BuffListTransform);
		}
	}

	public void SetTransform(CustomUITransform customUITransform)
	{
		RectTransform obj = transform as RectTransform;
		Vector2 anchorMin = (obj.anchorMax = new Vector2(customUITransform.AnchorX, customUITransform.AnchorY));
		obj.anchorMin = anchorMin;
		obj.anchoredPosition = customUITransform.Pos;
	}
}
