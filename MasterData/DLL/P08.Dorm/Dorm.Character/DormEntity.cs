using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using Dorm.Character.Animation;
using UnityEngine;

namespace Dorm.Character;

[Serializable]
public class DormEntity
{
	public class AnimationEventReciver : MonoBehaviour
	{
		internal DormEntity entity;

		internal bool playedOnce;

		public int entityID => entity.id;

		public void Notify(string @event)
		{
			if (@event == "start")
			{
				playedOnce = false;
			}
			DormEntityAction.Notify("ON_DORM_ENTITY_ANIME_EVENT", entityID, @event, entity.CurPlaying);
		}

		private void LateUpdate()
		{
			float curAnimePlayNormalizedTime = GetCurAnimePlayNormalizedTime(entity.animator);
			if (!playedOnce && curAnimePlayNormalizedTime >= 1f)
			{
				playedOnce = true;
				Notify("end_play_once");
			}
		}
	}

	public enum DormEntityAnime
	{
		Stand,
		Move,
		Idle
	}

	private class LinkToHost : MonoBehaviour
	{
		public Transform host;

		public Vector3 offset = Vector3.zero;

		public Vector3 scale = Vector3.one;

		public Quaternion rotation = Quaternion.identity;

		private void LateUpdate()
		{
			UpdatePos();
		}

		public void UpdatePos()
		{
			if ((bool)host)
			{
				Matrix4x4 matrix4x = Matrix4x4.TRS(offset, rotation, scale);
				Matrix4x4 matrix4x2 = host.localToWorldMatrix * matrix4x;
				base.transform.position = matrix4x2.MultiplyPoint3x4(Vector3.zero);
				base.transform.rotation = Quaternion.LookRotation(matrix4x2.MultiplyVector(Vector3.forward), matrix4x2.MultiplyVector(Vector3.up));
				base.transform.localScale = Vector3.Scale(scale, host.localScale);
			}
		}
	}

	public const string ATTACH_POINT_PREFIX = "gua_";

	public const string ROOT = "root";

	public const string ANIME_ACTION_SCHEME = "(.+\\D)\\d*$";

	internal readonly GameObject model;

	private Transform rootPoint;

	public readonly int id;

	private bool movable = true;

	[Min(0f)]
	public float Speed = 2f;

	public float radius = 0.25f;

	public float height = 1f;

	internal DormAnimeCfg animeNameCfg;

	private Dictionary<string, Transform> attachPoints;

	private readonly Dictionary<Transform, Transform> selfAttachedItems;

	private AnimationEventReciver eventReciver;

	internal bool needDestoryModelOnDispose;

	private readonly bool isPooled;

	private AnimationClipCollectInfo allClipsInfo;

	public IProvideInteractEntity interactProvider;

	private List<DormEntityManager.WaitForNotify> waitList = new List<DormEntityManager.WaitForNotify>();

	internal HashSet<int> countAsWaitInteract = new HashSet<int>();

	protected bool animatorInfoInit;

	private const string ANIME_BASE_LAYER = "Base Layer";

	protected int animatorBaseLayer = -1;

	internal bool animeReleaseControl;

	internal DormAnimeCfg defaultScheme;

	private readonly Dictionary<Transform, DormEntity> selfAttachedItemsOwner = new Dictionary<Transform, DormEntity>();

	private readonly Dictionary<Transform, string> grabedItems = new Dictionary<Transform, string>();

	private DormEntity host;

	internal readonly Lazy<EntityVfxController> VfxController;

	internal virtual int DefaultMouth => 0;

	public Transform ModelTrs
	{
		get
		{
			if (!model)
			{
				return null;
			}
			return model.transform;
		}
	}

	public string name
	{
		get
		{
			return ModelTrs.name;
		}
		set
		{
			ModelTrs.name = value;
		}
	}

	public virtual bool Movable
	{
		get
		{
			if (host == null)
			{
				return movable;
			}
			return false;
		}
		set
		{
			movable = value;
		}
	}

	internal Animator animator { get; set; }

	public ColorOutline Outline { get; private set; }

	public bool Highlighted
	{
		get
		{
			return Outline?.enabled ?? false;
		}
		set
		{
			if ((bool)Outline)
			{
				Outline.enabled = value;
			}
		}
	}

	public int HighlightLayer
	{
		get
		{
			return Outline?.rendererLayer ?? 0;
		}
		set
		{
			if ((bool)Outline)
			{
				Outline.rendererLayer = value;
			}
		}
	}

