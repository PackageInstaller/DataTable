using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRBattleVoice : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int ObjectId { get; private set; }

	public BattleObserverEventEnum BattleObserverEventEnum { get; private set; }

	public List<string> Conditions { get; private set; }

	public int Priority { get; private set; }

	public int Volume { get; private set; }

	public int VoiceId { get; private set; }

	public float CoolingTime { get; private set; }

	public float DelayTime { get; private set; }

	public override bool ParseDataRow(string dataRowString, object userData)
	{
		string[] array = dataRowString.Split(DataTableExtension.DataSplitSeparators);
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = array[i].Trim(DataTableExtension.DataTrimSeparators);
		}
		int num = 0;
		num++;
		m_Id = int.Parse(array[num++]);
		ObjectId = int.Parse(array[num++]);
		BattleObserverEventEnum = DataTableExtension.ParseEnum<BattleObserverEventEnum>(array[num++]);
		Conditions = DataTableExtension.ParseListString(array[num++]);
		Priority = int.Parse(array[num++]);
		Volume = int.Parse(array[num++]);
		VoiceId = int.Parse(array[num++]);
		CoolingTime = float.Parse(array[num++]);
		DelayTime = float.Parse(array[num++]);
		num++;
		GeneratePropertyArray();
		return true;
	}

	public override bool ParseDataRow(byte[] dataRowBytes, int startIndex, int length, object userData)
	{
		using (MemoryStream memoryStream = new MemoryStream(dataRowBytes, startIndex, length, writable: false))
		{
			byte[] array = AesXorEncryption.DecryptAllData(memoryStream.ToArray());
			using MemoryStream input = new MemoryStream(array, 0, array.Length, writable: false);
			using BinaryReader binaryReader = new BinaryReader(input, Encoding.UTF8);
			m_Id = binaryReader.Read7BitEncodedInt32();
			ObjectId = binaryReader.Read7BitEncodedInt32();
			BattleObserverEventEnum = binaryReader.ReadEnum<BattleObserverEventEnum>();
			Conditions = binaryReader.ReadListString();
			Priority = binaryReader.Read7BitEncodedInt32();
			Volume = binaryReader.Read7BitEncodedInt32();
			VoiceId = binaryReader.Read7BitEncodedInt32();
			CoolingTime = binaryReader.ReadSingle();
			DelayTime = binaryReader.ReadSingle();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
