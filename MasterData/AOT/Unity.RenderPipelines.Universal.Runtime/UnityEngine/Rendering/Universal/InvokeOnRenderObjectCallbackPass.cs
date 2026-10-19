namespace UnityEngine.Rendering.Universal;

internal class InvokeOnRenderObjectCallbackPass : ScriptableRenderPass
{
	public InvokeOnRenderObjectCallbackPass(RenderPassEvent evt)
	{
		profilingSampler = new ProfilingSampler("InvokeOnRenderObjectCallbackPass");
		renderPassEvent = evt;
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		context.InvokeOnRenderObjectCallback();
	}
}
