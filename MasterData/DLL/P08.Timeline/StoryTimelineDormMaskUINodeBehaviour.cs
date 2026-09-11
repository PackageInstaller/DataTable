using Dorm;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.UI;

public class StoryTimelineDormMaskUINodeBehaviour : PlayableBehaviour
{
	public string ui_path;

	public Gradient color_grad;

	private GameObject ui_go;

	private Image mask_img;

	private bool isRunning;

	public void SetWeight(float weight)
	{
		if (isRunning && weight == 0f)
		{
			isRunning = false;
			Exit();
		}
		if (!isRunning && weight == 1f)
		{
			isRunning = true;
			Enter();
		}
	}

	private void Enter()
	{
	}

	private void Exit()
	{
		if (ui_go != null)
		{
			DormStoryManager.instance.DestroyGo(ui_go);
		}
	}

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		SetUIContent();
	}

	public override void OnGraphStop(Playable playable)
	{
		Exit();
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (!(mask_img == null))
		{
			float num = (float)playable.GetTime();
			float num2 = (float)playable.GetDuration();
			Color color = color_grad.Evaluate(num / num2);
			mask_img.color = color;
		}
	}

	private void SetUIContent()
	{
		GetUIGameObject();
	}

	private void GetUIGameObject()
	{
		if (!(ui_go == null))
		{
			return;
		}
		GameObject gameObject = GameObject.Find("UICamera/Canvas/UIStory/Canvas");
		if (!(gameObject == null))
		{
			GameObject gameObject2 = Asset.InstantiateWithoutCache(ui_path);
			if (!(gameObject2 == null))
			{
				gameObject2.transform.SetParent(gameObject.transform, worldPositionStays: false);
				gameObject2.transform.SetSiblingIndex(-1);
				ui_go = gameObject2;
				mask_img = ui_go.transform.Find("mask").gameObject.GetComponent<Image>();
				Color color = color_grad.Evaluate(0f);
				mask_img.color = color;
			}
		}
	}
}
