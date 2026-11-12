using System.Collections.Generic;
using System.Linq;
using Nova.Hotfix;
using UnityEngine;

internal sealed class WwiseVoiceRuntimeImpl : IWwiseVoiceRuntime
{
	private string strExternalCookie = "externalCookie";

	private AkExternalSourceInfoArray _akExtSrcInfoArr;

	private string _sLanguageSurfix = string.Empty;

	private Dictionary<int, Dictionary<string, List<VoDirectory>>> voDirecDatas = new Dictionary<int, Dictionary<string, List<VoDirectory>>>();

	private int[] currentPlayVoSort = new int[4];

	private uint[] voPlayingIDs = new uint[4];

	private List<string> cdStrs = new List<string>(30);

	private List<float> cdValues = new List<float>(30);

	private VoDirectory lastVo;

	private bool forbiddenVoice;

	private readonly List<VoDirectory> tempVoList = new List<VoDirectory>(20);

	private AkExternalSourceInfoArray AkExtSrcInfoArr
	{
		get
		{
			if (_akExtSrcInfoArr == null)
			{
				_akExtSrcInfoArr = new AkExternalSourceInfoArray(1);
				((AkBaseArray<AkExternalSourceInfo>)_akExtSrcInfoArr).get_Item(0).iExternalSrcCookie = AkSoundEngine.GetIDFromString(strExternalCookie);
				((AkBaseArray<AkExternalSourceInfo>)_akExtSrcInfoArr).get_Item(0).idCodec = 4u;
			}
			return _akExtSrcInfoArr;
		}
	}

	private string SURFIX
	{
		get
		{
			switch (MonoSingleton<ClientManager>.Instance.voiceLanguage)
			{
			case "zh_CN":
				_sLanguageSurfix = "_cn";
				break;
			case "zh_TW":
				_sLanguageSurfix = "_tw";
				break;
			case "ja_JP":
				_sLanguageSurfix = "_jp";
				break;
			case "en_US":
				_sLanguageSurfix = "_en";
				break;
			case "ko_KR":
				_sLanguageSurfix = "_kr";
				break;
			}
			return _sLanguageSurfix;
		}
	}

	private GameObject AkListener
	{
		get
		{
			if (!(MonoSingleton<WwiseAudioManager>.Instance != null))
			{
				return null;
			}
			return MonoSingleton<WwiseAudioManager>.Instance.AkListener;
		}
	}

	public void InitVoiceData()
	{
		voDirecDatas.Clear();
		foreach (VoDirectory value2 in Singleton<HotfixDataController>.Instance.VoDirectoryData.Values)
		{
			if (!voDirecDatas.ContainsKey(value2.CharacterId))
			{
				Dictionary<string, List<VoDirectory>> dictionary = new Dictionary<string, List<VoDirectory>>();
				List<VoDirectory> value = new List<VoDirectory> { value2 };
				dictionary.Add(value2.Votype, value);
				voDirecDatas.Add(value2.CharacterId, dictionary);
				continue;
			}
			Dictionary<string, List<VoDirectory>> dictionary2 = voDirecDatas.get_Item(value2.CharacterId);
			if (!dictionary2.ContainsKey(value2.Votype))
			{
				List<VoDirectory> list = new List<VoDirectory>();
				list.Add(value2);
				dictionary2.Add(value2.Votype, list);
			}
			else
			{
				dictionary2.get_Item(value2.Votype).Add(value2);
			}
		}
	}

	public void UpdateVoCd()
	{
		if (cdValues.Count <= 0)
		{
			return;
		}
		for (int num = cdValues.Count - 1; num > -1; num--)
		{
			cdValues.get_Item(num) -= Time.deltaTime;
			if (cdValues.get_Item(num) < 0f)
			{
				cdValues.RemoveAt(num);
				cdStrs.RemoveAt(num);
			}
		}
	}

