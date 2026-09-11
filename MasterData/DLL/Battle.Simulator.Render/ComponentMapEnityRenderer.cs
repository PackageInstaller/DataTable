using System.Collections;
using UnityEngine;

public class ComponentMapEnityRenderer : ComponentRootRenderer
{
	public Material defaultMaterial;

	public Material fadeoutMaterial;

	public Transform probeAnchor;

	public bool canBatch = true;

	private IEnumerator fadeInCoroutine;

	private IEnumerator fadeOutCoroutine;

	protected override Material DefaultMaterial => defaultMaterial;

	protected override Shader DefaultShader => defaultMaterial.shader;

	protected override Material FadeoutMaterial => fadeoutMaterial;

	protected override bool IsFading
	{
		get
		{
			if (fadeInCoroutine == null)
			{
				return fadeOutCoroutine == null;
			}
			return false;
		}
	}

	public override void ActiveBehavior()
	{
		base.ActiveBehavior();
		base.Renderer = GetComponentInChildren<MeshRenderer>();
		if (!canBatch && defaultMaterial == null)
		{
			defaultMaterial = base.Renderer.material;
		}
		base.ActiveBehavior();
		DefaultStatus(base.Owner.IsAlpha);
		fadeInCoroutine = null;
		fadeOutCoroutine = null;
	}

	public void ChangeEnityRender(MeshRenderer render)
	{
		if ((bool)render)
		{
			base.Renderer = render;
			if (!canBatch && defaultMaterial == null)
			{
				defaultMaterial = base.Renderer.material;
			}
			DefaultStatus(base.Owner.IsAlpha);
			fadeInCoroutine = null;
			fadeOutCoroutine = null;
		}
	}

	public override void SetDefault(bool semivisible = false)
	{
		if (!canBatch)
		{
			base.SetDefault(semivisible);
		}
	}

	public override bool Highlight(bool on)
	{
		if (!canBatch)
		{
			return base.Highlight(on);
		}
		return false;
	}

	public override void SetSemivisible(bool on)
	{
		if (!canBatch)
		{
			base.SetSemivisible(on);
		}
	}

	public override void Fadeout(float timeOffs, float invert, float duration)
	{
		if (!canBatch)
		{
			base.Fadeout(timeOffs, invert, duration);
		}
	}

	private IEnumerator FadeIn(float duration = 1f)
	{
		Fadeout(0f - Time.time, 1f, duration);
		yield return new WaitForSeconds(duration);
		DefaultStatus(base.Owner.IsAlpha);
		if (fadeInCoroutine != null)
		{
			StopCoroutine(fadeInCoroutine);
			fadeInCoroutine = null;
		}
	}

	private IEnumerator Fadeout()
	{
		yield return new WaitForSeconds(1.8f);
		if ((bool)fadeoutMaterial && (bool)base.Renderer)
		{
			Fadeout(0f - Time.time, 0f, 2f);
		}
		if (fadeOutCoroutine != null)
		{
			StopCoroutine(fadeOutCoroutine);
			fadeOutCoroutine = null;
		}
	}

	public override void DefaultStatus(bool isSemivisible)
	{
		base.DefaultStatus(isSemivisible);
		base.Renderer.probeAnchor = probeAnchor;
	}
}
