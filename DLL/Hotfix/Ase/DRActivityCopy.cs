using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRActivityCopy : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int TeamSet { get; private set; }

	public string ActivityMapData { get; private set; }

	public bool IsMulti { get; private set; }

	public bool IsRepeat { get; private set; }

	public List<int> Buff { get; private set; }

	public int MatchTeamLevel { get; private set; }

	public string Name { get; private set; }

	public string Desc { get; private set; }

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
		TeamSet = int.Parse(array[num++]);
		ActivityMapData = array[num++];
		IsMulti = bool.Parse(array[num++]);
		IsRepeat = bool.Parse(array[num++]);
		Buff = DataTableExtension.ParseListInt(array[num++]);
		MatchTeamLevel = int.Parse(array[num++]);
		Name = array[num++];
		Desc = array[num++];
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
			TeamSet = binaryReader.Read7BitEncodedInt32();
			ActivityMapData = binaryReader.ReadString();
			IsMulti = binaryReader.ReadBoolean();
			IsRepeat = binaryReader.ReadBoolean();
			Buff = binaryReader.ReadListInt();
			MatchTeamLevel = binaryReader.Read7BitEncodedInt32();
			Name = binaryReader.ReadString();
			Desc = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
