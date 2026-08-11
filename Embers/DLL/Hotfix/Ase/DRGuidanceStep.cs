using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRGuidanceStep : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int GuidanceType { get; private set; }

	public bool IsCheck { get; private set; }

	public string WindowName { get; private set; }

	public string UIKey { get; private set; }

	public int ChildIndex { get; private set; }

	public bool CheckChild { get; private set; }

	public float DelayTime { get; private set; }

	public List<float> WindowSize { get; private set; }

	public List<float> WindowShifting { get; private set; }

	public int TipType { get; private set; }

	public List<float> TipPosition { get; private set; }

	public List<float> FingerShifting { get; private set; }

	public int FingerDirection { get; private set; }

	public string TipCharacterName { get; private set; }

	public string TipCharacter { get; private set; }

	public string TipText { get; private set; }

	public string VideoClip { get; private set; }

	public string VideoName { get; private set; }

	public float WaitTime { get; private set; }

	public bool Alpha { get; private set; }

	public int ManualId { get; private set; }

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
		GuidanceType = int.Parse(array[num++]);
		IsCheck = bool.Parse(array[num++]);
		WindowName = array[num++];
		UIKey = array[num++];
		ChildIndex = int.Parse(array[num++]);
		CheckChild = bool.Parse(array[num++]);
		DelayTime = float.Parse(array[num++]);
		WindowSize = DataTableExtension.ParseListFloat(array[num++]);
		WindowShifting = DataTableExtension.ParseListFloat(array[num++]);
		TipType = int.Parse(array[num++]);
		TipPosition = DataTableExtension.ParseListFloat(array[num++]);
		FingerShifting = DataTableExtension.ParseListFloat(array[num++]);
		FingerDirection = int.Parse(array[num++]);
		TipCharacterName = array[num++];
		TipCharacter = array[num++];
		TipText = array[num++];
		VideoClip = array[num++];
		VideoName = array[num++];
		WaitTime = float.Parse(array[num++]);
		Alpha = bool.Parse(array[num++]);
		ManualId = int.Parse(array[num++]);
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
			GuidanceType = binaryReader.Read7BitEncodedInt32();
			IsCheck = binaryReader.ReadBoolean();
			WindowName = binaryReader.ReadString();
			UIKey = binaryReader.ReadString();
			ChildIndex = binaryReader.Read7BitEncodedInt32();
			CheckChild = binaryReader.ReadBoolean();
			DelayTime = binaryReader.ReadSingle();
			WindowSize = binaryReader.ReadListFloat();
			WindowShifting = binaryReader.ReadListFloat();
			TipType = binaryReader.Read7BitEncodedInt32();
			TipPosition = binaryReader.ReadListFloat();
			FingerShifting = binaryReader.ReadListFloat();
			FingerDirection = binaryReader.Read7BitEncodedInt32();
			TipCharacterName = binaryReader.ReadString();
			TipCharacter = binaryReader.ReadString();
			TipText = binaryReader.ReadString();
			VideoClip = binaryReader.ReadString();
			VideoName = binaryReader.ReadString();
			WaitTime = binaryReader.ReadSingle();
			Alpha = binaryReader.ReadBoolean();
			ManualId = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
