using System;
using Bamboo.ImageCenter;
using UnityEngine;

namespace ACT.UI;

public abstract class TaskTip_Base : MonoBehaviour
{
	protected const string COMPLETE = "Complete";

	protected const string NEW = "New";

	protected const string UPDATE = "Update";

	protected const string FAIL = "Fail";

	protected const string PROCEED = "Proceed";

	protected static readonly int New = Animator.StringToHash("New");

	protected static readonly int UpdateParam = Animator.StringToHash("Update");

	protected static readonly int Complete = Animator.StringToHash("Complete");

	protected static readonly int Fail = Animator.StringToHash("Fail");

	protected static readonly int Proceed = Animator.StringToHash("Proceed");

	private TaskTipManager m_Manager;

	public TaskTipManager Manager => m_Manager;

	public void Init(TaskTipManager manager)
	{
		m_Manager = manager;
		OnInit();
	}

	public void UnInit()
	{
		try
		{
			OnUnInit();
		}
		catch (Exception message)
		{
			Debug.LogError(message);
		}
		m_Manager = null;
	}

	protected virtual void OnInit()
	{
	}

	protected virtual void OnUnInit()
	{
	}

	protected ImageAssetStation GetImageStation()
	{
		return m_Manager?.GetImageStation();
	}
}
