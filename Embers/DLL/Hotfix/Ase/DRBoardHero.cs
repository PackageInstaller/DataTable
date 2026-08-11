using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRBoardHero : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int HeroId { get; private set; }

	public int StateType { get; private set; }

	public string Desc { get; private set; }

	public List<string> Animations { get; private set; }

	public List<string> ChatBubbles { get; private set; }

	public List<float> BubbleRunTime { get; private set; }

	public int AnimationType { get; private set; }

	public bool CanBreak { get; private set; }

	public List<float> Size { get; private set; }

	public List<float> Position { get; private set; }

	public float Rotation { get; private set; }

	public string ActionKey { get; private set; }

	public List<string> ActionStrings { get; private set; }

	public List<int> ActionUnlock { get; private set; }

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
		HeroId = int.Parse(array[num++]);
		StateType = int.Parse(array[num++]);
		Desc = array[num++];
		Animations = DataTableExtension.ParseListString(array[num++]);
		ChatBubbles = DataTableExtension.ParseListString(array[num++]);
		BubbleRunTime = DataTableExtension.ParseListFloat(array[num++]);
		AnimationType = int.Parse(array[num++]);
		CanBreak = bool.Parse(array[num++]);
		Size = DataTableExtension.ParseListFloat(array[num++]);
		Position = DataTableExtension.ParseListFloat(array[num++]);
		Rotation = float.Parse(array[num++]);
		ActionKey = array[num++];
		ActionStrings = DataTableExtension.ParseListString(array[num++]);
		ActionUnlock = DataTableExtension.ParseListInt(array[num++]);
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
			HeroId = binaryReader.Read7BitEncodedInt32();
			StateType = binaryReader.Read7BitEncodedInt32();
			Desc = binaryReader.ReadString();
			Animations = binaryReader.ReadListString();
			ChatBubbles = binaryReader.ReadListString();
			BubbleRunTime = binaryReader.ReadListFloat();
			AnimationType = binaryReader.Read7BitEncodedInt32();
			CanBreak = binaryReader.ReadBoolean();
			Size = binaryReader.ReadListFloat();
			Position = binaryReader.ReadListFloat();
			Rotation = binaryReader.ReadSingle();
			ActionKey = binaryReader.ReadString();
			ActionStrings = binaryReader.ReadListString();
			ActionUnlock = binaryReader.ReadListInt();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
