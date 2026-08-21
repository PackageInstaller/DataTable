using System;
using System.Linq.Expressions;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class DecoratePopupView : UGuiWindow
{
	[SerializeField]
	private Button btnOutside;

	[SerializeField]
	private Button btnClose;

	[SerializeField]
	private TextMeshProUGUI title;

	[SerializeField]
	private Image image;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private new TextMeshProUGUI name;

	[SerializeField]
	private TextMeshProUGUI source;

	[SerializeField]
	private Image qualityTitleImg;

	[SerializeField]
	private Image qualityBgImg;

	[SerializeField]
	private Image qualityMiddleImg;

	[SerializeField]
	private GameObject timeLimitGo;

	[SerializeField]
	private TextMeshProUGUI timeLimitText;

	private DecoratePopupViewModel _viewModel;

	private GameObject imagePrefabGo;

	private int imagePrefabLoadVersion;

	private string imagePath;

	private bool useTitlePrefab;

	public string ImagePath
	{
		get
		{
			return imagePath;
		}
		set
		{
			imagePath = value;
			RefreshImageShow().Forget();
		}
	}

	public bool UseTitlePrefab
	{
		get
		{
			return useTitlePrefab;
		}
		set
		{
			useTitlePrefab = value;
			RefreshImageShow().Forget();
		}
	}

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<DecoratePopupViewModel>();
		BindingSet<DecoratePopupView, DecoratePopupViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((DecoratePopupView v) => v.OnDismissRequest).To((DecoratePopupViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnOutside).For((Button v) => v.onClick).To((DecoratePopupViewModel vm) => vm.Close);
		bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((DecoratePopupViewModel vm) => vm.Close);
		bindingSet.Bind<TextMeshProUGUI>(title).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DecoratePopupViewModel vm) => vm.Title);
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DecoratePopupViewModel vm) => vm.Name);
		bindingSet.Bind<TextMeshProUGUI>(source).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DecoratePopupViewModel vm) => vm.Source);
		bindingSet.Bind(this).For((DecoratePopupView v) => v.ImagePath).To((DecoratePopupViewModel vm) => vm.Image);
		bindingSet.Bind(this).For((DecoratePopupView v) => v.UseTitlePrefab).ToExpression((DecoratePopupViewModel vm) => (int)vm.PropDataBase.PropTypeEnum == 11);
		bindingSet.Bind(icon).For((Image v) => v.sprite).To((DecoratePopupViewModel vm) => vm.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(qualityTitleImg).For((Image v) => v.sprite).ToExpression((DecoratePopupViewModel vm) => $"Prop_Title_{vm.PropDataBase.Quality}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(qualityBgImg).For((Image v) => v.sprite).ToExpression((DecoratePopupViewModel vm) => $"Prop_Bg_{vm.PropDataBase.Quality}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(qualityMiddleImg).For((Image v) => v.sprite).ToExpression((DecoratePopupViewModel vm) => $"Rarity_Middle_{vm.PropDataBase.Quality}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(timeLimitGo).For((GameObject v) => v.activeSelf).ToExpression((DecoratePopupViewModel vm) => (int)vm.PropDataBase.PropTimeLimitEnum != 0);
		bindingSet.Bind<TextMeshProUGUI>(timeLimitText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((DecoratePopupViewModel vm) => vm.PropDataBase.TimeLimitText);
		bindingSet.Build();
		icon.SetNativeSize();
		if (!useTitlePrefab)
		{
			image.SetNativeSize();
		}
	}

	private async UniTaskVoid RefreshImageShow()
	{
		int loadVersion = ++imagePrefabLoadVersion;
		ClearImagePrefab();
		if (this.image == null)
		{
			return;
		}
		if (!useTitlePrefab && _viewModel.Title != "称号")
		{
			Color color = this.image.color;
			this.image.color = new Color(color.r, color.g, color.b, 1f);
			string decorateImagePath = GetDecorateImagePath(imagePath);
			if (!string.IsNullOrEmpty(decorateImagePath))
			{
				Image image = this.image;
				image.sprite = await LoadSpriteAsync(AssetUtility.GetTextureIconSprite(decorateImagePath));
			}
			else
			{
				this.image.sprite = null;
			}
			this.image.SetNativeSize();
			return;
		}
		this.image.sprite = null;
		Color color2 = this.image.color;
		this.image.color = new Color(color2.r, color2.g, color2.b, 0f);
		if (string.IsNullOrEmpty(imagePath))
		{
			return;
		}
		GameObject gameObject = await InstantiateAsync(AssetUtility.GetDynamicDecorationPrefab(imagePath), this.image.transform);
		if (!(gameObject == null))
		{
			if (loadVersion != imagePrefabLoadVersion)
			{
				UnityEngine.Object.Destroy(gameObject);
				return;
			}
			imagePrefabGo = gameObject;
			imagePrefabGo.transform.localScale = Vector3.one;
			imagePrefabGo.transform.localPosition = Vector3.zero;
			imagePrefabGo.transform.localRotation = Quaternion.identity;
		}
	}

	private string GetDecorateImagePath(string rawPath)
	{
		if (string.IsNullOrEmpty(rawPath))
		{
			return rawPath;
		}
		string text = rawPath;
		switch (_viewModel.Title)
		{
		case "头像框":
			if (!text.StartsWith("UserHeadFrame/"))
			{
				text = "UserHeadFrame/" + text;
			}
			break;
		case "备战边框":
			if (!text.StartsWith("RoomCardFrame/"))
			{
				text = "RoomCardFrame/" + text;
			}
			break;
		case "聊天气泡":
		case "战斗表情":
			if (!text.StartsWith("Prop/"))
			{
				text = "Prop/" + text;
			}
			break;
		case "聊天表情":
			if (!text.StartsWith("Emoji/"))
			{
				text = "Emoji/" + text;
			}
			break;
		}
		if (!text.EndsWith(".png"))
		{
			text += ".png";
		}
		return text;
	}

	private void ClearImagePrefab()
	{
		if (imagePrefabGo != null)
		{
			UnityEngine.Object.Destroy(imagePrefabGo);
			imagePrefabGo = null;
		}
	}

	protected override void OnDismiss()
	{
		imagePrefabLoadVersion++;
		ClearImagePrefab();
		base.OnDismiss();
	}
}
