using System;
using System.Linq.Expressions;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class MainRoleInfoView : MonoBehaviour
{
	public Text nameText;

	public TextMeshProUGUI levelText;

	public Image levelProgress;

	public TextMeshProUGUI levelProgressText;

	public TextMeshProUGUI uid;

	public TextMeshProUGUI laborUnionTxt;

	public TextMeshProUGUI rigisterTxt;

	public Image icon;

	public Image iconFrame;

	public Image title;

	public GameObject red;

	private GameObject titlePrefabGo;

	private int titlePrefabLoadVersion;

	private int titleId = -1;

	private PlayerDataBase viewModel;

	public int TitleId
	{
		get
		{
			return titleId;
		}
		set
		{
			if (titleId != value)
			{
				titleId = value;
				RefreshTitlePrefab().Forget();
			}
		}
	}

	public void Init(PlayerDataBase playerData)
	{
		viewModel = playerData;
		BindingSet<MainRoleInfoView, PlayerDataBase> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(nameText).For((Text v) => v.text).To((PlayerDataBase vm) => vm.Name);
		bindingSet.Bind<TextMeshProUGUI>(levelText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PlayerDataBase vm) => $"{vm.Level}");
		bindingSet.Bind(levelProgress).For((Image v) => v.fillAmount).ToExpression((PlayerDataBase vm) => (vm.MaxExp == 0) ? 1f : ((float)vm.Exp * 1f / (float)vm.MaxExp));
		if ((UnityEngine.Object)(object)levelProgressText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(levelProgressText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PlayerDataBase vm) => $"{vm.Exp}/{vm.MaxExp}");
		}
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((PlayerDataBase vm) => vm.Icon)
			.WithConversion("ItemIcon");
		if (iconFrame != null)
		{
			bindingSet.Bind(iconFrame).For((Image v) => v.sprite).ToExpression((PlayerDataBase vm) => $"HeadAdorn{vm.IconFrame}")
				.WithConversion("ItemIcon");
			bindingSet.Bind(iconFrame.gameObject).For((GameObject v) => v.activeSelf).ToExpression((PlayerDataBase vm) => vm.IconFrame != 0);
		}
		if (title != null)
		{
			bindingSet.Bind(this).For((MainRoleInfoView v) => v.TitleId).To((PlayerDataBase vm) => vm.Title);
		}
		if ((UnityEngine.Object)(object)uid != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(uid).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PlayerDataBase vm) => $"{vm.Uid}");
		}
		if ((UnityEngine.Object)(object)laborUnionTxt != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(laborUnionTxt).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PlayerDataBase vm) => vm.UnionName);
		}
		if ((UnityEngine.Object)(object)rigisterTxt != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(rigisterTxt).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PlayerDataBase vm) => vm.CreatTimeTxt);
		}
		bindingSet.Build();
		InitRedPoint();
	}

	private async UniTaskVoid RefreshTitlePrefab()
	{
		int loadVersion = ++titlePrefabLoadVersion;
		ClearTitlePrefab();
		if (title == null)
		{
			return;
		}
		title.sprite = null;
		string text;
		if (titleId == 0)
		{
			text = "Title/UserTitle0";
		}
		else
		{
			DRTitle dataRow = GameEntry.DataTable.GetDataRow<DRTitle>(titleId);
			if (dataRow == null || string.IsNullOrEmpty(dataRow.Icon))
			{
				return;
			}
			text = dataRow.Icon;
		}
		title.gameObject.SetActive(value: true);
		if (text == "")
		{
			return;
		}
		GameObject gameObject = await GameEntry.Resource.InstantiateAsync(AssetUtility.GetDynamicDecorationPrefab(text), title.transform);
		if (!(gameObject == null))
		{
			if (loadVersion != titlePrefabLoadVersion)
			{
				UnityEngine.Object.Destroy(gameObject);
				return;
			}
			titlePrefabGo = gameObject;
			titlePrefabGo.transform.localScale = Vector3.one;
			titlePrefabGo.transform.localPosition = Vector3.zero;
			titlePrefabGo.transform.localRotation = Quaternion.identity;
		}
	}

	private void ClearTitlePrefab()
	{
		if (titlePrefabGo != null)
		{
			UnityEngine.Object.Destroy(titlePrefabGo);
			titlePrefabGo = null;
		}
	}

	private void OnDestroy()
	{
		titlePrefabLoadVersion++;
		ClearTitlePrefab();
	}

	private void InitRedPoint()
	{
		try
		{
			GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.HeroHeadIcon).SetFuncOnMessage((RedPointMessage message) => Singleton<ServiceSystem>.Instance.GetService<IRedPointService>().GetUserRead(ServerReadEnum.HeroHeadIcon))
				.Invoke();
			red.gameObject.SetActive(Singleton<ServiceSystem>.Instance.GetService<IRedPointService>().GetUserRead(ServerReadEnum.HeroHeadIcon));
		}
		catch (Exception)
		{
		}
	}
}
