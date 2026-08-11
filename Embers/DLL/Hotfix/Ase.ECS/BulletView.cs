using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase.ECS;

public class BulletView : EntityView
{
	private List<Animator> tmpAnimatorArray;

	private List<float> tmpAnimatorSpeed;

	private List<ParticleSystem> tmpParticleSystems;

	private List<float> tmpParticleSpeed;

	private List<Color> tmpParticleColors;

	private int effectId;

	private bool isTeamMetaEffect;

	private float lastSkillAlpha = -1f;

	private GameSpeedMaterialSet gameSpeedMaterialSet;

	private bool _hasSpeedMaterial;

	private static readonly int baseColorPropertyShaderID = Shader.PropertyToID("_BaseColor");

	private static readonly int colorTintPropertyShaderID = Shader.PropertyToID("_ColorTint");

	private List<SkinnedMeshRenderer> _skinnedMeshRendererList;

	private List<MeshRenderer> _meshRendererList;

	private void DeepSearchGoComponent(GameObject current)
	{
		if (!(current == null))
		{
			MeshRenderer component2;
			if (current.TryGetComponent<SkinnedMeshRenderer>(out var component))
			{
				_skinnedMeshRendererList.Add(component);
			}
			else if (current.TryGetComponent<MeshRenderer>(out component2))
			{
				_meshRendererList.Add(component2);
			}
			Transform transform = current.transform;
			for (int i = 0; i < transform.childCount; i++)
			{
				Transform child = transform.GetChild(i);
				DeepSearchGoComponent(child.gameObject);
			}
		}
	}

