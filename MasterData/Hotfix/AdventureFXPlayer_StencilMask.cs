using Game.Graphics.AutoStencilMask;
using UnityEngine;

public class AdventureFXPlayer_StencilMask : AdventureFXPlayer_Component
{
	public string ownerMaskName;

	public AutoStencilMaskHandler.MaskInteractionType ownerMaskInteraction = AutoStencilMaskHandler.MaskInteractionType.VisibleOutsideMask;

	private AutoStencilCullByHandler _ownerStencilCullByHandler;

	public override void Release()
	{
		_ownerStencilCullByHandler = null;
	}

	public override void OnBind(GameObject owner)
	{
		if (string.IsNullOrEmpty(ownerMaskName))
		{
			return;
		}
		if (!owner.TryGetComponent<AutoStencilCullByHandler>(out _ownerStencilCullByHandler))
		{
			_ownerStencilCullByHandler = owner.AddComponent<AutoStencilCullByHandler>();
			_ownerStencilCullByHandler.enabled = false;
			if (owner.TryGetComponent<AutoStencilMaskListener>(out var component))
			{
				_ownerStencilCullByHandler.listener = component;
			}
		}
		_ownerStencilCullByHandler.maskName = ownerMaskName;
		_ownerStencilCullByHandler.maskInteraction = ownerMaskInteraction;
		_ownerStencilCullByHandler.enabled = true;
	}

	public override void Stop()
	{
		if (_ownerStencilCullByHandler != null)
		{
			_ownerStencilCullByHandler.enabled = false;
		}
	}
}
