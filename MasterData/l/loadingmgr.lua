---@class LoadingMgr
local LoadingMgr = class("LoadingMgr")

function LoadingMgr:ctor()
	self:Init()
end

function LoadingMgr:Init()
	self._switchStart = false
	self._pendingCallback = nil
	self._pendingNeedGalo = nil
	self.emptySatateTest = false
	if EngineGlobal.checkMemory then
		self.emptySatateTest = true
	end
end


function LoadingMgr:SendLoadingStartEvent(key, source)
	local data = {
		source = source,
		event_type = 79,
		distinct_id = SDKMgr:getDistinctId(),
		stage = key
	}
	-- ThinkingAnalytics:track(key, data)
	ClientData:sendDailyLogMessage(data)
end

--设置转场加载界面
---@param callBack function?
---@param needGalo boolean?
---@param notLoadScene boolean?
---@param source string? 来源界面名；同脚本多次调用时后续加 2/3...
function LoadingMgr:SetLoadingStart(callBack, needGalo, notLoadScene, source)
	self:SendLoadingStartEvent("loading_start", source)
	UIMgr:hideClickEffect()
	if not self.emptySatateTest or notLoadScene then
		UIMgr:popLoadingUI("InterludeLoadingPanel",{call = callBack, needGalo = needGalo})
	else
		self._pendingCallback = callBack
		self._pendingNeedGalo = needGalo
		StateMgr:ChangeToState(GameFlowState.EmptyState)
	end
end

--更新进度条
--@param {number} progress 进度
function LoadingMgr:UpdateProgress(progress)
	local InterludeLoadingPanel = UIMgr:getUIData("InterludeLoadingPanel")
	if InterludeLoadingPanel then
		InterludeLoadingPanel.ui:UpdateProgress(progress)
	end
end

--结束转场加载
---@param callbackAhead function?  提前回调函数 直接调用
---@param callBack function?  回调函数 等loading界面动画结束后调用
---@param source string? 来源界面名；同脚本多次调用时后续加 2/3...
function LoadingMgr:SetLoadingOver(callbackAhead, callBack, source)
LuaLogger.ds("SetLoadingOver")
	self:SendLoadingStartEvent("loading_end", source)
	local InterludeLoadingPanel = UIMgr:getUIData("InterludeLoadingPanel")
	if InterludeLoadingPanel then
		---@type InterludeLoadingPanel
		local InterludeLoadingPanelUI = InterludeLoadingPanel.ui
		InterludeLoadingPanelUI:PlayOverAnim(callBack)
	else
		if (callBack) then
			callBack()
		end
	end
	if callbackAhead then
		callbackAhead()
	end
end

---设置UI切换开始
---@param callBack function 回调函数
function LoadingMgr:SetUISwitchStart(callBack, isQuick)
	self._switchStart = true
	UIMgr:popLoadingUI("UISwitchPanel",{callBack = callBack, isQuick = isQuick})
end

---设置UI切换结束
---@param callBack function 回调函数
---@param callbackAhead function 提前回调函数
function LoadingMgr:SetUISwitchOver(callBack, isQuick)
	if not self._switchStart then
		if callBack then
			callBack()
		end
		return
	end
	local UISwitchPanel = UIMgr:getUIData("UISwitchPanel")
	if UISwitchPanel then
		UISwitchPanel.ui:PlayOverAnim(callBack, isQuick)
		self._switchStart = false
	else
		if callBack then
			callBack()
		end
	end
end

---设置UI快速切换开始
---@param callBack function 回调函数
function LoadingMgr:SetUIQuickSwitchStart(callBack)
	if self._switchStart then
		if callBack then
			callBack()
		end
		return
	end
	UIMgr:popLoadingUI("UIQuickSwitchPanel",{callBack = callBack})
end

---设置UI快速切换结束
---@param callBack function 回调函数
---@param callbackAhead function 提前回调函数
function LoadingMgr:SetUIQuickSwitchOver(callBack)
	local UIQuickSwitchPanel = UIMgr:getUIData("UIQuickSwitchPanel")
	if UIQuickSwitchPanel then
		UIQuickSwitchPanel.ui:PlayOverAnim(callBack)
	else
		if callBack then
			callBack()
		end
	end
end

function LoadingMgr:Clear()
	self:Init()
end


return LoadingMgr