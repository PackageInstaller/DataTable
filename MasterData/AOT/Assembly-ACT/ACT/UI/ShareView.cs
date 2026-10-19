using System;
using System.Collections.Generic;
using System.IO;
using System.Threading;
using ACT.Battle;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;
using bamboosdk;

namespace ACT.UI;

public class ShareView : BaseUIView<ShareViewInputController>
{
	public enum SharePlatform
	{
		QQ,
		QQZone,
		Tiktok,
		Wechat,
		WechatMoments,
		Weibo,
		Bilibili,
		RedNote,
		TapTap
	}

	[Serializable]
	public class ShareButtonEntry
	{
		public ActButton Button;

		public SharePlatform Platform;
	}

	private const string ShareModName = "share_platform";

	private const string SaveImageModName = "save_image";

	private const string PcScreenshotDirectoryName = "Screenshot";

	private const float ReferenceScreenshotWidth = 2340f;

	private const float ReferenceScreenshotHeight = 1080f;

	private const float ReferenceScreenshotFrameWidth = 1354f;

	private const float PanelHorizontalPadding = 10f;

	private const int GameRootLocalizationId = 2802;

	private const int SaveImageLocalizationId = 2803;

	private const int ImageSavedLocalizationId = 2804;

	private const int OtherMedia = 10;

	[Header("截图分享区域")]
	public RectTransform Panel;

	public Image Screenshot;

	[Header("按钮组")]
	public RectTransform ButtonContainer;

	public GameObject ButtonBar;

	public ShareButtonEntry[] Buttons;

	public ActButton BtnSaveLocal;

	[Header("水印相关")]
	public Image LuminLogo;

	public ActButton BtnWaterMarkOn;

	public ActButton BtnWaterMarkOff;

	[Header("其他信息展示")]
	public TextMeshProUGUI TxtPlayerName;

	public TextMeshProUGUI TxtPlayerUidHeader;

	public TextMeshProUGUI TxtPlayerUid;

	public TextMeshProUGUI TxtDate;

	public GamePadTipsComp gamePadGroup;

	public ViewControlLayer viewControlLayer;

	private readonly Dictionary<SharePlatform, string> _platformSDKIdMapping = new Dictionary<SharePlatform, string>
	{
		{
			SharePlatform.QQ,
			"qq"
		},
		{
			SharePlatform.QQZone,
			"qzone"
		},
		{
			SharePlatform.Tiktok,
			"douyin"
		},
		{
			SharePlatform.Wechat,
			"wechat_session"
		},
		{
			SharePlatform.WechatMoments,
			"wechat_timeline"
		},
		{
			SharePlatform.Weibo,
			"weibo"
		},
		{
			SharePlatform.Bilibili,
			"bilibili"
		},
		{
			SharePlatform.RedNote,
			"rednote"
		},
		{
			SharePlatform.TapTap,
			"taptap"
		}
	};

	private readonly Dictionary<ActButton, UnityAction> _shareButtonCallbacks = new Dictionary<ActButton, UnityAction>();

	private ShareViewViewData _dataContext;

	private CancellationTokenSource _operationCancellationTokenSource;

	private ShareScreenshotResult _screenshot;

	private bool _hasRegisteredScreenshotRelease;

	private bool _hasScreenshot;

	private bool _isProcessing;

	private bool _hasSavedImage;

	private bool _isAwaitingShareCallback;

	private bool _isAwaitingSaveCallback;

	private int _pendingShareMedia = 10;

	private Dictionary<string, GamePadTipsAction> _allInputPrompt = new Dictionary<string, GamePadTipsAction>();

	private List<GamePadTipsAction> _tipsActions;

	public override async UniTask PreInit()
	{
		try
		{
			_dataContext = (ShareViewViewData)uiViewData;
			_screenshot = _dataContext.Screenshot;
			_screenshot.TakeOwnership();
			if (!_hasRegisteredScreenshotRelease)
			{
				_hasRegisteredScreenshotRelease = true;
				this.GetCancellationTokenOnDestroy().Register(ReleaseScreenshot);
			}
			await base.PreInit();
			SetText();
		}
		catch
		{
			ReleaseScreenshot();
			throw;
		}
	}

	protected override void Init()
	{
		try
		{
			base.Init();
			_operationCancellationTokenSource?.Dispose();
			_operationCancellationTokenSource = new CancellationTokenSource();
			_isProcessing = false;
			ResetSaveState();
			_isAwaitingShareCallback = false;
			_pendingShareMedia = 10;
			RefreshPlatformButtonVisibility();
			BindShareButtons();
			BindSdkCallbacks();
			ShowWaterMarkInformation();
			_hasScreenshot = TryBindScreenshot();
			SetActionButtonsInteractable(_hasScreenshot);
			OnGamePadInit();
			ReBindBtnPrompt();
		}
		catch
		{
			ReleaseScreenshot();
			throw;
		}
	}

