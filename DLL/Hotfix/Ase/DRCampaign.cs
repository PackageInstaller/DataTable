using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRCampaign : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int NodeType { get; private set; }

	public int NodeSeat { get; private set; }

	public string NodeTip { get; private set; }

	public string TargetText { get; private set; }

	public List<int> CalcFactor { get; private set; }

	public List<int> ClacSymbol { get; private set; }

	public List<int> CalcNum { get; private set; }

	public string NodePaceText { get; private set; }

	public List<int> NodePaceFactor { get; private set; }

	public int ElitePropType { get; private set; }

	public int ElitePropID { get; private set; }

	public int ElitPropNum { get; private set; }

	public string StoryName { get; private set; }

	public List<string> StoryTabIcon { get; private set; }

	public List<int> CurStory { get; private set; }

	public string StoryIcon { get; private set; }

	public string PushText { get; private set; }

	public List<string> ResIcon { get; private set; }

	public List<int> ResProp { get; private set; }

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
		NodeType = int.Parse(array[num++]);
		NodeSeat = int.Parse(array[num++]);
		NodeTip = array[num++];
		TargetText = array[num++];
		CalcFactor = DataTableExtension.ParseListInt(array[num++]);
		ClacSymbol = DataTableExtension.ParseListInt(array[num++]);
		CalcNum = DataTableExtension.ParseListInt(array[num++]);
		NodePaceText = array[num++];
		NodePaceFactor = DataTableExtension.ParseListInt(array[num++]);
		ElitePropType = int.Parse(array[num++]);
		ElitePropID = int.Parse(array[num++]);
		ElitPropNum = int.Parse(array[num++]);
		StoryName = array[num++];
		StoryTabIcon = DataTableExtension.ParseListString(array[num++]);
		CurStory = DataTableExtension.ParseListInt(array[num++]);
		StoryIcon = array[num++];
		PushText = array[num++];
		ResIcon = DataTableExtension.ParseListString(array[num++]);
		ResProp = DataTableExtension.ParseListInt(array[num++]);
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
			NodeType = binaryReader.Read7BitEncodedInt32();
			NodeSeat = binaryReader.Read7BitEncodedInt32();
			NodeTip = binaryReader.ReadString();
			TargetText = binaryReader.ReadString();
			CalcFactor = binaryReader.ReadListInt();
			ClacSymbol = binaryReader.ReadListInt();
			CalcNum = binaryReader.ReadListInt();
			NodePaceText = binaryReader.ReadString();
			NodePaceFactor = binaryReader.ReadListInt();
			ElitePropType = binaryReader.Read7BitEncodedInt32();
			ElitePropID = binaryReader.Read7BitEncodedInt32();
			ElitPropNum = binaryReader.Read7BitEncodedInt32();
			StoryName = binaryReader.ReadString();
			StoryTabIcon = binaryReader.ReadListString();
			CurStory = binaryReader.ReadListInt();
			StoryIcon = binaryReader.ReadString();
			PushText = binaryReader.ReadString();
			ResIcon = binaryReader.ReadListString();
			ResProp = binaryReader.ReadListInt();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
