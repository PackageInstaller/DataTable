using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.UI;

public abstract class FrameworkComponent : MonoBehaviour
{
	public bool enable { get; protected set; }

	public abstract UniTask Enable(FrameworkComponentData data = null);

	public abstract UniTask EnableImmediate(FrameworkBlackLoadData data = null);

	public abstract UniTask Disable(FrameworkComponentData data = null);

	public abstract UniTask DisableImmediate(FrameworkBlackLoadData data = null);
}
