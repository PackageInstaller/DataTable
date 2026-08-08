using System.Collections;

public abstract class AssetBundleLoadOperation : IEnumerator
{
	public float timeout = 60f;

	protected bool m_debug_log;

	internal int m_ReferencedCount = 1;

	public object Current => null;

	public bool MoveNext()
	{
		return !IsDone();
	}

	public void Reset()
	{
	}

	public abstract bool Update();

	public abstract bool IsDone();
}
