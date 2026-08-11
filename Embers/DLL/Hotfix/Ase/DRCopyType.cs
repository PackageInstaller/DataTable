using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRCopyType : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Name { get; private set; }

	public string Icon { get; private set; }

	public int MainCopyId { get; private set; }

	public int CopyNumber { get; private set; }

	public int OpenType { get; private set; }

	public int Open { get; private set; }

	public int TaskCompleted { get; private set; }

	public int RewardCountMax { get; private set; }

	public List<int> ZoneBuff { get; private set; }

	public int Zone { get; private set; }

	public string StartTime { get; private set; }

	public string EndTime { get; private set; }

	public int Version { get; private set; }

	public bool ShowBattleDS { get; private set; }

	public int Rate { get; private set; }

	public int SoloAuto { get; private set; }

	public int CoopAuto { get; private set; }

	public int AutoSwitchDelay { get; private set; }

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
		Name = array[num++];
		Icon = array[num++];
		MainCopyId = int.Parse(array[num++]);
		CopyNumber = int.Parse(array[num++]);
		OpenType = int.Parse(array[num++]);
		Open = int.Parse(array[num++]);
		TaskCompleted = int.Parse(array[num++]);
		RewardCountMax = int.Parse(array[num++]);
		ZoneBuff = DataTableExtension.ParseListInt(array[num++]);
		Zone = int.Parse(array[num++]);
		StartTime = array[num++];
		EndTime = array[num++];
		Version = int.Parse(array[num++]);
		ShowBattleDS = bool.Parse(array[num++]);
		Rate = int.Parse(array[num++]);
		SoloAuto = int.Parse(array[num++]);
		CoopAuto = int.Parse(array[num++]);
		AutoSwitchDelay = int.Parse(array[num++]);
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
			Name = binaryReader.ReadString();
			Icon = binaryReader.ReadString();
			MainCopyId = binaryReader.Read7BitEncodedInt32();
			CopyNumber = binaryReader.Read7BitEncodedInt32();
			OpenType = binaryReader.Read7BitEncodedInt32();
			Open = binaryReader.Read7BitEncodedInt32();
			TaskCompleted = binaryReader.Read7BitEncodedInt32();
			RewardCountMax = binaryReader.Read7BitEncodedInt32();
			ZoneBuff = binaryReader.ReadListInt();
			Zone = binaryReader.Read7BitEncodedInt32();
			StartTime = binaryReader.ReadString();
			EndTime = binaryReader.ReadString();
			Version = binaryReader.Read7BitEncodedInt32();
			ShowBattleDS = binaryReader.ReadBoolean();
			Rate = binaryReader.Read7BitEncodedInt32();
			SoloAuto = binaryReader.Read7BitEncodedInt32();
			CoopAuto = binaryReader.Read7BitEncodedInt32();
			AutoSwitchDelay = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
