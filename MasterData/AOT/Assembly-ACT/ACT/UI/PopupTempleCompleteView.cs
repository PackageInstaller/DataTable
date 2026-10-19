using ACT.Game;
using ACT.Game.Data;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.UI;

public class PopupTempleCompleteView : BaseUIView
{
	private PopupTempleCompleteViewData m_data;

	private bool m_isOption;

	public MonoScrollBagComponent scrollBag;

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
		m_isOption = false;
		m_data = uiViewData as PopupTempleCompleteViewData;
		if (!m_data.noReward)
		{
			scrollBag.gameObject.SetActive(value: true);
			scrollBag.Init(m_data.scrollBagParam);
		}
		else
		{
			scrollBag.gameObject.SetActive(value: false);
		}
		base.Init();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	public async void LeaveTemple()
	{
		if (!m_isOption)
		{
			m_isOption = true;
			await CloseAsync();
			G.service.LeaveTemple((bool t) =>
			{
				Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Main);
			});
		}
	}

	public async void ReChallenge()
	{
		if (m_isOption)
		{
			return;
		}
		m_isOption = true;
		await CloseAsync();
		await Singleton<GameManager>.instance.worldManager.LeaveWorld();
		G.service.TempleRechallenge((bool t) =>
		{
			if (t)
			{
				Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Temple).Forget();
			}
		});
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
