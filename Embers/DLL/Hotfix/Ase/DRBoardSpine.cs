using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRBoardSpine : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public List<int> BoardHeroId { get; private set; }

	public string ActionIndex { get; private set; }

	public List<int> TriggerType { get; private set; }

	public bool CanBreak { get; private set; }

	public List<int> OpenType { get; private set; }

	public List<int> OpenArgs { get; private set; }

	public string StartOpenTime { get; private set; }

	public string EndOpenTime { get; private set; }

	public List<string> FixTimeRange { get; private set; }

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
		BoardHeroId = DataTableExtension.ParseListInt(array[num++]);
		ActionIndex = array[num++];
		TriggerType = DataTableExtension.ParseListInt(array[num++]);
		CanBreak = bool.Parse(array[num++]);
		OpenType = DataTableExtension.ParseListInt(array[num++]);
		OpenArgs = DataTableExtension.ParseListInt(array[num++]);
		StartOpenTime = array[num++];
		EndOpenTime = array[num++];
		FixTimeRange = DataTableExtension.ParseListString(array[num++]);
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
			BoardHeroId = binaryReader.ReadListInt();
			ActionIndex = binaryReader.ReadString();
			TriggerType = binaryReader.ReadListInt();
			CanBreak = binaryReader.ReadBoolean();
			OpenType = binaryReader.ReadListInt();
			OpenArgs = binaryReader.ReadListInt();
			StartOpenTime = binaryReader.ReadString();
			EndOpenTime = binaryReader.ReadString();
			FixTimeRange = binaryReader.ReadListString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
