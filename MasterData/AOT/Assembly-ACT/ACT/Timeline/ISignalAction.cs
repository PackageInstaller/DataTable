using Cysharp.Threading.Tasks;
using UnityEngine.Playables;

namespace ACT.Timeline;

public interface ISignalAction
{
	UniTask Invoke(INotificationReceiver receiver);
}
