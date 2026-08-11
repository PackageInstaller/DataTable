using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using Ase;
using GameFramework;
using Newtonsoft.Json;

[Serializable]
public class BattleVerificationData
{
	private List<byte[]> _battleFrameMessages = new List<byte[]>();

	private byte[] _battleDamageData;

	private string _version;

	private long _roomId;

	public long RoomId => _roomId;

	private BattleVerificationData()
	{
	}

	public BattleVerificationData(string version, long roomId)
	{
		_version = version;
		_roomId = roomId;
	}

	public void RecodeCommand(MsgPlayerInput input, int tick = -1)
	{
		if (_battleFrameMessages != null && (input != null || tick != -1))
		{
			SingleBattleFrameMessage singleBattleFrameMessage = StructureServerData(input, tick);
			string s = JsonConvert.SerializeObject(new BattleFrameData
			{
				SingleBattleFrameMessage = new List<SingleBattleFrameMessage> { singleBattleFrameMessage }
			});
			byte[] item = CLZF2.Compress(Encoding.UTF8.GetBytes(s));
			_battleFrameMessages.Add(item);
			ReferencePool.Release(singleBattleFrameMessage);
		}
	}

	public void RecodeAICommand(int entityID, string paradoxParamKey, int paradoxParamValue, int tick)
	{
		if (_battleFrameMessages != null && (string.IsNullOrEmpty(paradoxParamKey) || tick != -1))
		{
			SingleBattleFrameMessage singleBattleFrameMessage = StructureServerDataAICommand(entityID, paradoxParamKey, paradoxParamValue, tick);
			string s = JsonConvert.SerializeObject(new BattleFrameData
			{
				SingleBattleFrameMessage = new List<SingleBattleFrameMessage> { singleBattleFrameMessage }
			});
			byte[] item = CLZF2.Compress(Encoding.UTF8.GetBytes(s));
			_battleFrameMessages.Add(item);
			ReferencePool.Release(singleBattleFrameMessage);
		}
	}

	public void RecodeMaxDamage(Dictionary<int, float> maxDamageDic)
	{
		SingleBattleDamage singleBattleDamage = StructureServerDataDamage(maxDamageDic);
		string s = JsonConvert.SerializeObject(new BattleDamageData
		{
			SingleBattleDamage = new List<SingleBattleDamage> { singleBattleDamage }
		});
		_battleDamageData = CLZF2.Compress(Encoding.UTF8.GetBytes(s));
		ReferencePool.Release(singleBattleDamage);
	}

	public byte[] GetCompleteBattleData()
	{
		using MemoryStream memoryStream = new MemoryStream();
		using BinaryWriter binaryWriter = new BinaryWriter(memoryStream);
		binaryWriter.Write(_battleFrameMessages.Count);
		foreach (byte[] battleFrameMessage in _battleFrameMessages)
		{
			binaryWriter.Write(battleFrameMessage.Length);
			binaryWriter.Write(battleFrameMessage);
		}
		if (_battleDamageData != null)
		{
			binaryWriter.Write(value: true);
			binaryWriter.Write(_battleDamageData.Length);
			binaryWriter.Write(_battleDamageData);
		}
		else
		{
			binaryWriter.Write(value: false);
		}
		return memoryStream.ToArray();
	}

	public byte[] GetVerificationData()
	{
		return GetCompleteBattleData();
	}

	private SingleBattleFrameMessage StructureServerData(MsgPlayerInput msgPlayerInput, int tick)
	{
		SingleBattleFrameMessage singleBattleFrameMessage = SingleBattleFrameMessage.Create();
		singleBattleFrameMessage.Actor = -1;
		singleBattleFrameMessage.Tick = tick;
		if (msgPlayerInput != null)
		{
			singleBattleFrameMessage.Tick = msgPlayerInput.Tick;
			singleBattleFrameMessage.inputUV.Add(msgPlayerInput.inputUV.x);
			singleBattleFrameMessage.inputUV.Add(msgPlayerInput.inputUV.y);
			singleBattleFrameMessage.skillJoyUv.Add(msgPlayerInput.skillJoyUv.x);
			singleBattleFrameMessage.skillJoyUv.Add(msgPlayerInput.skillJoyUv.y);
			singleBattleFrameMessage.optionCode = (int)msgPlayerInput.optionCode;
			singleBattleFrameMessage.SkillState = msgPlayerInput.SkillState;
		}
		return singleBattleFrameMessage;
	}

	private SingleBattleFrameMessage StructureServerDataAICommand(int entityID, string paradoxParamKey, int paradoxParamValue, int tick)
	{
		SingleBattleFrameMessage singleBattleFrameMessage = SingleBattleFrameMessage.Create();
		singleBattleFrameMessage.Actor = entityID;
		singleBattleFrameMessage.Tick = tick;
		singleBattleFrameMessage.ParadoxParamKey = paradoxParamKey;
		singleBattleFrameMessage.ParadoxParamValue = paradoxParamValue;
		return singleBattleFrameMessage;
	}

	private SingleBattleDamage StructureServerDataDamage(Dictionary<int, float> maxDamageDic)
	{
		SingleBattleDamage singleBattleDamage = SingleBattleDamage.Create();
		foreach (KeyValuePair<int, float> item in maxDamageDic)
		{
			singleBattleDamage.Entities.Add(item.Key);
			singleBattleDamage.MaxDamages.Add(item.Value);
		}
		return singleBattleDamage;
	}

	public void Clear()
	{
		_version = null;
		_roomId = 0L;
		_battleFrameMessages.Clear();
	}
}