	public bool HighlightedVisible => Outline?.isActiveAndEnabled ?? false;

	internal int WaitInteractCount => waitList.Count + countAsWaitInteract.Count;

	internal bool IsInteracted
	{
		get
		{
			foreach (DormEntityManager.WaitForNotify wait in waitList)
			{
				if (wait.keepWaiting)
				{
					return true;
				}
			}
			return false;
		}
	}

	internal int AnimatorBaseLayer
	{
		get
		{
			if (!animatorInfoInit && (bool)animator)
			{
				PullAnimatorInfo();
			}
			return animatorBaseLayer;
		}
	}

	private int CurPlayingHash
	{
		get
		{
			if ((bool)animator)
			{
				if (animator.IsInTransition(AnimatorBaseLayer))
				{
					return animator.GetAnimatorTransitionInfo(AnimatorBaseLayer).fullPathHash;
				}
				return animator.GetCurrentAnimatorStateInfo(AnimatorBaseLayer).fullPathHash;
			}
			return -1;
		}
	}

	public string CurPlaying { get; private set; }

	internal bool SelfAnimeControl
	{
		get
		{
			if (!animeReleaseControl)
			{
				return !IsInteracted;
			}
			return false;
		}
	}

	public string MoveAnime => animeNameCfg.moveAnime;

	public string IdleAnime => animeNameCfg.idleAnime;

	public string StandAnime => animeNameCfg.standAnime;

	public override string ToString()
	{
		return $"{{entity id = {id}}}";
	}

	internal float GetCurAnimePlayNormalizedTime()
	{
		return GetCurAnimePlayNormalizedTime(animator);
	}

	protected static float GetCurAnimePlayNormalizedTime(Animator animator)
	{
		if (animator.IsInTransition(0))
		{
			return animator.GetAnimatorTransitionInfo(0).normalizedTime;
		}
		return animator.GetCurrentAnimatorStateInfo(0).normalizedTime;
	}

	private static Dictionary<Transform, Transform> CollectItemPart(Dictionary<string, Transform> attachPoints)
	{
		Dictionary<Transform, Transform> dictionary = new Dictionary<Transform, Transform>();
		foreach (KeyValuePair<string, Transform> attachPoint in attachPoints)
		{
			Transform value = attachPoint.Value;
			foreach (Transform item in value)
			{
				if (item.CompareTag("Item"))
				{
					dictionary.Add(item, value);
				}
			}
		}
		return dictionary;
	}

	private static Dictionary<string, Transform> CollectAttachPoints(Transform model, out Transform rootPoint)
	{
		Dictionary<string, Transform> dictionary = new Dictionary<string, Transform>();
		rootPoint = model;
		dictionary.Add("root", rootPoint);
		CollectAttachPoints(dictionary, model);
		return dictionary;
	}

	private static void CollectAttachPoints(Dictionary<string, Transform> attachPoints, Transform trans)
	{
		if (trans.name.StartsWith("gua_"))
		{
			attachPoints.Add(trans.name, trans);
		}
		foreach (Transform tran in trans)
		{
			CollectAttachPoints(attachPoints, tran);
		}
	}

	internal T InitComponent<T>() where T : Component
	{
		if (!model)
		{
			return null;
		}
		return U3DUtil.Get<T>(model);
	}

	internal DormEntity(int id, GameObject model, bool needDestoryModelOnDispose, bool isPooled)
	{
		this.id = id;
		this.model = model;
		this.needDestoryModelOnDispose = needDestoryModelOnDispose;
		Outline = InitComponent<ColorOutline>();
		Highlighted = false;
		animator = model.GetComponent<Animator>();
		if ((bool)animator)
		{
			eventReciver = InitComponent<AnimationEventReciver>();
			eventReciver.entity = this;
			allClipsInfo = model.GetComponent<AnimationClipCollectInfo>();
		}
		attachPoints = CollectAttachPoints(model.transform, out rootPoint);
		selfAttachedItems = CollectItemPart(attachPoints);
		this.isPooled = isPooled;
		VfxController = new Lazy<EntityVfxController>(delegate
		{
			EntityVfxController entityVfxController = InitComponent<EntityVfxController>();
			if ((bool)entityVfxController)
			{
				entityVfxController.entity = this;
				return entityVfxController;
			}
			return (EntityVfxController)null;
		});
	}