	private void InitMeshRendererList()
	{
		_skinnedMeshRendererList = CollectionPool<List<SkinnedMeshRenderer>, SkinnedMeshRenderer>.Get();
		_meshRendererList = CollectionPool<List<MeshRenderer>, MeshRenderer>.Get();
		_skinnedMeshRendererList.Clear();
		_meshRendererList.Clear();
		bool flag = false;
		for (int i = 0; i < base.transform.childCount; i++)
		{
			Transform child = base.transform.GetChild(i);
			if (!flag && child.transform.childCount > 0 && child.name.Contains("Bone"))
			{
				flag = true;
			}
			else
			{
				DeepSearchGoComponent(child.gameObject);
			}
		}
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
		tmpAnimatorArray = CollectionPool<List<Animator>, Animator>.Get();
		tmpAnimatorSpeed = CollectionPool<List<float>, float>.Get();
		tmpAnimatorArray.Clear();
		tmpAnimatorSpeed.Clear();
		base.transform.GetComponentsInChildren(tmpAnimatorArray);
		for (int k = 0; k < tmpAnimatorArray.Count; k++)
		{
			tmpAnimatorSpeed.Add(tmpAnimatorArray[k].speed);
		}
	}

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		InitMeshRendererList();
		InitDataArray();
		_hasSpeedMaterial = TryGetComponent<GameSpeedMaterialSet>(out gameSpeedMaterialSet);
		if (!mBaseEntity.GetWorld().EntityIgnoreTimeScale(mBaseEntity) && mBaseEntity.FinalSpeed != 1f)
		{
			ChangeEffectPlaySpeed(mBaseEntity.FinalSpeed);
		}
	}

	public void SetEffectData(int effectId, bool isTeamMetaEffect)
	{
		this.effectId = effectId;
		this.isTeamMetaEffect = isTeamMetaEffect;
		InitParticleSystems();
		InitTeamMeshEffect();
	}

	public override void OnEntityFrozen(bool isFrozen)
	{
		if (mBaseEntity != null && mBaseEntity.IsSurvival)
		{
			if (isFrozen)
			{
				SetAnimatorSpeed(mBaseEntity.FinalSpeed);
				SetParticleSystemSpeed(mBaseEntity.FinalSpeed);
			}
			else
			{
				SetAnimatorSpeed(mBaseEntity.EntityGameSpeed);
				SetParticleSystemSpeed(mBaseEntity.EntityGameSpeed);
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

	public override void OnPause()
	{
		base.OnPause();
		if (mBaseEntity == null || !mBaseEntity.IsSurvival)
		{
			return;
		}
		SetAnimatorSpeed(0f);
		if (tmpParticleSystems != null && tmpParticleSystems.Count > 0)
		{
			for (int i = 0; i < tmpParticleSystems.Count; i++)
			{
				tmpParticleSystems[i].Pause(false);
			}
		}
	}

	public override void OnResume()
	{
		base.OnResume();
		if (mBaseEntity == null || !mBaseEntity.IsSurvival)
		{
			return;
		}
		SetAnimatorSpeed(mBaseEntity.FinalSpeed);
		if (tmpParticleSystems != null && tmpParticleSystems.Count > 0)
		{
			for (int i = 0; i < tmpParticleSystems.Count; i++)
			{
				tmpParticleSystems[i].Play(false);
			}
		}
	}

	private void SetAnimatorSpeed(float speed)
	{
		if (tmpAnimatorArray == null)
		{
			return;
		}
		for (int i = 0; i < tmpAnimatorArray.Count; i++)
		{
			if ((Object)(object)tmpAnimatorArray[i] != null)
			{
				tmpAnimatorArray[i].speed = tmpAnimatorSpeed[i] * speed;
			}
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
		SetMaterialSpeed(speed);
	}

	public void InitParticleSystems()
	{
		if (!isTeamMetaEffect)
		{
			return;
		}
		float num = mBaseEntity.GetSystem<EffectSystem>()?.GetTeammateSkillEffectAlpha(effectId) ?? 0f;
		if (lastSkillAlpha != num)
		{
			for (int i = 0; i < tmpParticleSystems.Count; i++)
			{
				ParticleColorTint(tmpParticleSystems[i], tmpParticleColors[i], num);
			}
			lastSkillAlpha = num;
		}
	}

	private static void SetTeamEffectMatColor(Renderer renderer, float teammateSkillEffectAlpha)
	{
		List<Material> list = CollectionPool<List<Material>, Material>.Get();
		renderer.GetMaterials(list);
		foreach (Material item in list)
		{
			if (item.HasProperty(baseColorPropertyShaderID))
			{
				Color color = item.GetColor(baseColorPropertyShaderID);
				color.a = teammateSkillEffectAlpha;
				item.SetColor(baseColorPropertyShaderID, color);
			}
			if (item.HasProperty(colorTintPropertyShaderID))
			{
				Color color2 = item.GetColor(colorTintPropertyShaderID);
				color2.a = teammateSkillEffectAlpha;
				item.SetColor(colorTintPropertyShaderID, color2);
			}
		}
		CollectionPool<List<Material>, Material>.Release(list);
	}

	private void InitTeamMeshEffect()
	{
		if (isTeamMetaEffect)
		{
			float teammateSkillEffectAlpha = mBaseEntity.GetSystem<EffectSystem>()?.GetTeammateSkillEffectAlpha(effectId) ?? 0f;
			for (int i = 0; i < _skinnedMeshRendererList.Count; i++)
			{
				SetTeamEffectMatColor(_skinnedMeshRendererList[i], teammateSkillEffectAlpha);
			}
			for (int j = 0; j < _meshRendererList.Count; j++)
			{
				SetTeamEffectMatColor(_meshRendererList[j], teammateSkillEffectAlpha);
			}
		}
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

	private void ChangeEffectPlaySpeed(float gameSpeed)
	{
		//IL_00bb: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c0: Unknown result type (might be due to invalid IL or missing references)
		if (mBaseEntity == null)
		{
			return;
		}
		if (tmpAnimatorArray != null)
		{
			for (int i = 0; i < tmpAnimatorArray.Count; i++)
			{
				if ((Object)(object)tmpAnimatorArray[i] != null)
				{
					tmpAnimatorArray[i].speed = tmpAnimatorSpeed[i] * gameSpeed;
				}
			}
		}
		if (tmpParticleSystems != null && tmpParticleSystems.Count > 0)
		{
			for (int j = 0; j < tmpParticleSystems.Count; j++)
			{
				if ((Object)(object)tmpParticleSystems[j] != null)
				{
					if (tmpParticleSystems[j].isPaused)
					{
						tmpParticleSystems[j].Play();
					}
					MainModule main = tmpParticleSystems[j].main;
					((MainModule)(ref main)).simulationSpeed = tmpParticleSpeed[j] * gameSpeed;
				}
			}
		}
		SetMaterialSpeed(gameSpeed);
	}

	private void SetMaterialSpeed(float gameSpeed)
	{
		if (_hasSpeedMaterial)
		{
			gameSpeedMaterialSet.SetGameSpeed(gameSpeed);
		}
	}

	private void ReleaseTmpArray()
	{
		//IL_0048: Unknown result type (might be due to invalid IL or missing references)
		//IL_004d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0063: Unknown result type (might be due to invalid IL or missing references)
		//IL_0068: Unknown result type (might be due to invalid IL or missing references)
		//IL_007e: Unknown result type (might be due to invalid IL or missing references)
		if (tmpParticleSystems != null)
		{
			if (tmpParticleSystems != null && tmpParticleSystems.Count > 0)
			{
				for (int i = 0; i < tmpParticleSystems.Count; i++)
				{
					if ((Object)(object)tmpParticleSystems[i] != null)
					{
						MainModule main = tmpParticleSystems[i].main;
						((MainModule)(ref main)).simulationSpeed = tmpParticleSpeed[i];
						MinMaxGradient startColor = ((MainModule)(ref main)).startColor;
						((MinMaxGradient)(ref startColor)).color = tmpParticleColors[i];
						((MainModule)(ref main)).startColor = startColor;
					}
				}
			}
			tmpParticleSystems.Clear();
			CollectionPool<List<ParticleSystem>, ParticleSystem>.Release(tmpParticleSystems);
			tmpParticleSystems = null;
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
		if (tmpAnimatorArray != null)
		{
			for (int j = 0; j < tmpAnimatorArray.Count; j++)
			{
				if ((Object)(object)tmpAnimatorArray[j] != null)
				{
					tmpAnimatorArray[j].speed = tmpAnimatorSpeed[j];
				}
			}
			tmpAnimatorArray.Clear();
			CollectionPool<List<Animator>, Animator>.Release(tmpAnimatorArray);
			tmpAnimatorArray = null;
		}
		if (tmpAnimatorSpeed != null)
		{
			tmpAnimatorSpeed.Clear();
			CollectionPool<List<float>, float>.Release(tmpAnimatorSpeed);
			tmpAnimatorSpeed = null;
		}
	}

	public override void OnDispose()
	{
		base.OnDispose();
		ReleaseTmpArray();
		SetMaterialSpeed(1f);
		if (_skinnedMeshRendererList != null)
		{
			_skinnedMeshRendererList.Clear();
			CollectionPool<List<SkinnedMeshRenderer>, SkinnedMeshRenderer>.Release(_skinnedMeshRendererList);
			_skinnedMeshRendererList = null;
		}
		if (_meshRendererList != null)
		{
			_meshRendererList.Clear();
			CollectionPool<List<MeshRenderer>, MeshRenderer>.Release(_meshRendererList);
			_meshRendererList = null;
		}
		lastSkillAlpha = -1f;
	}
}
