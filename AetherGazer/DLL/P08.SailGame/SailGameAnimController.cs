using System.Collections.Generic;
using Spine;
using Spine.Unity;
using UnityEngine;

public class SailGameAnimController : MonoBehaviour
{
	[Header("循环移动背景")]
	public LoopBgSprite loopBgSprite;

	[Header("角色")]
	public Transform shipTrans;

	public SkeletonAnimation roleSpine;

	private AnimationState.TrackEntryDelegate roleAnimCompleteHandler;

	[Header("进度条")]
	public Transform progressBgBgTrans;

	public Transform progressTrans;

	private SpriteRenderer progressRenderer;

	public Transform pointerTrans;

	private float barBgWidth;

	private float halfBgWidth;

	public GameObject markGo;

	private List<GameObject> markItemPool = new List<GameObject>();

	[Header("音效")]
	public string sheetName = "minigame_activity_2_2_summer_sea";

	public string cueName = "minigame_activity_2_2_summer_sea_loop";

	private CriAtomExPlayback audioPlayback;

	private float originOrthograpgicSize;

	public void Initialize()
	{
		roleAnimCompleteHandler = delegate
		{
			roleSpine.AnimationState.SetAnimation(0, "idle", loop: false);
		};
		roleSpine.AnimationState.Complete += roleAnimCompleteHandler;
		AdaptScreen();
	}

	public void GameStart()
	{
		loopBgSprite.StartMove();
		audioPlayback = AudioManager.Instance.Play("effect", sheetName, cueName, useStream: false);
	}

	public void ShutDown()
	{
		roleSpine.AnimationState.Complete -= roleAnimCompleteHandler;
		Camera.main.orthographicSize = originOrthograpgicSize;
		audioPlayback.Stop();
	}

	public void PlayRoleEventAnim()
	{
		roleSpine.AnimationState.SetAnimation(0, "Happy", loop: false);
	}

	public void TriggerEvent(int stageIndex, float percent)
	{
		PlayRoleEventAnim();
		SetMark(stageIndex, percent);
	}

	public void SetPause(bool value)
	{
		if (value)
		{
			loopBgSprite.PuaseMove();
			audioPlayback.Pause();
		}
		else
		{
			loopBgSprite.ResumeMove();
			audioPlayback.Resume(CriAtomEx.ResumeMode.PausedPlayback);
		}
	}

	public void UpdateProgress(float percent)
	{
		float num = barBgWidth * percent;
		Vector3 localPosition = pointerTrans.localPosition;
		localPosition.x = num - halfBgWidth;
		pointerTrans.localPosition = localPosition;
		progressRenderer.size = new Vector2(num, progressRenderer.size.y);
		localPosition = progressTrans.localPosition;
		localPosition.x = num / 2f - halfBgWidth;
		progressTrans.localPosition = localPosition;
	}

	public void InitMark(int curStageIndex, List<int> eventTimeList, float maxTime)
	{
		for (int i = 0; i < curStageIndex; i++)
		{
			if (i < eventTimeList.Count)
			{
				SetMark(i, (float)eventTimeList[i] / maxTime);
			}
		}
	}

	private void SetMark(int stageIndex, float percent)
	{
		GameObject gameObject = null;
		float x = barBgWidth * percent - halfBgWidth;
		if (stageIndex >= markItemPool.Count)
		{
			gameObject = Object.Instantiate(markGo, progressBgBgTrans);
			markItemPool.Add(gameObject);
		}
		else
		{
			gameObject = markItemPool[stageIndex];
		}
		Vector3 localPosition = gameObject.transform.localPosition;
		gameObject.transform.localPosition = new Vector3(x, localPosition.y, localPosition.z);
		gameObject.SetActive(value: true);
	}

	private void AdaptScreen()
	{
		RectTransform component = GameObject.Find("SailGamePanel").GetComponent<RectTransform>();
		component.localScale = new Vector3(1f, 1f, 1f);
		float x = component.sizeDelta.x;
		float y = component.sizeDelta.y;
		Camera main = Camera.main;
		float num = main.orthographicSize * 2f;
		float a = num / (float)Screen.height * (float)Screen.width / x;
		float b = num / y;
		float num2 = Mathf.Min(a, b);
		originOrthograpgicSize = main.orthographicSize;
		float num3 = (main.orthographicSize = originOrthograpgicSize / num2);
		float num5 = num3 * 2f;
		float num6 = num5 / (float)Screen.height * (float)Screen.width;
		progressRenderer = progressTrans.GetComponent<SpriteRenderer>();
		SpriteRenderer component2 = progressBgBgTrans.GetComponent<SpriteRenderer>();
		barBgWidth = component2.size.x;
		float num7 = x - num6;
		barBgWidth -= num7;
		component2.size = new Vector2(barBgWidth, component2.size.y);
		halfBgWidth = barBgWidth / 2f;
		float num8 = (y - num5) / 2f;
		Vector3 position = progressBgBgTrans.position;
		position.y += num8;
		progressBgBgTrans.position = position;
		float a2 = num6 / x;
		float b2 = num5 / y;
		float num9 = Mathf.Min(a2, b2);
		shipTrans.localScale = new Vector3(num9, num9, 1f);
	}
}
