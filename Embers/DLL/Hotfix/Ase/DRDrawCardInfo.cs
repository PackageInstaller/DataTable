using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRDrawCardInfo : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string CardName { get; private set; }

	public string NormalIcon { get; private set; }

	public string SelectedIcon { get; private set; }

	public int CardType { get; private set; }

	public string CardTag { get; private set; }

	public string TagColor { get; private set; }

	public bool IsSingle { get; private set; }

	public int DrawTime { get; private set; }

	public int Sale { get; private set; }

	public int SaleTime { get; private set; }

	public int DrawPropId { get; private set; }

	public int DrawPropNum { get; private set; }

	public int DropType { get; private set; }

	public string UpDesc { get; private set; }

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
		CardTag = array[num++];
		TagColor = array[num++];
		IsSingle = bool.Parse(array[num++]);
		DrawTime = int.Parse(array[num++]);
		Sale = int.Parse(array[num++]);
		SaleTime = int.Parse(array[num++]);
		DrawPropId = int.Parse(array[num++]);
		DrawPropNum = int.Parse(array[num++]);
		DropType = int.Parse(array[num++]);
		UpDesc = array[num++];
		StartTime = array[num++];
		EndTime = array[num++];
		CardDesc = array[num++];
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
			CardName = binaryReader.ReadString();
			NormalIcon = binaryReader.ReadString();
			SelectedIcon = binaryReader.ReadString();
			CardType = binaryReader.Read7BitEncodedInt32();
			CardTag = binaryReader.ReadString();
			TagColor = binaryReader.ReadString();
			IsSingle = binaryReader.ReadBoolean();
			DrawTime = binaryReader.Read7BitEncodedInt32();
			Sale = binaryReader.Read7BitEncodedInt32();
			SaleTime = binaryReader.Read7BitEncodedInt32();
			DrawPropId = binaryReader.Read7BitEncodedInt32();
			DrawPropNum = binaryReader.Read7BitEncodedInt32();
			DropType = binaryReader.Read7BitEncodedInt32();
			UpDesc = binaryReader.ReadString();
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
