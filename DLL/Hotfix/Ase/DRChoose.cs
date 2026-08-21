using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRChoose : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int CardId { get; private set; }

	public List<int> Option { get; private set; }

	public List<int> Type { get; private set; }

	public int Trigger { get; private set; }

	public int IsDie { get; private set; }

	public bool IsPopUp { get; private set; }

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
		CardId = int.Parse(array[num++]);
		Option = DataTableExtension.ParseListInt(array[num++]);
		Type = DataTableExtension.ParseListInt(array[num++]);
		Trigger = int.Parse(array[num++]);
		IsDie = int.Parse(array[num++]);
		IsPopUp = bool.Parse(array[num++]);
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
			CardId = binaryReader.Read7BitEncodedInt32();
			Option = binaryReader.ReadListInt();
			Type = binaryReader.ReadListInt();
			Trigger = binaryReader.Read7BitEncodedInt32();
			IsDie = binaryReader.Read7BitEncodedInt32();
			IsPopUp = binaryReader.ReadBoolean();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
