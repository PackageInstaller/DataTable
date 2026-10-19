using ACT.Battle;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class ShowHideWeaponSignalAction : ISignalAction
{
	public bool show = true;

	public float duration = 1f;

	public UniTask Invoke(INotificationReceiver receiver)
	{
		AniPartControl aniControl = MonoECS.instance.mainEntity.GetMono().aniControl;
		if (show)
		{
			aniControl.PlayVisible(AniPartControl.PartType.WeaponDissolve, duration, MonoECS.instance.mainEntity);
		}
		else
		{
			aniControl.PlayHidden(AniPartControl.PartType.WeaponDissolve, duration, MonoECS.instance.mainEntity);
		}
		return UniTask.CompletedTask;
	}
}
