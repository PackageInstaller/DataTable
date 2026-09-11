using BilliardGame.Runtime;
using BilliardGame.Spell;

namespace BilliardGame;

public class BilliardGameScene : BilliardGameSceneLoader
{
	private BilliardGameManager gameMgr;

	private EasyObjectPoolManager easyPoolMgr;

	private BilliardGameSpellManager spellMgr;

	public static BilliardStageContext Context;

	public override void OnSceneEnter()
	{
		easyPoolMgr = new EasyObjectPoolManager();
		easyPoolMgr.Init();
		BilliardGameDataManager.Init();
		BilliardGameAudioManager.Init();
		gameMgr = new BilliardGameManager();
		gameMgr.Init();
		spellMgr = new BilliardGameSpellManager();
		spellMgr.Init();
		LuaHelper.CallFunction("OnBilliardGameEnter");
	}

	private void PreloadGameBullets()
	{
		BilliardGameObjectPool instance = BilliardGameObjectPool.Instance;
		instance.PreloadBullets("BilliardGame/Bullet/billiard_physical_bullet", 160);
		instance.PreloadBullets("BilliardGame/Bullet/billiard_physical_bullet_burn", 160);
		instance.PreloadBullets("BilliardGame/Bullet/billiard_physical_bullet_vehicle", 160);
	}

	public override void OnSceneLoaded()
	{
		base.OnSceneLoaded();
		if (!BilliardGameDataManager.IsBallGame())
		{
			PreloadGameBullets();
		}
		LuaHelper.CallFunction("OnBilliardGameLoaded");
	}

	public override void OnSceneReady()
	{
		LuaHelper.CallFunction("OnBilliardGameReady");
	}

	public override void OnSceneExit(NScene nextScene)
	{
		BilliardGameLogicManager.Instance?.SetOver(isOver: true);
		gameMgr.Dispose();
		gameMgr = null;
		easyPoolMgr.Dispose();
		easyPoolMgr = null;
		spellMgr.Dispose();
		spellMgr = null;
		BilliardGameObjectPool.Dispose();
		BilliardGameDataManager.Dispose();
		BilliardGameAudioManager.Dispose();
		LuaHelper.CallFunction("OnBilliardGameExit");
	}
}