	internal void SetActive(bool active)
	{
		ModelTrs.gameObject.SetActive(active);
		if (active)
		{
			OnEnable();
		}
	}

	private static string TryMatchActionName(string anime)
	{
		if (!string.IsNullOrEmpty(anime))
		{
			return Regex.Match(anime, "(.+\\D)\\d*$").Groups[1].Value;
		}
		return null;
	}

	internal static bool IsSameAnimeAction(string action1, string action2)
	{
		string text = TryMatchActionName(action1);
		string text2 = TryMatchActionName(action2);
		return text == text2;
	}

	internal bool IsIdleAnime(string animeAction)
	{
		if (animeAction == null)
		{
			return false;
		}
		return TryMatchActionName(animeAction) == animeNameCfg.idleAnime;
	}

	internal bool IsMoveAnime(string animeAction)
	{
		if (animeAction == null)
		{
			return false;
		}
		return TryMatchActionName(animeAction) == animeNameCfg.moveAnime;
	}

	internal bool IsStandAnime(string animeAction)
	{
		if (animeAction == null)
		{
			return false;
		}
		return TryMatchActionName(animeAction) == animeNameCfg.standAnime;
	}

	private void OnEnable()
	{
		if (!string.IsNullOrEmpty(CurPlaying))
		{
			Restart();
		}
	}

	internal virtual void DestoryEntity(float delay)
	{
		foreach (DormEntityManager.WaitForNotify wait in waitList)
		{
			wait.Cancel();
		}
		waitList.Clear();
		DisposeModel(delay);
	}

	internal void PutAt(Vector3 position)
	{
		ModelTrs.position = position;
	}

	internal void PutAt(Vector3 position, Quaternion rotation)
	{
		ModelTrs.position = position;
		ModelTrs.rotation = rotation;
	}

	internal void DisposeModel(float delay)
	{
		RestoreAttachedEfx();
		RestoreSelfItemPart();
		if (needDestoryModelOnDispose)
		{
			if (isPooled)
			{
				PooledAsset.DestroyOrReturn(model, delay);
			}
			else
			{
				UnityEngine.Object.Destroy(model, delay);
			}
		}
	}

	private static void OnInteractByOtherEntity(int entityID, int otherEntityID)
	{
		DormEntityAction.Notify("ON_DORM_CHARACTER_BE_INTERACTED", entityID, otherEntityID);
	}

	internal virtual void BeInteractedBy(int otherEntity, DormEntityManager.WaitForNotify @event)
	{
		waitList.Add(@event);
		OnInteractByOtherEntity(id, otherEntity);
	}

	internal virtual void BeInteractedFinished(DormEntityManager.WaitForNotify @event)
	{
		interactProvider?.OnInteractBeingCanceled();
		waitList.Remove(@event);
		if (waitList.Count == 0)
		{
			RestoreAttachedInteractEfx();
			RestoreSelfItemPart();
		}
	}

	internal virtual void PullAnimatorInfo()
	{
		animatorBaseLayer = animator.GetLayerIndex("Base Layer");
		animatorInfoInit = true;
	}

	internal void UseAnimeCfg(DormAnimeCfg animeCfg)
	{
		animeNameCfg = animeCfg;
	}

	private bool IsPlayingAnyAnime()
	{
		return CurPlayingHash != 1;
	}

	public bool IsPlaying(string animeName)
	{
		return animeName == CurPlaying;
	}

	public Vector3 GetWorldPos()
	{
		return ModelTrs.position;
	}

	public Vector3 GetForward()
	{
		return ModelTrs.forward;
	}

	public string Play(DormEntityAnime anime, float crossFade = 0.05f)
	{
		return anime switch
		{
			DormEntityAnime.Stand => Play(StandAnime, null, crossFade), 
			DormEntityAnime.Idle => Play(IdleAnime, null, crossFade), 
			DormEntityAnime.Move => Play(MoveAnime, null, crossFade), 
			_ => null, 
		};
	}

	internal string Play(string name, string subType = null, float crossFade = 0.05f)
	{
		string result = FindAnimeClip(name, subType, AnimatorBaseLayer, out var hash);
		if (!animeReleaseControl)
		{
			PlayImpl(hash, result, crossFade);
		}
		return result;
	}

	internal void RestoreAnimeScheme()
	{
		if ((bool)defaultScheme)
		{
			UseAnimeCfg(defaultScheme);
		}
		DormEntityManager.Instance?.RestoreEntityAnimeSchemeInternal(this);
	}

