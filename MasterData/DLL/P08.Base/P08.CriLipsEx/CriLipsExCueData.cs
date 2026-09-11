using System;

namespace P08.CriLipsEx;

[Serializable]
public class CriLipsExCueData
{
	public string m_cueName = string.Empty;

	public int m_cueLength;

	public CriLipsExFrameData[] m_criLipsExFrameDatas;
}
