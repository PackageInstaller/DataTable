using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline.Character;

public class PassiveCharaActor
{
	private struct PooledChara
	{
		public float fade;

		private FadeGroup fadeControl;

		private PooledAsset pooledInfo;

		private Renderer[] renderers;

		public SDCharacter sdChara;

		public Animator animator;

		private const float AFFECT_BY_PLAYER_FADE_RANGE = 0.75f;

		private const float AFFECT_BY_MAIN_CAM_FADE_RANGE = 1.5f;

		public string asset { get; private set; }

		public bool Visible => (double?)fadeControl?.groupFade >= 0.2;

		public GameObject obj
		{
			get
			{
				if (!pooledInfo)
				{
					return null;
				}
				return pooledInfo.gameObject;
			}
		}

		public bool IsValid => pooledInfo;

		private float FadeByPlayer
		{
			get
			{
				if (!IsValid || !(QWorldScene.Scene.Agent != null))
				{
					return 1f;
				}
				return CalcDitherByDistance(Vector3.Distance(QWorldScene.Scene.Agent.Position, obj.transform.position), 0.75f);
			}
		}

		private float FadeByCamera
		{
			get
			{
				if (!IsValid || !QWorldCameraManager.Instance.MainCamera)
				{
					return 1f;
				}
				return CalcDitherByDistance(Vector3.Distance(QWorldCameraManager.Instance.MainCamera.transform.position, obj.transform.position), 1.5f);
			}
		}

		public bool ClaimActor(string asset)
		{
			if (!IsValid || asset != this.asset)
			{
				RecycleActor();
				this.asset = asset;
				GameObject gameObject = Asset.Instantiate(asset);
				pooledInfo = gameObject.GetComponent<PooledAsset>();
				sdChara = gameObject.GetComponentInChildren<SDCharacter>(includeInactive: true);
				sdChara.ditherAlpha = 0f;
				fadeControl = new FadeGroup();
				renderers = gameObject.GetComponentsInChildren<Renderer>(includeInactive: true);
				animator = gameObject.GetComponentInChildren<Animator>(includeInactive: true);
				return true;
			}
			return false;
		}

		public void RecycleActor()
		{
			if (IsValid)
			{
				pooledInfo.Return();
			}
			pooledInfo = null;
			sdChara = null;
			renderers = null;
		}

		private static float CalcDitherByDistance(float distance, float range)
		{
			return Mathf.Clamp(distance / range, 0.25f, 1f);
		}

		public void UpdateFade(float fade)
		{
			this.fade = fade;
			float num = Mathf.Min(fadeControl.groupFade, Mathf.Min(fade, Mathf.Min(FadeByPlayer, FadeByCamera)));
			if ((bool)sdChara)
			{
				sdChara.ditherAlpha = num;
				Renderer[] array = renderers;
				for (int i = 0; i < array.Length; i++)
				{
					array[i].enabled = num >= 0.2f;
				}
			}
		}

		public void StartFadeIn()
		{
			fadeControl.StartFadeIn(obj);
		}

		public void StartFadeOut()
		{
			fadeControl.StartFadeOut(obj);
		}

		internal void SetAssetWithoutClaim(string asset)
		{
			if (!IsValid || asset != this.asset)
			{
				RecycleActor();
				this.asset = asset;
			}
		}
	}

	public enum Quality
	{
		Cull,
		Low,
		High
	}

	private const string LOW_QUALITY_NPC_ASSET_PATH = "QWWorld/NPC/QW_GrayPeople";

	private PooledChara mainActor;

	private PooledChara lowQualityActor;

	private QWAttachPointSetup mainActorAttachPoints;

	public const int LOD_START_LOW_QUALITY = 2;

	public const int LOD_START_CULL = 3;

	public Quality quality;

	private string defaultAnime;

	public string asset => mainActor.asset;

