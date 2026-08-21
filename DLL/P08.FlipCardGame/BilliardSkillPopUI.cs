using BilliardGame;
using BilliardGame.Runtime;
using UnityEngine;
using UnityEngine.UI;

public class BilliardSkillPopUI : MonoBehaviour
{
	private static string AvatarBasePath = "TextureConfig/Activity_SummerPub/BilliardGame/{0}";

	private static string enterAnim = "UI_BilliardGame_SkillPop_cx";

	private static string exitAnim = "UI_BilliardGame_SkillPop_xs";

	public SelfAdaptImage avatarImg;

	public Animator animator;

	public Text nameTxt;

	public float time;

	public float camTime = 0.6f;

	private int timerID;

	private int camTimerID;

	private void Start()
	{
		if (null == animator)
		{
			animator = GetComponent<Animator>();
		}
	}

	public void SetName(string name)
	{
		nameTxt.text = name;
	}

	public void SetAvatar(string avatar)
	{
		string spritePath = string.Format(AvatarBasePath, avatar);
		AtlasManager.GetSpriteWithoutAtlas(avatarImg, spritePath);
		avatarImg.AdaptImg();
	}

	public void PlaySkillPop(int playerID, int idx)
	{
		BilliardCharacterConfig playerCfg = BilliardGameDataManager.GetPlayerCfg(playerID);
		SetAvatar(playerCfg.hero_skill_image);
		base.gameObject.SetActive(value: true);
		animator.Play(enterAnim, 0, 0f);
		Transform playerTransByPos = BilliardGameLogicManager.Instance.GetPlayerTransByPos(idx);
		BilliardGameLogicManager.Instance.FollowCamera.Follow = playerTransByPos;
		BilliardGameLogicManager.Instance.FollowCamera.SetActive(bActive: true);
		BilliardGameUIManager.Instance.ShowUI(isShow: false);
		if (timerID != -1)
		{
			FuncTimerManager.inst.RemoveFuncTimer(timerID);
			timerID = -1;
		}
		if (camTimerID != -1)
		{
			FuncTimerManager.inst.RemoveFuncTimer(camTimerID);
			camTimerID = -1;
		}
		camTimerID = FuncTimerManager.inst.CreateFuncTimer(delegate
		{
			BilliardGameLogicManager.Instance.FollowCamera.SetActive(bActive: false);
			BilliardGameLogicManager.Instance.FollowCamera.Follow = null;
			camTimerID = -1;
		}, camTime, 1);
		timerID = FuncTimerManager.inst.CreateFuncTimer(delegate
		{
			base.gameObject.SetActive(value: false);
			timerID = -1;
			BilliardGameUIManager.Instance.ShowUI(isShow: true);
		}, time, 1);
	}

	public void OnDispose()
	{
		if (timerID != -1)
		{
			FuncTimerManager.inst.RemoveFuncTimer(timerID);
			timerID = -1;
		}
		if (camTimerID != -1)
		{
			FuncTimerManager.inst.RemoveFuncTimer(camTimerID);
			camTimerID = -1;
		}
	}
}
