using System;
using System.Collections;
using System.Collections.Generic;
using Nova.Hotfix;
using TMPro;
using UnityEngine;

public class MathParkourCombatEntity : MonoBehaviour
{
	private MathParkourLevelController levelController;

	[SerializeField]
	private Animator animator;

	[SerializeField]
	[Tooltip("Normal状态特效")]
	private List<GameObject> NormalFxList;

	[SerializeField]
	[Tooltip("死亡特效")]
	private List<GameObject> DefeatedFxList;

	[SerializeField]
	[Tooltip("受击时播放的粒子特效")]
	private ParticleSystem hitParticleFx;

	private float hpDecreaseRemainder;

	private Coroutine animationCoroutine;

	private bool isKillAnimationPaused;

	private float killAnimationSpeedBeforePause = 1f;

	[SerializeField]
	private Canvas worldSpaceCanvas;

	[SerializeField]
	private GameObject img_fun;

	[SerializeField]
	private Animator scoreAnimator;

	[SerializeField]
	private TextMeshProUGUI hpText;

	[SerializeField]
	private GameObject visualRoot;

	[SerializeField]
	private Collider bodyCollider;

	public long EntityId { get; private set; }

	public int ConfigId { get; private set; }

	public int InitialHp { get; private set; }

	public int Hp { get; private set; }

	public bool IsDefeated => Hp <= 0;

	public bool IsDefeatHandled { get; private set; }

	public MathParkourChunk OwnerChunk { get; private set; }

	public int LaneIndex { get; private set; }

	public int RowIndex { get; private set; }

	public void Init(long entityId, int configId, int hp, MathParkourChunk ownerChunk, int laneIndex, int rowIndex)
	{
		EntityId = entityId;
		ConfigId = configId;
		InitialHp = Mathf.Max(0, hp);
		Hp = InitialHp;
		hpDecreaseRemainder = 0f;
		IsDefeatHandled = false;
		OwnerChunk = ownerChunk;
		LaneIndex = laneIndex;
		RowIndex = rowIndex;
		levelController = ((ownerChunk != null) ? ownerChunk.GetComponentInParent<MathParkourLevelController>() : null);
		if (visualRoot != null)
		{
			visualRoot.SetActive(value: true);
		}
		SetCollidersEnabled(enabled: true);
		BindHudCamera();
		UpdateHud();
		if (NormalFxList != null && NormalFxList.Count > 0)
		{
			foreach (GameObject normalFx in NormalFxList)
			{
				normalFx.SetActive(value: true);
			}
		}
		if (DefeatedFxList != null && DefeatedFxList.Count > 0)
		{
			foreach (GameObject defeatedFx in DefeatedFxList)
			{
				defeatedFx.SetActive(value: false);
			}
		}
		ResetHitParticleFx();
	}

	public MathParkourDamageResult ApplyDamage(float amount)
	{
		if (amount <= 0f || IsDefeated)
		{
			return new MathParkourDamageResult(0, IsDefeated, isFirstDefeat: false);
		}
		hpDecreaseRemainder += amount;
		int num = Mathf.FloorToInt(hpDecreaseRemainder);
		if (num <= 0)
		{
			return new MathParkourDamageResult(0, isDefeated: false, isFirstDefeat: false);
		}
		hpDecreaseRemainder -= num;
		int actualDamage = Mathf.Min(num, Hp);
		Hp = Mathf.Max(0, Hp - num);
		UpdateHud();
		if (scoreAnimator.gameObject.activeSelf)
		{
			scoreAnimator.Play("MathParkourHP_in");
		}
		PlayAnimatorAnim("hit", null, skipIfAlreadyPlaying: true);
		PlayHitParticleFx();
		return new MathParkourDamageResult(actualDamage, IsDefeated, isFirstDefeat: false);
	}

	public void ResetHpDecreaseRemainder()
	{
		hpDecreaseRemainder = 0f;
	}

	public bool TryMarkDefeatHandled()
	{
		if (!IsDefeated || IsDefeatHandled)
		{
			return false;
		}
		IsDefeatHandled = true;
		SetCollidersEnabled(enabled: false);
		return true;
	}

	public void PlayKillAnim(Action finishCallback = null)
	{
		string text = "death";
		MathParkourObject cfg = Singleton<HotfixDataController>.Instance.GetMathParkourObject(ConfigId);
		if (cfg != null && cfg.ObjType == 2)
		{
			text = "unlock";
		}
		if (DefeatedFxList != null && DefeatedFxList.Count > 0)
		{
			foreach (GameObject defeatedFx in DefeatedFxList)
			{
				defeatedFx.SetActive(value: true);
			}
		}
		if (NormalFxList != null && NormalFxList.Count > 0)
		{
			foreach (GameObject normalFx in NormalFxList)
			{
				normalFx.SetActive(value: false);
			}
		}
		img_fun.SetActive(value: false);
		hpText.gameObject.SetActive(value: false);
		if (cfg != null && cfg.ObjType != 2)
		{
			MonoSingleton<WwiseAudioManager>.Instance.PostEvent("Mode_400018_die");
		}
		PlayAnimatorAnim(text, () =>
		{
			if (cfg != null && cfg.ObjType == 2)
			{
				MonoSingleton<WwiseAudioManager>.Instance.PostEvent("Mode_400018_pop");
				MonoSingleton<LuaManager>.Instance?.FireEvent("MathParkour_BuffItemCollected", StringParamHelper.ParseStringParamToInt(cfg.Param3));
			}
			if (visualRoot != null)
			{
				visualRoot.SetActive(value: false);
			}
			finishCallback?.Invoke();
		});
	}

