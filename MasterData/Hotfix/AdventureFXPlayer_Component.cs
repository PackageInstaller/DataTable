using UnityEngine;

public abstract class AdventureFXPlayer_Component : MonoBehaviour
{
	public enum ComponentType
	{
		[InspectorName("无")]
		None = 0,
		[InspectorName("残影特效")]
		AfterImage = 5,
		[InspectorName("材质特效")]
		Material = 6,
		[InspectorName("后期特效")]
		PostProcess = 7,
		[InspectorName("震动")]
		ImpulseSource = 8,
		[InspectorName("蒙版")]
		StencilMask = 9
	}

	protected AdventureFXPlayer _fxPlayer;

	public virtual bool isLoop => false;

	public virtual bool isStoped => true;

	public virtual void Initialize(AdventureFXPlayer fxPlayer)
	{
		_fxPlayer = fxPlayer;
	}

	public virtual void Release()
	{
	}

	public virtual void Play()
	{
	}

	public virtual void Stop()
	{
	}

	public virtual void Pause()
	{
	}

	public virtual void Resume()
	{
	}

	public virtual void UpdatePlayback(float dt)
	{
	}

	public virtual void PlayInRemain()
	{
	}

	public virtual void UpdatePlaybackInRemain(float dt)
	{
	}

	public virtual void OnBind(GameObject owner)
	{
	}

	public virtual void OnUpdatePlaybackSpeed(float playbackSpeed, float timeScale)
	{
	}

	public virtual void OnHide()
	{
	}

	public virtual void OnVisible()
	{
	}

	public virtual void OnIndependentUpdateChanged(bool value)
	{
	}
}
