using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GuildTaskItem : UGuiView
{
	[SerializeField]
	private Color highlightColor;

	[SerializeField]
	private Color disableColor;

	[SerializeField]
	private GameObject highlightBg;

	[SerializeField]
	private Button btnFinish;

	[SerializeField]
	private TextMeshProUGUI btnText;

	[SerializeField]
	private TextMeshProUGUI btnEngText;

	[SerializeField]
	private GameObject highlightBtnBg;

	[SerializeField]
	private TextMeshProUGUI description;

	[SerializeField]
	private Button detailButton;

	[SerializeField]
	private TextMeshProUGUI detailDesc;

	[SerializeField]
	private TextMeshProUGUI progressText;

	[SerializeField]
	private Image progressBar;

	[SerializeField]
	private TextMeshProUGUI activePoint;

	[SerializeField]
	private GameObject red;

	[SerializeField]
	private GameObject canFinishEffect;

	private GuildTaskItemData _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<GuildTaskItemData>(userData);
		BindingSet<GuildTaskItem, GuildTaskItemData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(highlightBg).For((GameObject v) => v.activeSelf).ToExpression((GuildTaskItemData vm) => (int)vm.TaskState == 0);
		bindingSet.Bind(btnFinish).For((Button v) => v.onClick).To((GuildTaskItemData vm) => vm.OnFinishBtnClick);
		bindingSet.Bind(btnFinish).For((Button v) => v.enabled).ToExpression((GuildTaskItemData vm) => (int)vm.TaskState == 0);
		bindingSet.Bind<TextMeshProUGUI>(btnText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((GuildTaskItemData vm) => ((int)vm.TaskState == 0) ? $"<color=#{ColorUtility.ToHtmlStringRGB(highlightColor)}>{vm.BtnText}</color>" : $"<color=#{ColorUtility.ToHtmlStringRGB(disableColor)}>{vm.BtnText}</color>");
		bindingSet.Bind<TextMeshProUGUI>(btnEngText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((GuildTaskItemData vm) => ((int)vm.TaskState == 0) ? $"<color=#{ColorUtility.ToHtmlStringRGB(highlightColor)}>{vm.BtnEnglishText}</color>" : $"<color=#{ColorUtility.ToHtmlStringRGB(disableColor)}>{vm.BtnEnglishText}</color>");
		bindingSet.Bind(highlightBtnBg).For((GameObject v) => v.activeSelf).ToExpression((GuildTaskItemData vm) => (int)vm.TaskState == 0);
		bindingSet.Bind<TextMeshProUGUI>(description).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildTaskItemData vm) => vm.TaskDesc);
		bindingSet.Bind(detailButton.gameObject).For((GameObject v) => v.activeSelf).To((GuildTaskItemData vm) => vm.ShowDetailBtn);
		bindingSet.Bind(detailButton).For((Button v) => v.onClick).To((GuildTaskItemData vm) => vm.OnDetailBtnClick);
		bindingSet.Bind<TextMeshProUGUI>(detailDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildTaskItemData vm) => vm.DetailDesc);
		bindingSet.Bind<TextMeshProUGUI>(progressText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((GuildTaskItemData vm) => $"{vm.CurProgress}/{vm.TotalProgress}");
		bindingSet.Bind(progressBar).For((Image v) => v.fillAmount).ToExpression((GuildTaskItemData vm) => (vm.CurProgress >= vm.TotalProgress) ? 1f : ((float)vm.CurProgress / (float)vm.TotalProgress));
		bindingSet.Bind<TextMeshProUGUI>(activePoint).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildTaskItemData vm) => vm.ActivePoint);
		bindingSet.Bind(red).For((GameObject v) => v.activeSelf).ToExpression((GuildTaskItemData vm) => (int)vm.TaskState == 0);
		bindingSet.Bind(canFinishEffect).For((GameObject v) => v.activeSelf).ToExpression((GuildTaskItemData vm) => (int)vm.TaskState == 0);
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		if (userData is GuildTaskItemData guildTaskItemData)
		{
			_viewModel = guildTaskItemData;
			this.SetDataContext(guildTaskItemData);
		}
	}
}
