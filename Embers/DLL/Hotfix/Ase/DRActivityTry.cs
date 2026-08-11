using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRActivityTry : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int ActivityTypeId { get; private set; }

	public int TryHero { get; private set; }

	public int ActivityCopyId { get; private set; }

	public int ActivityTaskId { get; private set; }

	public int RewardId { get; private set; }

	public string JumpWindow { get; private set; }

	public int JumpConfig { get; private set; }

	public int Skin { get; private set; }

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
		ActivityTypeId = int.Parse(array[num++]);
		TryHero = int.Parse(array[num++]);
		ActivityCopyId = int.Parse(array[num++]);
		ActivityTaskId = int.Parse(array[num++]);
		RewardId = int.Parse(array[num++]);
		JumpWindow = array[num++];
		JumpConfig = int.Parse(array[num++]);
		Skin = int.Parse(array[num++]);
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
			ActivityTypeId = binaryReader.Read7BitEncodedInt32();
			TryHero = binaryReader.Read7BitEncodedInt32();
			ActivityCopyId = binaryReader.Read7BitEncodedInt32();
			ActivityTaskId = binaryReader.Read7BitEncodedInt32();
			RewardId = binaryReader.Read7BitEncodedInt32();
			JumpWindow = binaryReader.ReadString();
			JumpConfig = binaryReader.Read7BitEncodedInt32();
			Skin = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
