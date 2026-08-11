using System;

namespace UnityEngine.Rendering;

[Serializable]
public class SerializableEnum
{
	[SerializeField]
	private string m_EnumValueAsString;

	[SerializeField]
	private Type m_EnumType;

	public Enum value
	{
		get
		{
			if (Enum.TryParse(m_EnumType, m_EnumValueAsString, out var result))
			{
				return (Enum)result;
			}
			return null;
		}
		set
		{
			m_EnumValueAsString = value.ToString();
		}
	}

	public SerializableEnum(Type enumType)
	{
		m_EnumType = enumType;
		m_EnumValueAsString = Enum.GetNames(enumType)[0];
	}
}
