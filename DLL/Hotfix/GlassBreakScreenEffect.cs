using UnityEngine;

public class GlassBreakScreenEffect : MonoBehaviour
{
	private bool _capture;

	public RenderTexture renderTexture;

	private void OnRenderObject()
	{
		if (_capture)
		{
			CaptureScreenToRenderTexture();
			_capture = false;
		}
	}

	public void CaptureScreenToRenderTexture()
	{
		RenderTexture active = RenderTexture.active;
		RenderTexture.active = renderTexture;
		Graphics.Blit(active, renderTexture);
		RenderTexture.active = active;
	}

	public void StartCapture()
	{
		_capture = true;
	}
}
