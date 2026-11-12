using TrueSync;
using UnityEngine;

public class TiliaShieldEntity : LogicEntity, ISpecialEntity
{
	protected int buffId;

	protected FP duration;

	protected FP shieldRotateSpeed;

	protected FP counterAttackCoolDown;

	protected FP counterAttackRadius;

	protected int counterAttackHitDamageId;

	private int beBroBuff;

	protected bool counterAttack;

	protected const int counterAttackTime = 3;

	protected FP counterAttackLeftCoolDown;

	protected int counterAttackLeftTime;

	protected const string shieldPath = "Assets/AssetBundles/Actor/Character/10701/Buff/fx_10701_buff_reboundshield.prefab";

	protected const string counterShieldPath = "Assets/AssetBundles/Actor/Character/10701/Buff/fx_10701_buff_reboundshield.prefab";

	protected const string aoeFxPath = "Assets/AssetBundles/Actor/Character/10701/FX/fx_10701_base_reboundshieldattack.prefab";

	protected GameObject shieldPrefab;

	protected GameObject counterShieldPrefab;

	protected GameObject aoeFxPrefab;

	protected GameObject[] fxParents;

	protected AdventureBuffFXHandler[] shieldHandler;

	protected bool isValid;

	protected FP leftTime;

	protected AdventureActor owner;

	public AdventureActor Owner => owner;

	public void Setup(AdventureActor owner)
	{
	}

	protected override void OnActive()
	{
		EnableLogicUpdate();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_ATTACK", OnReciveAttack);
	}

	public void Initialize(int buffId, FP duration, FP shieldRotateSpeed, bool counterAttack = false, FP counterAttackCoolDown = default(FP), FP counterAttackRadius = default(FP), int counterAttackHitDamageId = 0, int beBrokenBuff = 0)
	{
		this.buffId = buffId;
		this.duration = duration;
		this.shieldRotateSpeed = shieldRotateSpeed;
		this.counterAttack = counterAttack;
		this.counterAttackCoolDown = counterAttackCoolDown;
		this.counterAttackRadius = counterAttackRadius;
		this.counterAttackHitDamageId = counterAttackHitDamageId;
		beBroBuff = beBrokenBuff;
		InitData();
		PlayShieldFX();
		isValid = true;
	}

	protected void InitData()
	{
		leftTime = duration;
		counterAttackLeftTime = 3;
		counterAttackLeftCoolDown = counterAttackCoolDown;
	}

	protected void PlayShieldFX()
	{
		if (fxParents == null)
		{
			fxParents = new GameObject[3];
			for (int i = 0; i < fxParents.Length; i++)
			{
				GameObject gameObject = new GameObject($"FxParent_{i}");
				gameObject.transform.SetParent(transform);
				fxParents[i] = gameObject;
			}
		}
		if (shieldHandler == null)
		{
			shieldHandler = new AdventureBuffFXHandler[3];
		}
		if (counterAttack)
		{
			if (counterShieldPrefab == null)
			{
				counterShieldPrefab = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.FX, "Assets/AssetBundles/Actor/Character/10701/Buff/fx_10701_buff_reboundshield.prefab", typeof(GameObject)) as GameObject;
			}
			for (int j = 0; j < fxParents.Length; j++)
			{
				AdventureBuffFXHandler[] array = shieldHandler;
				int num = j;
				GameObject fxPrefab = counterShieldPrefab;
				GameObject obj = fxParents[j];
				AdventureActor targetActor = owner;
				array[num] = AdventureBuffFXHandler.PlayFX(fxPrefab, obj, AdventureBuffFXHandler.FXPlayMode.Default, default, default, 1f, targetActor);
			}
		}
		else
		{
			if (shieldPrefab == null)
			{
				shieldPrefab = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.FX, "Assets/AssetBundles/Actor/Character/10701/Buff/fx_10701_buff_reboundshield.prefab", typeof(GameObject)) as GameObject;
			}
			for (int k = 0; k < fxParents.Length; k++)
			{
				AdventureBuffFXHandler[] array2 = shieldHandler;
				int num2 = k;
				GameObject fxPrefab2 = shieldPrefab;
				GameObject obj2 = fxParents[k];
				AdventureActor targetActor = owner;
				array2[num2] = AdventureBuffFXHandler.PlayFX(fxPrefab2, obj2, AdventureBuffFXHandler.FXPlayMode.Default, default, default, 1f, targetActor);
			}
		}
	}

	protected void RotateShield(FP rotate)
	{
		FP fP = 360f / new FP(fxParents.Length);
		for (int i = 0; i < fxParents.Length; i++)
		{
			Transform transform = fxParents[i].transform;
			if (transform != null)
			{
				FP t = fP * i + rotate;
				t = TSMath.Repeat(t, 360f);
				transform.rotation = Quaternion.Euler(0f, 0f - (float)t, 0f);
			}
		}
	}

	protected override void OnLogicUpdate()
	{
		if (isValid || !(leftTime <= -1))
		{
			leftTime -= LogicDeltaTime;
			if (leftTime > 0 && isValid && owner != SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor)
			{
				owner?.buffComponent?.RemoveBuffByBuffId(buffId);
				owner = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as AdventureActor;
				owner?.buffComponent?.AddBuff(buffId, owner);
			}
			FP rotate = 120 + LogicTime * shieldRotateSpeed;
			RotateShield(rotate);
			if (counterAttackLeftCoolDown > 0)
			{
				counterAttackLeftCoolDown -= LogicDeltaTime;
			}
			if (leftTime < 0 && isValid)
			{
				Finish();
			}
			if (counterAttackLeftTime == 0 && isValid)
			{
				shieldHandler = null;
				Finish();
			}
		}
	}

	protected override void OnVisualUpdate()
	{
		AdventureActor adventureActor = owner;
		if (adventureActor == null)
		{
			adventureActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as AdventureActor;
		}
		if (!(adventureActor == null))
		{
			Vector3 position = adventureActor.transform.position;
			position.y = transform.position.y;
			transform.position = position;
		}
	}

	protected void OnReciveAttack(IEvent evt)
	{
		if (isValid && counterAttackLeftTime > 0 && evt is AdventureActorReceiveAttackEvent adventureActorReceiveAttackEvent && adventureActorReceiveAttackEvent.to == owner)
		{
			counterAttackLeftTime--;
			int num = 3 - counterAttackLeftTime - 1;
			if (shieldHandler[num] != null)
			{
				shieldHandler[num].StopFX();
				shieldHandler[num] = null;
			}
			if (counterAttackLeftTime >= 0 && beBroBuff > 0)
			{
				Singleton<BuffManager>.Instance?.AddBufftoGroup(beBroBuff, owner);
			}
		}
	}

	protected void StopShieldFX()
	{
		if (shieldHandler != null)
		{
			for (int i = 0; i < shieldHandler.Length; i++)
			{
				shieldHandler[i]?.StopFX();
				shieldHandler[i] = null;
			}
		}
	}

	public void Finish()
	{
		isValid = false;
		StopShieldFX();
		owner?.buffComponent?.RemoveBuffByBuffId(buffId);
		owner = null;
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_ATTACK", OnReciveAttack);
		DisableLogicUpdate();
	}
}
