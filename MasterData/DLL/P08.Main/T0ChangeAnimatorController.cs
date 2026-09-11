using UnityEngine;

public class T0ChangeAnimatorController : MonoBehaviour
{
	public Animator animator;

	private const int BASE_LAYER = 0;

	private string lastControllerPath = "UICharTimeline/108502ui_light/uiCtrl_108502_test1";

	public string defaulControllerPath = "UICharTimeline/108502ui_light/uiCtrl_108502_Cull";

	public RuntimeAnimatorController LoadAnimatorController(string path)
	{
		return Asset.Load<RuntimeAnimatorController>(path);
	}

	public void UnloadAnimatorController(string path)
	{
		Asset.Unload(path);
		Resources.UnloadUnusedAssets();
	}

	public void ChangeAnimatorController(RuntimeAnimatorController controller)
	{
		if (animator.IsInTransition(0))
		{
			AnimatorStateInfo currentAnimatorStateInfo = animator.GetCurrentAnimatorStateInfo(0);
			AnimatorStateInfo nextAnimatorStateInfo = animator.GetNextAnimatorStateInfo(0);
			AnimatorTransitionInfo animatorTransitionInfo = animator.GetAnimatorTransitionInfo(0);
			animator.runtimeAnimatorController = controller;
			animator.Play(currentAnimatorStateInfo.fullPathHash, 0, currentAnimatorStateInfo.normalizedTime);
			animator.CrossFade(nextAnimatorStateInfo.fullPathHash, animatorTransitionInfo.duration, 0, nextAnimatorStateInfo.normalizedTime, animatorTransitionInfo.normalizedTime);
		}
		else
		{
			AnimatorStateInfo currentAnimatorStateInfo2 = animator.GetCurrentAnimatorStateInfo(0);
			animator.runtimeAnimatorController = controller;
			animator.Play(currentAnimatorStateInfo2.fullPathHash, 0, currentAnimatorStateInfo2.normalizedTime);
		}
		animator.Update(0f);
	}

	public void ChangeAnimatorController(string path = "UICharTimeline/108502ui_light/uiCtrl_108502_test2")
	{
		if (!(path == lastControllerPath))
		{
			RuntimeAnimatorController controller = LoadAnimatorController(path);
			ChangeAnimatorController(controller);
			UnloadAnimatorController(lastControllerPath);
			lastControllerPath = path;
		}
	}

	public void ChangeToDefaultController()
	{
		ChangeAnimatorController(defaulControllerPath);
	}

	public void UnLoadCurrentController()
	{
		UnloadAnimatorController(lastControllerPath);
		lastControllerPath = string.Empty;
		animator.runtimeAnimatorController = null;
	}
}
