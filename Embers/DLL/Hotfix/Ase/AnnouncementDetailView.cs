using System;
using System.Linq.Expressions;
using System.Text.RegularExpressions;
using GameFramework.Runtime;
using Sirenix.Utilities;
using TMPro;
using UnityEngine;

namespace Ase;

public class AnnouncementDetailView : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI title;

	[SerializeField]
	private TextMeshProUGUI date;

	[SerializeField]
	private GameObject headImageGo;

	[SerializeField]
	private UrlImage headImage;

	[SerializeField]
	private ContentImageItem contentImageTpl;

	[SerializeField]
	private HyperlinkText contentTextTpl;

	[SerializeField]
	private RectTransform scrollRect;

	[SerializeField]
	private RectTransform content;

	private GameObjectPool contentImagePool;

	private GameObjectPool hyperLinkTextPool;

	private AnnouncementDetailViewModel viewModel;

	public void Init(AnnouncementDetailViewModel viewModel)
	{
		contentImagePool = new GameObjectPool(contentImageTpl.gameObject, content);
		hyperLinkTextPool = new GameObjectPool(contentTextTpl.gameObject, content);
		this.viewModel = viewModel;
		BindingSet<AnnouncementDetailView, AnnouncementDetailViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind<TextMeshProUGUI>(title).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((AnnouncementDetailViewModel vm) => vm.Title);
		bindingSet.Bind<TextMeshProUGUI>(date).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((AnnouncementDetailViewModel vm) => vm.StartTime);
		bindingSet.Bind().For((AnnouncementDetailView v) => v.RefreshAll).To((AnnouncementDetailViewModel vm) => vm.RefreshAllRequest);
		bindingSet.Build();
		RefreshAll();
	}

	public void SetVisibility(bool active)
	{
		CanvasGroup.alpha = (active ? 1 : 0);
		CanvasGroup.blocksRaycasts = active;
	}

	private async void RefreshAll(object sender = null, InteractionEventArgs e = null)
	{
		contentImagePool.RecycleAll();
		hyperLinkTextPool.RecycleAll();
		if (viewModel.Data == null || viewModel.Data.Data == null)
		{
			return;
		}
		string[] array = AnalysisContent(viewModel.Data.Data.Content);
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i].StartsWith("<picUrl>"))
			{
				ContentImageItem component = contentImagePool.Allocate(out var newCreate).GetComponent<ContentImageItem>();
				if (newCreate)
				{
					component.SetImageWidthLimit(scrollRect.sizeDelta.x);
				}
				component.SetSpriteUrl(array[i].Replace("<picUrl>", ""));
				component.transform.SetSiblingIndex(i + 1);
			}
			else
			{
				HyperlinkText component2 = hyperLinkTextPool.Allocate().GetComponent<HyperlinkText>();
				((TMP_Text)component2.text).text = array[i].Replace("\\n", "\n").Replace(" ", "\u00a0");
				component2.transform.SetSiblingIndex(i + 1);
				component2.GetFinalLink = (Func<string, string>)Delegate.Combine(component2.GetFinalLink, new Func<string, string>(GetFinalLink));
				component2.SetOnLinkClickAction(OnLinkClick);
			}
		}
		LoadHeadImage();
	}

	private string GetFinalLink(string link)
	{
		IRoleService service = Singleton<ServiceSystem>.Instance.GetService<IRoleService>();
		if (service != null)
		{
			char c = (link.Contains('?') ? '&' : '?');
			return $"{link}{c}uid={service.GetRoleData()?.Uid}";
		}
		return link;
	}

	private async void LoadHeadImage()
	{
		if (string.IsNullOrEmpty(viewModel.HeadImage))
		{
			headImageGo.SetActive(value: false);
			return;
		}
		headImage.gameObject.SetActive(value: false);
		headImageGo.SetActive(value: true);
		await headImage.SetSpriteUrl(viewModel.HeadImage);
		if (!headImage.SafeIsUnityNull())
		{
			headImage.gameObject.SetActive(value: true);
		}
	}

	private string[] AnalysisContent(string rawContent)
	{
		return Regex.Split(rawContent, "(<picUrl>[^>\\n\\s]+)</picUrl>");
	}

	private void OnLinkClick(string link)
	{
		if (!string.IsNullOrEmpty(link))
		{
			string text = GameEntry.Web.OpenWebViewWithUid(link, ((Component)(object)GameEntry.UI.Canvas).GetComponent<RectTransform>(), useToolBar: true, null, null);
			if (!string.IsNullOrEmpty(text))
			{
				Toast.ShowInfo(text);
			}
		}
	}

	protected override void OnDestroy()
	{
		contentImagePool?.Dispose();
		hyperLinkTextPool?.Dispose();
		contentImagePool = null;
		hyperLinkTextPool = null;
		base.OnDestroy();
	}
}
