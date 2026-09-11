using UnityEngine;

[AddComponentMenu("CRIWARE/CriManaMovieController")]
public class CriManaMovieController : CriManaMovieMaterial
{
	public Renderer target;

	public bool useOriginalMaterial;

	private Material originalMaterial;

	public override void CriInternalUpdate()
	{
		base.CriInternalUpdate();
		if (renderMode == RenderMode.OnVisibility && !base.HaveRendererOwner && target != null && target.isVisible)
		{
			base.player.OnWillRenderObject(this);
		}
	}

	public override bool RenderTargetManualSetup()
	{
		if (target == null)
		{
			target = base.gameObject.GetComponent<Renderer>();
		}
		if (target == null)
		{
			Debug.LogError("[CRIWARE] Missing render target for the Mana Controller component: Please add a renderer to the GameObject or specify the target manually.");
			return false;
		}
		originalMaterial = target.sharedMaterial;
		if (!useOriginalMaterial)
		{
			target.enabled = false;
		}
		return true;
	}

	public override void RenderTargetManualFinalize()
	{
		if (target != null)
		{
			target.material = originalMaterial;
			if (!useOriginalMaterial)
			{
				target.enabled = false;
			}
		}
		originalMaterial = null;
	}

	protected override void OnMaterialAvailableChanged()
	{
		if (target == null)
		{
			return;
		}
		if (base.isMaterialAvailable)
		{
			target.material = base.material;
			target.enabled = true;
			return;
		}
		target.material = originalMaterial;
		if (!useOriginalMaterial)
		{
			target.enabled = false;
		}
	}
}
