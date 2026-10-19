using ACT.Battle;
using ACT.EventTrack;
using ACT.Sound;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class ConnectionMiniGameView : BaseUIView<ConnectionMiniGameViewInputController>
{
	private ConnectionMiniGameViewData m_data;

	public SeparateSegment separateSegment;

	public ViewControlRoot viewControlRoot;

	public ViewControlLayer viewControlLayer;

	public GamePadTipsComp gamePadTipsComp;

	[SerializeField]
	private ActButton _closeButton;

	[SerializeField]
	private string _showAnimation;

	[SerializeField]
	private string _successAnimation;

	[SerializeField]
	private string _failAnimation;

	private bool _success;

	private uint _loopSoundHandle;

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
		_success = false;
		m_data = (ConnectionMiniGameViewData)uiViewData;
		separateSegment.Init(Finish, m_data?.separateSegmentConfig);
		_closeButton.SetBtnClick(Fail);
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/UAV/UAV_Fix");
		_loopSoundHandle = Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/UAV/UAV_Fix_Loop", new AudioPlayOptions
		{
			attachTarget = transform
		});
		MonoECS.instance.PushPause();
		int swid = m_data.swid;
		CasualGameplayEvent evt = EventTrackSolver.Instance.GetEvt<CasualGameplayEvent>();
		evt.swid = swid;
		evt.status = 1;
		evt.opNum = separateSegment.GetConnectCount();
		EventTrackSolver.Instance.Dispatch(evt);
	}

	protected override void PlayOpenAnimation()
	{
		betterAnimation.GetSequence(_showAnimation).OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void PlayCloseAnimation()
	{
		if (_success)
		{
			betterAnimation.GetSequence(_successAnimation).OnComplete((AnimationBuilder _) =>
			{
				CloseEffectFinishNew();
			}).Play();
		}
		else
		{
			betterAnimation.GetSequence(_failAnimation).OnComplete((AnimationBuilder _) =>
			{
				CloseEffectFinishNew();
			}).Play();
		}
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void OnSetSortingLayer(int layer)
	{
		base.OnSetSortingLayer(layer);
		separateSegment.SetSortingLayer(ContentCanvas.sortingLayerID);
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public void Fail()
	{
		_success = false;
		Close();
		int swid = m_data.swid;
		CasualGameplayEvent evt = EventTrackSolver.Instance.GetEvt<CasualGameplayEvent>();
		evt.swid = swid;
		evt.status = 3;
		evt.opNum = separateSegment.GetConnectCount();
		EventTrackSolver.Instance.Dispatch(evt);
	}

	public override void Close()
	{
		MonoECS.instance.PopPause();
		Singleton<GameManager>.instance.audioManager.Stop(_loopSoundHandle);
		m_data.callback?.Invoke(!_success);
		if (_success)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/UAV/UAV_Fix_Success");
		}
		else
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/UAV/UAV_Fix_Fail");
		}
		base.Close();
	}

	public void Finish()
	{
		_success = true;
		Close();
		int swid = m_data.swid;
		CasualGameplayEvent evt = EventTrackSolver.Instance.GetEvt<CasualGameplayEvent>();
		evt.swid = swid;
		evt.status = 2;
		evt.opNum = separateSegment.GetConnectCount();
		EventTrackSolver.Instance.Dispatch(evt);
	}
}
