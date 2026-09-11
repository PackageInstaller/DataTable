using System;
using UnityEngine;

public abstract class ComponentRenderer : CMonoBehaviour
{
	public static int RENDER_QUEUE_ACTOR = 2200;

	public static int RENDER_QUEUE_OCCLUSION = 2100;

	public Renderer Renderer { get; protected set; }

	public bool isVisible
	{
		get
		{
			if (!Renderer)
			{
				return false;
			}
			return Renderer.isVisible;
		}
	}

	public bool isSemivisible { get; private set; }

	protected NAgent Owner { get; set; }

	protected virtual Color RimColor => Color.red;

	protected virtual Shader DefaultShader => DefaultMaterial.shader;

	protected virtual Shader FadeoutShader => FadeoutMaterial.shader;

	protected virtual Material DefaultMaterial
	{
		get
		{
			throw new NotImplementedException();
		}
	}

	protected virtual Material FadeoutMaterial
	{
		get
		{
			throw new NotImplementedException();
		}
	}

	public override void ActiveBehavior()
	{
		base.ActiveBehavior();
		Owner = GetComponent<NAgent>();
	}

	public virtual void Show(bool show)
	{
		if (Renderer.enabled != show)
		{
			Renderer.enabled = show;
		}
	}

	public virtual void SetDefault(bool semivisible = false)
	{
		Renderer.material = DefaultMaterial;
	}

	public virtual void Fadeout(float timeOffs, float invert, float duration)
	{
	}

	public virtual bool Highlight(bool on)
	{
		return false;
	}

	public virtual void SetSemivisible(bool on)
	{
		if (isSemivisible != on)
		{
			isSemivisible = on;
		}
	}

	public virtual void DefaultStatus(bool isSemivisible)
	{
		SetDefault(isSemivisible);
	}

	public virtual void ToggleRimLight(bool on)
	{
	}
}
