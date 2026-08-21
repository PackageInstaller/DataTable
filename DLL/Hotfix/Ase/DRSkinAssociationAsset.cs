using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRSkinAssociationAsset : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int OriginalEffectConfigId { get; private set; }

	public int SkinAssociationEffectConfigId { get; private set; }

	public int OriginalAudioConfigId { get; private set; }

	public int SkinAssociationAudioConfigId { get; private set; }

	public int AudioID { get; private set; }

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
		OriginalEffectConfigId = int.Parse(array[num++]);
		SkinAssociationEffectConfigId = int.Parse(array[num++]);
		OriginalAudioConfigId = int.Parse(array[num++]);
		SkinAssociationAudioConfigId = int.Parse(array[num++]);
		AudioID = int.Parse(array[num++]);
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
			OriginalEffectConfigId = binaryReader.Read7BitEncodedInt32();
			SkinAssociationEffectConfigId = binaryReader.Read7BitEncodedInt32();
			OriginalAudioConfigId = binaryReader.Read7BitEncodedInt32();
			SkinAssociationAudioConfigId = binaryReader.Read7BitEncodedInt32();
			AudioID = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
