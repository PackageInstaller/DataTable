using GameFramework;

public class ModifyShaderParam : IReference
{
	public ShaderOperationType operation;

	public string pointName;

	public int matIndex;

	public int materialRuntimeId;

	public string variableName;

	public float value;

	public bool isEffectEnd;

	public bool useMaterialRuntimeId;

	public void Clear()
	{
		pointName = null;
		matIndex = 0;
		materialRuntimeId = 0;
		variableName = null;
		value = 0f;
		isEffectEnd = false;
		useMaterialRuntimeId = false;
	}
}
