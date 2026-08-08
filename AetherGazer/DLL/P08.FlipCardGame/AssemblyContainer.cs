using UnityEngine;

public class AssemblyContainer : MonoBehaviour
{
	private int progress;

	private int maxProgress;

	private int num;

	private int Maxnum;

	private bool isFinish;

	public AssemblyStep Drag;

	private bool isCover;

	[SerializeField]
	public Animator animator;

	private void Start()
	{
		num = 0;
		Drag.init();
	}

	private void Update()
	{
		progress = Drag.getProgress();
		maxProgress = Drag.getMaxProgress();
		nextDrag();
		doFinish();
	}

	private void nextDrag()
	{
		if (isFinish)
		{
			return;
		}
		AnimatorStateInfo currentAnimatorStateInfo = animator.GetCurrentAnimatorStateInfo(0);
		if (currentAnimatorStateInfo.IsName("sushi") && currentAnimatorStateInfo.normalizedTime >= 1f)
		{
			Drag.setState(newisover: true);
		}
		if (Drag.getState())
		{
			if (progress >= maxProgress && currentAnimatorStateInfo.IsName("sushi") && currentAnimatorStateInfo.normalizedTime >= 3f)
			{
				isFinish = true;
			}
			else if (currentAnimatorStateInfo.normalizedTime >= 1f && currentAnimatorStateInfo.IsName("drop01"))
			{
				Drag.setProgress(progress + 1);
				Drag.init();
			}
		}
	}

	private void doFinish()
	{
		if (isFinish)
		{
			Drag.finish();
			isCover = true;
		}
	}

	public bool GetIsCover()
	{
		return isCover;
	}

	public int GetProcess()
	{
		return progress;
	}

	public int GetMaxProcess()
	{
		return maxProgress;
	}
}
