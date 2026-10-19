using ACT.Config;
using ACT.Core;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class CharacterTagDetailsView : BaseUIView
{
	private CharacterTagDetailsViewData m_data;

	[SerializeField]
	private ActButton BtnClose;

	[SerializeField]
	private Transform tFCharacterTagDetailItem;

	[SerializeField]
	private GameObject characterTagDetailItemPrefab;

	[SerializeField]
	private CharacterProfessionItem CharacterProfessionItem;

	[SerializeField]
	private CharacterMannerDetailsItem CharacterMannerDetailsItem;

	[SerializeField]
	[Header("通用底板动画")]
	private BetterAnimation _commonBgAnimation;

	[SerializeField]
	[Header("右摇杆滚动支持")]
	private RightStickScrollSupport _rightStickScrollSupport;

	[SerializeField]
	[Header("滚动区域")]
	private ScrollRect _scrollView;

	[SerializeField]
	[Header("滑动提示")]
	private OperateBtnPrompt _scrollOperateBtnPrompt;

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
		BtnClose.SetBtnClick(Close);
		m_data = uiViewData as CharacterTagDetailsViewData;
	}

	protected override void Init()
	{
		base.Init();
		InitPanel();
		RefreshRightStickScrollForbid();
	}

	private void InitPanel()
	{
		EntityCharacterData data = CoreUtils.GetData(m_data.characterId, RuntimeConfigs.data.entityCharacterDatas);
		int[] characterTagGroup = data.characterTagGroup;
		if (tFCharacterTagDetailItem.childCount > 0)
		{
			tFCharacterTagDetailItem.DestroyChildren();
		}
		for (int i = 0; i < characterTagGroup.Length; i++)
		{
			CharacterTagDetailsItem characterTagDetailsItem = UIUtility.AddWidget<CharacterTagDetailsItem>(tFCharacterTagDetailItem, characterTagDetailItemPrefab);
			EntityCharacterTag data2 = CoreUtils.GetData(characterTagGroup[i], RuntimeConfigs.data.entityCharacterTags);
			characterTagDetailsItem.Init(data2, i);
		}
		CharacterProfessionItem.Init(m_data.characterId, Station);
		CharacterMannerDetailsItem.Init(data.mannerType, Station);
	}

	private void RefreshRightStickScrollForbid()
	{
		if (_rightStickScrollSupport == null)
		{
			_rightStickScrollSupport = GetComponentInChildren<RightStickScrollSupport>(includeInactive: true);
		}
		if (_scrollView == null)
		{
			_scrollView = ((_rightStickScrollSupport != null) ? _rightStickScrollSupport.GetComponentInChildren<ScrollRect>(includeInactive: true) : GetComponentInChildren<ScrollRect>(includeInactive: true));
		}
		if (!(_rightStickScrollSupport == null) && !(_scrollView == null))
		{
			Canvas.ForceUpdateCanvases();
			if (_scrollView.content != null)
			{
				LayoutRebuilder.ForceRebuildLayoutImmediate(_scrollView.content);
			}
			bool flag = _scrollView.content != null && _scrollView.viewport != null && _scrollView.content.rect.height > _scrollView.viewport.rect.height;
			_scrollOperateBtnPrompt.SetVisible(flag);
			_rightStickScrollSupport.SetForbidScroll(!flag);
		}
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		_commonBgAnimation.GetSequence("Show").Play();
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		_rightStickScrollSupport?.SetForbidScroll(isForbid: false);
		base.UnInit();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		_commonBgAnimation.GetSequence("Hide").Play();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
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
