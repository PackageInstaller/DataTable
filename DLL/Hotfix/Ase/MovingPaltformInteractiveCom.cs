using UnityEngine;

namespace Ase;

public class MovingPaltformInteractiveCom : InteractiveMonoCom
{
	[SerializeField]
	private int index;

	[SerializeField]
	private IMovingPlatformInteractive movingPlatformInteractive;

	[SerializeField]
	private string interactiveName = "机械开关";

	[SerializeField]
	private float interactiveTime = 1f;

	private void Start()
	{
		ActiveInteractive(interactiveName, interactiveTime);
	}

	public override void InteractiveFinishCallback(int obj)
	{
		base.InteractiveFinishCallback(obj);
		movingPlatformInteractive.InteractiveFinish(index);
	}

	public void Init(int index, IMovingPlatformInteractive movingPlatformInteractive)
	{
		this.index = index;
		this.movingPlatformInteractive = movingPlatformInteractive;
	}

	public void SetCanInteractive(bool active)
	{
		((Component)(object)this).transform.localScale = (active ? Vector3.one : Vector3.zero);
	}
}
