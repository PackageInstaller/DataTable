using System.Threading.Tasks;

namespace Ase;

public class LoadingBattleViewModelBase : LoadingSceneViewModel
{
	public uint worldId;

	protected LoadingBattleViewModelBase(WorldData worldData, bool autoLoad)
		: base(worldData, autoLoad)
	{
	}

	protected LoadingBattleViewModelBase()
	{
	}

	protected override void OnLoadingClosed()
	{
		if (loadingSuccess)
		{
			Singleton<GameSystem>.Instance?.WorldStart(worldId);
		}
	}

	protected override async Task OnCloseLoadWindow()
	{
		if (loadingSuccess)
		{
			await Singleton<GameSystem>.Instance.WorldStartBefore(worldId);
		}
	}
}
