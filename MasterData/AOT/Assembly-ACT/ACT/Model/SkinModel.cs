using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using Pb;

namespace ACT.Model;

public class SkinModel : Model<SkinModel>
{
	public enum SkinClickStatus
	{
		Dress = 2,
		UnDress,
		Preview,
		GotoShop
	}

	private Dictionary<int, SkinInfo> _skinInfo = new Dictionary<int, SkinInfo>();

	private Dictionary<int, EffectDressInfo> _effectDressInfo = new Dictionary<int, EffectDressInfo>();

	protected override void Init()
	{
	}

	protected override void UnInit()
	{
		_skinInfo.Clear();
		_effectDressInfo.Clear();
	}

	public bool CheckSkinIsHave(int skinId)
	{
		Skin data = CoreUtils.GetData(skinId, RuntimeConfigs.data.Skins);
		if (data == null || data.skinType != 1)
		{
			return _skinInfo.ContainsKey(skinId);
		}
		return true;
	}

	public void OnSkinInfoNtf(SkinSyncNtf skinSyncNtf)
	{
		_skinInfo.Clear();
		for (int i = 0; i < skinSyncNtf.Skins.Count; i++)
		{
			_skinInfo.Add(skinSyncNtf.Skins[i].SkinId, skinSyncNtf.Skins[i]);
		}
	}

	public void AddSkin(SkinAddNtf addNtf)
	{
		for (int i = 0; i < addNtf.Skins.Count; i++)
		{
			_skinInfo.Add(addNtf.Skins[i].SkinId, addNtf.Skins[i]);
		}
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.AddSkin, null);
	}

	public void SendChangeSkin(int RoleId, int SkinId)
	{
		G.service.SendChangeSkinReq(RoleId, SkinId, (ChangeSkinAck ack) =>
		{
			CharacterSkinRuntimeUtility.ChangeCharacterSkin(RoleId, SkinId).Forget();
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.SwitchSkin, null);
		});
	}

	public bool CheckEffectDressIsHave(int effectDressId)
	{
		return _effectDressInfo.ContainsKey(effectDressId);
	}

	public void OnEffectDressSyncNtf(EffectDressSyncNtf syncNtf)
	{
		_effectDressInfo.Clear();
		for (int i = 0; i < syncNtf.EffectDresses.Count; i++)
		{
			_effectDressInfo[syncNtf.EffectDresses[i].EffectDressId] = syncNtf.EffectDresses[i];
		}
	}

	public void AddEffectDress(EffectDressAddNtf addNtf)
	{
		for (int i = 0; i < addNtf.EffectDresses.Count; i++)
		{
			_effectDressInfo[addNtf.EffectDresses[i].EffectDressId] = addNtf.EffectDresses[i];
		}
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.AddEffectDress, null);
	}

	public void SendChangeEffectDress(int roleId, int effectDressId, bool wear)
	{
		G.service.SendChangeEffectDressReq(roleId, effectDressId, wear, (ChangeEffectDressAck ack) =>
		{
			if (ack != null)
			{
				int num = ((ack.CharacterId != 0) ? ack.CharacterId : roleId);
				Character character = G.localPlayer.GetCharacter(num);
				if (character != null)
				{
					character.EffectDressId = ack.EffectDressId;
				}
				SwitchEffectDressEvt evt = Singleton<EventManager>.instance.GetEvt<SwitchEffectDressEvt>();
				evt.roleId = num;
				evt.requestEffectDressId = effectDressId;
				evt.currentEffectDressId = ack.EffectDressId;
				evt.wear = wear;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.SwitchEffectDress, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
			}
		});
		Model<SkinModel>.Interface.DecorationClickSkinEvent(roleId, effectDressId, wear ? SkinClickStatus.Dress : SkinClickStatus.UnDress);
	}

	public void DispatchClickSkinEvent(int characterId, int skinId, SkinClickStatus skinClickStatus)
	{
		CosmeticClickEvent evt = EventTrackSolver.Instance.GetEvt<CosmeticClickEvent>();
		evt.cosmeticId = skinId;
		evt.quality = CoreUtils.GetData(skinId, RuntimeConfigs.data.Skins).skinQuality;
		evt.status = (int)skinClickStatus;
		evt.cosmeticType = 0;
		evt.characterId = characterId;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	public void DecorationClickSkinEvent(int characterId, int decorationId, SkinClickStatus skinClickStatus)
	{
		CosmeticClickEvent evt = EventTrackSolver.Instance.GetEvt<CosmeticClickEvent>();
		evt.cosmeticId = decorationId;
		evt.quality = CoreUtils.GetData(decorationId, RuntimeConfigs.data.effectDresss).dressQuality;
		evt.status = (int)skinClickStatus;
		evt.cosmeticType = CoreUtils.GetData(decorationId, RuntimeConfigs.data.effectDresss).dressType;
		evt.characterId = characterId;
		EventTrackSolver.Instance.Dispatch(evt);
	}
}
