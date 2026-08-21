using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRMonsterInfo : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Name { get; private set; }

	public string Information { get; private set; }

	public int GuideId { get; private set; }

	public string MonsterHead { get; private set; }

	public string MonsterIcon { get; private set; }

	public string BodyWeak { get; private set; }

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
		Information = array[num++];
		GuideId = int.Parse(array[num++]);
		MonsterHead = array[num++];
		MonsterIcon = array[num++];
		BodyWeak = array[num++];
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
			Information = binaryReader.ReadString();
			GuideId = binaryReader.Read7BitEncodedInt32();
			MonsterHead = binaryReader.ReadString();
			MonsterIcon = binaryReader.ReadString();
			BodyWeak = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
