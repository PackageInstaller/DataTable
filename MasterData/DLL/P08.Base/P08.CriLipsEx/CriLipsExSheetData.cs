using System;
using System.IO;
using System.Text;

namespace P08.CriLipsEx;

[Serializable]
public class CriLipsExSheetData
{
	public CriLipsExCueData[] m_criLipsExCueDatas;

	public CriLipsExSheetData()
	{
	}

	public CriLipsExSheetData(byte[] bytes)
	{
		Deserialize(bytes);
	}

	public void Serialize(FileStream fs)
	{
		using BinaryWriter binaryWriter = new BinaryWriter(fs);
		binaryWriter.Write(BitConverter.GetBytes(m_criLipsExCueDatas.Length));
		CriLipsExCueData[] criLipsExCueDatas = m_criLipsExCueDatas;
		foreach (CriLipsExCueData criLipsExCueData in criLipsExCueDatas)
		{
			byte[] bytes = Encoding.Default.GetBytes(criLipsExCueData.m_cueName);
			binaryWriter.Write(BitConverter.GetBytes(bytes.Length));
			binaryWriter.Write(bytes);
			binaryWriter.Write(BitConverter.GetBytes(criLipsExCueData.m_cueLength));
			binaryWriter.Write(BitConverter.GetBytes(criLipsExCueData.m_criLipsExFrameDatas.Length));
			CriLipsExFrameData[] criLipsExFrameDatas = criLipsExCueData.m_criLipsExFrameDatas;
			for (int j = 0; j < criLipsExFrameDatas.Length; j++)
			{
				CriLipsExFrameData criLipsExFrameData = criLipsExFrameDatas[j];
				binaryWriter.Write(BitConverter.GetBytes(criLipsExFrameData.m_frameIndex));
				binaryWriter.Write(BitConverter.GetBytes(criLipsExFrameData.m_a));
				binaryWriter.Write(BitConverter.GetBytes(criLipsExFrameData.m_i));
				binaryWriter.Write(BitConverter.GetBytes(criLipsExFrameData.m_u));
				binaryWriter.Write(BitConverter.GetBytes(criLipsExFrameData.m_e));
				binaryWriter.Write(BitConverter.GetBytes(criLipsExFrameData.m_o));
			}
		}
	}

	public void Deserialize(byte[] bytes)
	{
		int num = 0;
		int num2 = BitConverter.ToInt32(bytes, num);
		num += 4;
		m_criLipsExCueDatas = new CriLipsExCueData[num2];
		for (int i = 0; i < num2; i++)
		{
			CriLipsExCueData criLipsExCueData = new CriLipsExCueData();
			int num3 = BitConverter.ToInt32(bytes, num);
			num += 4;
			criLipsExCueData.m_cueName = Encoding.Default.GetString(bytes, num, num3);
			num += num3;
			criLipsExCueData.m_cueLength = BitConverter.ToInt32(bytes, num);
			num += 4;
			int num4 = BitConverter.ToInt32(bytes, num);
			num += 4;
			criLipsExCueData.m_criLipsExFrameDatas = new CriLipsExFrameData[num4];
			for (int j = 0; j < num4; j++)
			{
				CriLipsExFrameData criLipsExFrameData = new CriLipsExFrameData
				{
					m_frameIndex = BitConverter.ToUInt16(bytes, num)
				};
				num += 2;
				criLipsExFrameData.m_a = BitConverter.ToUInt16(bytes, num);
				num += 2;
				criLipsExFrameData.m_i = BitConverter.ToUInt16(bytes, num);
				num += 2;
				criLipsExFrameData.m_u = BitConverter.ToUInt16(bytes, num);
				num += 2;
				criLipsExFrameData.m_e = BitConverter.ToUInt16(bytes, num);
				num += 2;
				criLipsExFrameData.m_o = BitConverter.ToUInt16(bytes, num);
				num += 2;
				criLipsExCueData.m_criLipsExFrameDatas[j] = criLipsExFrameData;
			}
			m_criLipsExCueDatas[i] = criLipsExCueData;
		}
	}
}
