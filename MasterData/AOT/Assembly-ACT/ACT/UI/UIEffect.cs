using UnityEngine;

namespace ACT.UI;

public class UIEffect : MonoBehaviour
{
	private UIEffectPool myPool;

	public bool IsUsed { get; set; }

	public int UsedTimes { get; set; }

	public void Init(UIEffectPool uiEffectPool)
	{
		myPool = uiEffectPool;
		IsUsed = true;
		UsedTimes = 1;
		OnInit();
	}

	public virtual void OnInit()
	{
	}

	public virtual void Play()
	{
		gameObject.SetActive(value: true);
	}

	public virtual void End()
	{
		gameObject.SetActive(value: false);
		myPool.Recycle(this);
	}

	public virtual void Stop()
	{
	}
}