	internal void PlayAnime(string name, string subName, float transDuration)
	{
		string text = FindAnimeClip(name, subName, AnimatorBaseLayer, out var hash);
		PlayImpl(hash, text, transDuration);
	}

	private void OnAnimeStart()
	{
		eventReciver.playedOnce = false;
		eventReciver.Notify("start");
	}

	private void OnAnimeEnd()
	{
		eventReciver.Notify("end");
	}

	private void Restart()
	{
		int hash = Animator.StringToHash(animator.GetLayerName(AnimatorBaseLayer) + "." + CurPlaying);
		PlayImpl(hash, CurPlaying);
	}

	private void PlayImpl(int hash, string name, float transDuration = 0.05f)
	{
		if ((bool)animator)
		{
			if (animator.HasState(AnimatorBaseLayer, hash))
			{
				if (IsPlayingAnyAnime())
				{
					OnAnimeEnd();
				}
				PlayInternal(hash, AnimatorBaseLayer, transDuration);
				CurPlaying = name;
				OnAnimeStart();
			}
		}
		else
		{
			CurPlaying = null;
			DormEntityAction.Notify("ON_DORM_ENTITY_ANIME_EVENT", id, "start", name);
			DormEntityAction.Notify("ON_DORM_ENTITY_ANIME_EVENT", id, "end", name);
		}
	}

	internal void PlayInternal(int animeHash, int layer, float crossFade = 0.05f)
	{
		if (animeHash != -1)
		{
			if (crossFade == 0f)
			{
				animator.Play(animeHash, layer, 0f);
			}
			else
			{
				animator.CrossFade(animeHash, crossFade, layer, 0f);
			}
		}
	}

	private static string CombineClipName(string action, string subType)
	{
		return action + subType;
	}

	internal string FindAnimeClip(string name, string subName, int layerIdx, out int hash)
	{
		if ((bool)animator)
		{
			if (!string.IsNullOrEmpty(subName))
			{
				string layerName = animator.GetLayerName(layerIdx);
				string text = CombineClipName(name, subName);
				hash = Animator.StringToHash(layerName + "." + text);
				return text;
			}
			AnimationClipCollectInfo.ActionInfo pick;
			if (allClipsInfo == null)
			{
				List<AnimationClip> list = new List<AnimationClip>();
				AnimationClip[] animationClips = animator.runtimeAnimatorController.animationClips;
				foreach (AnimationClip animationClip in animationClips)
				{
					if (IsSameAnimeAction(name, animationClip.name))
					{
						list.Add(animationClip);
					}
				}
				if (list.Count > 0)
				{
					AnimationClip animationClip2 = list[UnityEngine.Random.Range(0, list.Count)];
					string layerName2 = animator.GetLayerName(layerIdx);
					hash = Animator.StringToHash(layerName2 + "." + animationClip2.name);
					return animationClip2.name;
				}
			}
			else if (allClipsInfo.PickAnime(layerIdx, name, out pick))
			{
				hash = pick.nameHash;
				return pick.name;
			}
		}
		Debug.LogWarning($"Entity {id} Animation {name} NOT FOUND", model);
		hash = -1;
		return name;
	}

	private void AttachItemPart(Transform item, string attachPoint)
	{
		grabedItems[item] = attachPoint;
		Transform parent = FindAttachPoint(attachPoint);
		item.SetParent(parent);
		item.localPosition = Vector3.zero;
		item.localRotation = Quaternion.identity;
		item.localScale = Vector3.one;
	}

	private void ReleaseItem(Transform item)
	{
		grabedItems.Remove(item);
		item.SetParent(null);
	}

	internal void RestoreSelfItemPart(string itemName)
	{
		RestoreSelfItemPart(FindItem(itemName));
	}

	internal void RestoreSelfItemPart(Transform item)
	{
		if ((bool)item && selfAttachedItemsOwner.TryGetValue(item, out var value))
		{
			value.ReleaseItem(item);
			item.SetParent(selfAttachedItems[item]);
			item.localPosition = Vector3.zero;
			item.localRotation = Quaternion.identity;
			item.localScale = Vector3.one;
			selfAttachedItemsOwner.Remove(item);
		}
	}

