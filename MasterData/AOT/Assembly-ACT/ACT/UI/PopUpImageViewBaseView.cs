using System.Collections.Generic;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.UI;

public class PopUpImageViewBaseView : BaseUIView<PopUpImageViewInputController>
{
	protected PopUpImageViewBaseViewData m_data;

	[SerializeField]
	private BImage _image;

	[SerializeField]
	private ActButton _maskBtn;

	[SerializeField]
	[Header("手柄提示组件")]
	public GamePadTipsComp gamePadTips;

	private int index = -1;

	private List<GamePadTipsAction> _tipsActions = new List<GamePadTipsAction>();

	private Dictionary<string, GamePadTipsAction> actionDic = new Dictionary<string, GamePadTipsAction>();

	protected override void AddEventListener()
	{
		_maskBtn.SetBtnClick(Close);
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
	}

	protected override void OnInputControllerCreate()
	{
		base.OnInputControllerCreate();
		InitGameTipsDic();
	}

	private void InitGameTipsDic()
	{
		actionDic.Add("UI/Back", new GamePadTipsAction
		{
			inputAction = "UI/Back",
			localizeKey = 606,
			localizeTable = "Common"
		});
		actionDic.Add("UI/LSLeftRightSelect", new GamePadTipsAction
		{
			inputAction = "UI/LSLeftRightSelect"
		});
	}

	protected override void Init()
	{
		base.Init();
		m_data = uiViewData as PopUpImageViewBaseViewData;
		Station.LoadImage(136, m_data.imageIds[m_data.imageIds.Count - 1], _image);
		index = ((m_data.imageIds.Count > 1) ? (m_data.imageIds.Count - 1) : (-1));
		gamePadTips.ClearAllPrompts();
		if (m_data.imageIds.Count > 1)
		{
			_tipsActions.Add(actionDic["UI/Back"]);
			_tipsActions.Add(actionDic["UI/LSLeftRightSelect"]);
			gamePadTips.RegisterInputActions(_tipsActions);
		}
		else
		{
			_tipsActions.Add(actionDic["UI/Back"]);
			gamePadTips.RegisterInputActions(_tipsActions);
		}
		_image.icon.SetNativeSize();
	}

	public void NextImage()
	{
		if (m_data.imageIds.Count > 1 && index != m_data.imageIds.Count - 1)
		{
			Station.LoadImage(136, m_data.imageIds[++index], _image);
			_image.icon.SetNativeSize();
		}
	}

	public void LastImage()
	{
		if (m_data.imageIds.Count > 1 && index != 0)
		{
			Station.LoadImage(136, m_data.imageIds[--index], _image);
			_image.icon.SetNativeSize();
		}
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
