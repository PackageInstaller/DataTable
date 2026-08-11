using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TitleItemView : UGuiView
{
	[SerializeField]
	private Button btnSel;

	[SerializeField]
	private GameObject isSel;

	[SerializeField]
	private GameObject lockIcon;

	private bool isLock;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private GameObject timeLimit;

	[SerializeField]
	private StateItem emptyState;

	private GameObject titleIconGo;

	private int titleIconLoadVersion;

	private TitleItemViewModel viewModel;

	private TitleItemColor prefabView;

	public bool IsLock
	{
		get
		{
			return isLock;
		}
		set
		{
			isLock = value;
			lockIcon.SetActive(isLock);
			if (prefabView != null)
			{
				prefabView.SetImageColor(viewModel.IsLock);
			}
			Color color = icon.color;
			if (!isLock)
			{
				color = Color.white;
				icon.color = new Color(color.r, color.g, color.b, 1f);
			}
			else
			{
				ColorUtility.TryParseHtmlString("#3F3F3F", out color);
				icon.color = new Color(color.r, color.g, color.b, 0.4f);
			}
		}
	}

	public void Init(TitleItemViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<TitleItemView, TitleItemViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(btnSel).For((Button v) => v.onClick).To((TitleItemViewModel vm) => vm.OnSelect);
		bindingSet.Bind(isSel).For((GameObject v) => v.activeSelf).To((TitleItemViewModel vm) => vm.IsSelect);
		bindingSet.Bind(timeLimit).For((GameObject v) => v.activeSelf).ToExpression((TitleItemViewModel vm) => vm.TitleTimeLimitType != 1);
		bindingSet.Bind().For((TitleItemView v) => v.IsLock).To((TitleItemViewModel vm) => vm.IsLock);
		bindingSet.Build();
		RefreshTitleIconAsync();
	}

	public void RefreshData(TitleItemViewModel viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
		RefreshTitleIconAsync();
	}

	private async UniTaskVoid RefreshTitleIconAsync()
	{
		int version = ++titleIconLoadVersion;
		if (titleIconGo != null)
		{
			Object.Destroy(titleIconGo);
			titleIconGo = null;
		}
		icon.sprite = null;
		Color color = icon.color;
		icon.color = new Color(color.r, color.g, color.b, 0f);
		if (viewModel == null || string.IsNullOrEmpty(viewModel.TitleIcon))
		{
			return;
		}
		GameObject gameObject = await InstantiateAsync(AssetUtility.GetDynamicDecorationPrefab(viewModel.TitleIcon), icon.transform);
		if (!(gameObject == null))
		{
			if (version != titleIconLoadVersion)
			{
				Object.Destroy(gameObject);
				return;
			}
			titleIconGo = gameObject;
			prefabView = titleIconGo.GetComponent<TitleItemColor>();
			prefabView.SetImageColor(viewModel.IsLock);
			titleIconGo.transform.localScale = Vector3.one;
			titleIconGo.transform.localPosition = Vector3.zero;
			titleIconGo.transform.localRotation = Quaternion.identity;
		}
	}

	protected override void OnDestroy()
	{
		titleIconLoadVersion++;
		if (titleIconGo != null)
		{
			Object.Destroy(titleIconGo);
			titleIconGo = null;
		}
		base.OnDestroy();
	}
}
