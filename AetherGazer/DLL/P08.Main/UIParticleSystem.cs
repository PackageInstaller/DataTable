using System;
using UnityEngine;
using UnityEngine.UI;

[ExecuteInEditMode]
[RequireComponent(typeof(CanvasRenderer), typeof(ParticleSystem))]
public class UIParticleSystem : MaskableGraphic
{
	[Tooltip("勾上这个，会把粒子系统放在LateUpdate里运行")]
	public bool fixedTime = true;

	[Range(1f, 60f)]
	public int maxParticleCount = 15;

	private Transform _transform;

	private ParticleSystem pSystem;

	private ParticleSystem.Particle[] particles;

	private UIVertex[] _quad = new UIVertex[4];

	private Vector4 imageUV = Vector4.zero;

	private ParticleSystem.TextureSheetAnimationModule textureSheetAnimation;

	private int textureSheetAnimationFrames;

	private Vector2 textureSheetAnimationFrameSize;

	private ParticleSystemRenderer pRenderer;

	private Material currentMaterial;

	private Texture currentTexture;

	private ParticleSystem.MainModule mainModule;

	public override Texture mainTexture => currentTexture;

	protected bool Initialize()
	{
		if (_transform == null)
		{
			_transform = base.transform;
		}
		if (pSystem == null)
		{
			pSystem = GetComponent<ParticleSystem>();
			if (pSystem == null)
			{
				return false;
			}
			mainModule = pSystem.main;
			if (pSystem.main.maxParticles > maxParticleCount)
			{
				mainModule.maxParticles = maxParticleCount;
			}
			pRenderer = pSystem.GetComponent<ParticleSystemRenderer>();
			if (pRenderer != null)
			{
				pRenderer.material = null;
				pRenderer.enabled = false;
			}
			currentMaterial = material;
			if ((bool)currentMaterial && currentMaterial.HasProperty("_MainTex"))
			{
				currentTexture = currentMaterial.mainTexture;
				if (currentTexture == null)
				{
					currentTexture = Texture2D.whiteTexture;
				}
			}
			material = currentMaterial;
			mainModule.scalingMode = ParticleSystemScalingMode.Hierarchy;
			particles = null;
		}
		if (particles == null)
		{
			particles = new ParticleSystem.Particle[pSystem.main.maxParticles];
		}
		imageUV = new Vector4(0f, 0f, 1f, 1f);
		textureSheetAnimation = pSystem.textureSheetAnimation;
		textureSheetAnimationFrames = 0;
		textureSheetAnimationFrameSize = Vector2.zero;
		if (textureSheetAnimation.enabled)
		{
			textureSheetAnimationFrames = textureSheetAnimation.numTilesX * textureSheetAnimation.numTilesY;
			textureSheetAnimationFrameSize = new Vector2(1f / (float)textureSheetAnimation.numTilesX, 1f / (float)textureSheetAnimation.numTilesY);
		}
		return true;
	}

	protected override void Awake()
	{
		base.Awake();
		if (!Initialize())
		{
			base.enabled = false;
		}
		raycastTarget = false;
	}