	private VoDirectory GetVoConfig(int characterId, string voType, int voIndex = 0, int skinId = 0, bool isSkinLimit = false)
	{
		if (characterId > 0 && !string.IsNullOrEmpty(voType))
		{
			if (skinId == 0 && AdventureWwiseRuntime.Current != null && AdventureWwiseRuntime.Current.TryGetActorSkinId(characterId, out var skinId2))
			{
				skinId = skinId2;
			}
			if (voDirecDatas.ContainsKey(characterId) && voDirecDatas.get_Item(characterId).ContainsKey(voType))
			{
				int count = voDirecDatas.get_Item(characterId).get_Item(voType).Count;
				if (voIndex > 0 && voIndex <= count)
				{
					return voDirecDatas.get_Item(characterId).get_Item(voType).get_Item(voIndex - 1);
				}
				if (count > 1)
				{
					if (isSkinLimit)
					{
						List<VoDirectory> list = (from vo in voDirecDatas.get_Item(characterId).get_Item(voType)
							where vo.SkinId == skinId
							select vo).ToList();
						if (list.Count > 0)
						{
							return list.get_Item(Random.Range(0, list.Count));
						}
						List<VoDirectory> list2 = (from vo in voDirecDatas.get_Item(characterId).get_Item(voType)
							where vo.SkinId == 0
							select vo).ToList();
						if (list2.Count > 0)
						{
							return list2.get_Item(Random.Range(0, list2.Count));
						}
					}
					List<VoDirectory> list3 = (from vo in voDirecDatas.get_Item(characterId).get_Item(voType)
						where vo.SkinId == skinId || vo.SkinId == 0
						select vo).ToList();
					VoDirectory voDirectory = list3.get_Item(Random.Range(0, list3.Count));
					int num = 0;
					while (voDirectory == lastVo && num < 10)
					{
						num++;
						voDirectory = list3.get_Item(Random.Range(0, list3.Count));
					}
					lastVo = voDirectory;
					return voDirectory;
				}
				if (count > 0)
				{
					return voDirecDatas.get_Item(characterId).get_Item(voType).get_Item(0);
				}
			}
		}
		return null;
	}

	private bool CheckWemFileLegal(CharacterVoiceControl voCdata, bool checkProbability = true)
	{
		if (voCdata == null)
		{
			return false;
		}
		IAdventureWwiseRuntime current = AdventureWwiseRuntime.Current;
		if (voCdata.WorldLevelTypes.get_Item(0) != 11 && current != null)
		{
			for (int i = 0; i < voCdata.WorldLevelTypes.Count; i++)
			{
				if (voCdata.WorldLevelTypes.get_Item(i) != current.CurrentLevelType)
				{
					return false;
				}
			}
		}
		if (current != null && voCdata.CombatOnly && !current.IsInAlert)
		{
			return false;
		}
		if (checkProbability && voCdata.Probability < 100 && voCdata.Probability < Random.Range(1, 100))
		{
			return false;
		}
		if (checkProbability && voCdata.Cd > 0f && cdStrs.Contains(voCdata.Id))
		{
			return false;
		}
		int num = voCdata.VoPlayer - 1;
		if (checkProbability && currentPlayVoSort[num] > voCdata.Priority)
		{
			if (voPlayingIDs[num] != 0 && AkSoundEngine.GetEventIDFromPlayingID(voPlayingIDs[num]) != 0)
			{
				return false;
			}
		}
		else if (voPlayingIDs[num] != 0 && AkSoundEngine.GetEventIDFromPlayingID(voPlayingIDs[num]) != 0)
		{
			WwiseVoice_Stop(num);
		}
		return true;
	}

	private string GetEventName(int voIndex, bool iPlay = true)
	{
		switch (voIndex)
		{
		case 0:
			if (iPlay)
			{
				return "vo_combat_externalSource_play";
			}
			return "vo_combat_externalSource_stop";
		case 1:
			if (iPlay)
			{
				return "vo_combat_externalSource_play";
			}
			return "vo_combat_externalSource_stop";
		case 2:
			if (iPlay)
			{
				return "vo_system_externalSource_play";
			}
			return "vo_system_externalSource_stop";
		case 3:
			if (iPlay)
			{
				return "vo_system_externalSource_play";
			}
			return "vo_system_externalSource_stop";
		default:
			return null;
		}
	}

