using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRBattlePropInfo : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int TeamId { get; private set; }

	public string Name { get; private set; }

	public BattlePropEnum BattlePropEnum { get; private set; }

	public int Quality { get; private set; }

	public string Icon { get; private set; }

	public int Lev { get; private set; }

	public int LevMax { get; private set; }

	public string Function { get; private set; }

	public int TakeLimit { get; private set; }

	public int OwnerLimit { get; private set; }

	public int CoolDown { get; private set; }

	public int AiTreeID { get; private set; }

	public int PropSkillID { get; private set; }

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
		TeamId = int.Parse(array[num++]);
		Name = array[num++];
		BattlePropEnum = DataTableExtension.ParseEnum<BattlePropEnum>(array[num++]);
		Quality = int.Parse(array[num++]);
		Icon = array[num++];
		Lev = int.Parse(array[num++]);
		LevMax = int.Parse(array[num++]);
		Function = array[num++];
		TakeLimit = int.Parse(array[num++]);
		OwnerLimit = int.Parse(array[num++]);
		CoolDown = int.Parse(array[num++]);
		AiTreeID = int.Parse(array[num++]);
		PropSkillID = int.Parse(array[num++]);
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
			TeamId = binaryReader.Read7BitEncodedInt32();
			Name = binaryReader.ReadString();
			BattlePropEnum = binaryReader.ReadEnum<BattlePropEnum>();
			Quality = binaryReader.Read7BitEncodedInt32();
			Icon = binaryReader.ReadString();
			Lev = binaryReader.Read7BitEncodedInt32();
			LevMax = binaryReader.Read7BitEncodedInt32();
			Function = binaryReader.ReadString();
			TakeLimit = binaryReader.Read7BitEncodedInt32();
			OwnerLimit = binaryReader.Read7BitEncodedInt32();
			CoolDown = binaryReader.Read7BitEncodedInt32();
			AiTreeID = binaryReader.Read7BitEncodedInt32();
			PropSkillID = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
