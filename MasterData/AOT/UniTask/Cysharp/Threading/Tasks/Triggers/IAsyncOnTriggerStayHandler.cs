using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnTriggerStayHandler
{
	UniTask<Collider> OnTriggerStayAsync();
}
