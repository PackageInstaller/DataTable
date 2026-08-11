using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRHeroPropertyConvert : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string IPropertyToProtection { get; private set; }

	public float ProtectionConvert { get; private set; }

	public string IPropertyMaxToProtection { get; private set; }

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
		IPropertyToProtection = array[num++];
		ProtectionConvert = float.Parse(array[num++]);
		IPropertyMaxToProtection = array[num++];
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
			IPropertyToProtection = binaryReader.ReadString();
			ProtectionConvert = binaryReader.ReadSingle();
			IPropertyMaxToProtection = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
