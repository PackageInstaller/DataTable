using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRCallHero : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string CardName { get; private set; }

	public string NormalIcon { get; private set; }

	public string SelectedIcon { get; private set; }

	public int CardType { get; private set; }

	public int DrawTime { get; private set; }

	public int DrawPropId { get; private set; }

	public int DrawPropNum { get; private set; }

	public string StartTime { get; private set; }

	public string EndTime { get; private set; }

	public string CardDesc { get; private set; }

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
		CardName = array[num++];
		NormalIcon = array[num++];
		SelectedIcon = array[num++];
		CardType = int.Parse(array[num++]);
		DrawTime = int.Parse(array[num++]);
		DrawPropId = int.Parse(array[num++]);
		DrawPropNum = int.Parse(array[num++]);
		StartTime = array[num++];
		EndTime = array[num++];
		CardDesc = array[num++];
		num++;
		GeneratePropertyArray();
		return true;
	}

	public override bool ParseDataRow(byte[] dataRowBytes, int startIndex, int length, object userData)
	{
		using (MemoryStream input = new MemoryStream(dataRowBytes, startIndex, length, writable: false))
		{
			using BinaryReader binaryReader = new BinaryReader(input, Encoding.UTF8);
			m_Id = binaryReader.Read7BitEncodedInt32();
			CardName = binaryReader.ReadString();
			NormalIcon = binaryReader.ReadString();
			SelectedIcon = binaryReader.ReadString();
			CardType = binaryReader.Read7BitEncodedInt32();
			DrawTime = binaryReader.Read7BitEncodedInt32();
			DrawPropId = binaryReader.Read7BitEncodedInt32();
			DrawPropNum = binaryReader.Read7BitEncodedInt32();
			StartTime = binaryReader.ReadString();
			EndTime = binaryReader.ReadString();
			CardDesc = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
