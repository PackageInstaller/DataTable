using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRGuidanceLevel : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int ParentId { get; private set; }

	public int Type { get; private set; }

	public string Name { get; private set; }

	public string Desc { get; private set; }

	public string Cover { get; private set; }

	public string VideoClip { get; private set; }

	public int Reward { get; private set; }

	public string SceneName { get; private set; }

	public string MapData { get; private set; }

	public int NavMeshId { get; private set; }

	public int Hero { get; private set; }

	public int TaskId { get; private set; }

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
		ParentId = int.Parse(array[num++]);
		Type = int.Parse(array[num++]);
		Name = array[num++];
		Desc = array[num++];
		Cover = array[num++];
		VideoClip = array[num++];
		Reward = int.Parse(array[num++]);
		SceneName = array[num++];
		MapData = array[num++];
		NavMeshId = int.Parse(array[num++]);
		Hero = int.Parse(array[num++]);
		TaskId = int.Parse(array[num++]);
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
			ParentId = binaryReader.Read7BitEncodedInt32();
			Type = binaryReader.Read7BitEncodedInt32();
			Name = binaryReader.ReadString();
			Desc = binaryReader.ReadString();
			Cover = binaryReader.ReadString();
			VideoClip = binaryReader.ReadString();
			Reward = binaryReader.Read7BitEncodedInt32();
			SceneName = binaryReader.ReadString();
			MapData = binaryReader.ReadString();
			NavMeshId = binaryReader.Read7BitEncodedInt32();
			Hero = binaryReader.Read7BitEncodedInt32();
			TaskId = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
