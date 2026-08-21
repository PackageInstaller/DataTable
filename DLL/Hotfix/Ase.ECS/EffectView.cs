using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase.ECS;

public class EffectView : EntityView
{
	private struct RendererSortInfo
	{
		public ParticleSystemRenderer Renderer;

		public float OriginalSortingFudge;

		public int SiblingIndex;
	}

	private struct ActionBoneMaterial
	{
		public Material material;

		public string key;
	}

	private float minSpacing = 0.0005f;

	private float lastHitAlpha = -1f;

	private float lastSkillAlpha = -1f;

	private List<ParticleSystem> tmpParticleSystems;

	private List<Renderer> rendererList;

	private Dictionary<Material, Color> materialAlphaDic;

	private List<float> tmpParticleSpeed;

	private List<Color> tmpParticleColors;

	[HideInInspector]
	public TrailRenderer[] TrailRenderers;

	private List<TrailStruct> trailStructList = new List<TrailStruct>();

	private bool isInitParticle;

	private ActionBoneMaterial boneMaterial;

	protected bool IsTeamMetaAttackEffect;

	protected bool IsTeamMetaEffect;

	protected bool ignoreTimeScale;

	private GameSpeedMaterialSet gameSpeedMaterialSet;

	public override void OnAwake(object data = null)
	{
		base.OnAwake(data);
		mBaseEntity.GetComponent<AnimatorComponent>()?.RegisterChildAnimator(base.transform.GetComponentsInChildren<Animator>());
	}

