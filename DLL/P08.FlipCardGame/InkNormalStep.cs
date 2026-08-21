using UnityEngine;
using UnityEngine.UI;

public class InkNormalStep : MainStepBase
{
	[Header("图片资源")]
	public RawImage inkImage;

	public RawImage finalImage;

	[Header("游戏参数")]
	public float requiredEraseRatio = 0.7f;

	public float guideTime = 8f;

	[Header("引导元素")]
	public GameObject guideHand;

	public string guideText;

	public float imgKeepTime = 2f;

	private InkCoverNormalGameManager manager;

	public void Start()
	{
		manager = GetComponent<InkCoverNormalGameManager>();
		manager.Initialize();
	}

	private void Update()
	{
		manager.Update();
	}

	public override bool IsStepCompleted()
	{
		if (!manager)
		{
			return false;
		}
		return manager.IsCompleted();
	}

	public override CookingGameConst.ProgressData GetProgress()
	{
		return new CookingGameConst.ProgressData(config.stepDescription, IsStepCompleted() ? 1 : 0, 1);
	}
}