	private string GetFullWemName(string sName)
	{
		return $"{sName}{SURFIX}.wem";
	}

	private GameObject GetAkObj(int actorId)
	{
		if (AdventureWwiseRuntime.Current != null && AdventureWwiseRuntime.Current.TryGetActorGameObject(actorId, out var gameObject))
		{
			return gameObject;
		}
		return AkListener;
	}

	private CharacterVoiceControl CheckWwiseVoiceState(ref int characterId, string voType)
	{
		if (forbiddenVoice)
		{
			return null;
		}
		IAdventureWwiseRuntime current = AdventureWwiseRuntime.Current;
		if (characterId == 0 && current != null)
		{
			characterId = current.ActivedPlayerActorDataID;
		}
		if (characterId <= 0 || string.IsNullOrEmpty(voType))
		{
			return null;
		}
		CharacterVoiceControl characterVoiceControl = Singleton<HotfixDataController>.Instance.GetCharacterVoiceControl(voType);
		if (characterVoiceControl == null)
		{
			return null;
		}
		if (characterVoiceControl.ResType == 3)
		{
			int index = Random.Range(0, 3);
			if (current != null && current.ActorCount > 2)
			{
				int actorDataIdAt = current.GetActorDataIdAt(index);
				if (actorDataIdAt > 0)
				{
					characterId = actorDataIdAt;
				}
			}
		}
		if (current != null && current.IsStarTowerPrologue && (characterId == 111 || characterId == 112))
		{
			return null;
		}
		return characterVoiceControl;
	}

	public void Voice_Perk(int characterId)
	{
		if (AdventureWwiseRuntime.Current != null)
		{
			bool flag = AdventureWwiseRuntime.Current.ActivedPlayerActorId != characterId;
			WwiseVoice_Play(characterId, flag ? "subperk" : "perk");
		}
	}

	public void Voice_BattleLvEnd()
	{
		if (AdventureWwiseRuntime.Current != null)
		{
			WwiseVoice_Play(AdventureWwiseRuntime.Current.ActivedPlayerActorId, "battleClear");
		}
	}

	private int Voice_Play(CharacterVoiceControl voCdata, VoDirectory voFile, int characterId, AkCallbackManager.EventCallback callback = null, AkCallbackType callbackType = AkCallbackType.AK_Duration, bool checkProbability = true)
	{
		if (!CheckWemFileLegal(voCdata, checkProbability))
		{
			return 0;
		}
		if (voFile == null)
		{
			return 0;
		}
		int _index = voCdata.VoPlayer - 1;
		if (_index >= 4)
		{
			return 0;
		}
		if (!string.IsNullOrEmpty(voFile.VoResource))
		{
			((AkBaseArray<AkExternalSourceInfo>)AkExtSrcInfoArr).get_Item(0).szFile = GetFullWemName(voFile.VoResource);
			string _event = GetEventName(_index);
			callback = ((callback == null) ? new AkCallbackManager.EventCallback(CallbackHandler) : callback);
			MonoSingleton<SoundBankManager>.Instance.LoadBankByEventName(_event, () =>
			{
				voPlayingIDs[_index] = AkSoundEngine.PostEvent(_event, GetAkObj(characterId), (uint)callbackType, callback, 0, (uint)AkExtSrcInfoArr.Count(), AkExtSrcInfoArr);
				currentPlayVoSort[_index] = voCdata.Priority;
				if (voCdata.Cd > 0f)
				{
					cdStrs.Add(voCdata.Id);
					cdValues.Add(voCdata.Cd);
				}
				if (voCdata.Bubble)
				{
					MonoSingleton<LuaManager>.Instance.FireEvent("ShowBubbleVoiceText", characterId, voFile.Id);
				}
			});
		}
		return voFile.Id;
	}

