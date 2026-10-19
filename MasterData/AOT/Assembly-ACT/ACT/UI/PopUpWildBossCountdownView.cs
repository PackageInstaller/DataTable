using ACT.Core;
using ACT.Model;
using ACT.Utility;
using ACT.World.Asset;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class PopUpWildBossCountdownView : BaseUIView<PopUpWildBossCountdownViewInputController>
{
	private PopUpWildBossCountdownViewData m_data;

	[SerializeField]
	private LocalizeStringEvent _countDown3VariablesEvent;

	[SerializeField]
	private LocalizeStringEvent _countDown4VariablesEvent;

	[SerializeField]
	private TextMeshProUGUI _countDownText;

	[SerializeField]
	[Header("关闭按钮")]
	private ActButton _closeBtn;

	[SerializeField]
	[Header("确认按钮")]
	private ActButton _confirmBtn;

	private const int CommonStartId = 679;

	private const string Show = "Show";

	private const string Hide = "Hide";

	private void Awake()
	{
		_closeBtn.SetBtnClick(CloseViewAction);
		_confirmBtn.SetBtnClick(ConfirmAction);
	}

	protected override void OnUnityDestroy()
	{
		_closeBtn.OnClick.RemoveAllListeners();
		_confirmBtn.OnClick.RemoveAllListeners();
	}

	private void CloseViewAction()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Return_Click");
		Close();
	}

	private void ConfirmAction()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Button_Click");
		Close();
	}

	public void CloseByGamePad()
	{
		CloseViewAction();
	}

	public void ConfirmByGamePad()
	{
		ConfirmAction();
	}

	public override UniTask PreInit()
	{
		m_data = uiViewData as PopUpWildBossCountdownViewData;
		return base.PreInit();
	}

	private string GetRefreshDayString(int day)
	{
		return day switch
		{
			1 => LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.Monday), 
			2 => LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.Tuesday), 
			3 => LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.Wednesday), 
			4 => LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.Thursday), 
			5 => LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.Friday), 
			6 => LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.Saturday), 
			7 => LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.Sunday), 
			_ => null, 
		};
	}

	protected override void Init()
	{
		base.Init();
		if (!(Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(m_data.monsterPointUid) is MonsterPointData { monsterPointId: var monsterPointId }))
		{
			return;
		}
		int[] refreshTime = Model<WildBossModel>.Interface.GetRefreshTime(monsterPointId);
		if (refreshTime.Length == 0)
		{
			Debug.LogError($"野外boss怪点id->{monsterPointId}不在wildBossUses表中？请检查配置！");
			return;
		}
		int nameLocal = CoreUtils.GetData(CoreUtils.DetermineActualMonster(monsterPointId), RuntimeConfigs.data.entityDatas).nameLocal;
		string localizeString = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, nameLocal);
		if (refreshTime.Length == 2)
		{
			_countDown3VariablesEvent.gameObject.SetActive(value: true);
			_countDown4VariablesEvent.gameObject.SetActive(value: false);
			_countDown3VariablesEvent.StringReference.GetVariable<string>("0").Value = localizeString;
			_countDown3VariablesEvent.StringReference.GetVariable<string>("1").Value = GetRefreshDayString(refreshTime[0]);
			_countDown3VariablesEvent.StringReference.GetVariable<string>("2").Value = GetRefreshDayString(refreshTime[1]);
		}
		else if (refreshTime.Length == 3)
		{
			_countDown3VariablesEvent.gameObject.SetActive(value: false);
			_countDown4VariablesEvent.gameObject.SetActive(value: true);
			_countDown4VariablesEvent.StringReference.GetVariable<string>("0").Value = localizeString;
			_countDown4VariablesEvent.StringReference.GetVariable<string>("1").Value = GetRefreshDayString(refreshTime[0]);
			_countDown4VariablesEvent.StringReference.GetVariable<string>("2").Value = GetRefreshDayString(refreshTime[1]);
			_countDown4VariablesEvent.StringReference.GetVariable<string>("3").Value = GetRefreshDayString(refreshTime[2]);
		}
		_countDownText.text = Model<WildBossModel>.Interface.GetRemainTime(monsterPointId);
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}
}
