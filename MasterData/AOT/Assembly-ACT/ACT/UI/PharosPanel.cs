using ACT.Battle;
using Cinemachine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class PharosPanel : BaseUIView
{
	public class MyParam
	{
		public int LightHouseUId;

		public CinemachineVirtualCamera VirtualCamera;
	}

	public LocalizeStringEvent title;

	public LocalizeStringEvent des;

	private MyParam m_param;

	protected override void Init()
	{
		base.Init();
		m_param = (MyParam)uiViewData;
		MonoECS.instance.PushPauseInput();
		title.StringReference.TableEntryReference = m_param.LightHouseUId + 1879048487;
		des.StringReference.TableEntryReference = m_param.LightHouseUId + 1879048486;
		m_param.VirtualCamera.Priority = 45;
	}

	public void ClickBtn()
	{
		ClickCloseBtn();
	}

	protected override void UnInit()
	{
		base.UnInit();
		MonoECS.instance.PopPauseInput();
	}

	public void ClickCloseBtn()
	{
		Close();
		m_param.VirtualCamera.Priority = 9;
	}
}
