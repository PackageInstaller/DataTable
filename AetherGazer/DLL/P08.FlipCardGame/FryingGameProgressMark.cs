using ControllerExSpace;
using UnityEngine;

public class FryingGameProgressMark : MonoBehaviour
{
	public ControllerExCollection controllerEx;

	private ControllerEx completeController;

	private ControllerEx typeController;

	public Animator animator;

	private FryingGameManager manager;

	private int markIndex;

	private bool isSuccessMark;

	private bool isDirty;

	private bool _isComplete;

	private bool needPlayCompleteAnim;

	public bool isComplete
	{
		get
		{
			return _isComplete;
		}
		private set
		{
			isDirty = isDirty || _isComplete != value;
			_isComplete = value;
		}
	}

	public void Init(FryingGameManager manager, int markIndex, bool isSuccessMark)
	{
		completeController = controllerEx.GetController("complete");
		typeController = controllerEx.GetController("type");
		base.gameObject.SetActive(value: true);
		animator.enabled = false;
		SetType(isSuccessMark);
		this.manager = manager;
		this.markIndex = markIndex;
		this.isSuccessMark = isSuccessMark;
		Reset();
	}

	public void Reset()
	{
		isComplete = false;
		isDirty = true;
		needPlayCompleteAnim = false;
		SetComplete(value: false);
	}

	public void UpdateLogic()
	{
		bool flag = (isSuccessMark ? (manager.curSuccessMarkCount > markIndex) : (manager.curFailMarkCount > markIndex));
		if (isComplete != flag)
		{
			needPlayCompleteAnim = true;
		}
		isComplete = flag;
	}

	public void UpdateRender()
	{
		if (!isDirty)
		{
			return;
		}
		isDirty = false;
		SetComplete(isComplete);
		if (needPlayCompleteAnim)
		{
			needPlayCompleteAnim = false;
			PlayCompleteAnim();
			if (isSuccessMark)
			{
				AudioManager.Instance.Play("effect", "minigame_activity_3_9", "minigame_activity_3_9_pipe_success", useStream: false);
			}
		}
	}

	public void SetComplete(bool value)
	{
		completeController.SetSelectedState(value ? "true" : "false");
	}

	private void SetType(bool isSuccess)
	{
		typeController.SetSelectedState(isSuccess ? "success" : "fail");
	}

	private void PlayCompleteAnim()
	{
		string stateName = (isSuccessMark ? "stepsTemplate" : "stepsTemplate_fail");
		animator.enabled = true;
		animator.Play(stateName, 0, 0f);
		animator.Update(0f);
	}
}