	public int WwiseVoice_Play(int characterId, string voType, AkCallbackManager.EventCallback callback = null, int skinId = 0, bool isSkinLimit = false)
	{
		CharacterVoiceControl characterVoiceControl = CheckWwiseVoiceState(ref characterId, voType);
		if (characterVoiceControl == null)
		{
			return 0;
		}
		VoDirectory voConfig = GetVoConfig(characterId, voType, 0, skinId, isSkinLimit);
		return Voice_Play(characterVoiceControl, voConfig, characterId, callback);
	}

	public int WwiseVoice_Play(int characterId, List<string> voTypes, AkCallbackManager.EventCallback callback = null, int skinId = 0, List<string> limitVoTypes = null)
	{
		if (voTypes.Count == 0)
		{
			return 0;
		}
		if (voTypes.Count == 1)
		{
			bool isSkinLimit = limitVoTypes?.Contains(voTypes.get_Item(0)) ?? false;
			return WwiseVoice_Play(characterId, voTypes.get_Item(0), callback, skinId, isSkinLimit);
		}
		tempVoList.Clear();
		int num = characterId;
		for (int i = 0; i < voTypes.Count; i++)
		{
			num = characterId;
			CharacterVoiceControl characterVoiceControl = CheckWwiseVoiceState(ref num, voTypes.get_Item(i));
			if (num <= 0 || characterVoiceControl == null || !voDirecDatas.ContainsKey(characterId) || !voDirecDatas.get_Item(characterId).ContainsKey(characterVoiceControl.Id))
			{
				continue;
			}
			if (limitVoTypes != null && limitVoTypes.Contains(voTypes.get_Item(i)))
			{
				List<VoDirectory> list = (from vo in voDirecDatas.get_Item(characterId).get_Item(characterVoiceControl.Id)
					where vo.SkinId == skinId
					select vo).ToList();
				if (list.Count > 0)
				{
					tempVoList.AddRange(list);
					continue;
				}
				List<VoDirectory> list2 = (from vo in voDirecDatas.get_Item(characterId).get_Item(characterVoiceControl.Id)
					where vo.SkinId == 0
					select vo).ToList();
				if (list2.Count > 0)
				{
					tempVoList.AddRange(list2);
				}
			}
			else
			{
				List<VoDirectory> list3 = (from vo in voDirecDatas.get_Item(characterId).get_Item(characterVoiceControl.Id)
					where vo.SkinId == skinId || vo.SkinId == 0
					select vo).ToList();
				if (list3.Count > 0)
				{
					tempVoList.AddRange(list3);
				}
			}
		}
		if (tempVoList.Count > 1)
		{
			VoDirectory voDirectory = tempVoList.get_Item(Random.Range(0, tempVoList.Count));
			CharacterVoiceControl characterVoiceControl2 = Singleton<HotfixDataController>.Instance.GetCharacterVoiceControl(voDirectory.Votype);
			return Voice_Play(characterVoiceControl2, voDirectory, voDirectory.CharacterId, callback);
		}
		if (tempVoList.Count > 0)
		{
			VoDirectory voDirectory2 = tempVoList.get_Item(0);
			CharacterVoiceControl characterVoiceControl3 = Singleton<HotfixDataController>.Instance.GetCharacterVoiceControl(voDirectory2.Votype);
			return Voice_Play(characterVoiceControl3, voDirectory2, voDirectory2.CharacterId, callback);
		}
		return 0;
	}

	public int WwiseVoice_PlayEndCallback(int characterId, string voType, int voIndex = 0)
	{
		CharacterVoiceControl characterVoiceControl = CheckWwiseVoiceState(ref characterId, voType);
		if (characterVoiceControl == null)
		{
			return 0;
		}
		VoDirectory voConfig = GetVoConfig(characterId, voType, voIndex);
		return Voice_Play(characterVoiceControl, voConfig, characterId, WWiseVoice_EndCallbackHandler, AkCallbackType.AK_EndOfEvent, checkProbability: false);
	}

	public void WwiseVoice_Stop(int voIndex)
	{
		string _event = GetEventName(voIndex, iPlay: false);
		MonoSingleton<SoundBankManager>.Instance.LoadBankByEventName(_event, () =>
		{
			AkSoundEngine.PostEvent(_event, AkListener, 0u, null, 0, (uint)AkExtSrcInfoArr.Count(), AkExtSrcInfoArr);
		});
	}