	protected override void OnPopulateMesh(VertexHelper vh)
	{
		vh.Clear();
		if (!base.gameObject.activeInHierarchy)
		{
			return;
		}
		Vector2 zero = Vector2.zero;
		Vector2 zero2 = Vector2.zero;
		Vector2 zero3 = Vector2.zero;
		int num = pSystem.GetParticles(particles);
		for (int i = 0; i < num; i++)
		{
			ParticleSystem.Particle particle = particles[i];
			Vector2 vector = ((mainModule.simulationSpace == ParticleSystemSimulationSpace.Local) ? particle.position : _transform.InverseTransformPoint(particle.position));
			float num2 = (0f - particle.rotation) * (MathF.PI / 180f);
			float f = num2 + MathF.PI / 2f;
			Color32 currentColor = particle.GetCurrentColor(pSystem);
			float num3 = particle.GetCurrentSize(pSystem) * 0.5f;
			if (mainModule.scalingMode == ParticleSystemScalingMode.Shape)
			{
				vector /= base.canvas.scaleFactor;
			}
			Vector4 vector2 = imageUV;
			if (textureSheetAnimation.enabled)
			{
				float num4 = 1f - particle.remainingLifetime / particle.startLifetime;
				if (textureSheetAnimation.frameOverTime.curveMin != null)
				{
					num4 = textureSheetAnimation.frameOverTime.curveMin.Evaluate(1f - particle.remainingLifetime / particle.startLifetime);
				}
				else if (textureSheetAnimation.frameOverTime.curve != null)
				{
					num4 = textureSheetAnimation.frameOverTime.curve.Evaluate(1f - particle.remainingLifetime / particle.startLifetime);
				}
				else if (textureSheetAnimation.frameOverTime.constant > 0f)
				{
					num4 = textureSheetAnimation.frameOverTime.constant - particle.remainingLifetime / particle.startLifetime;
				}
				num4 = Mathf.Repeat(num4 * (float)textureSheetAnimation.cycleCount, 1f);
				int num5 = 0;
				switch (textureSheetAnimation.animation)
				{
				case ParticleSystemAnimationType.WholeSheet:
					num5 = Mathf.FloorToInt(num4 * (float)textureSheetAnimationFrames);
					break;
				case ParticleSystemAnimationType.SingleRow:
				{
					num5 = Mathf.FloorToInt(num4 * (float)textureSheetAnimation.numTilesX);
					int rowIndex = textureSheetAnimation.rowIndex;
					num5 += rowIndex * textureSheetAnimation.numTilesX;
					break;
				}
				}
				num5 %= textureSheetAnimationFrames;
				vector2.x = (float)(num5 % textureSheetAnimation.numTilesX) * textureSheetAnimationFrameSize.x;
				vector2.y = (float)Mathf.FloorToInt(num5 / textureSheetAnimation.numTilesX) * textureSheetAnimationFrameSize.y;
				vector2.z = vector2.x + textureSheetAnimationFrameSize.x;
				vector2.w = vector2.y + textureSheetAnimationFrameSize.y;
			}
			zero.x = vector2.x;
			zero.y = vector2.y;
			_quad[0] = UIVertex.simpleVert;
			_quad[0].color = currentColor;
			_quad[0].uv0 = zero;
			zero.x = vector2.x;
			zero.y = vector2.w;
			_quad[1] = UIVertex.simpleVert;
			_quad[1].color = currentColor;
			_quad[1].uv0 = zero;
			zero.x = vector2.z;
			zero.y = vector2.w;
			_quad[2] = UIVertex.simpleVert;
			_quad[2].color = currentColor;
			_quad[2].uv0 = zero;
			zero.x = vector2.z;
			zero.y = vector2.y;
			_quad[3] = UIVertex.simpleVert;
			_quad[3].color = currentColor;
			_quad[3].uv0 = zero;
			if (num2 == 0f)
			{
				zero2.x = vector.x - num3;
				zero2.y = vector.y - num3;
				zero3.x = vector.x + num3;
				zero3.y = vector.y + num3;
				zero.x = zero2.x;
				zero.y = zero2.y;
				_quad[0].position = zero;
				zero.x = zero2.x;
				zero.y = zero3.y;
				_quad[1].position = zero;
				zero.x = zero3.x;
				zero.y = zero3.y;
				_quad[2].position = zero;
				zero.x = zero3.x;
				zero.y = zero2.y;
				_quad[3].position = zero;
			}
			else
			{
				Vector2 vector3 = new Vector2(Mathf.Cos(num2), Mathf.Sin(num2)) * num3;
				Vector2 vector4 = new Vector2(Mathf.Cos(f), Mathf.Sin(f)) * num3;
				_quad[0].position = vector - vector3 - vector4;
				_quad[1].position = vector - vector3 + vector4;
				_quad[2].position = vector + vector3 + vector4;
				_quad[3].position = vector + vector3 - vector4;
			}
			vh.AddUIVertexQuad(_quad);
		}
	}

	private void Update()
	{
		if (!fixedTime && Application.isPlaying)
		{
			pSystem.Simulate(Time.unscaledDeltaTime, withChildren: false, restart: false, fixedTimeStep: true);
			SetAllDirty();
			if ((currentMaterial != null && currentTexture != currentMaterial.mainTexture) || (material != null && currentMaterial != null && material.shader != currentMaterial.shader))
			{
				pSystem = null;
				Initialize();
			}
		}
	}

	private void LateUpdate()
	{
		if (!Application.isPlaying)
		{
			SetAllDirty();
		}
		else if (fixedTime)
		{
			pSystem.Simulate(Time.unscaledDeltaTime, withChildren: false, restart: false, fixedTimeStep: true);
			SetAllDirty();
			if ((currentMaterial != null && currentTexture != currentMaterial.mainTexture) || (material != null && currentMaterial != null && material.shader != currentMaterial.shader))
			{
				pSystem = null;
				Initialize();
			}
		}
		if (!(material == currentMaterial))
		{
			pSystem = null;
			Initialize();
		}
	}
}
