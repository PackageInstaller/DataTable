using UnityEngine;
using UnityEngine.UI;

[AddComponentMenu("CRIWARE/CriManaMovieControllerForUI")]
public class CriManaMovieControllerForUI : CriManaMovieMaterial
{
	public Graphic target;

	public bool useOriginalMaterial;

	private Material originalMaterial;

	protected override void Awake()
	{
		base.uiRenderMode = true;
		base.Awake();
	}

	public override void CriInternalUpdate()
	{
		base.CriInternalUpdate();
		if (renderMode == RenderMode.OnVisibility && !base.HaveRendererOwner && target != null && target.IsActive())
		{
			base.player.OnWillRenderObject(this);
		}
	}

	public override bool RenderTargetManualSetup()
	{
		if (target == null)
		{
			target = base.gameObject.GetComponent<Graphic>();
		}
		if (target == null)
		{
			Debug.LogError("[CRIWARE] Missing render target for the Mana Controller component: Please add a renderer to the GameObject or specify the target manually.");
			return false;
		}
		originalMaterial = target.materialForRendering;
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
