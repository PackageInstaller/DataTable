using System.Collections.Generic;
using ACT.Battle;
using ACT.Utility;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.World.StateObject;

public class InteractRotater : StateObjectBase
{
	private static readonly int State = Animator.StringToHash("state");

	public Transform transformTarget;

	public float rotateDuration = 1f;

	public InteractEntry entry;

	private bool m_isInInteract;

	private bool m_isRotating;

	private float timer;

	private Vector3 rotateTo;

	private List<Vector3> rotations;

	private SystemTime systemTime;

	[SerializeField]
	private Animator _animator;

	[SerializeField]
	private int _systemId;

	public override bool serviceSave { get; }

	private int nextState => (currentStateId + 1) % rotations.Count;

	public override void InitStateObject(int stateId)
	{
		CompStateObject compStateObject = entity.GetCompStateObject();
		if (compStateObject?.StateWorldAssetData is RotateCompData rotateCompData)
		{
			systemTime = GameManager.timeSystem;
			rotations = rotateCompData.rotations;
			m_isInInteract = false;
			m_isRotating = false;
			entry.BindInteractObjectBase(this);
			entry.BindData(compStateObject.StateWorldAssetData);
			entry.InteractActionList.BindInteractObject(this);
			if (transformTarget == null)
			{
				transformTarget = transform;
			}
			transformTarget.localRotation = Quaternion.Euler(rotateCompData.initRotation);
			if (stateId >= 0 && stateId < rotations.Count)
			{
				transformTarget.localRotation = Quaternion.Euler(rotations[stateId]);
			}
			base.InitStateObject(stateId);
		}
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		return stateId < rotations.Count;
	}

	protected override void HandleEnterInteract()
	{
		if (currentStateId != -1 && !m_isRotating)
		{
			entry.HandleEnter();
		}
	}

	protected override void HandleExitInteract()
	{
		if (currentStateId != -1)
		{
			entry.HandleExit();
		}
	}

	protected override void HandleInitState(int stateId)
	{
		if (_animator != null)
		{
			_animator.SetInteger(State, stateId);
		}
		if (stateId == -1)
		{
			return;
		}
		entry.BindInteractState(stateId, 0);
		entry.HandleInit();
		if (stateId != -2)
		{
			if (m_isRotating)
			{
				timer = 0f;
			}
			rotateTo = rotations[stateId];
			base.HandleInitState(stateId);
		}
	}

	protected override void HandleUninitState(int stateId)
	{
		base.HandleUninitState(stateId);
		entry.HandleUninit();
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
		if (currentStateId == -2)
		{
			if (Singleton<SystemUnlockManager>.instance.IsUnlock(_systemId))
			{
				NetEnterState(0).Forget();
			}
			else
			{
				GameUtility.OpenToolTip(LocalizationCommonData.CommonString.MissingRequireItem);
			}
		}
		else
		{
			RotateToTarget();
			NetEnterState(nextState).Forget();
		}
		entry.HandleInteract(eb, InteractAction.InteractSource.Player);
	}

	public override Transform OverrideSyncTransform(Transform inputValue)
	{
		return transformTarget;
	}

	private async void RotateToTarget()
	{
		Quaternion euler = Quaternion.Euler(rotateTo);
		timer = 0f;
		m_isRotating = true;
		entry.HandleExit();
		while (timer < rotateDuration)
		{
			transformTarget.localRotation = Quaternion.Slerp(transformTarget.localRotation, euler, timer / rotateDuration);
			euler = Quaternion.Euler(rotateTo);
			float num = systemTime.globalSpeed * Time.deltaTime;
			timer += num;
			await UniTask.Yield();
		}
		transformTarget.localRotation = euler;
		m_isRotating = false;
		if (IsStay)
		{
			entry.HandleEnter();
		}
	}

	public override bool CanInteract()
	{
		InteractEntry interactEntry = GetInteractEntry();
		if (interactEntry == null)
		{
			return false;
		}
		if (!m_isRotating && base.CanInteract())
		{
			return interactEntry.ShowType != ShowType.Hide;
		}
		return false;
	}

	protected override InteractEntry GetInteractEntry()
	{
		return entry;
	}

	public override ShowType GetInteractBtnShowType()
	{
		if (currentStateId == -2)
		{
			InteractEntry interactEntry = GetInteractEntry();
			if (interactEntry == null)
			{
				return ShowType.Hide;
			}
			if (!interactEntry.ConditionPassed)
			{
				return interactEntry.ConditionFailShowType;
			}
			return ShowType.Show;
		}
		if (currentStateId == -1)
		{
			return ShowType.Hide;
		}
		return ShowType.Show;
	}

	public override bool ShowInteractTip()
	{
		if (!m_isRotating && currentStateId != -1)
		{
			return GetInteractBtnShowType() == ShowType.Show;
		}
		return false;
	}

	protected override bool NeedInteractTip()
	{
		InteractEntry interactEntry = GetInteractEntry();
		if (interactEntry == null || interactEntry.TipIcon == -1)
		{
			return base.NeedInteractTip();
		}
		return true;
	}
}
