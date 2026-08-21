#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Video;

namespace Ase;

public class HeroSkillSkinWindow : UGuiWindow
{
	[SerializeField]
	private Button closeBtn;

	[SerializeField]
	private Image heroImg;

	[SerializeField]
	private TextMeshProUGUI heroName;

	[SerializeField]
	private LoopGridView skillList;

	[SerializeField]
	private LoopGridView skillSkinList;

	[SerializeField]
	private TextMeshProUGUI heroSkillDesc;

	[SerializeField]
	private GameObject activeRoot;

	[SerializeField]
	private Button showPropBtn;

	[SerializeField]
	private Button activeBtn;

	[SerializeField]
	private GameObject notClickObj;

	[SerializeField]
	private TextMeshProUGUI countTxt;

	[SerializeField]
	private TextMeshProUGUI btnTxt;

	[SerializeField]
	private Image propRarityImg;

	[SerializeField]
	private Image propImg;

	[SerializeField]
	private GameObject propNotEnough;

	[SerializeField]
	private GameObject changeRoot;

	[SerializeField]
	private Button changeBtn;

	[SerializeField]
	private GameObject nowRoot;

	[SerializeField]
	private Button playerBtn;

	[SerializeField]
	private Transform videoParent;

	[SerializeField]
	private RawImage videoDisplay;

	private RenderTexture renderTexture;

	private Vector2 videoSize;

	private GameObject videoPrefab;

	private VideoPlayer prefabVideoPlayer;

	private string currentVideoName;

	private bool playAfterPrepare;

	private const string HeroSkillCameraSkinVideoPrefabPath = "Assets/Art/UI/HeroSkillCameraSkinVideo/{0}.prefab";