	private void MapBones(GameObject masterActor, GameObject slaveActor)
	{
		Dictionary<string, SkinnedMeshRenderer> dictionary = masterActor.GetComponentsInChildren<SkinnedMeshRenderer>().ToDictionary((SkinnedMeshRenderer com) => com.gameObject.name);
		SkinnedMeshRenderer[] componentsInChildren = slaveActor.GetComponentsInChildren<SkinnedMeshRenderer>();
		foreach (SkinnedMeshRenderer skinnedMeshRenderer in componentsInChildren)
		{
			if (!dictionary.TryGetValue(skinnedMeshRenderer.gameObject.name, out var value))
			{
				continue;
			}
			Dictionary<string, Transform> masterBones = value.bones.ToDictionary((Transform trs) => trs.name);
			skinnedMeshRenderer.bones = skinnedMeshRenderer.bones.Select(delegate(Transform bone)
			{
				if (masterBones.TryGetValue(bone.name, out var value2))
				{
					return value2;
				}
				Debug.LogWarning("bone(" + bone.gameObject.name + ") does not have a mapping", bone);
				return bone;
			}).ToArray();
			skinnedMeshRenderer.rootBone = value.rootBone;
		}
	}

	public void SetAssetWithoutClaim(ActorPrefab asset)
	{
		mainActor.SetAssetWithoutClaim(asset.path);
		defaultAnime = asset.anime;
	}

	public void Claim(ActorPrefab asset)
	{
		bool flag = mainActor.ClaimActor(asset.path);
		mainActorAttachPoints = mainActor.obj.GetComponent<QWAttachPointSetup>();
		if (!lowQualityActor.IsValid && lowQualityActor.ClaimActor("QWWorld/NPC/QW_GrayPeople"))
		{
			flag = true;
		}
		if (flag)
		{
			MapBones(mainActor.obj, lowQualityActor.obj);
			if ((bool)mainActor.animator && mainActor.animator.gameObject.GetComponent<QWNPCMoveComponent>() == null)
			{
				mainActor.animator.gameObject.AddComponent<QWNPCMoveComponent>();
			}
		}
		if (!string.IsNullOrEmpty(asset.anime))
		{
			defaultAnime = asset.anime;
			mainActor.animator.Play(defaultAnime);
		}
	}

	public void Recycle()
	{
		quality = Quality.Cull;
		mainActor.RecycleActor();
		mainActorAttachPoints = null;
		lowQualityActor.RecycleActor();
	}

	private static void GetShowState(Quality quality, out bool showMain, out bool showLow)
	{
		showMain = quality == Quality.High;
		showLow = quality == Quality.Low;
	}

	public void OnUpdate(bool cull, Quality quality)
	{
		if (cull || quality == Quality.Cull)
		{
			Recycle();
			return;
		}
		Claim(new ActorPrefab
		{
			path = asset,
			anime = defaultAnime
		});
		if (this.quality == quality)
		{
			return;
		}
		GetShowState(quality, out var showMain, out var showLow);
		GetShowState(this.quality, out var showMain2, out var showLow2);
		if (showMain2 != showMain)
		{
			if (showMain)
			{
				mainActor.StartFadeIn();
			}
			else
			{
				mainActor.StartFadeOut();
			}
		}
		if (showLow2 != showLow)
		{
			if (showLow)
			{
				lowQualityActor.StartFadeIn();
			}
			else
			{
				lowQualityActor.StartFadeOut();
			}
		}
		this.quality = quality;
	}

	internal void UpdateFade(float fade)
	{
		if (mainActor.IsValid)
		{
			mainActor.UpdateFade(fade);
		}
		if (lowQualityActor.IsValid)
		{
			lowQualityActor.UpdateFade(fade);
		}
	}

	internal void UpdatePos(Vector3 pos)
	{
		if (mainActor.IsValid)
		{
			mainActor.obj.transform.position = pos;
		}
	}

	internal void UpdateRot(Quaternion rot)
	{
		if (mainActor.IsValid)
		{
			mainActor.obj.transform.rotation = rot;
		}
	}

	internal void UpdatePosAndRot(Vector3 pos, Quaternion rot)
	{
		if (mainActor.IsValid)
		{
			mainActor.obj.transform.position = pos;
			mainActor.obj.transform.rotation = rot;
		}
	}

	internal Transform QueryMainActorTrs()
	{
		if (!mainActor.IsValid)
		{
			return null;
		}
		return mainActor.obj.transform;
	}

	internal Transform QueryLowQualityActorTrs()
	{
		if (!lowQualityActor.IsValid)
		{
			return null;
		}
		return lowQualityActor.obj.transform;
	}

	internal Transform QueryMainActorPoint(string pointName)
	{
		if ((bool)mainActorAttachPoints)
		{
			return mainActorAttachPoints.GetAttachPoint(pointName);
		}
		return QueryMainActorTrs() ?? QueryLowQualityActorTrs();
	}
}
