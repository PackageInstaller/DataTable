using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRSkinTheater : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int SkinId { get; private set; }

	public string TheaterIcon { get; private set; }

	public bool SexRoom { get; private set; }

	public string ResPath { get; private set; }

	public bool MultiClass { get; private set; }

	public List<int> ScaleRange { get; private set; }

	public List<int> MoveRange { get; private set; }

	public List<int> CameraInit { get; private set; }

	public List<int> BankGroupId { get; private set; }

	public int RoomMusic { get; private set; }

	public List<int> TranType { get; private set; }

	public List<string> TranAnim { get; private set; }

	public List<int> TranAudio { get; private set; }

	public List<int> TranVoice { get; private set; }

	public List<string> HeXie_Sket { get; private set; }

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
		SkinId = int.Parse(array[num++]);
		TheaterIcon = array[num++];
		SexRoom = bool.Parse(array[num++]);
		ResPath = array[num++];
		MultiClass = bool.Parse(array[num++]);
		ScaleRange = DataTableExtension.ParseListInt(array[num++]);
		MoveRange = DataTableExtension.ParseListInt(array[num++]);
		CameraInit = DataTableExtension.ParseListInt(array[num++]);
		BankGroupId = DataTableExtension.ParseListInt(array[num++]);
		RoomMusic = int.Parse(array[num++]);
		TranType = DataTableExtension.ParseListInt(array[num++]);
		TranAnim = DataTableExtension.ParseListString(array[num++]);
		TranAudio = DataTableExtension.ParseListInt(array[num++]);
		TranVoice = DataTableExtension.ParseListInt(array[num++]);
		HeXie_Sket = DataTableExtension.ParseListString(array[num++]);
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
			SkinId = binaryReader.Read7BitEncodedInt32();
			TheaterIcon = binaryReader.ReadString();
			SexRoom = binaryReader.ReadBoolean();
			ResPath = binaryReader.ReadString();
			MultiClass = binaryReader.ReadBoolean();
			ScaleRange = binaryReader.ReadListInt();
			MoveRange = binaryReader.ReadListInt();
			CameraInit = binaryReader.ReadListInt();
			BankGroupId = binaryReader.ReadListInt();
			RoomMusic = binaryReader.Read7BitEncodedInt32();
			TranType = binaryReader.ReadListInt();
			TranAnim = binaryReader.ReadListString();
			TranAudio = binaryReader.ReadListInt();
			TranVoice = binaryReader.ReadListInt();
			HeXie_Sket = binaryReader.ReadListString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
