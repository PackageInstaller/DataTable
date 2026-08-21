using System;
using UnityEngine.Scripting.APIUpdating;

namespace UnityEngine.Rendering;

[MovedFrom("Utilities")]
public static class MaterialQualityUtilities
{
	public static string[] KeywordNames = new string[3] { "MATERIAL_QUALITY_LOW", "MATERIAL_QUALITY_MEDIUM", "MATERIAL_QUALITY_HIGH" };

	public static string[] EnumNames = Enum.GetNames(typeof(MaterialQuality));

	public static ShaderKeyword[] Keywords = new ShaderKeyword[3]
	{
		new ShaderKeyword(KeywordNames[0]),
		new ShaderKeyword(KeywordNames[1]),
		new ShaderKeyword(KeywordNames[2])
	};

	public static MaterialQuality GetHighestQuality(this MaterialQuality levels)
	{
		for (int num = Keywords.Length - 1; num >= 0; num--)
		{
			MaterialQuality materialQuality = (MaterialQuality)(1 << num);
			if ((levels & materialQuality) != 0)
			{
				return materialQuality;
			}
		}
		return (MaterialQuality)0;
	}

	public static MaterialQuality GetClosestQuality(this MaterialQuality availableLevels, MaterialQuality requestedLevel)
	{
		if (availableLevels == (MaterialQuality)0)
		{
			return MaterialQuality.Low;
		}
		int num = requestedLevel.ToFirstIndex();
		MaterialQuality materialQuality = (MaterialQuality)0;
		for (int num2 = num; num2 >= 0; num2--)
		{
			MaterialQuality materialQuality2 = FromIndex(num2);
			if ((materialQuality2 & availableLevels) != 0)
			{
				materialQuality = materialQuality2;
				break;
			}
		}
		if (materialQuality != 0)
		{
			return materialQuality;
		}
		for (int i = num + 1; i < Keywords.Length; i++)
		{
			MaterialQuality materialQuality3 = FromIndex(i);
			Math.Abs(requestedLevel - materialQuality3);
			if ((materialQuality3 & availableLevels) != 0)
			{
				materialQuality = materialQuality3;
				break;
			}
		}
		return materialQuality;
	}

	public static void SetGlobalShaderKeywords(this MaterialQuality level)
	{
		for (int i = 0; i < KeywordNames.Length; i++)
		{
			if (((uint)level & (uint)(1 << i)) != 0)
			{
				Shader.EnableKeyword(KeywordNames[i]);
			}
			else
			{
				Shader.DisableKeyword(KeywordNames[i]);
			}
		}
	}

	public static void SetGlobalShaderKeywords(this MaterialQuality level, CommandBuffer cmd)
	{
		for (int i = 0; i < KeywordNames.Length; i++)
		{
			if (((uint)level & (uint)(1 << i)) != 0)
			{
				cmd.EnableShaderKeyword(KeywordNames[i]);
			}
			else
			{
				cmd.DisableShaderKeyword(KeywordNames[i]);
			}
		}
	}

	public static int ToFirstIndex(this MaterialQuality level)
	{
		for (int i = 0; i < KeywordNames.Length; i++)
		{
			if (((uint)level & (uint)(1 << i)) != 0)
			{
				return i;
			}
		}
		return -1;
	}

	public static MaterialQuality FromIndex(int index)
	{
		return (MaterialQuality)(1 << index);
	}
}
