using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRTowerTalent : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int ActivityId { get; private set; }

	public int Talent { get; private set; }

	public string Name { get; private set; }

	public string Tag { get; private set; }

	public string Icon { get; private set; }

	public int Order { get; private set; }

	public int NeedType { get; private set; }

	public int NeedId { get; private set; }

	public int NeedNum { get; private set; }

	public List<int> UnlockTalent { get; private set; }

	public List<int> UnlockOrder { get; private set; }

	public int UnlockNum { get; private set; }

	public int Type { get; private set; }

	public string Desc { get; private set; }

	public int BattleBuffId { get; private set; }

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
		ActivityId = int.Parse(array[num++]);
		Talent = int.Parse(array[num++]);
		Name = array[num++];
		Tag = array[num++];
		Icon = array[num++];
		Order = int.Parse(array[num++]);
		NeedType = int.Parse(array[num++]);
		NeedId = int.Parse(array[num++]);
		NeedNum = int.Parse(array[num++]);
		UnlockTalent = DataTableExtension.ParseListInt(array[num++]);
		UnlockOrder = DataTableExtension.ParseListInt(array[num++]);
		UnlockNum = int.Parse(array[num++]);
		Type = int.Parse(array[num++]);
		Desc = array[num++];
		BattleBuffId = int.Parse(array[num++]);
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
			ActivityId = binaryReader.Read7BitEncodedInt32();
			Talent = binaryReader.Read7BitEncodedInt32();
			Name = binaryReader.ReadString();
			Tag = binaryReader.ReadString();
			Icon = binaryReader.ReadString();
			Order = binaryReader.Read7BitEncodedInt32();
			NeedType = binaryReader.Read7BitEncodedInt32();
			NeedId = binaryReader.Read7BitEncodedInt32();
			NeedNum = binaryReader.Read7BitEncodedInt32();
			UnlockTalent = binaryReader.ReadListInt();
			UnlockOrder = binaryReader.ReadListInt();
			UnlockNum = binaryReader.Read7BitEncodedInt32();
			Type = binaryReader.Read7BitEncodedInt32();
			Desc = binaryReader.ReadString();
			BattleBuffId = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
