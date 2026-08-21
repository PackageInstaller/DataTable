using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRBattleTimeline : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int ShowForms { get; private set; }

	public string Path { get; private set; }

	public float Duration { get; private set; }

	public float StartTime { get; private set; }

	public string Paramter { get; private set; }

	public bool EndBlack { get; private set; }

	public List<float> Offset { get; private set; }

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
		ShowForms = int.Parse(array[num++]);
		Path = array[num++];
		Duration = float.Parse(array[num++]);
		StartTime = float.Parse(array[num++]);
		Paramter = array[num++];
		EndBlack = bool.Parse(array[num++]);
		Offset = DataTableExtension.ParseListFloat(array[num++]);
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
			ShowForms = binaryReader.Read7BitEncodedInt32();
			Path = binaryReader.ReadString();
			Duration = binaryReader.ReadSingle();
			StartTime = binaryReader.ReadSingle();
			Paramter = binaryReader.ReadString();
			EndBlack = binaryReader.ReadBoolean();
			Offset = binaryReader.ReadListFloat();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
