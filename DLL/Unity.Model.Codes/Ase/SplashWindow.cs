using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class SplashWindow : Window
{
	[SerializeField]
	private AnimationClip clip;

	protected override void OnCreate(IBundle bundle)
	{
	}

	protected override async void OnShow()
	{
		base.OnShow();
		Animator component = GetComponent<Animator>();
		if (component != null)
		{
			component.SetTrigger("enter");
		}
		await UniTask.WaitForSeconds(((Object)(object)clip != null) ? clip.length : 0f);
		await GameEntry.UI.OpenResWindow("StartForm");
		Dismiss();
	}
}
