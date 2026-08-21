require "FSM"
require "GameFlowState"

---@class EmptyState : FSMState
local EmptyState = FSMState:new("EmptyState", GameFlowState.EmptyState)

function EmptyState:enter()
	print("!!!!!!!!!!!!!!!!!!!!!!!EmptyState:enter")
	UIMgr:switchUIDataGroup(UIGroup.Empty)
	local endFunc = function()
		UIMgr:popUIBase("EmptyScenePanel", nil, nil, nil, nil, function()
			LuaLogger.ds("EmptyState:EmptyScenePanel callback", debug.traceback())
			LoadingMgr:SetLoadingOver(nil, nil, "EmptyState")
		end)
	end

	--加载场景
	-- local asyncOperation = UnityEngine.SceneManagement.SceneManager.LoadSceneAsync("EmptyScene")
	-- LuaLogger.ds("EmptyScene LoadSceneAsync", asyncOperation)
	-- if asyncOperation then
	-- 	self.loadSceneTimer = DLuaTimer:DoRepeatForever(0.1, function()
	-- 		LuaLogger.ds("EmptyScene loadSceneTimer", asyncOperation.isDone)
	-- 		if (asyncOperation.isDone) then
	-- 			endFunc()
	-- 			DLuaTimer:RemoveTimer(self.loadSceneTimer)
	-- 		end
	-- 	end)
	-- else
	-- 	endFunc()
	-- end

	ResMgr:LoadSceneAsyncLua(Config.ScenePath.EmptyScene, false, function(sceneName)
        endFunc()
    end)
end


function EmptyState:update()

end

function EmptyState:exit()
	print("!!!!!!!!!!!!!!!!!!!!!!!EmptyState:exit")

	-- if self.baseCamera then
	-- 	self.baseCamera.gameObject:SetActive(true)
	-- end
	-- ClientData:PauseSyncServerTime()

	UIMgr:clearAllUI(false)
	UIMgr:ClearLoader()
	PoolMgr:Clear()
	SeaMapMgr:Clear()
	-- AssetManager.Instance:UnloadUnusedAssets()
	-- ResMgr:UnloadUnusedBundles(true)
end

return EmptyState