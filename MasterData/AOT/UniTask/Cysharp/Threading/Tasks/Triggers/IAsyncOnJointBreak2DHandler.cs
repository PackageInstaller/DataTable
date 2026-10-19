using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnJointBreak2DHandler
{
	UniTask<Joint2D> OnJointBreak2DAsync();
}
