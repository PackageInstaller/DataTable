namespace System.Runtime.Serialization;

internal class TypeLoadExceptionHolder
{
	private string m_typeName;

	internal string TypeName => m_typeName;

	internal TypeLoadExceptionHolder(string typeName)
	{
		m_typeName = typeName;
	}
}
