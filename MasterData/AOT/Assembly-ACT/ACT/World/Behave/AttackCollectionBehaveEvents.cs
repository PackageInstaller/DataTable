using System.Linq;
using ACT.Battle;
using ACT.Core;
using ACT.Sound;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using FMODUnity;
using Fundamental;
using UnityEngine;

namespace ACT.World.Behave;

[AddComponentMenu("ACT/StateObjectBehave/AttackCollectionBehaveEvents")]
public class AttackCollectionBehaveEvents : CollectionBehaveEvents
{
	public Element[] destroyElements;

	public string[] abilities;

	public Alliance alliance;

	public Vector3 size = Vector3.one;

	public Vector3 posOffset = Vector3.zero;

	public bool abilityControl;

	private float maxHp;

	private int comboStateParam;

	private string comboStateName;

	private Element lastAttackElement = Element.Born;

	[Tooltip("特效预制体")]
	public YooAssetReference effectReferenceAssetID;

	[Tooltip("音效名字")]
	public EventReference soundEvent;

	public AudioEventReference audioSoundEvent;

	public bool setMeshRenderDither;

	public MeshRenderer meshRenderer;

	public BoxCollider box;

	public GameObject damageBox;

	public float time;

	private bool m_IsStart;

	public bool fireCameraNoise;

	[Tooltip("震屏效果预制体")]
	public YooAssetReference noiseReferenceAssetID;

	[Tooltip("震屏效果类型")]
	public CameraNoiseType cameraNoiseType = CameraNoiseType.LevelTrigger;

	[Tooltip("震屏效果相对于播放点的偏移量，一般只有Y轴才有用")]
	public Vector3 velocity;

	private void Update()
	{
		if (m_IsStart)
		{
			time -= Time.deltaTime;
			meshRenderer.material.SetFloat(BattleConsts.SUB_EFFECT_SHADER_DITHER, time);
			if (time < 0f)
			{
				time = 0f;
				box.enabled = false;
				damageBox.SetActive(value: false);
				m_IsStart = false;
			}
		}
	}

	public void OnHited(int lastHP, int HP)
	{
		if (!abilityControl && lastHP != HP)
		{
			animator.SetInteger("hp", HP * 100 / (int)maxHp);
		}
	}

	public void OnCombo(int ChangeCount)
	{
		if (!(animator == null))
		{
			comboStateName = "";
			if (ChangeCount >= entry.ComboStateParam1.startComboCount && ChangeCount <= entry.ComboStateParam1.endComboCount)
			{
				comboStateParam = 5;
				comboStateName = "Hit01";
			}
			else if (ChangeCount >= entry.ComboStateParam2.startComboCount && ChangeCount <= entry.ComboStateParam2.endComboCount)
			{
				comboStateParam = 6;
				comboStateName = "Hit02";
			}
			else if (ChangeCount >= entry.ComboStateParam3.startComboCount && ChangeCount <= entry.ComboStateParam3.endComboCount)
			{
				comboStateParam = 7;
				comboStateName = "Hit03";
			}
			animator?.StopPlayback();
			animator?.SetInteger("state", comboStateParam);
			animator?.CrossFade(comboStateName, 0f, 0, 0f);
		}
	}

	public override void OnSpawnAttackable(Entity behave)
	{
		base.OnSpawnAttackable(behave);
		CompAbility compAbility = behave.GetCompAbility();
		maxHp = compAbility.maxHP;
		if (animator != null)
		{
			animator.SetInteger("hp", 100);
		}
		compAbility.AddBaseEvtListener(typeof(EvtSetActualDamage), (BaseEvt evt) =>
		{
			EvtSetActualDamage evtSetActualDamage = evt as EvtSetActualDamage;
			lastAttackElement = evtSetActualDamage.attackData.element;
			if (animator != null)
			{
				animator.SetInteger("element", (int)evtSetActualDamage.attackData.element);
			}
		});
	}

	public override void OnInteract(Entity eb)
	{
		if (destroyElements != null && destroyElements.Contains(lastAttackElement))
		{
			interactCollection.NetEnterState(2).Forget();
		}
		else
		{
			interactCollection.NetEnterState(1).Forget();
		}
	}

	public void FireEffect()
	{
		GameManager.effectSystem.FireEffect(effectReferenceAssetID, transform.position, Quaternion.identity);
	}

	public void PostWwise()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound(audioSoundEvent, new AudioPlayOptions
		{
			attachTarget = gameObject.transform
		});
	}

	public void SetMeshRenderDither()
	{
		m_IsStart = true;
	}

	public void FireCameraNoise(Entity behave)
	{
		Singleton<CameraNoiseManager>.instance.TriggerCameraNoise(cameraNoiseType, MonoECS.instance.localPlayer.battleEntity.GetModelTrans().position, noiseReferenceAssetID, velocity, 0f, 0f, changeVelocityXZ: false, overLay: true, unloadAfterPlaying: true);
	}
}
