using System;
using UnityEngine;

namespace ACT.MissionSystem;

public class ClickCondition : MissionCondition
{
	public class ClickConditionHelper : MonoBehaviour
	{
		public Action OnInputA;

		public Action OnInputB;

		private void Update()
		{
			if (Input.GetKeyDown(KeyCode.A))
			{
				OnInputA?.Invoke();
			}
			if (Input.GetKeyDown(KeyCode.B))
			{
				OnInputB?.Invoke();
			}
		}
	}

	private bool m_Finished;

	private ClickConditionHelper helper;

	public override bool AllowRepeat => true;

	protected override void OnActivate()
	{
		m_Finished = false;
		helper = new GameObject("ClickConditionHelper").AddComponent<ClickConditionHelper>();
		ClickConditionHelper clickConditionHelper = helper;
		clickConditionHelper.OnInputA = (Action)Delegate.Combine(clickConditionHelper.OnInputA, new Action(OnInputA));
	}

	protected override void OnDeactivate()
	{
		m_Finished = false;
		UnityEngine.Object.Destroy(helper.gameObject);
	}

	private void OnInputA()
	{
		if (IsRepeat)
		{
			MarkSuccess();
		}
		else if (!m_Finished)
		{
			m_Finished = true;
			MarkSuccess();
		}
	}
}