	internal void RestoreSelfItemPart()
	{
		foreach (KeyValuePair<Transform, DormEntity> item in selfAttachedItemsOwner)
		{
			Transform key = item.Key;
			item.Value.ReleaseItem(key);
			key.SetParent(selfAttachedItems[key]);
			key.localPosition = Vector3.zero;
			key.localRotation = Quaternion.identity;
			key.localScale = Vector3.one;
		}
		selfAttachedItemsOwner.Clear();
	}

	internal Transform AttachItemPart(DormEntity owner, string itemPartName, string attachToPoint)
	{
		Transform transform = owner?.FindItem(itemPartName);
		if ((bool)transform)
		{
			owner.selfAttachedItemsOwner[transform] = this;
			AttachItemPart(transform, attachToPoint);
		}
		return transform;
	}

	internal void SetPartVisible(string itemPartName, bool value, bool modifyRendererEnabled)
	{
		Transform transform = FindItem(itemPartName);
		if (!transform)
		{
			return;
		}
		transform.gameObject.SetActive(value);
		if (value | modifyRendererEnabled)
		{
			Renderer[] componentsInChildren = transform.GetComponentsInChildren<Renderer>();
			for (int i = 0; i < componentsInChildren.Length; i++)
			{
				componentsInChildren[i].enabled = value;
			}
		}
	}

	internal void AttachAsItem(DormEntity itemEntity, string attachPoint, bool setAsChild)
	{
		itemEntity.DetachItemHost(resetFaceDir: false);
		Transform modelTrs = itemEntity.ModelTrs;
		itemEntity.host = this;
		Transform parent = FindAttachPoint(attachPoint);
		if (setAsChild)
		{
			modelTrs.SetParent(parent);
			modelTrs.localPosition = Vector3.zero;
			modelTrs.localRotation = Quaternion.identity;
			modelTrs.localScale = Vector3.one;
		}
		else
		{
			LinkToHost linkToHost = itemEntity.InitComponent<LinkToHost>();
			linkToHost.host = parent;
			linkToHost.UpdatePos();
		}
	}

	internal void DetachItemHost(bool resetFaceDir)
	{
		if (host == null)
		{
			return;
		}
		if ((bool)ModelTrs)
		{
			Transform modelTrs = ModelTrs;
			modelTrs.parent = null;
			if (resetFaceDir)
			{
				modelTrs.rotation = Quaternion.identity;
			}
			if ((bool)host.ModelTrs)
			{
				modelTrs.position = host.ModelTrs.position;
			}
			InitComponent<LinkToHost>().host = null;
		}
		host = null;
	}

	internal Transform FindAttachPoint(string path)
	{
		if (!string.IsNullOrEmpty(path) && attachPoints.TryGetValue(path, out var value))
		{
			return value;
		}
		return rootPoint;
	}

	private Transform FindItem(string itemName)
	{
		foreach (Transform key in selfAttachedItems.Keys)
		{
			if (key.name == itemName)
			{
				return key;
			}
		}
		return null;
	}

	internal EffectController PlayEffect(string efxType, string efxFacePath, string attachPoint, Vector3 offset, Quaternion rotation, Vector3 localScale, float duration)
	{
		EntityVfxController value = VfxController.Value;
		Transform attachPoint2 = FindAttachPoint(attachPoint);
		return value.PlayEffect(efxType, efxFacePath, attachPoint2, offset, rotation, localScale, duration, EEffectQuality.Low);
	}

	internal void ClearAllEffectOnAttachPoint(string attachPoint)
	{
		EffectController[] componentsInChildren = FindAttachPoint(attachPoint).GetComponentsInChildren<EffectController>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			componentsInChildren[i].Stop();
		}
	}

	internal void ClearInteractEffectOnAttachPoint(string attachPoint)
	{
		if (VfxController.IsValueCreated)
		{
			EntityVfxController value = VfxController.Value;
			EffectController[] componentsInChildren = FindAttachPoint(attachPoint).GetComponentsInChildren<EffectController>();
			foreach (EffectController efx in componentsInChildren)
			{
				value.RemoveVisualEfx("interact", efx);
			}
		}
	}

	internal void RestoreAttachedEfx()
	{
		if (VfxController.IsValueCreated)
		{
			VfxController.Value.ClearAllVisualEfx();
		}
	}

	internal void RestoreAttachedEfx(string vfxType)
	{
		if (VfxController.IsValueCreated)
		{
			VfxController.Value.ClearAllVisualEfx(vfxType);
		}
	}

	internal void RestoreAttachedInteractEfx()
	{
		RestoreAttachedEfx("interact");
	}
}