	private void InitDataArray()
	{
		//IL_0099: Unknown result type (might be due to invalid IL or missing references)
		//IL_009e: Unknown result type (might be due to invalid IL or missing references)
		//IL_00bb: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c0: Unknown result type (might be due to invalid IL or missing references)
		tmpParticleSystems = CollectionPool<List<ParticleSystem>, ParticleSystem>.Get();
		tmpParticleSpeed = CollectionPool<List<float>, float>.Get();
		tmpParticleColors = CollectionPool<List<Color>, Color>.Get();
		tmpParticleSystems.Clear();
		tmpParticleSpeed.Clear();
		tmpParticleColors.Clear();
		base.transform.GetComponentsInChildren(tmpParticleSystems);
		for (int i = 0; i < tmpParticleSystems.Count; i++)
		{
			tmpParticleSpeed.Add(0f);
			tmpParticleColors.Add(Color.white);
		}
		for (int j = 0; j < tmpParticleSystems.Count; j++)
		{
			MainModule main = tmpParticleSystems[j].main;
			tmpParticleSpeed[j] = ((MainModule)(ref main)).simulationSpeed;
			List<Color> list = tmpParticleColors;
			int index = j;
			MinMaxGradient startColor = ((MainModule)(ref main)).startColor;
			list[index] = ((MinMaxGradient)(ref startColor)).color;
		}
	}

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		InitDataArray();
		if (TrailRenderers != null && TrailRenderers.Length != 0)
		{
			for (int i = 0; i < TrailRenderers.Length; i++)
			{
				TrailStruct item = default(TrailStruct);
				item.Init(TrailRenderers[i]);
				trailStructList.Add(item);
			}
		}
		ignoreTimeScale = mBaseEntity.IgnoreTimeScale();
		if (mBaseEntity is EffectEntity effectEntity)
		{
			IsTeamMetaEffect = effectEntity.IsTeamMetaEffect;
			IsTeamMetaAttackEffect = effectEntity.IsTeamMetaAttackEffect;
		}
		else if (mBaseEntity is LinkEffectEntity linkEffectEntity)
		{
			IsTeamMetaEffect = linkEffectEntity.IsTeamMetaEffect;
			IsTeamMetaAttackEffect = linkEffectEntity.IsTeamMetaAttackEffect;
		}
		else if (mBaseEntity is ScreenEffectEntity screenEffectEntity)
		{
			IsTeamMetaEffect = screenEffectEntity.IsTeamMetaEffect;
			IsTeamMetaAttackEffect = screenEffectEntity.IsTeamMetaAttackEffect;
		}
		TryGetComponent<GameSpeedMaterialSet>(out gameSpeedMaterialSet);
		InitParticleSystems();
		InitMeshRenders();
		InitActionBone();
		if (!mBaseEntity.GetWorld().EntityIgnoreTimeScale(mBaseEntity) && mBaseEntity.FinalSpeed != 1f)
		{
			ChangeEffectPlaySpeed(mBaseEntity.FinalSpeed);
		}
	}

	public void InitParticleSystems()
	{
		//IL_003b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0040: Unknown result type (might be due to invalid IL or missing references)
		if (!isInitParticle)
		{
			isInitParticle = true;
			List<ParticleSystemRenderer> needChangeRenderers = CollectionPool<List<ParticleSystemRenderer>, ParticleSystemRenderer>.Get();
			foreach (ParticleSystem tmpParticleSystem in tmpParticleSystems)
			{
				if (ignoreTimeScale)
				{
					MainModule main = tmpParticleSystem.main;
					((MainModule)(ref main)).useUnscaledTime = ignoreTimeScale;
				}
				if (((Component)(object)tmpParticleSystem).TryGetComponent(out ParticleSystemRenderer component))
				{
					needChangeRenderers.Add(component);
				}
			}
			RedistributeSortingFudge(in needChangeRenderers);
			needChangeRenderers.Clear();
			CollectionPool<List<ParticleSystemRenderer>, ParticleSystemRenderer>.Release(needChangeRenderers);
		}
		if (!(mBaseEntity is EffectEntity effectEntity))
		{
			return;
		}
		EffectSystem system = mBaseEntity.GetSystem<EffectSystem>();
		float num = system?.GetTeammateHitEffectAlpha(effectEntity.Config) ?? 0f;
		if (lastHitAlpha != num && IsTeamMetaAttackEffect)
		{
			for (int i = 0; i < tmpParticleSystems.Count; i++)
			{
				ParticleColorTint(tmpParticleSystems[i], tmpParticleColors[i], num);
			}
			lastHitAlpha = num;
		}
		float num2 = system?.GetTeammateSkillEffectAlpha(effectEntity.Config) ?? 0f;
		if (lastSkillAlpha != num2 && IsTeamMetaEffect && !IsTeamMetaAttackEffect)
		{
			for (int j = 0; j < tmpParticleSystems.Count; j++)
			{
				ParticleColorTint(tmpParticleSystems[j], tmpParticleColors[j], num2);
			}
			lastSkillAlpha = num2;
		}
	}

	private void RedistributeSortingFudge(in List<ParticleSystemRenderer> needChangeRenderers)
	{
		if (needChangeRenderers == null || needChangeRenderers.Count == 0)
		{
			return;
		}
		List<RendererSortInfo> list = CollectionPool<List<RendererSortInfo>, RendererSortInfo>.Get();
		float num = float.MaxValue;
		float num2 = float.MinValue;
		for (int i = 0; i < needChangeRenderers.Count; i++)
		{
			ParticleSystemRenderer val = needChangeRenderers[i];
			if (!((Object)(object)val == null))
			{
				float sortingFudge = val.sortingFudge;
				if (sortingFudge < num)
				{
					num = sortingFudge;
				}
				if (sortingFudge > num2)
				{
					num2 = sortingFudge;
				}
				list.Add(new RendererSortInfo
				{
					Renderer = val,
					OriginalSortingFudge = sortingFudge,
					SiblingIndex = ((Component)(object)val).transform.GetSiblingIndex()
				});
			}
		}
		if (list.Count > 1)
		{
			list.Sort(CompareRendererSortInfo);
			float num3 = num2 - num;
			float num4 = minSpacing * (float)(list.Count - 1);
			if (num3 < num4)
			{
				num3 = num4;
				num2 = num + num3;
			}
			int num5 = (int)(num3 / (float)(list.Count - 1));
			for (int j = 0; j < list.Count; j++)
			{
				list[j].Renderer.sortingFudge = num + (float)(num5 * j);
			}
			list.Clear();
			CollectionPool<List<RendererSortInfo>, RendererSortInfo>.Release(list);
		}
	}

	private static int CompareRendererSortInfo(RendererSortInfo left, RendererSortInfo right)
	{
		int num = left.OriginalSortingFudge.CompareTo(right.OriginalSortingFudge);
		if (num != 0)
		{
			return num;
		}
		return left.SiblingIndex.CompareTo(right.SiblingIndex);
	}

	private void ParticleColorTint(ParticleSystem particleSystem, Color color, float alpha)
	{
		//IL_000b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		//IL_0027: Unknown result type (might be due to invalid IL or missing references)
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		//IL_002d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0047: Expected I4, but got Unknown
		//IL_00d6: Unknown result type (might be due to invalid IL or missing references)
		if (!((Object)(object)particleSystem == null))
		{
			MainModule main = particleSystem.main;
			MinMaxGradient startColor = ((MainModule)(ref main)).startColor;
			color.a *= alpha;
			ParticleSystemGradientMode mode = ((MinMaxGradient)(ref startColor)).mode;
			switch ((int)mode)
			{
			case 0:
				((MinMaxGradient)(ref startColor)).color = color;
				break;
			case 1:
				GradientColorTint(((MinMaxGradient)(ref startColor)).gradient, ((MinMaxGradient)(ref startColor)).gradient, color.a);
				break;
			case 2:
				((MinMaxGradient)(ref startColor)).colorMin = color;
				((MinMaxGradient)(ref startColor)).colorMax = color;
				break;
			case 3:
				GradientColorTint(((MinMaxGradient)(ref startColor)).gradientMax, ((MinMaxGradient)(ref startColor)).gradientMax, color.a);
				GradientColorTint(((MinMaxGradient)(ref startColor)).gradientMin, ((MinMaxGradient)(ref startColor)).gradientMin, color.a);
				break;
			case 4:
				GradientColorTint(((MinMaxGradient)(ref startColor)).gradientMax, ((MinMaxGradient)(ref startColor)).gradientMax, color.a);
				break;
			}
			((MainModule)(ref main)).startColor = startColor;
		}
	}

	private void GradientColorTint(Gradient origin, Gradient gradient, float alpha)
	{
		for (int i = 0; i < gradient.alphaKeys.Length; i++)
		{
			gradient.alphaKeys[i].alpha = alpha;
		}
	}

	private void InitMeshRenders()
	{
		if (!(mBaseEntity is EffectEntity effectEntity))
		{
			return;
		}
		EffectSystem system = mBaseEntity.GetSystem<EffectSystem>();
		float num = 1f;
		if (IsTeamMetaEffect)
		{
			num = system?.GetTeammateSkillEffectAlpha(effectEntity.Config) ?? 0f;
		}
		else if (IsTeamMetaAttackEffect)
		{
			num = system?.GetTeammateHitEffectAlpha(effectEntity.Config) ?? 0f;
		}
		if (num == 1f)
		{
			return;
		}
		rendererList = CollectionPool<List<Renderer>, Renderer>.Get();
		base.transform.GetComponentsInChildren(includeInactive: true, rendererList);
		if (rendererList.IsNullOrEmpty())
		{
			return;
		}
		materialAlphaDic = CollectionPool<Dictionary<Material, Color>, KeyValuePair<Material, Color>>.Get();
		int nameID = Shader.PropertyToID("_BaseColor");
		foreach (Renderer renderer in rendererList)
		{
			List<Material> list = CollectionPool<List<Material>, Material>.Get();
			renderer.GetMaterials(list);
			if (list.IsNullOrEmpty())
			{
				CollectionPool<List<Material>, Material>.Release(list);
				continue;
			}
			foreach (Material item in list)
			{
				if (!(item == null) && item.HasProperty(nameID))
				{
					Color color = item.GetColor(nameID);
					if (!materialAlphaDic.ContainsKey(item))
					{
						materialAlphaDic.Add(item, color);
					}
					color.a *= num;
					item.SetColor(nameID, color);
				}
			}
			CollectionPool<List<Material>, Material>.Release(list);
		}
	}

	public override void OnEntityFrozen(bool isFrozen)
	{
		//IL_005a: Unknown result type (might be due to invalid IL or missing references)
		//IL_005f: Unknown result type (might be due to invalid IL or missing references)
		if (mBaseEntity == null || !mBaseEntity.IsSurvival)
		{
			return;
		}
		if (isFrozen)
		{
			if (tmpParticleSystems != null && tmpParticleSystems.Count > 0)
			{
				for (int i = 0; i < tmpParticleSystems.Count; i++)
				{
					ParticleSystemPauseOnStartToPerformTime(tmpParticleSystems[i], GetStartToPerformTime());
					MainModule main = tmpParticleSystems[i].main;
					((MainModule)(ref main)).simulationSpeed = tmpParticleSpeed[i] * mBaseEntity.FinalSpeed;
				}
			}
			if (trailStructList.Count > 0)
			{
				for (int j = 0; j < trailStructList.Count; j++)
				{
					trailStructList[j].Pause();
				}
			}
			SetMaterialSpeed(mBaseEntity.FinalSpeed);
			return;
		}
		SetParticleSystemSpeed(mBaseEntity.EntityGameSpeed);
		if (trailStructList.Count > 0)
		{
			for (int k = 0; k < trailStructList.Count; k++)
			{
				trailStructList[k].Play();
			}
		}
	}

	public override void OnGameSpeedChanged(float gameSpeed)
	{
		base.OnGameSpeedChanged(gameSpeed);
		if (mBaseEntity != null && !mBaseEntity.GetWorld().EntityIgnoreTimeScale(mBaseEntity))
		{
			ChangeEffectPlaySpeed(mBaseEntity.FinalSpeed);
		}
	}

	public override void OnRePlay(bool isClear)
	{
		if (tmpParticleSystems.IsNullOrEmpty())
		{
			return;
		}
		InitParticleSystems();
		foreach (ParticleSystem tmpParticleSystem in tmpParticleSystems)
		{
			tmpParticleSystem.Stop(true, (ParticleSystemStopBehavior)(!isClear));
			tmpParticleSystem.Play(true);
		}
	}

	public override void OnPause()
	{
		base.OnPause();
		if (tmpParticleSystems != null && tmpParticleSystems.Count > 0)
		{
			for (int i = 0; i < tmpParticleSystems.Count; i++)
			{
				tmpParticleSystems[i].Pause(false);
			}
		}
		if (trailStructList.Count > 0)
		{
			for (int j = 0; j < trailStructList.Count; j++)
			{
				trailStructList[j].Pause();
			}
		}
	}

	public override void OnResume()
	{
		base.OnResume();
		if (mBaseEntity == null)
		{
			return;
		}
		if (tmpParticleSystems != null && tmpParticleSystems.Count > 0)
		{
			for (int i = 0; i < tmpParticleSystems.Count; i++)
			{
				if ((Object)(object)tmpParticleSystems[i] != null)
				{
					tmpParticleSystems[i].Play(false);
				}
			}
		}
		if (trailStructList != null && trailStructList.Count > 0)
		{
			for (int j = 0; j < trailStructList.Count; j++)
			{
				trailStructList[j].Play();
			}
		}
	}

	private void ChangeEffectPlaySpeed(float gameSpeed)
	{
		if (mBaseEntity != null)
		{
			SetParticleSystemSpeed(gameSpeed);
		}
	}

	private void SetParticleSystemSpeed(float speed)
	{
		//IL_003a: Unknown result type (might be due to invalid IL or missing references)
		//IL_003f: Unknown result type (might be due to invalid IL or missing references)
		if (tmpParticleSystems != null && tmpParticleSystems.Count > 0)
		{
			for (int i = 0; i < tmpParticleSystems.Count; i++)
			{
				if ((Object)(object)tmpParticleSystems[i] != null)
				{
					MainModule main = tmpParticleSystems[i].main;
					((MainModule)(ref main)).simulationSpeed = tmpParticleSpeed[i] * speed;
				}
			}
		}
		SetMaterialSpeed(mBaseEntity.FinalSpeed);
	}

	private void ParticleSystemPauseOnStartToPerformTime(ParticleSystem particleSystem, float startToPerformTime)
	{
		if (!((Object)(object)particleSystem == null) && particleSystem.time < startToPerformTime)
		{
			particleSystem.Simulate(startToPerformTime, false, false, false);
			particleSystem.Play(false);
		}
	}

	private void ParticleSystemSimulateFromNow(ParticleSystem particleSystem, float delayTime)
	{
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		if (!((Object)(object)particleSystem == null) && base.Entity != null && delayTime != 0f)
		{
			MainModule main = particleSystem.main;
			float duration = ((MainModule)(ref main)).duration;
			float num = Mathf.Clamp(particleSystem.time + delayTime, 0f, duration);
			particleSystem.Simulate(num, false, false, false);
		}
	}

	private float GetStartToPerformTime()
	{
		EffectEntity effectEntity = base.Entity as EffectEntity;
		float result = 0f;
		if (effectEntity != null)
		{
			result = effectEntity.StartToPerformTime;
		}
		return result;
	}

	private void InitActionBone()
	{
		boneMaterial = default(ActionBoneMaterial);
		if (mBaseEntity is EffectEntity effectEntity && !string.IsNullOrEmpty(effectEntity.Config.ActionBonePath))
		{
			string[] array = effectEntity.Config.ActionBonePath.Split(",");
			if (array.Length == 2 && base.transform.Find(array[0]).TryGetComponent<ParticleSystemRenderer>(out var component) && !(((Renderer)(object)component).material == null))
			{
				boneMaterial.material = ((Renderer)(object)component).material;
				boneMaterial.key = array[1];
			}
		}
	}

	public virtual void OnModifyMaterialParams(float value)
	{
		Material material = boneMaterial.material;
		if (!(material == null) && !string.IsNullOrEmpty(boneMaterial.key) && material.HasFloat(boneMaterial.key))
		{
			material.SetFloat(boneMaterial.key, value);
		}
	}

	private void SetMaterialSpeed(float gameSpeed)
	{
		if ((Object)(object)gameSpeedMaterialSet != null)
		{
			gameSpeedMaterialSet.SetGameSpeed(gameSpeed);
		}
	}

	public override void OnDispose()
	{
		//IL_005c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0061: Unknown result type (might be due to invalid IL or missing references)
		//IL_0077: Unknown result type (might be due to invalid IL or missing references)
		//IL_007c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0092: Unknown result type (might be due to invalid IL or missing references)
		base.OnDispose();
		if (tmpParticleSystems != null)
		{
			for (int i = 0; i < tmpParticleSystems.Count; i++)
			{
				if ((Object)(object)tmpParticleSystems[i] != null)
				{
					if (tmpParticleSystems[i].isPaused)
					{
						tmpParticleSystems[i].Play();
					}
					MainModule main = tmpParticleSystems[i].main;
					((MainModule)(ref main)).simulationSpeed = tmpParticleSpeed[i];
					MinMaxGradient startColor = ((MainModule)(ref main)).startColor;
					((MinMaxGradient)(ref startColor)).color = tmpParticleColors[i];
					((MainModule)(ref main)).startColor = startColor;
				}
			}
			tmpParticleSystems.Clear();
			CollectionPool<List<ParticleSystem>, ParticleSystem>.Release(tmpParticleSystems);
			tmpParticleSystems = null;
		}
		if (rendererList != null && materialAlphaDic != null)
		{
			int nameID = Shader.PropertyToID("_BaseColor");
			foreach (Renderer renderer in rendererList)
			{
				List<Material> list = CollectionPool<List<Material>, Material>.Get();
				renderer.GetMaterials(list);
				if (list.IsNullOrEmpty())
				{
					CollectionPool<List<Material>, Material>.Release(list);
					continue;
				}
				foreach (Material item in list)
				{
					if (!(item == null) && item.HasProperty(nameID) && materialAlphaDic.TryGetValue(item, out var value))
					{
						item.SetColor(nameID, value);
					}
				}
				CollectionPool<List<Material>, Material>.Release(list);
			}
			rendererList.Clear();
			CollectionPool<List<Renderer>, Renderer>.Release(rendererList);
			rendererList = null;
			materialAlphaDic.Clear();
			CollectionPool<Dictionary<Material, Color>, KeyValuePair<Material, Color>>.Release(materialAlphaDic);
		}
		if (tmpParticleSpeed != null)
		{
			tmpParticleSpeed.Clear();
			CollectionPool<List<float>, float>.Release(tmpParticleSpeed);
			tmpParticleSpeed = null;
		}
		if (tmpParticleColors != null)
		{
			tmpParticleColors.Clear();
			CollectionPool<List<Color>, Color>.Release(tmpParticleColors);
			tmpParticleColors = null;
		}
		SetMaterialSpeed(1f);
		trailStructList.Clear();
		lastHitAlpha = -1f;
		lastSkillAlpha = -1f;
	}
}
