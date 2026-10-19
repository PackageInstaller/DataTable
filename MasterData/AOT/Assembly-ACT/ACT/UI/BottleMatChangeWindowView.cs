using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.Utility;
using Bamboo.NumberString;
using Cysharp.Threading.Tasks;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class BottleMatChangeWindowView : BaseUIView
{
	public LocalizeStringEvent titleContent;

	public ItemUIComponentBase targetMatCell;

	public ActButton cancelBtn;

	public ActButton confirmBtn;

	public ActButton closeBtn;

	private BottleMatChangeWindowViewData m_data;

	private const int BOTTLEMATCAHGNECONTEXT = 2202;

	protected override void AddEventListener()
	{
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		m_data = uiViewData as BottleMatChangeWindowViewData;
	}

	protected override void Init()
	{
		base.Init();
		if (m_data != null)
		{
			BloodBottleData bloodBottleById = Model<BloodBottleModel>.Interface.GetBloodBottleById(m_data.targetMaterial.belongBottle);
			ItemData data = CoreUtils.GetData(bloodBottleById.id, RuntimeConfigs.data.itemDatas);
			titleContent.StringReference.TableEntryReference = 2202L;
			titleContent.GetVariable<string>("0").Value = bloodBottleById.uid.FastToString();
			titleContent.GetVariable<string>("1").Value = LocalizationUtility.GetLocalizeString("shortcommon", data.nameLocal);
			ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get(m_data.targetMaterial);
			targetMatCell.SetData(item, long.MinValue, ItemUIComponentBase.InitType.BloodBottleMaterialInCangePanel, ItemUIComponentBase.ItemCountShowType.OneSide);
			if (targetMatCell is BloodBottleMaterialUIComponent bloodBottleMaterialUIComponent)
			{
				bloodBottleMaterialUIComponent.m_BelongBottleIcon.BloodBottleData = null;
			}
			targetMatCell.UpdatePerformance();
			RegisterBtnEvent();
		}
	}

	private void RegisterBtnEvent()
	{
		cancelBtn.SetBtnClick(() =>
		{
			m_data.cancelEvt?.Invoke();
			Close();
		});
		confirmBtn.SetBtnClick(() =>
		{
			m_data.confirmEvt?.Invoke();
			Close();
		});
		closeBtn.SetBtnClick(() =>
		{
			m_data.cancelEvt?.Invoke();
			Close();
		});
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
		targetMatCell.Release();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}
}
