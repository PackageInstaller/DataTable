namespace UnityEngine.Rendering.Universal;

public static class ShaderUtils
{
	public static string GetShaderPath(ShaderPathID id)
	{
		if (id == ShaderPathID.Lit)
		{
			return "ACT/toon generic";
		}
		string[] array = new string[5]
		{
			"Trying to access universal shader path out of bounds: (",
			id.ToString(),
			": ",
			null,
			null
		};
		int num = (int)id;
		array[3] = num.ToString();
		array[4] = ")";
		Debug.LogError(string.Concat(array));
		return "";
	}

	public static ShaderPathID GetEnumFromPath(string path)
	{
		if (path == "ACT/toon generic")
		{
			return ShaderPathID.Lit;
		}
		return (ShaderPathID)(-1);
	}

	public static bool IsLWShader(Shader shader)
	{
		if (shader != null)
		{
			return GetEnumFromPath(shader.name) != (ShaderPathID)(-1);
		}
		return false;
	}
}
