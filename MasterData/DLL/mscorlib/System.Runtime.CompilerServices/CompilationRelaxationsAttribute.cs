using System.Runtime.InteropServices;

namespace System.Runtime.CompilerServices;

[Serializable]
[ComVisible(true)]
[AttributeUsage(AttributeTargets.Assembly | AttributeTargets.Module | AttributeTargets.Class | AttributeTargets.Method)]
public class CompilationRelaxationsAttribute : Attribute
{
	private int m_relaxations;

	public int CompilationRelaxations => m_relaxations;

	public CompilationRelaxationsAttribute(int relaxations)
	{
		m_relaxations = relaxations;
	}

	public CompilationRelaxationsAttribute(CompilationRelaxations relaxations)
	{
		m_relaxations = (int)relaxations;
	}
}
