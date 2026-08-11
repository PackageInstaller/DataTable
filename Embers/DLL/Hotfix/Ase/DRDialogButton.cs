using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRDialogButton : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Text { get; private set; }

	public string Result { get; private set; }

	public string ParadoxArgs { get; private set; }

	public string Args { get; private set; }

	public List<int> OpenConfition { get; private set; }

	public string IconType { get; private set; }

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
		Text = array[num++];
		Result = array[num++];
		ParadoxArgs = array[num++];
		Args = array[num++];
		OpenConfition = DataTableExtension.ParseListInt(array[num++]);
		IconType = array[num++];
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
			Text = binaryReader.ReadString();
			Result = binaryReader.ReadString();
			ParadoxArgs = binaryReader.ReadString();
			Args = binaryReader.ReadString();
			OpenConfition = binaryReader.ReadListInt();
			IconType = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
