using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRRandomMonsterAttr : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int MonsterWeight { get; private set; }

	public string MonsterLabel { get; private set; }

	public string SceneName { get; private set; }

	public int NavmeshID { get; private set; }

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
		MonsterWeight = int.Parse(array[num++]);
		MonsterLabel = array[num++];
		SceneName = array[num++];
		NavmeshID = int.Parse(array[num++]);
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
			MonsterWeight = binaryReader.Read7BitEncodedInt32();
			MonsterLabel = binaryReader.ReadString();
			SceneName = binaryReader.ReadString();
			NavmeshID = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