	public void WwiseVoice_PauseCombat()
	{
		string _event = "vo_combat_externalSource_pause";
		MonoSingleton<SoundBankManager>.Instance.LoadBankByEventName(_event, () =>
		{
			AkSoundEngine.PostEvent(_event, AkListener, 0u, null, 0, (uint)AkExtSrcInfoArr.Count(), AkExtSrcInfoArr);
		});
	}

	public void WwiseVoice_ResumeCombat()
	{
		string _event = "vo_combat_externalSource_resume";
		MonoSingleton<SoundBankManager>.Instance.LoadBankByEventName(_event, () =>
		{
			AkSoundEngine.PostEvent(_event, AkListener, 0u, null, 0, (uint)AkExtSrcInfoArr.Count(), AkExtSrcInfoArr);
		});
	}

	private void WWiseVoice_EndCallbackHandler(object in_cookie, AkCallbackType in_type, AkCallbackInfo in_info)
	{
		MonoSingleton<LuaManager>.Instance.FireEvent("WWiseVoiceEnd");
	}

	public void WwiseVoice_PlayInAVG(string sVoResName, AkCallbackManager.EventCallback callback = null)
	{
		WwiseVoice_StopInAVG();
		((AkBaseArray<AkExternalSourceInfo>)AkExtSrcInfoArr).get_Item(0).szFile = GetFullWemName(sVoResName);
		string _event = GetEventName(3);
		callback = ((callback == null) ? new AkCallbackManager.EventCallback(CallbackHandler) : callback);
		MonoSingleton<SoundBankManager>.Instance.LoadBankByEventName(_event, () =>
		{
			AkSoundEngine.PostEvent(_event, AkListener, 8u, callback, 0, (uint)AkExtSrcInfoArr.Count(), AkExtSrcInfoArr);
		});
	}

	public void WwiseVoice_StopInAVG()
	{
		string _event = GetEventName(3, iPlay: false);
		MonoSingleton<SoundBankManager>.Instance.LoadBankByEventName(_event, () =>
		{
			AkSoundEngine.PostEvent(_event, AkListener, 0u, null, 0, (uint)AkExtSrcInfoArr.Count(), AkExtSrcInfoArr);
		});
	}

	private void CallbackHandler(object in_cookie, AkCallbackType in_type, AkCallbackInfo in_info)
	{
		if (in_type == AkCallbackType.AK_EndOfEvent)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("AvgVoiceEnd");
		}
		if (in_type == AkCallbackType.AK_Duration)
		{
			float fEstimatedDuration = (in_info as AkDurationCallbackInfo).fEstimatedDuration;
			MonoSingleton<LuaManager>.Instance.FireEvent("AvgVoiceDuration", fEstimatedDuration / 1000f);
		}
	}

	public void WwiseVoice_PauseSystem()
	{
		string _event = "vo_externalSource_pause";
		MonoSingleton<SoundBankManager>.Instance.LoadBankByEventName(_event, () =>
		{
			AkSoundEngine.PostEvent(_event, AkListener, 0u, null, 0, (uint)AkExtSrcInfoArr.Count(), AkExtSrcInfoArr);
		});
	}

	public void WwiseVoice_ResumeSystem()
	{
		string _event = "vo_externalSource_resume";
		MonoSingleton<SoundBankManager>.Instance.LoadBankByEventName(_event, () =>
		{
			AkSoundEngine.PostEvent(_event, AkListener, 0u, null, 0, (uint)AkExtSrcInfoArr.Count(), AkExtSrcInfoArr);
		});
	}

	public void WwiseVoice_PlayDisc(string sVoResName)
	{
		MonoSingleton<SoundBankManager>.Instance.LoadBankByEventName(sVoResName, () =>
		{
			AkSoundEngine.PostEvent(sVoResName, AkListener, 8u, CallbackHandler, 0, (uint)AkExtSrcInfoArr.Count(), AkExtSrcInfoArr);
		});
	}
}