	protected override void UnInit()
	{
		_operationCancellationTokenSource?.Cancel();
		_operationCancellationTokenSource?.Dispose();
		_operationCancellationTokenSource = null;
		UnbindShareButtons();
		UnbindSdkCallbacks();
		_hasScreenshot = false;
		_isProcessing = false;
		ResetSaveState();
		_isAwaitingShareCallback = false;
		_pendingShareMedia = 10;
		base.UnInit();
	}

	private void SetText()
	{
		BriefUserInfo briefUserInfo = G.detailUserInfo?.Brief;
		TxtPlayerName.text = briefUserInfo?.Nickname ?? "Unknown";
		TxtPlayerUid.text = briefUserInfo?.AccountId.ToString();
		TxtDate.text = DateTime.Now.ToString("d");
	}

	private void BindShareButtons()
	{
		_shareButtonCallbacks.Clear();
		if (Buttons != null && !MonoECS.instance.ispc)
		{
			ShareButtonEntry[] buttons = Buttons;
			foreach (ShareButtonEntry shareButtonEntry in buttons)
			{
				if ((bool)shareButtonEntry?.Button && !_shareButtonCallbacks.ContainsKey(shareButtonEntry.Button))
				{
					SharePlatform platform = shareButtonEntry.Platform;
					UnityAction unityAction = () =>
					{
						OnShareClicked(platform);
					};
					_shareButtonCallbacks.Add(shareButtonEntry.Button, unityAction);
					shareButtonEntry.Button.OnClick.AddListener(unityAction);
				}
			}
		}
		BtnSaveLocal.OnClick.AddListener(OnSaveLocalClicked);
	}

	private void UnbindShareButtons()
	{
		foreach (KeyValuePair<ActButton, UnityAction> shareButtonCallback in _shareButtonCallbacks)
		{
			if ((bool)shareButtonCallback.Key)
			{
				shareButtonCallback.Key.OnClick.RemoveListener(shareButtonCallback.Value);
			}
		}
		_shareButtonCallbacks.Clear();
		BtnSaveLocal.OnClick.RemoveListener(OnSaveLocalClicked);
	}

	private void RefreshPlatformButtonVisibility()
	{
		if (Buttons != null)
		{
			bool active = !MonoECS.instance.ispc;
			ButtonBar.SetActive(active);
		}
	}

	private void OnShareClicked(SharePlatform platform)
	{
		if (_operationCancellationTokenSource != null)
		{
			Share(platform, _operationCancellationTokenSource.Token);
		}
	}

	private void OnSaveLocalClicked()
	{
		if (_operationCancellationTokenSource != null)
		{
			if (MonoECS.instance.ispc)
			{
				SaveImageToPc(_operationCancellationTokenSource.Token);
			}
			else
			{
				SaveImageBySDK(_operationCancellationTokenSource.Token);
			}
		}
	}

	private void Share(SharePlatform platform, CancellationToken cancellationToken)
	{
		if (_isProcessing || _isAwaitingShareCallback || !_hasScreenshot)
		{
			return;
		}
		if (!_platformSDKIdMapping.TryGetValue(platform, out var value))
		{
			Debug.LogError($"ShareView: missing SDK platform mapping for {platform}.");
			return;
		}
		_isProcessing = true;
		try
		{
			cancellationToken.ThrowIfCancellationRequested();
			string filePath = _screenshot.FilePath;
			JObject jObject = new JObject
			{
				["platform"] = value,
				["type"] = "image",
				["image_source"] = filePath,
				["text"] = string.Empty,
				["title"] = string.Empty
			};
			_pendingShareMedia = GetTrackMedia(platform);
			_isAwaitingShareCallback = true;
			BamBooSdk.getInstance().getExtend("share_platform", jObject.ToString(Formatting.None));
		}
		catch (OperationCanceledException)
		{
		}
		catch (Exception arg)
		{
			Debug.LogError($"ShareView: failed to prepare the shared screenshot.\n{arg}");
			ReportShareEvent(GetTrackMedia(platform), 2);
			_isAwaitingShareCallback = false;
			_pendingShareMedia = 10;
		}
		finally
		{
			_isProcessing = false;
		}
	}