	public void SetKillAnimationPaused(bool paused)
	{
		if (!(animator == null) && isKillAnimationPaused != paused)
		{
			isKillAnimationPaused = paused;
			if (paused)
			{
				killAnimationSpeedBeforePause = animator.speed;
				animator.speed = 0f;
			}
			else
			{
				animator.speed = killAnimationSpeedBeforePause;
			}
		}
	}

	public void CollectHighlightVisualRoots(List<Transform> roots)
	{
		if (roots != null)
		{
			roots.Add(transform);
			AddFxRoots(NormalFxList, roots);
			AddFxRoots(DefeatedFxList, roots);
		}
	}

	private static void AddFxRoots(List<GameObject> fxList, List<Transform> roots)
	{
		if (fxList == null)
		{
			return;
		}
		for (int i = 0; i < fxList.Count; i++)
		{
			if (fxList.get_Item(i) != null)
			{
				roots.Add(fxList.get_Item(i).transform);
			}
		}
	}

	private void SetCollidersEnabled(bool enabled)
	{
		if ((object)bodyCollider == null)
		{
			bodyCollider = GetComponentInChildren<Collider>(includeInactive: true);
		}
		if (bodyCollider != null)
		{
			bodyCollider.enabled = enabled;
		}
	}

	public void PlayHitParticleFx()
	{
		if (!(hitParticleFx == null) && !hitParticleFx.isPlaying)
		{
			hitParticleFx.Stop(withChildren: true, ParticleSystemStopBehavior.StopEmittingAndClear);
			hitParticleFx.Play(withChildren: true);
		}
	}

	private void ResetHitParticleFx()
	{
		if (hitParticleFx != null)
		{
			hitParticleFx.Stop(withChildren: true, ParticleSystemStopBehavior.StopEmittingAndClear);
		}
	}

	private void BindHudCamera()
	{
		if ((object)worldSpaceCanvas == null)
		{
			worldSpaceCanvas = GetComponentInChildren<Canvas>(includeInactive: true);
		}
		if (!(worldSpaceCanvas == null))
		{
			if (worldSpaceCanvas.renderMode != RenderMode.WorldSpace)
			{
				Debug.LogError("[MathParkour] 战斗对象的 HUD Canvas 必须使用 World Space 模式。", worldSpaceCanvas);
			}
			else
			{
				worldSpaceCanvas.worldCamera = ModuleController<MathParkourModuleController>.Instance?.hudCamera;
			}
		}
	}

	public void PlayAnimatorAnim(string name, Action finishCallback, bool skipIfAlreadyPlaying = false)
	{
		if (animator == null)
		{
			finishCallback?.Invoke();
			return;
		}
		if (string.IsNullOrEmpty(name))
		{
			finishCallback?.Invoke();
			return;
		}
		int num = Animator.StringToHash(name);
		if (!animator.HasState(0, num))
		{
			finishCallback?.Invoke();
			return;
		}
		if (skipIfAlreadyPlaying)
		{
			AnimatorStateInfo currentAnimatorStateInfo = animator.GetCurrentAnimatorStateInfo(0);
			if (currentAnimatorStateInfo.shortNameHash == num && currentAnimatorStateInfo.normalizedTime < 1f)
			{
				return;
			}
		}
		if (animationCoroutine != null)
		{
			StopCoroutine(animationCoroutine);
			animationCoroutine = null;
		}
		if (isKillAnimationPaused)
		{
			animator.speed = killAnimationSpeedBeforePause;
			isKillAnimationPaused = false;
		}
		animator.Play(num, 0, 0f);
		animator.Update(0f);
		if (finishCallback != null)
		{
			animationCoroutine = StartCoroutine(WaitForAnimatorAnimationComplete(num, finishCallback));
		}
	}

	private IEnumerator WaitForAnimatorAnimationComplete(int stateHash, Action finishCallback)
	{
		yield return null;
		while (animator != null)
		{
			AnimatorStateInfo currentAnimatorStateInfo = animator.GetCurrentAnimatorStateInfo(0);
			if (currentAnimatorStateInfo.shortNameHash != stateHash || currentAnimatorStateInfo.normalizedTime >= 1f)
			{
				break;
			}
			yield return null;
		}
		animationCoroutine = null;
		finishCallback();
	}

	private void UpdateHud()
	{
		if (Hp <= 0)
		{
			hpText.gameObject.SetActive(value: false);
		}
		string text = Hp.ToString();
		if (hpText != null)
		{
			hpText.text = text;
		}
	}
}
