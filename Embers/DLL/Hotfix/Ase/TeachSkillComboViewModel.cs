using System;
using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class TeachSkillComboViewModel : OptionBase
{
	private int currentIndex;

	private float currentSkillTimer;

	private float currentSkillChargeTimer;

	private List<SkillComboViewModel> allSkillCombos;

	private List<float> timeOutFail;

	private List<float> skillChargeTime;

	private List<int> failAddBuff;

	private bool skillChargeStart;

	private float skillComboTimer;

	private float failWaitTimer;

	private SkillComboState skillComboState;

	private Action comboFailAction;

	private Action comboFinishAction;

	private Action<int, bool> teachSkillEffectAction;

	private Action uiShowAction;

	private InteractionRequest skillComboFailRequest;

	private InteractionRequest skillComboStartNextRequest;

	public int CurrentIndex => currentIndex;

	public List<int> FailAddBuff => failAddBuff;

	public SkillComboState SkillComboState => skillComboState;

	public List<SkillComboViewModel> AllSkillCombos => allSkillCombos;

	public InteractionRequest SkillComboFailRequest => skillComboFailRequest;

	public InteractionRequest SkillComboStartNextRequest => skillComboStartNextRequest;

	public TeachSkillComboViewModel(DRTeachingTask teachingTask, Action failAction, Action finishAction, Action<int, bool> skillComboEffectAction, Action showAction)
	{
		teachSkillEffectAction = skillComboEffectAction;
		allSkillCombos = new List<SkillComboViewModel>();
		for (int i = 0; i < teachingTask.ComboSkillID.Count; i++)
		{
			SkillComboViewModel item = new SkillComboViewModel(teachingTask.ComboSkillID[i], teachingTask.SkillChargeTime[i], teachingTask.TaskText[i]);
			allSkillCombos.Add(item);
		}
		timeOutFail = teachingTask.TimeOutFail;
		currentIndex = 0;
		allSkillCombos[currentIndex].SelectSkill = true;
		SetTeachSkillEffect(allSkillCombos[currentIndex].SkillId, isShow: true);
		skillComboState = SkillComboState.Running;
		skillComboFailRequest = new InteractionRequest();
		skillComboStartNextRequest = new InteractionRequest();
		skillComboTimer = teachingTask.FailResetTime;
		skillChargeTime = teachingTask.SkillChargeTime;
		failAddBuff = teachingTask.FailAddBuff;
		comboFailAction = failAction;
		comboFinishAction = finishAction;
		uiShowAction = showAction;
	}

	public void ShowAction()
	{
		uiShowAction?.Invoke();
	}

	private void StartFirst()
	{
		currentSkillChargeTimer = 0f;
		currentSkillTimer = 0f;
		currentIndex = 0;
		skillChargeStart = false;
		allSkillCombos[currentIndex].SelectSkill = true;
		SetTeachSkillEffect(allSkillCombos[currentIndex].SkillId, isShow: true);
		skillComboState = SkillComboState.Running;
	}

	private void SetTeachSkillEffect(int skillId, bool isShow)
	{
		teachSkillEffectAction?.Invoke(skillId, isShow);
	}

	private void ResetSkillComboState()
	{
		for (int i = 0; i < allSkillCombos.Count; i++)
		{
			if (allSkillCombos[i].SelectSkill)
			{
				allSkillCombos[i].SelectSkill = false;
				SetTeachSkillEffect(allSkillCombos[i].SkillId, isShow: false);
			}
			allSkillCombos[i].FinishSkill = false;
			allSkillCombos[i].FailSkill = false;
			allSkillCombos[i].ChargeFillAmount = 0f;
			allSkillCombos[i].ChargeStart = false;
		}
	}

	public void SetSkillStart(List<int> CommandBindSkillGroup)
	{
		if (skillComboState == SkillComboState.Running && CommandBindSkillGroup.Contains(allSkillCombos[currentIndex].SkillId))
		{
			skillChargeStart = true;
			if (skillChargeTime[currentIndex] > 0f)
			{
				allSkillCombos[currentIndex].ChargeStart = true;
			}
		}
	}

	public void GetSkillRelease(int skillId)
	{
		if (skillComboState != SkillComboState.Running)
		{
			return;
		}
		if (skillId == allSkillCombos[currentIndex].SkillId)
		{
			if (JudeChargeTime())
			{
				TeachASkillSuccess();
			}
			else
			{
				SkillComboFail();
			}
		}
		else
		{
			SkillComboFail();
		}
	}

	public void SetSkillCanel(int skillId)
	{
		if (skillComboState == SkillComboState.Running && skillChargeTime[currentIndex] > 0f)
		{
			SkillComboFail();
		}
	}

	private bool JudeChargeTime()
	{
		if (skillChargeTime[currentIndex] <= 0f)
		{
			return true;
		}
		if (skillChargeTime[currentIndex] > 0f && currentSkillChargeTimer >= skillChargeTime[currentIndex])
		{
			return true;
		}
		return false;
	}

	public void OnTimeElapse(float delateTime)
	{
		failWaitTimer += delateTime;
		if (skillComboState == SkillComboState.FailHide)
		{
			if (failWaitTimer >= skillComboTimer - 0.1f)
			{
				skillComboFailRequest.Raise();
				skillComboState = SkillComboState.FailShow;
			}
			return;
		}
		if (skillComboState == SkillComboState.FailShow)
		{
			if (failWaitTimer >= skillComboTimer)
			{
				ResetSkillComboState();
				skillComboFailRequest.Raise();
				skillComboState = SkillComboState.FailReset;
			}
			return;
		}
		if (skillComboState == SkillComboState.FailReset)
		{
			if (failWaitTimer >= skillComboTimer + 0.1f)
			{
				StartFirst();
				skillComboState = SkillComboState.Running;
			}
			return;
		}
		if (skillComboState == SkillComboState.FinishAll)
		{
			skillComboTimer += delateTime;
			if (skillComboTimer >= 1.2f)
			{
				skillComboState = SkillComboState.Close;
			}
			return;
		}
		if (timeOutFail[currentIndex] != -1f)
		{
			currentSkillTimer += delateTime;
			if (currentSkillTimer >= timeOutFail[currentIndex])
			{
				SkillComboFail();
			}
		}
		if (skillChargeStart && skillChargeTime[currentIndex] > 0f)
		{
			currentSkillChargeTimer++;
			allSkillCombos[currentIndex].ChargeFillAmount = currentSkillChargeTimer / skillChargeTime[currentIndex];
			if (allSkillCombos[currentIndex].ChargeFillAmount >= 1f)
			{
				allSkillCombos[currentIndex].ChargeStart = false;
			}
		}
	}

	public void TeachASkillSuccess()
	{
		allSkillCombos[currentIndex].FinishSkill = true;
		allSkillCombos[currentIndex].SelectSkill = false;
		SetTeachSkillEffect(allSkillCombos[currentIndex].SkillId, isShow: false);
		if (currentIndex >= allSkillCombos.Count - 1)
		{
			skillComboState = SkillComboState.FinishAll;
			skillComboStartNextRequest.Raise();
			skillComboTimer = 0f;
			comboFinishAction?.Invoke();
		}
		else
		{
			currentIndex++;
			allSkillCombos[currentIndex].SelectSkill = true;
			SetTeachSkillEffect(allSkillCombos[currentIndex].SkillId, isShow: true);
			currentSkillTimer = 0f;
			currentSkillChargeTimer = 0f;
			skillChargeStart = false;
			skillComboStartNextRequest.Raise();
		}
	}

	private void SkillComboFail()
	{
		failWaitTimer = 0f;
		allSkillCombos[currentIndex].FailSkill = true;
		allSkillCombos[currentIndex].ChargeStart = false;
		skillComboState = SkillComboState.FailHide;
		comboFailAction?.Invoke();
	}

	public void ForceSkillComboFail()
	{
		if (skillComboState == SkillComboState.Running)
		{
			SkillComboFail();
		}
	}

	public override void Dispose()
	{
		base.Dispose();
		comboFailAction = null;
		skillComboFailRequest = null;
		skillComboStartNextRequest = null;
		if (allSkillCombos == null)
		{
			return;
		}
		foreach (SkillComboViewModel allSkillCombo in allSkillCombos)
		{
			allSkillCombo.Dispose();
		}
		allSkillCombos.Clear();
		allSkillCombos = null;
	}
}
