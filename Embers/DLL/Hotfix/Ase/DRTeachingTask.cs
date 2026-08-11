using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRTeachingTask : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public List<int> ComboSkillID { get; private set; }

	public List<float> TimeOutFail { get; private set; }

	public List<float> SkillChargeTime { get; private set; }

	public float FailResetTime { get; private set; }

	public List<string> TaskText { get; private set; }

	public List<int> FailAddBuff { get; private set; }

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
		ComboSkillID = DataTableExtension.ParseListInt(array[num++]);
		TimeOutFail = DataTableExtension.ParseListFloat(array[num++]);
		SkillChargeTime = DataTableExtension.ParseListFloat(array[num++]);
		FailResetTime = float.Parse(array[num++]);
		TaskText = DataTableExtension.ParseListString(array[num++]);
		FailAddBuff = DataTableExtension.ParseListInt(array[num++]);
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
			ComboSkillID = binaryReader.ReadListInt();
			TimeOutFail = binaryReader.ReadListFloat();
			SkillChargeTime = binaryReader.ReadListFloat();
			FailResetTime = binaryReader.ReadSingle();
			TaskText = binaryReader.ReadListString();
			FailAddBuff = binaryReader.ReadListInt();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
