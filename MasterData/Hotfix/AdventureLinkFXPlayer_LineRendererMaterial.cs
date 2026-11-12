using UnityEngine;

public class AdventureLinkFXPlayer_LineRendererMaterial : AdventureFXPlayer_Material
{
	public override void OnBind(GameObject owner)
	{
	}

	public void BindWithLinkFXPlayer(AdventureLinkFXPlayer linkPlayer)
	{
		if (linkPlayer.linkMode == AdventureLinkFXPlayer.LinkMode.Line && !(linkPlayer.lineRenderer == null))
		{
			if (!linkPlayer.lineRenderer.TryGetComponent<RendererMaterialStackComponent>(out _rendererMaterialStackComp))
			{
				_rendererMaterialStackComp = linkPlayer.lineRenderer.gameObject.AddComponent<RendererMaterialStackComponent>();
				_rendererMaterialStackComp.InitRendererMaterialStacks(includeInactive: false, includeMeshRenderer: false, includeSkinnedMeshRenderer: false, includeParticleSystemRenderer: false, includeLineRenderer: true);
			}
			if (_rendererMaterialStackComp != null)
			{
				_rendererMaterialStackList.AddRange(_rendererMaterialStackComp.rendererMaterialStacks);
			}
		}
	}

	public void PlayWithLinkFXPlayer(AdventureLinkFXPlayer linkPlayer)
	{
		if (linkPlayer.linkMode == AdventureLinkFXPlayer.LinkMode.Line && !(linkPlayer.lineRenderer == null) && materialFXDelay <= float.Epsilon)
		{
			Play_Internal();
		}
	}
}
