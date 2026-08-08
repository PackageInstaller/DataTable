using Sirenix.OdinInspector;

public abstract class DormItemSubTagBase : SerializedMonoBehaviour
{
	public string m_namespace;

	internal abstract object Value { get; }
}
