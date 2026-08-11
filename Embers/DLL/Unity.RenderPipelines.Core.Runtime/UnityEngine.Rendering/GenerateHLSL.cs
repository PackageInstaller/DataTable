using System;
using System.Runtime.CompilerServices;

namespace UnityEngine.Rendering;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Enum)]
public class GenerateHLSL : Attribute
{
	public PackingRules packingRules;

	public bool containsPackedFields;

	public bool needAccessors;

	public bool needSetters;

	public bool needParamDebug;

	public int paramDefinesStart;

	public bool omitStructDeclaration;

	public bool generateCBuffer;

	public int constantRegister;

	public string sourcePath;

	public GenerateHLSL(PackingRules rules = PackingRules.Exact, bool needAccessors = true, bool needSetters = false, bool needParamDebug = false, int paramDefinesStart = 1, bool omitStructDeclaration = false, bool containsPackedFields = false, bool generateCBuffer = false, int constantRegister = -1, [CallerFilePath] string sourcePath = null)
	{
		this.sourcePath = sourcePath;
		packingRules = rules;
		this.needAccessors = needAccessors;
		this.needSetters = needSetters;
		this.needParamDebug = needParamDebug;
		this.paramDefinesStart = paramDefinesStart;
		this.omitStructDeclaration = omitStructDeclaration;
		this.containsPackedFields = containsPackedFields;
		this.generateCBuffer = generateCBuffer;
		this.constantRegister = constantRegister;
	}
}
