using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

public class StirProgressItem : MonoBehaviour
{
	private StirGameManager manager;

	private StirStep config;

	public Image progressImage;

	public ControllerExCollection progressControllerEx;

	private ControllerEx progressColorController;

	public Animator progressAnimator;

	public RectTransform greenFxTrans;

	private float greenProgressWidth;

	private int playingAnimCount;

	public bool isBlocking => playingAnimCount > 0;

	public void Init(StirGameManager manager, StirStep config)
	{
		this.manager = manager;
		this.config = config;
		progressColorController = progressControllerEx.GetController("processColor");
		RectTransform rectTransform = greenFxTrans.parent as RectTransform;
		greenProgressWidth = rectTransform.sizeDelta.x;
	}

	public void InitGame()
	{
		progressColorController.SetSelectedState("green");
		progressImage.fillAmount = 0f;
		greenFxTrans.anchoredPosition = Vector2.zero;
		greenFxTrans.SetActive(bActive: false);
		playingAnimCount = 0;
	}

	public void UpdateRender()
	{
		RenderProgress();
	}

	public void RenderProgress()
	{
		float num = manager.currentProgress / config.maxNumOfProgression;
		progressImage.fillAmount = num;
		float x = greenProgressWidth * num;
		greenFxTrans.anchoredPosition = new Vector2(x, 0f);
		if (manager.currentProgress > 0f)
		{
			greenFxTrans.SetActive(bActive: true);
		}
		if (manager.currentProgress >= config.maxNumOfProgression)
		{
			PlayFinishAnim();
		}
	}

	public void PlayFinishAnim()
	{
		progressAnimator.SetActive(bActive: true);
		progressAnimator.enabled = true;
		progressAnimator.Play("finishi", 0, 0f);
		progressAnimator.Update(0f);
	}
}