	private void SaveImageToPc(CancellationToken cancellationToken)
	{
		if (_isProcessing || !_hasScreenshot)
		{
			return;
		}
		if (_hasSavedImage)
		{
			ShowPcSaveTip(2804);
			return;
		}
		_isProcessing = true;
		try
		{
			cancellationToken.ThrowIfCancellationRequested();
			string filePath = _screenshot.FilePath;
			string text = Path.Combine(Path.GetFullPath(Path.Combine(Application.dataPath, "..")), "Screenshot");
			Directory.CreateDirectory(text);
			string path = $"Screenshot_{DateTime.Now:yyyy-MM-dd_HH-mm-ss-fff}.png";
			string destFileName = Path.Combine(text, path);
			File.Copy(filePath, destFileName);
			_hasSavedImage = true;
			ShowPcSaveTip(2803);
			ReportShareEvent(10, 3);
		}
		catch (OperationCanceledException)
		{
		}
		catch (Exception arg)
		{
			Debug.LogError($"ShareView: failed to prepare the saved screenshot.\n{arg}");
		}
		finally
		{
			_isProcessing = false;
		}
	}

	private static void ShowPcSaveTip(int localizationId)
	{
		string localizeString = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, localizationId);
		string localizeString2 = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2802);
		GameUtility.OpenToolTip(localizeString + "：" + localizeString2 + "/Screenshot。");
	}

	private void SaveImageBySDK(CancellationToken cancellationToken)
	{
		if (_isProcessing || _isAwaitingSaveCallback || !_hasScreenshot || _hasSavedImage)
		{
			return;
		}
		_isProcessing = true;
		try
		{
			cancellationToken.ThrowIfCancellationRequested();
			string filePath = _screenshot.FilePath;
			Debug.Log("ShareView: Image saved location: " + filePath);
			JObject jObject = new JObject { ["image_source"] = filePath };
			_isAwaitingSaveCallback = true;
			BamBooSdk.getInstance().getExtend("save_image", jObject.ToString());
		}
		catch (OperationCanceledException)
		{
			ClearPendingSaveState();
		}
		catch (Exception arg)
		{
			Debug.LogError($"ShareView: failed to prepare the saved screenshot.\n{arg}");
			ClearPendingSaveState();
		}
		finally
		{
			_isProcessing = false;
		}
	}

	private void ResetSaveState()
	{
		_hasSavedImage = false;
		ClearPendingSaveState();
	}

	private void ClearPendingSaveState()
	{
		_isAwaitingSaveCallback = false;
	}

	private bool TryBindScreenshot()
	{
		if (_screenshot == null || _screenshot.IsDisposed || !_screenshot.Texture)
		{
			Debug.LogError("ShareView: screenshot has already been released.");
			return false;
		}
		Screenshot.sprite = null;
		ResizeScreenshotFrame(_screenshot.Size);
		return true;
	}

	private void ResizeScreenshotFrame(Vector2Int size)
	{
		float num = (float)size.x * 1080f / (float)size.y;
		float x = 1354f * num / 2340f + 10f;
		Panel.sizeDelta = new Vector2(x, Panel.sizeDelta.y);
		ButtonContainer.sizeDelta = new Vector2(x, ButtonContainer.sizeDelta.y);
	}

	private void ReleaseScreenshot()
	{
		_hasScreenshot = false;
		_screenshot?.Dispose();
		_screenshot = null;
	}

	private void SetActionButtonsInteractable(bool interactable)
	{
		if (Buttons != null)
		{
			ShareButtonEntry[] buttons = Buttons;
			foreach (ShareButtonEntry shareButtonEntry in buttons)
			{
				if ((bool)shareButtonEntry?.Button)
				{
					shareButtonEntry.Button.interactable = interactable;
				}
			}
		}
		BtnSaveLocal.interactable = interactable;
	}

	private void ShowWaterMarkInformation()
	{
	}

	private void BindSdkCallbacks()
	{
		LuminBambooBridgeListener.ExtendSucceeded += OnExtendSucceeded;
		LuminBambooBridgeListener.ExtendFailed += OnExtendFailed;
	}

	private void UnbindSdkCallbacks()
	{
		LuminBambooBridgeListener.ExtendSucceeded -= OnExtendSucceeded;
		LuminBambooBridgeListener.ExtendFailed -= OnExtendFailed;
	}

	private void OnExtendSucceeded(string modName, string jsonResult)
	{
		if (!IsShareViewModName(modName))
		{
			return;
		}
		try
		{
			JObject jObject = JObject.Parse(jsonResult);
			string text = jObject.Value<string>("platform") ?? string.Empty;
			string text2 = jObject.Value<string>("type") ?? string.Empty;
			string text3 = jObject["code"]?.ToString() ?? string.Empty;
			string text4 = jObject.Value<string>("msg") ?? string.Empty;
			Debug.Log("ShareView: SDK callback modName=" + modName + ", platform=" + text + ", type=" + text2 + ", code=" + text3 + ", msg=" + text4);
			if (modName == "share_platform" && _isAwaitingShareCallback)
			{
				int trackMedia = GetTrackMedia(text, _pendingShareMedia);
				ReportShareEvent(trackMedia, (text3 == "0") ? 1 : 2);
				_isAwaitingShareCallback = false;
				_pendingShareMedia = 10;
			}
			else if (modName == "save_image" && _isAwaitingSaveCallback)
			{
				if (text3 == "0")
				{
					_hasSavedImage = true;
				}
				ReportShareEvent(10, 3);
				ClearPendingSaveState();
			}
			if (!string.IsNullOrWhiteSpace(text4))
			{
				GameUtility.OpenToolTip(text4);
				return;
			}
			Debug.LogWarning("ShareView: SDK callback message is empty, modName=" + modName + ", code=" + text3 + ".");
		}
		catch (Exception arg)
		{
			Debug.LogError($"ShareView: failed to parse SDK callback, modName={modName}, json={jsonResult}.\n{arg}");
			if (modName == "share_platform" && _isAwaitingShareCallback)
			{
				ReportShareEvent(_pendingShareMedia, 2);
				_isAwaitingShareCallback = false;
				_pendingShareMedia = 10;
			}
			else if (modName == "save_image" && _isAwaitingSaveCallback)
			{
				ClearPendingSaveState();
			}
		}
	}

	private void OnExtendFailed(string modName, ErrorMsg error)
	{
		if (IsShareViewModName(modName))
		{
			string text = error?.errMsg ?? string.Empty;
			Debug.LogError("ShareView: SDK extension failed, modName=" + modName + ", message=" + text + ".");
			if (modName == "share_platform" && _isAwaitingShareCallback)
			{
				ReportShareEvent(_pendingShareMedia, 2);
				_isAwaitingShareCallback = false;
				_pendingShareMedia = 10;
			}
			else if (modName == "save_image" && _isAwaitingSaveCallback)
			{
				ClearPendingSaveState();
			}
			if (!string.IsNullOrWhiteSpace(text))
			{
				GameUtility.OpenToolTip(text);
			}
		}
	}

	private static bool IsShareViewModName(string modName)
	{
		if (!(modName == "share_platform"))
		{
			return modName == "save_image";
		}
		return true;
	}

	private static int GetTrackMedia(SharePlatform platform)
	{
		return platform switch
		{
			SharePlatform.Wechat => 1, 
			SharePlatform.WechatMoments => 2, 
			SharePlatform.Weibo => 3, 
			SharePlatform.RedNote => 4, 
			SharePlatform.QQ => 5, 
			SharePlatform.QQZone => 6, 
			SharePlatform.Bilibili => 7, 
			SharePlatform.Tiktok => 8, 
			SharePlatform.TapTap => 9, 
			_ => 10, 
		};
	}

	private static int GetTrackMedia(string platform, int fallbackMedia)
	{
		return platform switch
		{
			"wechat_session" => 1, 
			"wechat_timeline" => 2, 
			"weibo" => 3, 
			"rednote" => 4, 
			"qq" => 5, 
			"qzone" => 6, 
			"bilibili" => 7, 
			"douyin" => 8, 
			"taptap" => 9, 
			_ => fallbackMedia, 
		};
	}

	private void ReportShareEvent(int media, int result)
	{
		if (_dataContext?.LootItems == null)
		{
			return;
		}
		EventTrackSolver instance = EventTrackSolver.Instance;
		if (!instance)
		{
			return;
		}
		ShareEvent evt = instance.GetEvt<ShareEvent>();
		if (evt == null)
		{
			return;
		}
		foreach (ShareViewViewData.LootItemData lootItem in _dataContext.LootItems)
		{
			evt.lootitem.Add(new ShareEvent.LootitemData
			{
				id = lootItem.Id,
				num = lootItem.Num
			});
		}
		evt.media = media;
		evt.result = result;
		instance.Dispatch(evt);
	}

	private void OnGamePadInit()
	{
		_allInputPrompt = new Dictionary<string, GamePadTipsAction>
		{
			["UI/RSUpDownSelect"] = new GamePadTipsAction
			{
				inputAction = "UI/RSUpDownSelect",
				localizeKey = 2165,
				localizeTable = "Common"
			},
			["UI/Back"] = new GamePadTipsAction
			{
				inputAction = "UI/Back",
				localizeKey = 606,
				localizeTable = "Common"
			},
			["UI/Confirm"] = new GamePadTipsAction
			{
				inputAction = "UI/Confirm",
				localizeKey = 774,
				localizeTable = "Common"
			}
		};
	}

	private void ReBindBtnPrompt()
	{
		List<GamePadTipsAction> tipsActions = _tipsActions;
		if (tipsActions == null || tipsActions.Count <= 0)
		{
			_tipsActions = new List<GamePadTipsAction>();
		}
		gamePadGroup.ClearAllPrompts();
		_tipsActions.Clear();
		_tipsActions.Add(_allInputPrompt["UI/Confirm"]);
		_tipsActions.Add(_allInputPrompt["UI/Back"]);
		gamePadGroup.RegisterInputActions(_tipsActions);
	}
}
