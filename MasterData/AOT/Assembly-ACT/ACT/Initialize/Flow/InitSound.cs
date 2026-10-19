using System.Linq;
using ACT.Config;
using ACT.Error;
using ACT.Net;
using ACT.Sound;
using Fundamental;
using UnityEngine;

namespace ACT.Initialize.Flow;

public class InitSound : RuntimeLoadFlow
{
	public InitSound()
		: base("InitSound")
	{
	}

	protected override void OnStart()
	{
		base.OnStart();
		WaitInitializer.Start(2L);
		(LuminRuntimeInitializer.RunningFlows.FirstOrDefault((RuntimeLoadFlow x) => x is InitMetaRes) ?? throw new LuminErrorException(CodeType.CLIENT, CodeModule.INITIALIZE_RUNTIME_LOGIC, 1, null, "系统提示", "音频初始化异常")).OnFlowComplete += () =>
		{
			GameLoader gameLoader = LuminRuntimeInitializer.GameLoader;
			MetaRes meta = GameLoader.meta;
			if (gameLoader == null || meta == null)
			{
				Debug.LogError($"音频初始化依赖缺失: GameLoader={gameLoader != null}, MetaRes={meta != null}");
				LuminError.Handle(new LuminErrorException(CodeType.CLIENT, CodeModule.INITIALIZE_RUNTIME_LOGIC, 1, null, "系统提示", "音频初始化异常"), new ErrorHandleOptions(ErrorPresentation.Configured, null, null, null, Application.Quit));
			}
			else
			{
				AudioManager audioManager = Singleton<GameManager>.instance.audioManager;
				audioManager.LoadBanks(gameLoader.PreLoadBanksAssetID, () =>
				{
					WaitInitializer.CompleteOne();
				});
				audioManager.LoadBanks(meta.CommonBanksAssetID, () =>
				{
					WaitInitializer.CompleteOne();
				});
			}
		};
	}
}
