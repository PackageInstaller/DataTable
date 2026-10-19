using ACT.Battle;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public class ExitProtagonistModeCondition : MissionCondition
{
	protected override async void OnInMissionWorld()
	{
		while (!Singleton<ProtagonistManager>.HasInstance() || !Singleton<ProtagonistManager>.instance.IsProtagonist)
		{
			await UniTask.Yield();
			if (!InMissionWorld)
			{
				break;
			}
		}
		if (!InMissionWorld)
		{
			return;
		}
		do
		{
			if (CheckCondition())
			{
				MarkSuccess();
				break;
			}
			await UniTask.Yield();
		}
		while (InMissionWorld);
	}

	private bool CheckCondition()
	{
		if (Singleton<ProtagonistManager>.HasInstance())
		{
			return !Singleton<ProtagonistManager>.instance.IsProtagonist;
		}
		return true;
	}
}
