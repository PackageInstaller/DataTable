using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRHitBox : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Name { get; private set; }

	public int Count { get; private set; }

	public List<string> Keys { get; private set; }

	public List<int> KeysEffect { get; private set; }

	public List<List<string>> KeysGroups { get; private set; }

	public List<List<float>> DamageInjury { get; private set; }

	public List<float> Progressivecoefficient { get; private set; }

	public List<PrimitiveEnum> PrimitiveEnum { get; private set; }

	public List<List<float>> PrimitiveParams { get; private set; }

	public List<List<float>> CenterOffset { get; private set; }

	public List<List<float>> RotateOffset { get; private set; }

	public List<int> HitBoxLevel { get; private set; }

	public List<float> DamageRatio { get; private set; }

	public List<float> AffectTenacityRatio { get; private set; }

	public List<int> Weight { get; private set; }

	public List<float> NormalTough { get; private set; }

	public List<List<float>> DamageCumulativeThreshold { get; private set; }

	public List<List<float>> HitAngle { get; private set; }

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
		Name = array[num++];
		Count = int.Parse(array[num++]);
		Keys = DataTableExtension.ParseListString(array[num++]);
		KeysEffect = DataTableExtension.ParseListInt(array[num++]);
		KeysGroups = DataTableExtension.ParseListStringList(array[num++]);
		DamageInjury = DataTableExtension.ParseListFloatList(array[num++]);
		Progressivecoefficient = DataTableExtension.ParseListFloat(array[num++]);
		PrimitiveEnum = DataTableExtension.ParseListEnum<PrimitiveEnum>(array[num++]);
		PrimitiveParams = DataTableExtension.ParseListFloatList(array[num++]);
		CenterOffset = DataTableExtension.ParseListFloatList(array[num++]);
		RotateOffset = DataTableExtension.ParseListFloatList(array[num++]);
		HitBoxLevel = DataTableExtension.ParseListInt(array[num++]);
		DamageRatio = DataTableExtension.ParseListFloat(array[num++]);
		AffectTenacityRatio = DataTableExtension.ParseListFloat(array[num++]);
		Weight = DataTableExtension.ParseListInt(array[num++]);
		NormalTough = DataTableExtension.ParseListFloat(array[num++]);
		DamageCumulativeThreshold = DataTableExtension.ParseListFloatList(array[num++]);
		HitAngle = DataTableExtension.ParseListFloatList(array[num++]);
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
			Name = binaryReader.ReadString();
			Count = binaryReader.Read7BitEncodedInt32();
			Keys = binaryReader.ReadListString();
			KeysEffect = binaryReader.ReadListInt();
			KeysGroups = binaryReader.ReadListStringList();
			DamageInjury = binaryReader.ReadListFloatList();
			Progressivecoefficient = binaryReader.ReadListFloat();
			PrimitiveEnum = binaryReader.ReadListEnum<PrimitiveEnum>();
			PrimitiveParams = binaryReader.ReadListFloatList();
			CenterOffset = binaryReader.ReadListFloatList();
			RotateOffset = binaryReader.ReadListFloatList();
			HitBoxLevel = binaryReader.ReadListInt();
			DamageRatio = binaryReader.ReadListFloat();
			AffectTenacityRatio = binaryReader.ReadListFloat();
			Weight = binaryReader.ReadListInt();
			NormalTough = binaryReader.ReadListFloat();
			DamageCumulativeThreshold = binaryReader.ReadListFloatList();
			HitAngle = binaryReader.ReadListFloatList();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
