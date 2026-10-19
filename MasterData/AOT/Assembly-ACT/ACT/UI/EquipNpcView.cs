using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class EquipNpcView : BaseUIView
{
	private EquipNpcViewData m_data;

	[SerializeField]
	private ActToggle m_EquipBuildToggle;

	[SerializeField]
	private ActToggle m_EquipDisolveToggle;

	[SerializeField]
	private ActToggle m_GemRebuildToggle;

	private void Awake()
	{
		m_EquipBuildToggle.onToggleOn.AddListener(OpenEquipBuildView);
		m_EquipDisolveToggle.onToggleOn.AddListener(OpenEquipDissolveView);
		m_GemRebuildToggle.onToggleOn.AddListener(OpenGemRebuildView);
	}

	protected override void OnUnityDestroy()
	{
		m_EquipBuildToggle.onToggleOn.RemoveListener(OpenEquipBuildView);
		m_EquipDisolveToggle.onToggleOn.RemoveListener(OpenEquipDissolveView);
		m_GemRebuildToggle.onToggleOn.RemoveListener(OpenGemRebuildView);
	}

	private void OpenEquipBuildView()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_EQUIPBUILD);
	}

	private void OpenEquipDissolveView()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_EQUIPDISSOLVEVIEW);
	}

	private void OpenGemRebuildView()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_GEMREBUILD);
	}

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
	}

	protected override void Init()
	{
		base.Init();
		m_EquipBuildToggle.Group.SetAllToggleOff();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		if ((bool)betterAnimation)
		{
			betterAnimation.GetSequence("Show")?.OnComplete((AnimationBuilder _) =>
			{
				OpenEffectFinishNew();
			}).Play();
		}
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
		if ((bool)betterAnimation)
		{
			betterAnimation.GetSequence("Hide")?.OnComplete((AnimationBuilder _) =>
			{
				CloseEffectFinishNew();
			}).Play();
		}
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
