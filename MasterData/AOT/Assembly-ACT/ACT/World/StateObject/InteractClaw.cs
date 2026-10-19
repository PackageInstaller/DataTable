using ACT.Battle;
using ACT.Utility;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/InteractClaw")]
public class InteractClaw : StateObjectBase
{
	public GameObject guideEffect;

	public GameObject guideLineEffect;

	public float distance;

	public ClawData.Direction faceDirect;

	public Animator animator;

	private ClawData _data;

	private bool m_isInInteract;

	private float CdTime;

	private GameObject effectCirlce;

	private GameObject cdEffect;

	private float maxInteractRange;

	private float maxRange;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		if (entity.GetCompStateObject()?.StateWorldAssetData is ClawData clawData)
		{
			_data = clawData;
			CdTime = clawData.cd;
			m_isInInteract = false;
			Singleton<GameManager>.instance.clawManager.CanFinfClaw = true;
			if (clawData.clawCollider.colliderType == typeof(BoxCollider))
			{
				BoxCollider boxCollider = gameObject.AddComponent<BoxCollider>();
				boxCollider.center = clawData.clawCollider.center;
				boxCollider.size = clawData.clawCollider.size;
				boxCollider.isTrigger = true;
				maxInteractRange = Mathf.Max(boxCollider.size.x, boxCollider.size.y, boxCollider.size.z);
			}
			else if (clawData.clawCollider.colliderType == typeof(SphereCollider))
			{
				SphereCollider sphereCollider = gameObject.AddComponent<SphereCollider>();
				sphereCollider.center = clawData.clawCollider.center;
				sphereCollider.radius = clawData.clawCollider.radius;
				sphereCollider.isTrigger = true;
				maxInteractRange = sphereCollider.radius + sphereCollider.center.magnitude;
			}
			maxInteractRange++;
			maxRange = maxInteractRange + 2f;
			base.InitStateObject(stateId);
		}
	}

	public override void ReleaseStateObject()
	{
		base.ReleaseStateObject();
		Object.Destroy(gameObject);
	}

	public void OnInteract(Entity eb)
	{
		if (eb.GetCompPhysics().TriggerHook(transform.position))
		{
			Singleton<GameManager>.instance.clawManager.CanFinfClaw = false;
			CdTime = 0f;
			animator?.SetInteger("state", 0);
		}
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
		if (currentStateId == 1)
		{
			_ = 1;
		}
	}

	protected override void HandleEnterInteract()
	{
		if (currentStateId == 1)
		{
			CheckInteract();
		}
	}

	protected override void HandleExitInteract()
	{
		_ = currentStateId;
		_ = 1;
	}

	protected override void HandleChangeState(int fromStateId, int toStateId)
	{
		animator?.SetInteger("state", toStateId);
		switch (toStateId)
		{
		case 0:
			effectCirlce?.SetActive(value: false);
			break;
		case 1:
			effectCirlce?.SetActive(value: true);
			break;
		}
	}

	private async void CheckInteract()
	{
		while (true)
		{
			if (this == null || target == null || currentStateId != 1)
			{
				InitClawState();
				break;
			}
			if (!MonoECS.instance.running)
			{
				await UniTask.DelayFrame(1);
				continue;
			}
			Vector3 colliderPosition = target.entity.GetCompTransform().colliderPosition;
			if (Physics.Linecast(colliderPosition, transform.position, BattleConsts.enviromentMask) || CdTime < _data.cd || Singleton<ProtagonistManager>.instance.IsProtagonist)
			{
				InitClawState();
				await UniTask.DelayFrame(1);
				continue;
			}
			Vector3 lhs = transform.position + _data.clawCollider.center - colliderPosition;
			distance = lhs.magnitude;
			if (maxInteractRange <= distance)
			{
				InitClawState();
				if (maxRange <= distance)
				{
					break;
				}
				await UniTask.DelayFrame(1);
				continue;
			}
			guideLineEffect.transform.localScale = new Vector3(distance / 3f, 1f, 1f);
			Vector3 right = GameUtility.mainCamera.transform.right;
			Vector3 up = GameUtility.mainCamera.transform.up;
			float num = Vector2.SignedAngle(to: new Vector2(Vector3.Dot(lhs, right), Vector3.Dot(lhs, up)), from: Vector2.up);
			bool flag = false;
			if (num < _data.rightAngle && num > _data.leftAngle)
			{
				if (!_data.needInvert)
				{
					flag = true;
				}
			}
			else if (_data.needInvert)
			{
				flag = true;
			}
			if (num <= 0f)
			{
				faceDirect = ClawData.Direction.Left;
			}
			if (num > 0f)
			{
				faceDirect = ClawData.Direction.Right;
			}
			if (flag)
			{
				guideEffect.transform.eulerAngles = new Vector3(0f, 0f, num);
			}
			if (flag && !m_isInInteract)
			{
				m_isInInteract = true;
				Singleton<GameManager>.instance.clawManager.AddInteractClaw(this);
			}
			else if (!flag && m_isInInteract)
			{
				m_isInInteract = false;
				guideEffect.SetActive(value: false);
				Singleton<GameManager>.instance.clawManager.RemoveInteractClaw(this);
			}
			await UniTask.DelayFrame(1);
		}
	}

	public void ShowGuideEffect(bool state)
	{
		guideEffect.SetActive(state);
	}

	public void InitClawState()
	{
		if (m_isInInteract)
		{
			Singleton<GameManager>.instance?.clawManager?.RemoveInteractClaw(this);
		}
		m_isInInteract = false;
		if (guideEffect != null)
		{
			guideEffect.SetActive(value: false);
		}
	}

	protected override void HandleInitState(int stateId)
	{
		animator?.SetInteger("state", stateId);
		switch (stateId)
		{
		case 0:
			effectCirlce?.SetActive(value: false);
			break;
		case 1:
			effectCirlce?.SetActive(value: true);
			break;
		}
	}

	protected override void HandleUninitState(int stateId)
	{
		base.HandleUninitState(stateId);
		if (currentStateId == 1)
		{
			InitClawState();
		}
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (-4 <= stateId)
		{
			return stateId <= 1;
		}
		return false;
	}

	private void Update()
	{
		CdTime += GameManager.timeSystem.LogicSpeed * Time.deltaTime;
		if (_data != null && currentStateId != -1 && CdTime >= _data.cd)
		{
			animator?.SetInteger("state", 1);
		}
	}
}
