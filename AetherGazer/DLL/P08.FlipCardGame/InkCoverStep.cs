using UnityEngine;
using UnityEngine.UI;

public class InkCoverStep : PopStepBase
{
	[Header("图片资源")]
	public RawImage inkImage;

	[Header("游戏参数")]
	public float requiredEraseRatio = 0.7f;

	public float guideTime = 8f;

	[Header("引导元素")]
	public GameObject guideHand;

	public string guideText;

	private InkCoverGameManager manager;

	public override void Start()
	{
		base.Start();
		manager = GetComponent<InkCoverGameManager>();
		manager.Initialize();
	}

	private void Update()
	{
		manager.Update();
	}

	public override bool IsStepCompleted()
	{
		return manager.IsCompleted();
	}

	public override float GetProgress()
	{
		return manager.GetCurrentProgress();
	}
}
