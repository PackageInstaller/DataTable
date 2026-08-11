using Cysharp.Threading.Tasks;

namespace Ase;

public class ParadoxTimelineCasting : ParadoxTimeline
{
	private CastingViewModel _castingViewModel;

	private CastingWindow _castingWindow;

	private float paradoxTime;

	private float duration;

	public override int Group => system.CastingGroup;

	public override int Priority => system.CastingPriority;

	public string CastingPath => _castingViewModel?.CastingPath;

	public ParadoxTimelineCasting(ParadoxTimelineSystem system)
		: base(system)
	{
	}

	public async UniTask LoadCasting(string path)
	{
		if (string.IsNullOrEmpty(path))
		{
			return;
		}
		if (_castingViewModel != null)
		{
			if (!(_castingViewModel.CastingPath != path))
			{
				return;
			}
			if (_castingWindow != null)
			{
				_castingWindow.CloseUI();
			}
			_castingWindow = null;
			_castingViewModel = null;
		}
		_castingViewModel = new CastingViewModel(path);
		_castingWindow = await GameEntry.UI.LoadWindow<CastingWindow>(AssetUtility.GetUIFormAsset(path), "DEFAULT", _castingViewModel);
		if (!(_castingWindow == null) && _castingWindow.AssetPath != AssetUtility.GetUIFormAsset(_castingViewModel?.CastingPath))
		{
			_castingWindow?.CloseUI();
		}
	}

	public override async void SetShow()
	{
		if (!isStart)
		{
			paradoxTime = 0f;
			duration = 0f;
			if (_castingWindow != null)
			{
				_castingWindow.Show();
				duration = 1f * (float)_castingWindow.DelayTime / 1000f;
			}
			isStart = true;
			system?.GetSystem<BattleSystem>().ControlView(isShow: false, xpCastingWindow: true, touchInputMaskState: true);
		}
	}

	public override void SetHide()
	{
		if (_castingViewModel != null)
		{
			Finish();
		}
	}

	public override void OnLateUpdate(float deltaTime)
	{
		if (isStart)
		{
			if (paradoxTime >= duration)
			{
				SetHide();
			}
			else
			{
				paradoxTime += deltaTime;
			}
		}
	}

	public override void Finish(bool isDispose = false)
	{
		isStart = false;
		if (!isDispose)
		{
			system?.FinishTimeline(Group);
		}
		system?.GetSystem<BattleSystem>().ControlView(isShow: true, xpCastingWindow: true);
	}

	public override void Dispose()
	{
		system = null;
		Finish(isDispose: true);
		if (_castingViewModel != null && _castingWindow != null)
		{
			_castingWindow.CloseUI();
		}
		_castingViewModel = null;
		_castingWindow = null;
	}
}
