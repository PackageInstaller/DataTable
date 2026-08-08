using System;

public abstract class ComponentRootRenderer : ComponentRenderer
{
	protected virtual bool IsFading
	{
		get
		{
			throw new NotImplementedException();
		}
	}

	public override void ActiveBehavior()
	{
		base.ActiveBehavior();
	}

	public override void Fadeout(float timeOffs, float invert, float duration)
	{
		Highlight(on: false);
		base.Fadeout(timeOffs, invert, duration);
	}

	public override void SetSemivisible(bool on)
	{
		if (base.isSemivisible != on && !(base.Renderer == null))
		{
			if (on)
			{
				Highlight(on: false);
			}
			base.SetSemivisible(on);
		}
	}

	public override bool Highlight(bool on)
	{
		if (on && base.Owner.IsAlive)
		{
			if (IsFading)
			{
				return false;
			}
			if (base.Renderer.material.shader == DefaultMaterial.shader)
			{
				return true;
			}
		}
		return false;
	}
}
