using GameFramework;
using GameFramework.Runtime;

namespace Ase.ECS;

public class SpineData : IReference
{
	public string animName;

	public bool loop;

	private AsyncResult asyncResult;

	public AsyncResult AsyncResult => asyncResult;

	public SpineData()
	{
		asyncResult = new AsyncResult();
	}

	public void Finish()
	{
		asyncResult?.SetResult();
	}

	public void Clear()
	{
		animName = string.Empty;
		loop = false;
	}
}
