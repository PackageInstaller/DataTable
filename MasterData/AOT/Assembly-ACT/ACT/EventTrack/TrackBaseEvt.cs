using System.Collections.Generic;
using ACT.Battle;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using Bamboo.ECS;
using Fundamental;
using Newtonsoft.Json.Linq;
using UnityEngine;
using bamboosdk;

namespace ACT.EventTrack;

public abstract class TrackBaseEvt<T> where T : TrackBaseEvt<T>, new()
{
	public virtual bool SkipIfWorldNotStart => true;

	public virtual void ReleaseEvt()
	{
		((ObjectPool<T>)EventTrackSolver.EvtsPool[typeof(T)]).Release(this as T);
	}

	public virtual void OnDispatch()
	{
	}

	protected string SetTransNo(JObject jObject)
	{
		SceneStatus sceneStatus = G.localPlayer.Profile.SceneStatus;
		return SetTransNo(jObject, sceneStatus);
	}

	protected static string SetTransNo(JObject jObject, SceneStatus status)
	{
		if (G.localPlayer.Profile.SceneInfos.TryGetValue((int)status, out var value))
		{
			jObject["trans_no"] = value.TransNo;
			return value.TransNo;
		}
		jObject["trans_no"] = 0;
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"Cannot found trans_no for {status}");
		}
		return null;
	}

	protected static void SetTeamInfo(JArray array, out List<int> ids, JObject jObject = null)
	{
		if (jObject != null)
		{
			jObject["potion_id"] = Model<BloodBottleModel>.Interface.curSceneEquipBloodBottleId;
			jObject["capacity"] = new JArray(Model<BloodBottleModel>.Interface.bottleMaterials.Keys);
		}
		MonoECS.instance.chTimeStatisticsManager.Calculate();
		ids = new List<int>();
		int num = BattleConsts.TEAMCAPITAL - array.Count;
		for (int i = 0; i < num; i++)
		{
			array.Add(new JObject());
		}
		for (int j = 0; j < BattleConsts.TEAMCAPITAL; j++)
		{
			JToken jToken = array[j];
			Entity teamCharacter = MonoECS.instance.localPlayer.GetTeamCharacter(j);
			int num2 = -1;
			int num3 = -1;
			float num4 = -1f;
			JArray jArray = new JArray();
			JArray jArray2 = new JArray();
			JArray jArray3 = new JArray();
			if (teamCharacter.IsValid)
			{
				CompCharacter? compCharacter = teamCharacter.GetCompCharacter();
				num2 = compCharacter.characterSource.Id();
				num3 = compCharacter.characterSource.Level();
				num4 = teamCharacter.GetCompAbility().HpPercent;
				if (compCharacter.characterSource is Character character)
				{
					for (int k = 1; k <= 4; k++)
					{
						if (character.Equips.ContainsKey(k) && character.Equips[k] > 0)
						{
							int num5 = character.Equips[k];
							Equip equip = character.GetEquip(num5);
							jArray.Add(num5);
							jArray2.Add(equip.Level);
							jArray3.Add(equip.Id);
						}
						else
						{
							jArray.Add(0);
							jArray2.Add(0);
							jArray3.Add(0);
						}
					}
				}
			}
			jToken["id"] = num2;
			jToken["level"] = num3;
			jToken["hp"] = num4;
			jToken["damage"] = MonoECS.instance.damageStatisticsManager.GetDamageStatistics(num2);
			jToken["duration"] = MonoECS.instance.chTimeStatisticsManager.GetTimeStatistics(num2);
			jToken["equips"] = jArray;
			jToken["equips_level"] = jArray2;
			jToken["equips_list"] = jArray3;
			ids.Add(num2);
		}
	}

	protected void Send(string evtName, JObject properties)
	{
		BamBooSdk.getInstance().taEvent(evtName, properties.ToString());
	}
}
