using ACT.Event;
using ACT.Utility;
using Bamboo.NumberString;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class MissionArrowUAV : MissionArrow
{
	[Header("UAV")]
	[SerializeReference]
	private TMP_Text progressText;

	[SerializeReference]
	private Image progressImage;

	[SerializeReference]
	private Image progressImageRed;

	[SerializeReference]
	private GameObject lineLeft;

	[SerializeReference]
	private GameObject lineRight;

	private bool isPlayingAnim;

	protected override Vector3 InScreenOffset => new Vector3(_inScreenLeft ? 205 : (-205), 60f);

	private void OnEnable()
	{
		RefreshArrowState(gameObject.activeSelf);
	}

	private void OnDisable()
	{
	}

	public void UnShow()
	{
		RefreshArrowState(show: false);
	}

	private void RefreshArrowState(bool show)
	{
		if (show)
		{
			animation.GetSequence("Show").Play().OnComplete((AnimationBuilder _) =>
			{
				gameObject.SetActive(value: true);
			})
				.Play();
		}
		else
		{
			gameObject.SetActive(value: false);
		}
	}

	private async UniTask ShowCoroutine(bool show)
	{
		await UniTask.WaitUntil(() => !isPlayingAnim);
		AnimationBuilder seq = animation.GetSequence(show ? "Show" : "Hide").Play();
		isPlayingAnim = true;
		await UniTask.Delay(500);
		await UniTask.WaitUntil(() => seq.IsComplete());
		isPlayingAnim = false;
		if (!show)
		{
			gameObject.SetActive(value: false);
		}
	}

	public override void Init(int missionType)
	{
		base.Init(missionType);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.ChaseMission_ProgressChange, OnProgressChange);
		progressImage.fillAmount = 0f;
		progressImageRed.fillAmount = 0f;
		progressText.SetText(Mathf.FloorToInt(0f).FastToString());
		RefreshArrowState(show: true);
	}

	public override void UnInit()
	{
		base.UnInit();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ChaseMission_ProgressChange, OnProgressChange);
		RefreshArrowState(show: false);
	}

	private void OnProgressChange(BaseEventContent eventContent)
	{
		if (eventContent is ChaseMissionProgressChangeEvt chaseMissionProgressChangeEvt)
		{
			progressImageRed.gameObject.SetActive(chaseMissionProgressChangeEvt.isDanger);
			progressImage.gameObject.SetActive(!chaseMissionProgressChangeEvt.isDanger);
			if (chaseMissionProgressChangeEvt.isDanger)
			{
				progressImageRed.fillAmount = chaseMissionProgressChangeEvt.curProgress;
			}
			else
			{
				progressImage.fillAmount = chaseMissionProgressChangeEvt.curProgress;
			}
			if (chaseMissionProgressChangeEvt.ToFull)
			{
				PlayCoroutine("Full").Forget();
			}
			if (chaseMissionProgressChangeEvt.ToZero)
			{
				PlayCoroutine("Failed").Forget();
			}
		}
	}

	private async UniTask PlayCoroutine(string anim)
	{
		await UniTask.WaitUntil(() => !isPlayingAnim);
		AnimationBuilder seq = animation.GetSequence(anim).Play();
		isPlayingAnim = true;
		await UniTask.WaitUntil(() => seq.IsComplete());
		isPlayingAnim = false;
	}

	protected override void SetInScreenImply(bool inScreen)
	{
		base.SetInScreenImply(inScreen);
		if (!inScreen)
		{
			lineLeft.SetActive(value: false);
			lineRight.SetActive(value: false);
		}
	}

	public override void SetInScreenLeft(bool inScreenLeft)
	{
		base.SetInScreenLeft(inScreenLeft);
		lineLeft.SetActive(_inScreen & inScreenLeft);
		lineRight.SetActive(_inScreen && !inScreenLeft);
	}

	public override void SetPosInScreen(Vector3 missionPointWorldPos)
	{
		Camera uiCamera = GameUtility.uiCamera;
		Vector3 vector = GameUtility.mainCamera.WorldToScreenPoint(missionPointWorldPos);
		Vector3 normalized = (uiCamera.ScreenToWorldPoint(vector + InScreenOffset) - uiCamera.gameObject.transform.position).normalized;
		Vector3 b = 100f / normalized.z * normalized;
		transform.position = Vector3.Lerp(transform.position, b, Time.deltaTime * 10f);
	}
}