	private HeroSkillSkinViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<HeroSkillSkinViewModel>();
		BindingSet<HeroSkillSkinWindow, HeroSkillSkinViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind().For((HeroSkillSkinWindow v) => v.OnDismissRequest).To((HeroSkillSkinViewModel vm) => vm.DismissRequest);
		bindingSet.Bind().For((HeroSkillSkinWindow v) => v.OpenUguiWindow).To((HeroSkillSkinViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind().For((HeroSkillSkinWindow v) => v.RefreshSkins).To((HeroSkillSkinViewModel vm) => vm.RefreshSkinsRst);
		bindingSet.Bind().For((HeroSkillSkinWindow v) => v.RefreshVideo).To((HeroSkillSkinViewModel vm) => vm.RefreshVideoRst);
		bindingSet.Bind(closeBtn).For((Button v) => v.onClick).To((HeroSkillSkinViewModel vm) => vm.Close);
		bindingSet.Bind(heroImg).For((Image v) => v.sprite).To((HeroSkillSkinViewModel vm) => vm.HeroImgPath)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(heroName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkillSkinViewModel vm) => vm.HeroName);
		bindingSet.Bind<TextMeshProUGUI>(heroSkillDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkillSkinViewModel vm) => vm.SkillDesc);
		bindingSet.Bind(propRarityImg).For((Image v) => v.sprite).ToExpression((HeroSkillSkinViewModel vm) => $"RarityBG_Middle_{vm.Rarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(propImg).For((Image v) => v.sprite).To((HeroSkillSkinViewModel vm) => vm.PropIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(activeRoot).For((GameObject v) => v.activeSelf).ToExpression((HeroSkillSkinViewModel vm) => (int)vm.CurSkin.State == 1);
		bindingSet.Bind(changeRoot).For((GameObject v) => v.activeSelf).ToExpression((HeroSkillSkinViewModel vm) => (int)vm.CurSkin.State == 2);
		bindingSet.Bind(nowRoot).For((GameObject v) => v.activeSelf).ToExpression((HeroSkillSkinViewModel vm) => (int)vm.CurSkin.State == 3);
		bindingSet.Bind(notClickObj).For((GameObject v) => v.activeSelf).ToExpression((HeroSkillSkinViewModel vm) => !vm.IsActive);
		bindingSet.Bind<TextMeshProUGUI>(countTxt).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkillSkinViewModel vm) => vm.CountTxt);
		bindingSet.Bind<TextMeshProUGUI>(btnTxt).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkillSkinViewModel vm) => vm.BtnTxt);
		bindingSet.Bind(showPropBtn).For((Button v) => v.onClick).To((HeroSkillSkinViewModel vm) => vm.OnOpenPropCmd);
		bindingSet.Bind(activeBtn).For((Button v) => v.onClick).To((HeroSkillSkinViewModel vm) => vm.ActiveSkinCmd);
		bindingSet.Bind(changeBtn).For((Button v) => v.onClick).To((HeroSkillSkinViewModel vm) => vm.ChangeSkinCmd);
		bindingSet.Bind(propNotEnough).For((GameObject v) => v.activeSelf).ToExpression((HeroSkillSkinViewModel vm) => !vm.PropNotEnough);
		bindingSet.Build();
		skillList.InitGridView(viewModel.Skills.Count, OnGetItemByIndex1);
		skillSkinList.InitGridView(viewModel.Skins.Count, OnGetItemByIndex2);
		playerBtn.onClick.AddListener(PlayerHeroSkill);
		playerBtn.gameObject.SetActive(value: false);
		videoDisplay.texture = null;
		RefreshVideo();
	}

	protected override void OnShow()
	{
		base.OnShow();
		playAfterPrepare = true;
		RefreshVideo();
	}

	private void RefreshSkins(object sender, InteractionEventArgs e)
	{
		skillSkinList.SetListItemCount(viewModel.Skins.Count);
		skillSkinList.RefreshAllShownItem();
	}

	private LoopGridViewItem OnGetItemByIndex2(LoopGridView view, int arg2, int arg3, int arg4)
	{
		List<HeroSkillSkinItemData> skins = viewModel.Skins;
		if (arg2 < 0 || arg2 >= skins.Count)
		{
			return null;
		}
		HeroSkillSkinItemData heroSkillSkinItemData = skins[arg2];
		if (heroSkillSkinItemData == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = skillSkinList.NewListViewItem("skillSkinItem");
		HeroSkillSkinItem component = loopGridViewItem.GetComponent<HeroSkillSkinItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(heroSkillSkinItemData);
		}
		else
		{
			component.RefreshData(heroSkillSkinItemData);
		}
		return loopGridViewItem;
	}

	private LoopGridViewItem OnGetItemByIndex1(LoopGridView view, int arg2, int arg3, int arg4)
	{
		List<HeroSkillItemData> skills = viewModel.Skills;
		if (arg2 < 0 || arg2 >= skills.Count)
		{
			return null;
		}
		HeroSkillItemData heroSkillItemData = skills[arg2];
		if (heroSkillItemData == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = skillList.NewListViewItem("skillItem");
		HeroSkillItem component = loopGridViewItem.GetComponent<HeroSkillItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(heroSkillItemData);
		}
		else
		{
			component.RefreshData(heroSkillItemData);
		}
		return loopGridViewItem;
	}

	private async void RefreshVideo(object sender = null, InteractionEventArgs e = null)
	{
		string videoName = viewModel?.SkinVideoPath;
		StopVideo();
		UnloadVideoPrefab();
		if (string.IsNullOrEmpty(videoName))
		{
			playerBtn.gameObject.SetActive(value: false);
			return;
		}
		GameObject gameObject = await InstantiateAsync(GetHeroSkillCameraSkinVideoPrefab(videoName), videoParent);
		if (gameObject == null)
		{
			playerBtn.gameObject.SetActive(value: false);
			return;
		}
		if (this == null)
		{
			UnityEngine.Object.Destroy(gameObject);
			return;
		}
		videoPrefab = gameObject;
		videoPrefab.SetActive(value: true);
		currentVideoName = videoName;
		prefabVideoPlayer = videoPrefab.GetComponentInChildren<VideoPlayer>(includeInactive: true);
		if ((UnityEngine.Object)(object)prefabVideoPlayer == null)
		{
			Log.Error("加载的prefab中没有VideoPlayer组件 prefabName = " + videoName);
			playerBtn.gameObject.SetActive(value: false);
			return;
		}
		prefabVideoPlayer.renderMode = (VideoRenderMode)2;
		prefabVideoPlayer.prepareCompleted += new EventHandler(OnVideoPrepared);
		prefabVideoPlayer.loopPointReached += new EventHandler(OnVideoFinished);
		prefabVideoPlayer.errorReceived += new ErrorEventHandler(OnVideoError);
		playerBtn.gameObject.SetActive(value: true);
		prefabVideoPlayer.Prepare();
	}

	private void PlayerHeroSkill()
	{
		if (!((UnityEngine.Object)(object)prefabVideoPlayer == null))
		{
			playerBtn.gameObject.SetActive(value: false);
			if (prefabVideoPlayer.isPrepared)
			{
				prefabVideoPlayer.frame = 0L;
				prefabVideoPlayer.Play();
			}
			else
			{
				playAfterPrepare = true;
				prefabVideoPlayer.Prepare();
			}
		}
	}

	private async void OnVideoPrepared(VideoPlayer source)
	{
		int num = Mathf.Max(1, (int)source.width);
		int num2 = Mathf.Max(1, (int)source.height);
		if (renderTexture == null || videoSize.x != (float)num || videoSize.y != (float)num2)
		{
			ReleaseRenderTexture();
			videoSize = new Vector2(num, num2);
			renderTexture = new RenderTexture(num, num2, 0, RenderTextureFormat.ARGB32);
			renderTexture.Create();
		}
		source.targetTexture = renderTexture;
		videoDisplay.texture = renderTexture;
		if (playAfterPrepare)
		{
			playAfterPrepare = false;
			source.frame = 0L;
			source.Play();
			return;
		}
		source.Play();
		await UniTask.WaitUntil(() => source.frame > 0 || source.texture != null);
		source.Pause();
		source.frame = 0L;
		playerBtn.gameObject.SetActive(value: true);
	}

	private void OnVideoFinished(VideoPlayer source)
	{
		playAfterPrepare = false;
		source.Stop();
		playerBtn.gameObject.SetActive(value: true);
	}

	private void OnVideoError(VideoPlayer source, string message)
	{
		Log.Error("HeroSkillSkinWindow播放错误: " + message);
		playAfterPrepare = false;
		playerBtn.gameObject.SetActive(value: true);
	}

	private void StopVideo()
	{
		playAfterPrepare = false;
		if ((UnityEngine.Object)(object)prefabVideoPlayer != null)
		{
			prefabVideoPlayer.Stop();
		}
		playerBtn.gameObject.SetActive(value: false);
	}

	private void UnloadVideoPrefab()
	{
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0025: Expected O, but got Unknown
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		//IL_003c: Expected O, but got Unknown
		//IL_0049: Unknown result type (might be due to invalid IL or missing references)
		//IL_0053: Expected O, but got Unknown
		if ((UnityEngine.Object)(object)prefabVideoPlayer != null)
		{
			prefabVideoPlayer.prepareCompleted -= new EventHandler(OnVideoPrepared);
			prefabVideoPlayer.loopPointReached -= new EventHandler(OnVideoFinished);
			prefabVideoPlayer.errorReceived -= new ErrorEventHandler(OnVideoError);
			prefabVideoPlayer.targetTexture = null;
			prefabVideoPlayer = null;
		}
		if (videoPrefab != null)
		{
			videoPrefab.SetActive(value: false);
			UnityEngine.Object.Destroy(videoPrefab);
			videoPrefab = null;
		}
		if (!string.IsNullOrEmpty(currentVideoName))
		{
			GameEntry.Resource.UnloadAsset(GetHeroSkillCameraSkinVideoPrefab(currentVideoName));
			currentVideoName = null;
		}
		videoDisplay.texture = null;
		ReleaseRenderTexture();
	}

	private void ReleaseRenderTexture()
	{
		if (renderTexture != null)
		{
			renderTexture.Release();
			UnityEngine.Object.Destroy(renderTexture);
			renderTexture = null;
		}
		videoSize = Vector2.zero;
	}

	private static string GetHeroSkillCameraSkinVideoPrefab(string assetPath)
	{
		return Utility.Text.Format("Assets/Art/UI/HeroSkillCameraSkinVideo/{0}.prefab", assetPath);
	}

	protected override void OnDestroy()
	{
		StopVideo();
		UnloadVideoPrefab();
		base.OnDestroy();
	}
}
