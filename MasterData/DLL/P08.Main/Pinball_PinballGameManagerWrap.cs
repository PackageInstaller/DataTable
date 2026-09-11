using System;
using System.Collections.Generic;
using LuaInterface;
using Pinball;
using Pinball.Runtime;
using UnityEngine;

public class Pinball_PinballGameManagerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(PinballGameManager), typeof(MonoBehaviour));
		L.RegFunction("UpdateRemoveBlocks", UpdateRemoveBlocks);
		L.RegFunction("InitTurnBasedPinballGame", InitTurnBasedPinballGame);
		L.RegFunction("InitPlayAreaEffect", InitPlayAreaEffect);
		L.RegFunction("DebateInitGame", DebateInitGame);
		L.RegFunction("GMToNextWave", GMToNextWave);
		L.RegFunction("NextStage", NextStage);
		L.RegFunction("AwakeAimLine", AwakeAimLine);
		L.RegFunction("ShootBall", ShootBall);
		L.RegFunction("RoundOver", RoundOver);
		L.RegFunction("GameRestart", GameRestart);
		L.RegFunction("InterruptExitGame", InterruptExitGame);
		L.RegFunction("StopABall", StopABall);
		L.RegFunction("OnResetBlockBreak", OnResetBlockBreak);
		L.RegFunction("OnAffectBlockTriger", OnAffectBlockTriger);
		L.RegFunction("AddNewBall", AddNewBall);
		L.RegFunction("SupplementBlocksAtRandomPoints", SupplementBlocksAtRandomPoints);
		L.RegFunction("BallExplosionInCircle", BallExplosionInCircle);
		L.RegFunction("ExplosionInCircle", ExplosionInCircle);
		L.RegFunction("EnterPortal", EnterPortal);
		L.RegFunction("GetRecoveryBlockValue", GetRecoveryBlockValue);
		L.RegFunction("GetBaseOverTimes", GetBaseOverTimes);
		L.RegFunction("SetAllBallTypeForSkill", SetAllBallTypeForSkill);
		L.RegFunction("SetBallBuffWithCount", SetBallBuffWithCount);
		L.RegFunction("ChangeAllBlockRemainHpForSkill", ChangeAllBlockRemainHpForSkill);
		L.RegFunction("ChangeAllBlockTypeForSkill", ChangeAllBlockTypeForSkill);
		L.RegFunction("ChangeBlockTypeForSkill", ChangeBlockTypeForSkill);
		L.RegFunction("AddBuffToRandomBlocks", AddBuffToRandomBlocks);
		L.RegFunction("SupplementBlocksAtEmptySpace", SupplementBlocksAtEmptySpace);
		L.RegFunction("UpdatePlayerHitNumber", UpdatePlayerHitNumber);
		L.RegFunction("SpareBall", SpareBall);
		L.RegFunction("AffectAroundBlock", AffectAroundBlock);
		L.RegFunction("SavePolygonMap", SavePolygonMap);
		L.RegFunction("LoadPolygonMap", LoadPolygonMap);
		L.RegFunction("AddUIDToRemoveList", AddUIDToRemoveList);
		L.RegFunction("AddUIDToAddList", AddUIDToAddList);
		L.RegFunction("AddUIDToTempList", AddUIDToTempList);
		L.RegFunction("IsRemovedUID", IsRemovedUID);
		L.RegFunction("GetFreeTempBall", GetFreeTempBall);
		L.RegFunction("FreeTempBall", FreeTempBall);
		L.RegFunction("HideBlocks", HideBlocks);
		L.RegFunction("UpdateHiddenBlocks", UpdateHiddenBlocks);
		L.RegFunction("IsBlockHiddenByEnemy", IsBlockHiddenByEnemy);
		L.RegFunction("RestoreHiddenBlocks", RestoreHiddenBlocks);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("Instance", get_Instance, set_Instance);
		L.RegVar("ballTemplate", get_ballTemplate, set_ballTemplate);
		L.RegVar("blockTemplate", get_blockTemplate, set_blockTemplate);
		L.RegVar("ballRootTrs", get_ballRootTrs, set_ballRootTrs);
		L.RegVar("blockRootTrs", get_blockRootTrs, set_blockRootTrs);
		L.RegVar("panelArrowGo", get_panelArrowGo, set_panelArrowGo);
		L.RegVar("PlayAreaEffectList", get_PlayAreaEffectList, set_PlayAreaEffectList);
		L.RegVar("isDebateStage", get_isDebateStage, set_isDebateStage);
		L.RegConstant("WidthSize", 10.0);
		L.RegConstant("HeightSize", 10.0);
		L.RegVar("currentStageIndex", get_currentStageIndex, set_currentStageIndex);
		L.RegConstant("RSETPOSX", 5.0);
		L.RegConstant("RSETPOSY", 0.0);
		L.RegVar("GMDoubleSpeed", get_GMDoubleSpeed, set_GMDoubleSpeed);
		L.RegVar("GMPause", get_GMPause, set_GMPause);
		L.RegVar("currentStartTime", get_currentStartTime, set_currentStartTime);
		L.RegVar("ResetPos", get_ResetPos, set_ResetPos);
		L.RegVar("shootBallCount", get_shootBallCount, set_shootBallCount);
		L.RegVar("collsionCount", get_collsionCount, set_collsionCount);
		L.RegVar("resetCollsionCount", get_resetCollsionCount, set_resetCollsionCount);
		L.RegVar("affectHitDamage", get_affectHitDamage, set_affectHitDamage);
		L.RegVar("BallList", get_BallList, set_BallList);
		L.RegVar("activeBlocks", get_activeBlocks, set_activeBlocks);
		L.RegVar("activePointManager", get_activePointManager, set_activePointManager);
		L.RegVar("cacheActivePointManager", get_cacheActivePointManager, set_cacheActivePointManager);
		L.RegVar("portalCDDic", get_portalCDDic, set_portalCDDic);
		L.RegVar("turnBasedGame", get_turnBasedGame, set_turnBasedGame);
		L.RegVar("isSupplmentFrame", get_isSupplmentFrame, set_isSupplmentFrame);
		L.RegVar("isSupplmenting", get_isSupplmenting, set_isSupplmenting);
		L.RegVar("isExplosionFrame", get_isExplosionFrame, set_isExplosionFrame);
		L.RegVar("explosionBuffRemainCount", get_explosionBuffRemainCount, set_explosionBuffRemainCount);
		L.RegVar("explosionBuffRange", get_explosionBuffRange, set_explosionBuffRange);
		L.RegVar("arrowBuffRemainCount", get_arrowBuffRemainCount, set_arrowBuffRemainCount);
		L.RegVar("CanPlayGuide", get_CanPlayGuide, set_CanPlayGuide);
		L.RegVar("BreakBlockTimes", get_BreakBlockTimes, set_BreakBlockTimes);
		L.RegVar("MapData", get_MapData, set_MapData);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateRemoveBlocks(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1)).UpdateRemoveBlocks();
				return 0;
			case 2:
			{
				PinballGameManager obj = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
				bool needTriggerBlock = LuaDLL.luaL_checkboolean(L, 2);
				obj.UpdateRemoveBlocks(needTriggerBlock);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Pinball.PinballGameManager.UpdateRemoveBlocks");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitTurnBasedPinballGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			PinballGameManager obj = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
			GameObject turnBasedGameGo = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			PinballDataForExchange data = (PinballDataForExchange)ToLua.CheckObject<PinballDataForExchange>(L, 3);
			obj.InitTurnBasedPinballGame(turnBasedGameGo, data);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitPlayAreaEffect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1)).InitPlayAreaEffect();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DebateInitGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PinballGameManager obj = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
			StageData data = (StageData)ToLua.CheckObject<StageData>(L, 2);
			obj.DebateInitGame(data);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GMToNextWave(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1)).GMToNextWave();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int NextStage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1)).NextStage();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AwakeAimLine(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1)).AwakeAimLine();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ShootBall(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1)).ShootBall();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RoundOver(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PinballGameManager obj = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
			bool forceBreak = LuaDLL.luaL_checkboolean(L, 2);
			obj.RoundOver(forceBreak);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GameRestart(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1)).GameRestart();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InterruptExitGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1)).InterruptExitGame();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopABall(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			PinballGameManager obj = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
			Vector2 newResetPos = ToLua.ToVector2(L, 2);
			bool onGround = LuaDLL.luaL_checkboolean(L, 3);
			obj.StopABall(newResetPos, onGround);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnResetBlockBreak(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1)).OnResetBlockBreak();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnAffectBlockTriger(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			PinballGameManager obj = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
			Vector2 blockPos = ToLua.ToVector2(L, 2);
			float[] param = ToLua.CheckNumberArray<float>(L, 3);
			obj.OnAffectBlockTriger(blockPos, param);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddNewBall(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				PinballGameManager obj3 = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
				bool show3 = LuaDLL.luaL_checkboolean(L, 2);
				BallType type3 = (BallType)ToLua.CheckObject(L, 3, typeof(BallType));
				Ball o3 = obj3.AddNewBall(show3, type3);
				ToLua.PushObject(L, o3);
				return 1;
			}
			case 4:
			{
				PinballGameManager obj2 = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
				bool show2 = LuaDLL.luaL_checkboolean(L, 2);
				BallType type2 = (BallType)ToLua.CheckObject(L, 3, typeof(BallType));
				float posX2 = (float)LuaDLL.luaL_checknumber(L, 4);
				Ball o2 = obj2.AddNewBall(show2, type2, posX2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			case 5:
			{
				PinballGameManager obj = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
				bool show = LuaDLL.luaL_checkboolean(L, 2);
				BallType type = (BallType)ToLua.CheckObject(L, 3, typeof(BallType));
				float posX = (float)LuaDLL.luaL_checknumber(L, 4);
				float posY = (float)LuaDLL.luaL_checknumber(L, 5);
				Ball o = obj.AddNewBall(show, type, posX, posY);
				ToLua.PushObject(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Pinball.PinballGameManager.AddNewBall");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SupplementBlocksAtRandomPoints(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1)).SupplementBlocksAtRandomPoints();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int BallExplosionInCircle(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				PinballGameManager obj2 = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
				Vector2 blockPos2 = ToLua.ToVector2(L, 2);
				obj2.BallExplosionInCircle(blockPos2);
				return 0;
			}
			case 3:
			{
				PinballGameManager obj = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
				Vector2 blockPos = ToLua.ToVector2(L, 2);
				float length = (float)LuaDLL.luaL_checknumber(L, 3);
				obj.BallExplosionInCircle(blockPos, length);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Pinball.PinballGameManager.BallExplosionInCircle");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ExplosionInCircle(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				PinballGameManager obj2 = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
				Vector2 blockPos2 = ToLua.ToVector2(L, 2);
				obj2.ExplosionInCircle(blockPos2);
				return 0;
			}
			case 3:
			{
				PinballGameManager obj = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
				Vector2 blockPos = ToLua.ToVector2(L, 2);
				float length = (float)LuaDLL.luaL_checknumber(L, 3);
				obj.ExplosionInCircle(blockPos, length);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Pinball.PinballGameManager.ExplosionInCircle");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnterPortal(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			PinballGameManager obj = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
			Vector2 blockPos = ToLua.ToVector2(L, 2);
			Ball ball = (Ball)ToLua.CheckObject<Ball>(L, 3);
			obj.EnterPortal(blockPos, ball);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetRecoveryBlockValue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int recoveryBlockValue = ((PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1)).GetRecoveryBlockValue();
			LuaDLL.lua_pushinteger(L, recoveryBlockValue);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetBaseOverTimes(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int baseOverTimes = ((PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1)).GetBaseOverTimes();
			LuaDLL.lua_pushinteger(L, baseOverTimes);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetAllBallTypeForSkill(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			PinballGameManager obj = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
			int bType = (int)LuaDLL.luaL_checknumber(L, 2);
			int time = (int)LuaDLL.luaL_checknumber(L, 3);
			float[] param = ToLua.CheckNumberArray<float>(L, 4);
			obj.SetAllBallTypeForSkill(bType, time, param);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetBallBuffWithCount(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			PinballGameManager obj = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
			int buffType = (int)LuaDLL.luaL_checknumber(L, 2);
			int time = (int)LuaDLL.luaL_checknumber(L, 3);
			float[] param = ToLua.CheckNumberArray<float>(L, 4);
			obj.SetBallBuffWithCount(buffType, time, param);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeAllBlockRemainHpForSkill(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PinballGameManager obj = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
			int detla = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.ChangeAllBlockRemainHpForSkill(detla);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeAllBlockTypeForSkill(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			PinballGameManager obj = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
			int blkType = (int)LuaDLL.luaL_checknumber(L, 2);
			int time = (int)LuaDLL.luaL_checknumber(L, 3);
			obj.ChangeAllBlockTypeForSkill(blkType, time);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeBlockTypeForSkill(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 4:
			{
				PinballGameManager obj2 = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
				int blkType2 = (int)LuaDLL.luaL_checknumber(L, 2);
				int count2 = (int)LuaDLL.luaL_checknumber(L, 3);
				int time2 = (int)LuaDLL.luaL_checknumber(L, 4);
				obj2.ChangeBlockTypeForSkill(blkType2, count2, time2);
				return 0;
			}
			case 5:
			{
				PinballGameManager obj = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
				int blkType = (int)LuaDLL.luaL_checknumber(L, 2);
				int count = (int)LuaDLL.luaL_checknumber(L, 3);
				int time = (int)LuaDLL.luaL_checknumber(L, 4);
				float[] param = ToLua.CheckNumberArray<float>(L, 5);
				obj.ChangeBlockTypeForSkill(blkType, count, time, param);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Pinball.PinballGameManager.ChangeBlockTypeForSkill");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddBuffToRandomBlocks(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			PinballGameManager obj = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
			BlockBuffType buffType = (BlockBuffType)ToLua.CheckObject(L, 2, typeof(BlockBuffType));
			int buffCount = (int)LuaDLL.luaL_checknumber(L, 3);
			float[] param = ToLua.CheckNumberArray<float>(L, 4);
			obj.AddBuffToRandomBlocks(buffType, buffCount, param);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SupplementBlocksAtEmptySpace(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				PinballGameManager obj3 = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
				int num3 = (int)LuaDLL.luaL_checknumber(L, 2);
				obj3.SupplementBlocksAtEmptySpace(num3);
				return 0;
			}
			case 3:
			{
				PinballGameManager obj2 = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
				int num2 = (int)LuaDLL.luaL_checknumber(L, 2);
				PolygonType targeType2 = (PolygonType)ToLua.CheckObject(L, 3, typeof(PolygonType));
				obj2.SupplementBlocksAtEmptySpace(num2, targeType2);
				return 0;
			}
			case 4:
			{
				PinballGameManager obj = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
				int num = (int)LuaDLL.luaL_checknumber(L, 2);
				PolygonType targeType = (PolygonType)ToLua.CheckObject(L, 3, typeof(PolygonType));
				float[] param = ToLua.CheckNumberArray<float>(L, 4);
				obj.SupplementBlocksAtEmptySpace(num, targeType, param);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Pinball.PinballGameManager.SupplementBlocksAtEmptySpace");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdatePlayerHitNumber(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			PinballGameManager obj = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
			int changeHp = (int)LuaDLL.luaL_checknumber(L, 2);
			bool isDamageType = LuaDLL.luaL_checkboolean(L, 3);
			obj.UpdatePlayerHitNumber(changeHp, isDamageType);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SpareBall(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				PinballGameManager obj3 = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
				Vector2 blockPos3 = ToLua.ToVector2(L, 2);
				obj3.SpareBall(blockPos3);
				return 0;
			}
			case 3:
			{
				PinballGameManager obj2 = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
				Vector2 blockPos2 = ToLua.ToVector2(L, 2);
				int num2 = (int)LuaDLL.luaL_checknumber(L, 3);
				obj2.SpareBall(blockPos2, num2);
				return 0;
			}
			case 4:
			{
				PinballGameManager obj = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
				Vector2 blockPos = ToLua.ToVector2(L, 2);
				int num = (int)LuaDLL.luaL_checknumber(L, 3);
				bool isBallTrigger = LuaDLL.luaL_checkboolean(L, 4);
				obj.SpareBall(blockPos, num, isBallTrigger);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Pinball.PinballGameManager.SpareBall");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AffectAroundBlock(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			PinballGameManager obj = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
			Vector2 pos = ToLua.ToVector2(L, 2);
			float[] param = ToLua.CheckNumberArray<float>(L, 3);
			obj.AffectAroundBlock(pos, param);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SavePolygonMap(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1)).SavePolygonMap();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadPolygonMap(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1)).LoadPolygonMap();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddUIDToRemoveList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PinballGameManager obj = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
			int uniqueID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.AddUIDToRemoveList(uniqueID);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddUIDToAddList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			PinballGameManager obj = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
			int uniqueID = (int)LuaDLL.luaL_checknumber(L, 2);
			BallPolygon data = (BallPolygon)ToLua.CheckObject<BallPolygon>(L, 3);
			obj.AddUIDToAddList(uniqueID, data);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddUIDToTempList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			PinballGameManager obj = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
			int uniqueID = (int)LuaDLL.luaL_checknumber(L, 2);
			BallPolygon data = (BallPolygon)ToLua.CheckObject<BallPolygon>(L, 3);
			obj.AddUIDToTempList(uniqueID, data);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsRemovedUID(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PinballGameManager obj = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
			int uniqueID = (int)LuaDLL.luaL_checknumber(L, 2);
			bool value = obj.IsRemovedUID(uniqueID);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetFreeTempBall(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Ball freeTempBall = ((PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1)).GetFreeTempBall();
			ToLua.PushObject(L, freeTempBall);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FreeTempBall(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PinballGameManager obj = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
			Ball ball = (Ball)ToLua.CheckObject<Ball>(L, 2);
			obj.FreeTempBall(ball);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int HideBlocks(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				PinballGameManager obj2 = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
				int hiddenCount2 = (int)LuaDLL.luaL_checknumber(L, 2);
				int hiddenRound2 = (int)LuaDLL.luaL_checknumber(L, 3);
				obj2.HideBlocks(hiddenCount2, hiddenRound2);
				return 0;
			}
			case 4:
			{
				PinballGameManager obj = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
				int hiddenCount = (int)LuaDLL.luaL_checknumber(L, 2);
				int hiddenRound = (int)LuaDLL.luaL_checknumber(L, 3);
				bool isEnemySkill = LuaDLL.luaL_checkboolean(L, 4);
				obj.HideBlocks(hiddenCount, hiddenRound, isEnemySkill);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Pinball.PinballGameManager.HideBlocks");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateHiddenBlocks(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1)).UpdateHiddenBlocks();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsBlockHiddenByEnemy(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PinballGameManager obj = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1);
			int blockID = (int)LuaDLL.luaL_checknumber(L, 2);
			bool value = obj.IsBlockHiddenByEnemy(blockID);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RestoreHiddenBlocks(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 1)).RestoreHiddenBlocks();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int op_Equality(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEngine.Object obj = (UnityEngine.Object)ToLua.ToObject(L, 1);
			UnityEngine.Object obj2 = (UnityEngine.Object)ToLua.ToObject(L, 2);
			bool value = obj == obj2;
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Instance(IntPtr L)
	{
		try
		{
			ToLua.Push(L, PinballGameManager.Instance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ballTemplate(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<GameObject> ballTemplate = ((PinballGameManager)obj).ballTemplate;
			ToLua.PushSealed(L, ballTemplate);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ballTemplate on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_blockTemplate(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<GameObject> blockTemplate = ((PinballGameManager)obj).blockTemplate;
			ToLua.PushSealed(L, blockTemplate);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index blockTemplate on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ballRootTrs(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform ballRootTrs = ((PinballGameManager)obj).ballRootTrs;
			ToLua.Push(L, ballRootTrs);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ballRootTrs on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_blockRootTrs(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform blockRootTrs = ((PinballGameManager)obj).blockRootTrs;
			ToLua.Push(L, blockRootTrs);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index blockRootTrs on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_panelArrowGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject panelArrowGo = ((PinballGameManager)obj).panelArrowGo;
			ToLua.PushSealed(L, panelArrowGo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index panelArrowGo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_PlayAreaEffectList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<ParticleSystem> playAreaEffectList = ((PinballGameManager)obj).PlayAreaEffectList;
			ToLua.PushSealed(L, playAreaEffectList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index PlayAreaEffectList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isDebateStage(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isDebateStage = ((PinballGameManager)obj).isDebateStage;
			LuaDLL.lua_pushboolean(L, isDebateStage);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isDebateStage on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_currentStageIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int currentStageIndex = ((PinballGameManager)obj).currentStageIndex;
			LuaDLL.lua_pushinteger(L, currentStageIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index currentStageIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_GMDoubleSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool gMDoubleSpeed = ((PinballGameManager)obj).GMDoubleSpeed;
			LuaDLL.lua_pushboolean(L, gMDoubleSpeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index GMDoubleSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_GMPause(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool gMPause = ((PinballGameManager)obj).GMPause;
			LuaDLL.lua_pushboolean(L, gMPause);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index GMPause on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_currentStartTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float currentStartTime = ((PinballGameManager)obj).currentStartTime;
			LuaDLL.lua_pushnumber(L, currentStartTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index currentStartTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ResetPos(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 resetPos = ((PinballGameManager)obj).ResetPos;
			ToLua.Push(L, resetPos);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ResetPos on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_shootBallCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int shootBallCount = ((PinballGameManager)obj).shootBallCount;
			LuaDLL.lua_pushinteger(L, shootBallCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shootBallCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_collsionCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int collsionCount = ((PinballGameManager)obj).collsionCount;
			LuaDLL.lua_pushinteger(L, collsionCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index collsionCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_resetCollsionCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int resetCollsionCount = ((PinballGameManager)obj).resetCollsionCount;
			LuaDLL.lua_pushinteger(L, resetCollsionCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index resetCollsionCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_affectHitDamage(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int affectHitDamage = ((PinballGameManager)obj).affectHitDamage;
			LuaDLL.lua_pushinteger(L, affectHitDamage);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index affectHitDamage on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_BallList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<Ball> ballList = ((PinballGameManager)obj).BallList;
			ToLua.PushSealed(L, ballList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index BallList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_activeBlocks(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dictionary<int, BallPolygon> activeBlocks = ((PinballGameManager)obj).activeBlocks;
			ToLua.PushSealed(L, activeBlocks);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index activeBlocks on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_activePointManager(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dictionary<int, PathNodeManager> activePointManager = ((PinballGameManager)obj).activePointManager;
			ToLua.PushSealed(L, activePointManager);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index activePointManager on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cacheActivePointManager(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dictionary<int, PathNodeManager> cacheActivePointManager = ((PinballGameManager)obj).cacheActivePointManager;
			ToLua.PushSealed(L, cacheActivePointManager);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cacheActivePointManager on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_portalCDDic(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dictionary<int, float> portalCDDic = ((PinballGameManager)obj).portalCDDic;
			ToLua.PushSealed(L, portalCDDic);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index portalCDDic on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_turnBasedGame(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballTurnBasedGame turnBasedGame = ((PinballGameManager)obj).turnBasedGame;
			ToLua.Push(L, turnBasedGame);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index turnBasedGame on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isSupplmentFrame(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isSupplmentFrame = ((PinballGameManager)obj).isSupplmentFrame;
			LuaDLL.lua_pushboolean(L, isSupplmentFrame);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isSupplmentFrame on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isSupplmenting(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isSupplmenting = ((PinballGameManager)obj).isSupplmenting;
			LuaDLL.lua_pushboolean(L, isSupplmenting);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isSupplmenting on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isExplosionFrame(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isExplosionFrame = ((PinballGameManager)obj).isExplosionFrame;
			LuaDLL.lua_pushboolean(L, isExplosionFrame);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isExplosionFrame on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_explosionBuffRemainCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int explosionBuffRemainCount = ((PinballGameManager)obj).explosionBuffRemainCount;
			LuaDLL.lua_pushinteger(L, explosionBuffRemainCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index explosionBuffRemainCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_explosionBuffRange(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float explosionBuffRange = ((PinballGameManager)obj).explosionBuffRange;
			LuaDLL.lua_pushnumber(L, explosionBuffRange);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index explosionBuffRange on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_arrowBuffRemainCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int arrowBuffRemainCount = ((PinballGameManager)obj).arrowBuffRemainCount;
			LuaDLL.lua_pushinteger(L, arrowBuffRemainCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index arrowBuffRemainCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_CanPlayGuide(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool canPlayGuide = ((PinballGameManager)obj).CanPlayGuide;
			LuaDLL.lua_pushboolean(L, canPlayGuide);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index CanPlayGuide on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_BreakBlockTimes(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int breakBlockTimes = ((PinballGameManager)obj).BreakBlockTimes;
			LuaDLL.lua_pushinteger(L, breakBlockTimes);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index BreakBlockTimes on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MapData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballMapGenerateData mapData = ((PinballGameManager)obj).MapData;
			ToLua.PushObject(L, mapData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index MapData on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_Instance(IntPtr L)
	{
		try
		{
			PinballGameManager.Instance = (PinballGameManager)ToLua.CheckObject<PinballGameManager>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ballTemplate(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballGameManager obj2 = (PinballGameManager)obj;
			List<GameObject> ballTemplate = (List<GameObject>)ToLua.CheckObject(L, 2, typeof(List<GameObject>));
			obj2.ballTemplate = ballTemplate;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ballTemplate on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_blockTemplate(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballGameManager obj2 = (PinballGameManager)obj;
			List<GameObject> blockTemplate = (List<GameObject>)ToLua.CheckObject(L, 2, typeof(List<GameObject>));
			obj2.blockTemplate = blockTemplate;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index blockTemplate on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ballRootTrs(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballGameManager obj2 = (PinballGameManager)obj;
			Transform ballRootTrs = (Transform)ToLua.CheckObject<Transform>(L, 2);
			obj2.ballRootTrs = ballRootTrs;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ballRootTrs on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_blockRootTrs(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballGameManager obj2 = (PinballGameManager)obj;
			Transform blockRootTrs = (Transform)ToLua.CheckObject<Transform>(L, 2);
			obj2.blockRootTrs = blockRootTrs;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index blockRootTrs on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_panelArrowGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballGameManager obj2 = (PinballGameManager)obj;
			GameObject panelArrowGo = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.panelArrowGo = panelArrowGo;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index panelArrowGo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_PlayAreaEffectList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballGameManager obj2 = (PinballGameManager)obj;
			List<ParticleSystem> playAreaEffectList = (List<ParticleSystem>)ToLua.CheckObject(L, 2, typeof(List<ParticleSystem>));
			obj2.PlayAreaEffectList = playAreaEffectList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index PlayAreaEffectList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isDebateStage(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballGameManager obj2 = (PinballGameManager)obj;
			bool isDebateStage = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isDebateStage = isDebateStage;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isDebateStage on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_currentStageIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballGameManager obj2 = (PinballGameManager)obj;
			int currentStageIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.currentStageIndex = currentStageIndex;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index currentStageIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_GMDoubleSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballGameManager obj2 = (PinballGameManager)obj;
			bool gMDoubleSpeed = LuaDLL.luaL_checkboolean(L, 2);
			obj2.GMDoubleSpeed = gMDoubleSpeed;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index GMDoubleSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_GMPause(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballGameManager obj2 = (PinballGameManager)obj;
			bool gMPause = LuaDLL.luaL_checkboolean(L, 2);
			obj2.GMPause = gMPause;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index GMPause on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_currentStartTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballGameManager obj2 = (PinballGameManager)obj;
			float currentStartTime = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.currentStartTime = currentStartTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index currentStartTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ResetPos(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballGameManager obj2 = (PinballGameManager)obj;
			Vector2 resetPos = ToLua.ToVector2(L, 2);
			obj2.ResetPos = resetPos;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ResetPos on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_shootBallCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballGameManager obj2 = (PinballGameManager)obj;
			int shootBallCount = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.shootBallCount = shootBallCount;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shootBallCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_collsionCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballGameManager obj2 = (PinballGameManager)obj;
			int collsionCount = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.collsionCount = collsionCount;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index collsionCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_resetCollsionCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballGameManager obj2 = (PinballGameManager)obj;
			int resetCollsionCount = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.resetCollsionCount = resetCollsionCount;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index resetCollsionCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_affectHitDamage(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballGameManager obj2 = (PinballGameManager)obj;
			int affectHitDamage = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.affectHitDamage = affectHitDamage;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index affectHitDamage on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_BallList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballGameManager obj2 = (PinballGameManager)obj;
			List<Ball> ballList = (List<Ball>)ToLua.CheckObject(L, 2, typeof(List<Ball>));
			obj2.BallList = ballList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index BallList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_activeBlocks(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballGameManager obj2 = (PinballGameManager)obj;
			Dictionary<int, BallPolygon> activeBlocks = (Dictionary<int, BallPolygon>)ToLua.CheckObject(L, 2, typeof(Dictionary<int, BallPolygon>));
			obj2.activeBlocks = activeBlocks;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index activeBlocks on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_activePointManager(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballGameManager obj2 = (PinballGameManager)obj;
			Dictionary<int, PathNodeManager> activePointManager = (Dictionary<int, PathNodeManager>)ToLua.CheckObject(L, 2, typeof(Dictionary<int, PathNodeManager>));
			obj2.activePointManager = activePointManager;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index activePointManager on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cacheActivePointManager(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballGameManager obj2 = (PinballGameManager)obj;
			Dictionary<int, PathNodeManager> cacheActivePointManager = (Dictionary<int, PathNodeManager>)ToLua.CheckObject(L, 2, typeof(Dictionary<int, PathNodeManager>));
			obj2.cacheActivePointManager = cacheActivePointManager;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cacheActivePointManager on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_portalCDDic(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballGameManager obj2 = (PinballGameManager)obj;
			Dictionary<int, float> portalCDDic = (Dictionary<int, float>)ToLua.CheckObject(L, 2, typeof(Dictionary<int, float>));
			obj2.portalCDDic = portalCDDic;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index portalCDDic on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_turnBasedGame(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballGameManager obj2 = (PinballGameManager)obj;
			PinballTurnBasedGame turnBasedGame = (PinballTurnBasedGame)ToLua.CheckObject<PinballTurnBasedGame>(L, 2);
			obj2.turnBasedGame = turnBasedGame;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index turnBasedGame on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isSupplmentFrame(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballGameManager obj2 = (PinballGameManager)obj;
			bool isSupplmentFrame = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isSupplmentFrame = isSupplmentFrame;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isSupplmentFrame on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isSupplmenting(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballGameManager obj2 = (PinballGameManager)obj;
			bool isSupplmenting = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isSupplmenting = isSupplmenting;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isSupplmenting on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isExplosionFrame(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballGameManager obj2 = (PinballGameManager)obj;
			bool isExplosionFrame = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isExplosionFrame = isExplosionFrame;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isExplosionFrame on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_explosionBuffRemainCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballGameManager obj2 = (PinballGameManager)obj;
			int explosionBuffRemainCount = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.explosionBuffRemainCount = explosionBuffRemainCount;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index explosionBuffRemainCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_explosionBuffRange(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballGameManager obj2 = (PinballGameManager)obj;
			float explosionBuffRange = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.explosionBuffRange = explosionBuffRange;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index explosionBuffRange on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_arrowBuffRemainCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballGameManager obj2 = (PinballGameManager)obj;
			int arrowBuffRemainCount = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.arrowBuffRemainCount = arrowBuffRemainCount;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index arrowBuffRemainCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_CanPlayGuide(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballGameManager obj2 = (PinballGameManager)obj;
			bool canPlayGuide = LuaDLL.luaL_checkboolean(L, 2);
			obj2.CanPlayGuide = canPlayGuide;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index CanPlayGuide on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_BreakBlockTimes(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballGameManager obj2 = (PinballGameManager)obj;
			int breakBlockTimes = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.BreakBlockTimes = breakBlockTimes;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index BreakBlockTimes on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_MapData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballGameManager obj2 = (PinballGameManager)obj;
			PinballMapGenerateData mapData = (PinballMapGenerateData)ToLua.CheckObject<PinballMapGenerateData>(L, 2);
			obj2.MapData = mapData;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index MapData on a nil value");
		}
	}
}
