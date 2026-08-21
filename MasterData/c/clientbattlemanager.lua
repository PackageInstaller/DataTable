require "class"
---@class ClientBattleManager:BaseClass 负责前端战斗的表现，演出，战报播放等
local ClientBattleManager = class("ClientBattleManager")

---@type ClientBattleManager
local instance = nil

local contentStr = ","
local formationDataStr = ":"
local levelFormationIdListKey = "levelFormationIdList%s"
local maxSaveFormationCount = 6
---@type table<integer, FormationInfo[]>
local savedFormationLIst = {}

function ClientBattleManager:ctor()
    
end

---@return ClientBattleManager
function ClientBattleManager.getInstance()
    if not instance then
        instance = ClientBattleManager:new()
    end
    return instance
end

function ClientBattleManager:Init()
    self._battleMgr = BattleCore:getBattleMgr()
    local BattleInputManager = require "BattleInputManager"
    local battleShowManager = require "BattleShowManager"
    local reportPlayer = require "ReportPlayer"
    local BattleStoryManager = require "BattleStoryManager"

    ---@type BattleShowManager
    self._showMgr = battleShowManager:new()

    ---@type BattleInputManager
    self._inputMgr = BattleInputManager:new()
    self._inputMgr:init(self._battleMgr, self)
    self._inputMgr:SetShowManager(self._showMgr)

    ---@type ReportPlayer
	self._reportPlayer = reportPlayer:new()
	self._reportPlayer:initShowManger(self._showMgr)
	self._reportPlayer:initReportEvent()
    self._roleMgr = self._battleMgr:getRoleManager()
    self._battleReporter = self._battleMgr:getReporter()

    self._storyMgr = BattleStoryManager.instance()

    self._map = self._battleMgr:getMap()
    self._showMgr:setMap(self._map)

	self:initBattleStateEvent()
	self._pendingLoseBacktrace = false
	self._pendingBacktraceIsWin = false
	self._battleMgr:registerLoseConfirmHandler(function(isWin)
		return self:tryShowLoseBacktraceConfirm(isWin)
	end)
    self._battleMgr:registerClientGameOverCallback(function(resultData)
        self:EndBattle(resultData)
    end)

	self._battleMgr:registerClientShowEvent(GE.ClientBattleShowType.PreMove, function(data)
		local role = data.role
		local sourceBlock = data.sourceBlock
		local chooseBlock = data.chooseBlock
		local path = data.path
		local isUseSkill = data.isUseSkill
		local delay = data.delay
		self:BattleRolePreMove(role, sourceBlock, chooseBlock, path, isUseSkill, delay)
	end)

	self._battleMgr:registerClientShowEvent(GE.ClientBattleShowType.ResetPos, function(data)
		self._showMgr:roleMove(data)
		local role = self._roleMgr:getRole(data.id)
		self:checkRoleMoveIsInBePrepareSkillTarget(role)
		if self:isShowDangerBlockRange() then
			self:showDangerRange()
		end
	end)

	self._battleMgr:registerClientShowEvent(GE.ClientBattleShowType.PrepareSkill, function(data)
		local role = data.role
		local playInReport = data.playInReport
		self:checkRoleMoveIsInBePrepareSkillTarget(role, playInReport)
	end)

	self._battleMgr:registerClientShowEvent(GE.ClientBattleShowType.SelectRole, function(data)
		local role = self._battleMgr:getSelectedRole()
		local showBlock = role:getShowBlock()
		local t = self._showMgr:getBlockObj(showBlock.id)
		if t then
			---@type smoothFollowTargetData
			local d = {
				targetPos = t.transform.position,
				type = GE.FollowTargetType.Action,
			}
			self._showMgr:smoothFollowTarget(d)
		end
		self._showMgr:showBlockInfo(showBlock.terrainCfgData)
		self._showMgr:refreshSelectedCube(showBlock.id)
	end)

	self._battleMgr:registerClientShowEvent(GE.ClientBattleShowType.RefreshRoleAction, function(data)
		self:refreshRoleActionState(data.role, data.actionType, data.cancelAnim)
		self._showMgr:removeTargetEffect()
	end)

	self._battleMgr:registerClientShowEvent(GE.ClientBattleShowType.SelectSKillTarget, function(data)
		self:removeMoveRange()
		self:removeSkillRange()
		self:hidePreviewHpChange()
		local role = self._battleMgr:getSelectedRole()
		local skillConfig = Config.GetSkillInfo(role.selectedSkill)
		if skillConfig and not (skillConfig.skillOperateType == GE.SkillOperateType.SelfBlock) then
			local chooseRangeIdList = self._battleMgr:getChooseRangeIdList()
			self:refreshSkillRange(chooseRangeIdList, skillConfig, nil)
			self:uiEnterChooseState()
		end
	end)

	self._isEndBattle = false
	---@type integer[]
	self._formationRangeIdList = {}
	---@type table<integer, boolean>
	self._formationRangeIdKVList = {}
	self._startBattleBlockIds = {}
	self._lastSelectRoleID = -1
	self._lastSkillSelectBlockId = nil
	self._battleSpeed = 1
	self._finishFormation = false
	self._chooseTargetState = false
	self._isShowDangerRange = false
	---@type CoveScene
	self.coveScene = nil
	self._showPreviewHpList = {}
	self._waitCreateRoleNum = 0
	---@type function
	self._completeCreateRoleCallback = nil

	---不显示技能图标类型
	self._notShowSKillCountOperationList = {
		[GE.SkillOperateType.Direction] = 1,
		[GE.SkillOperateType.Block] = 1,
		[GE.SkillOperateType.NonRoleBlock] = 1,
	}

	--初始化地图格子范围相关
end

---@param levelConfig PveLevelTable
---@param CB function loadBattleRoot加载完成回调
function ClientBattleManager:StartBattle(levelConfig, CB)
    local mapConfig = Config.GetBattleMapInfo(levelConfig.BattleMapId)
	self._startBattleBlockIds = {
		[1] = {tablex.clone(mapConfig.showtime1), tablex.clone(mapConfig.offset1)},
		[2] = {tablex.clone(mapConfig.showtime2), tablex.clone(mapConfig.offset2)},
	}
	self._showMgr:loadBattleRoot(levelConfig, function ()
		if CB then
			CB()
		end
        self._battleMgr:setBattleState(GE.BattleState.LoadingFinish)
    end)
end

function ClientBattleManager:Update(deltaTime)
    ---结束战斗后不触发
	if self._isEndBattle then
		return
	end
	if self._showMgr then
		self._showMgr:update()
	end
	if self._inputMgr then
		self._inputMgr:update()
	end
end

function ClientBattleManager:clear()
	if self._battleMgr then
		self._battleMgr:registerClientGameOverCallback(nil)
		self._battleMgr:registerLoseConfirmHandler(nil)
	end
    self._battleMgr = nil
	if self._showMgr then
		self._showMgr:clear()
	end
    self._showMgr = nil
	if self._inputMgr then
		self._inputMgr:clear()
	end
    self._inputMgr = nil
	if self._reportPlayer then
		self._reportPlayer:clear()
	end
    self._reportPlayer = nil
    self._roleMgr = nil
    self._battleReporter = nil
    self._storyMgr = nil
    self._map = nil
    self._isEndBattle = nil
    self._formationRangeIdList = nil
	---@type table<BattleStateEnum, function>
    self._eventList = nil
	self._roleCanDoAction = nil
	self._showPreviewHpList = nil
	self._waitPlayAVGReport = nil

	---@type CoveScene
	self.coveScene = nil
	self._curWeatherId = nil
    instance = nil
	savedFormationLIst = {}

	self._waitCreateRoleNum = 0
	self._pendingLoseBacktrace = nil
	self._pendingBacktraceIsWin = nil
end

---战斗失败或非三星结算，且剩余回溯次数大于 1 时，询问是否进入回溯
---@param isWin boolean? 为 true 表示胜利但非三星；取消回溯后再次弹出时可不传
---@return boolean
function ClientBattleManager:tryShowLoseBacktraceConfirm(isWin)
	if self._battleMgr:isVerifyMode() or self._battleMgr:IsLocalBattle() or self._battleMgr:isReplayMode() then
		return false
	end
	local levelConfig = self:getLevelConfig()
	if not levelConfig or levelConfig.id <= 10102 then
		return false
	end
	if self._battleMgr:getBacktraceTimes() <= 1 then
		return false
	end
	local histroyMgr = self._battleMgr:getHistoryManager()
	if not histroyMgr:checkHasHistoryData() then
		return false
	end
	if isWin ~= nil then
		self._pendingBacktraceIsWin = isWin == true
	end
	local tip = self._pendingBacktraceIsWin and "未获得三星，是否使用行动回溯？" or "战斗失败，是否使用行动回溯？"
	self._inputMgr:SetCanInput(false)
	self:playAllReports(function()
		UICommonUtils.PopPromptOkCancelBox(
			tip,
			function()
				self:enterBacktraceFromLose()
			end,
			function()
				self:settleLoseBattle()
			end
		)
	end)
	return true
end

function ClientBattleManager:enterBacktraceFromLose()
	self._pendingLoseBacktrace = true
	self._battleMgr:clearPendingLoseResult()
	---@type BattleMainPanel
	local battleMainPanel = UIMgr:GetUI("BattleMainPanel")
	if battleMainPanel then
		battleMainPanel:enterBacktraceMode()
	end
end

function ClientBattleManager:settleLoseBattle()
	self._pendingLoseBacktrace = false
	self._pendingBacktraceIsWin = false
	self._battleMgr:proceedBattleResult()
end

function ClientBattleManager:isPendingLoseBacktrace()
	return self._pendingLoseBacktrace == true
end

function ClientBattleManager:clearPendingLoseBacktrace()
	self._pendingLoseBacktrace = false
	self._pendingBacktraceIsWin = false
	self._battleMgr:clearPendingGameResult()
end

---@param resultData BattleResultResp
function ClientBattleManager:EndBattle(resultData)
    self._isEndBattle = true
	self._inputMgr:SetCanInput(false)
    self:playAllReports(function()
        if (resultData.result) then
            self._isEndBattle = true
            Time.timeScale = 1
            local levelConfig = self:getLevelConfig()
            if levelConfig.storyEnd and levelConfig.storyEnd ~= 0 then
                local storyConfig = Config.GetStoryArraryInfo(levelConfig.storyEnd)
                if storyConfig.type == 1 then
                    UIMgr:closeUI("BattleMainPanel")
                    self:playEndBattleShow(function()
						LoadingMgr:SetUIQuickSwitchStart(function()
							self._showMgr:hideOtherRole(0)
							--演出结束后重置摄像机优先级
							local cam = self._showMgr:getEnterBattleVcam()
							if cam then
								cam.Priority = 0
							end
							self._map:clear()
							self._showMgr:clear()
							local battleMapId = levelConfig.BattleMapId
							self._storyMgr:initCreatMap(levelConfig.storyEnd, function()
								self._showMgr:loadPVRoot(function()
									LoadingMgr:SetUIQuickSwitchOver(function()
										self:storyStart(function()
											self._storyMgr:clear()
											UIMgr:popUI("BattleWinPanel", resultData, nil, nil, nil, function()
												--LoadingMgr:SetLoadingOver()
											end)
										end)
									end)
								end)
							end, battleMapId)
						end)
                    end)
                elseif storyConfig.type == 2 then
                    UIMgr:popUI("StoryPanel", {
                        storyName = storyConfig.storyArrary[1],
                        callBack = function()
                            UIMgr:closeUI("BattleMainPanel")
                            self:playEndBattleShow(function()
                                UIMgr:popUI("BattleWinPanel", resultData)
                            end)
							-- 恢复战斗场景显示
							self._showMgr:setBattleSceneActive(true)
                        end,
						openFinishFunc = function()
							--战后剧情关闭战斗场景显示
							self._showMgr:setBattleSceneActive(false)
						end
                    })
                end
            else
                Time.timeScale = 1
                UIMgr:closeUI("BattleMainPanel")
                self:playEndBattleShow(function()
                    UIMgr:popUI("BattleWinPanel", resultData)
                end)
            end
        else
            UIMgr:closeUI("BattleMainPanel")
            BattleCore.ds("battleResultReq BattleLosePanel")
            UIMgr:popUI("BattleLosePanel")
        end
    end)
end

---@return PveLevelTable
function ClientBattleManager:getLevelConfig()
    return self._battleMgr:getLevelConfig()
end

function ClientBattleManager:getBattleMgr()
    return self._battleMgr
end

function ClientBattleManager:getInputManager()
	return self._inputMgr
end

---@return BattleShowManager
function ClientBattleManager:getShowManager()
    return self._showMgr
end

function ClientBattleManager:getReportPlayer()
    return self._reportPlayer
end

function ClientBattleManager:getRoleManager()
    return self._roleMgr
end

function ClientBattleManager:SetCanInputClick(value)
    self._inputMgr:SetCanClick(value)
end

function ClientBattleManager:initBattleStateEvent()
    self._eventList = {
		[GE.BattleState.LoadingFinish] = function()
			local levelConfig = self:getLevelConfig()
			local jumpOpenStory = ClientData:GetJumpOpenStory()
			ClientData:SetJumpOpenStory(false)
			if levelConfig.storyOpen and levelConfig.storyOpen ~= 0 and jumpOpenStory ~= true then
				local storyConfig = Config.GetStoryArraryInfo(levelConfig.storyOpen)
				if storyConfig.type == 1 then
					self:startFormation()
					LoadingMgr:SetLoadingOver(nil, nil, "ClientBattleManager")
				elseif storyConfig.type == 2 then
					UIMgr:popUI(
						"StoryPanel",
						{
							storyName = storyConfig.storyArrary[1],
							callBack = function()
								self:startFormation()
								--恢复战斗场景显示
								self._showMgr:setBattleSceneActive(true)
							end
						},
						nil,
						nil,
						nil,
						function()
							LoadingMgr:SetLoadingOver(nil, nil, "ClientBattleManager2")
						end
					)
					--战前剧情关闭战斗场景显示
					self._showMgr:setBattleSceneActive(false)
				end
			else
				self:startFormation()
				LoadingMgr:SetLoadingOver(nil, nil, "ClientBattleManager3")
			end
		end,
        [GE.BattleState.BattleStart] = function()
            self:showBattleStartReport(GE.BattleMainPanelRoundShowType.BattleStart, 0)
            self:showBattleStartReport(GE.BattleMainPanelRoundShowType.None, 1.2)
			self._battleReporter:packStep()
        end,
        [GE.BattleState.SwitchCamp] = function()
            local curCamp = self._roleMgr:actionCamp()
            local roleList = self._roleMgr:getActionRolesByCamp(curCamp)
            local roleCount = #roleList
            if roleCount > 0 then
                self:showCurrCampReport(0.3)
				self:showBattleStartReport(GE.BattleMainPanelRoundShowType.None, 1.8)
				self._battleReporter:packStep()
            end
            self:allRoleActiveReport(0)
        end,
        [GE.BattleState.WaitInputOrder] = function()
			self._battleMgr:getReporter():SetLastTriggerId(nil)
			self._roleMgr:checkAllRoleBuffChangeReport()
			local role = self._battleMgr:getSelectedRole()
			if not role then
				role = self._roleMgr:autoSelectRole()
			end
			if not role then
				BattleCore.es("ClientBattleManager:WaitInputOrder no role selected")
				return
			end
			local showBlock = role:getShowBlock()
			role:SmoothFollowTargetReport(showBlock.id, GE.FollowTargetType.Select, false)
            self:playAllReports(function()
				GuideMgr:StartGuideTrigger()--引导检测
				if self._roleMgr:isManualCamp() and self._battleMgr:getIsAutoMode() == false then
					self._inputMgr:SetCanInput(true)
					self:SetCanInputClick(true)
					self._showMgr:showFullMask(false)
					local roleMoveAgain = role:getMoveAgainType()
					local activeType = roleMoveAgain and GE.RoleActionType.OnlyMove or GE.RoleActionType.Normal
					-- self._battleMgr:callClientShowEvent(GE.ClientBattleShowType.SelectRole)
					self._battleMgr:callClientShowEvent(GE.ClientBattleShowType.RefreshRoleAction, {
						role = role,
						actionType = activeType,
					})
					self:showEnemiesAimLine(role)
				end
				self._roleCanDoAction = true
				self._roleMgr:checkAutoAction(role)
            end)
        end,
        [GE.BattleState.AfterInputOrder] = function()
			self._inputMgr:SetCanInput(false)
			self._inputMgr:resetMouseState()
			self._showMgr:hideRoleAction()
			self._showMgr:removeTargetEffect()
			self._showMgr:refreshSelectedCube()
			self:hidePreviewHpChange()
			self:removeMoveRange()
			self:removeSkillRange()
			self._showMgr:removeAllAimLine()
			self._battleMgr:setSelectRole(nil)
			self._battleMgr:setBeforeBackTranceSelectRoleId(nil)
			self._showMgr:showAutoModeHideGroup(false)
			self._roleCanDoAction = false
        end,
		[GE.BattleState.AfterRoleAction] = function ()
			self:playAllReports(function()
				if self._isShowDangerRange then
					self:showDangerRange()
				end
				-- self:checkRemoveEventPerformance()
				self._roleMgr:completeAction()
			end)
		end,
        [GE.BattleState.PlayStory] = function()
			if self._storyMgr:getEditorMode() then
				self._storyMgr:initEditorMode()
			else
				self._storyMgr:initStoryData()
			end
		end,
		[GE.BattleState.InBacktrace] = function()
			self._battleMgr:resetAndStopActionState(true, false)
			self._lastSkillSelectBlockId = nil
			self:removeMoveRange()
			self:removeSkillRange()
			self._showMgr:removeAllAimLine()
			self._isActionState = false
			self._showMgr:cancelSelectRole()
			self._showMgr:refreshSelectedCube()
		end,
		[GE.BattleState.OnBacktrace] = function()
			local curWeatherId = self._battleMgr:getCurWeatherId()
			local d = {
				weatherId = curWeatherId
			}
			self._showMgr:WeatherChange(d)
		end,
    }
	for state, fun in pairs(self._eventList) do
		local f = function()
			fun()
			-- self:checkRemoveEventPerformance()
		end
		self._battleMgr:registerBattleStateEvent(state, f)
	end
end

function ClientBattleManager:playReport(reports, callback)
	if (not self._reportPlayer) then
		if (callback) then
			callback()
		end
		return
	end
	self._reportPlayer:play(reports, callback)
end

function ClientBattleManager:playAllReports(callback)
    self:playReport(self._battleReporter:getCurrentReports(true), function()
        if callback then
            callback()
        end
    end)
end

---将当前未播放的临时战报插入进游戏过程战报
function ClientBattleManager:insertReports()
	local reports = self._battleReporter:getCurrentReports(true)
	local unpackedReports = {}
	local listIndex = 1
	for _, reportList in ipairs(reports) do
		unpackedReports[listIndex] = reportList
		listIndex = listIndex + 1
	end
	local listCount = #unpackedReports
    for i = listCount, 1, -1 do
		local r = unpackedReports[i]
		self._reportPlayer:insertCurrentReptor(r)
    end
    self._battleReporter:clearCurReports()
end

function ClientBattleManager:isPlayReport()
	return self._reportPlayer and self._reportPlayer:isPlaying()
end

function ClientBattleManager:setIsPlayAVGReport(isPlay)
	self._waitPlayAVGReport = isPlay
end

function ClientBattleManager:isPlayAVGReport()
	return self._waitPlayAVGReport == true
end

function ClientBattleManager:isBlockInFormationRange(blockId)
	return self._formationRangeIdKVList[blockId] == true
end

function ClientBattleManager:getFormationRangeIdList()
	return self._formationRangeIdList
end

function ClientBattleManager:getFormationRangeIdKVList()
	return self._formationRangeIdKVList
end

---region 战斗表现相关
---获取开始战斗是表演所需格子
---@param isDouble boolean
function ClientBattleManager:getShowBlock(isDouble)
	local index = isDouble and 2 or 1
	return self._startBattleBlockIds[index]
end

---获取演出相对位移
---@return UnityEngine.Vector3[] 相对起始地块的位移列表（x:左右 z:前后）
---@return UnityEngine.Transform? 起始点（锚点）
function ClientBattleManager:getShowBlockPos(mapData)
	local startBlockID = mapData[1][1]
	local offsetList = mapData[2]
	local blockMapData = {}
    local map = self._battleMgr:getMap()
	local blockId = map:blockCidToId(startBlockID)
	local blockObj = self._showMgr:getBlockObj(blockId)
	local trans = nil
	if blockObj then
		trans = blockObj.transform
	end
	for index, value in ipairs(offsetList) do
		-- x: 左右位移, z: 前后位移（相对起始地块，由 PlayStartBattle 叠加 anchor）
		blockMapData[index] = Vector3.New(value[1], 0, value[2])
	end

	return blockMapData, trans
end

---播放战斗开始的表现
---@param callBack function 回调
function ClientBattleManager:playBattleShow(callBack)
    local roleMgr = self._battleMgr:getRoleManager()
	local allRoleList = roleMgr:getRolesList()
	for _, value in ipairs(allRoleList) do
		if value.camp ~= GE.BattleCampType.Friend then
			self._showMgr:showOrHideRole(value.id, false)
		end
	end
	local roleList = roleMgr:getRolesByCamp(GE.BattleCampType.Friend)
	local roleListCount = #roleList
	local randomNum = UnityEngine.Random.Range(1, roleListCount + 1)
	randomNum = math.floor(math.min(randomNum, roleListCount))
	---@type integer[]
	local roleIdList = {}
	for i, v in ipairs(roleList) do
		roleIdList[i] = v.id
	end
	local playAudioRole = roleList[randomNum]
	local skinConfig = playAudioRole.skinConfig
	local audioData = nil
	if skinConfig then
		audioData = skinConfig.battleStart
	end
	local roleCount = #roleIdList
	local isDouble = roleCount % 2 == 0
	local mapData = self:getShowBlock(isDouble)
	local blockMapData, trans = self:getShowBlockPos(mapData)
	
	local roleName = playAudioRole.roleConfig.name
	self._showMgr:refreshSelectedCube()
	self._inputMgr:SetCanInput(false)
	self._showMgr:PlayStartBattle(trans, roleIdList, blockMapData, function ()
		self._showMgr:PlayStartBattleEnemy(callBack)
	end)
	if audioData then
		self._showMgr:PlayBattleAudio(skinConfig, audioData, roleName)
	end
end

---结束播放进入战斗的表现，将所有角色移动到初始位置
---@param callBack function 回调
function ClientBattleManager:endPlayBattleShow(callBack)
	local roleMgr = self._battleMgr:getRoleManager()
	local roleList = roleMgr:getRolesByCamp(GE.BattleCampType.Friend)
	---@type integer[]
	local roleIdList = {}
	---@type integer[]
	local blockMapData = {}
	local dirList = {}
	for i, v in ipairs(roleList) do
		roleIdList[i] = v.id
		local block = v:getShowBlock()
		blockMapData[i] = block.id
		dirList[i] = v.direction
	end
	self._inputMgr:SetCanInput(true)
	self._showMgr:endPlayEnterBattle(roleIdList, blockMapData, dirList, callBack)
end

---播放战斗胜利结束的表现
---@param callBack function 回调
function ClientBattleManager:playEndBattleShow(callBack)
	local roleMgr = self._battleMgr:getRoleManager()
	local roleList = roleMgr:getRolesByCamp(GE.BattleCampType.Friend)
	---@type integer[]
	local roleIdList = {}
	for i, v in ipairs(roleList) do
		roleIdList[i] = v.id
	end

	local roleCount = 0
	local allRoleList = roleMgr:getRolesList()
	for _, value in ipairs(allRoleList) do
		local isShow = value.camp == GE.BattleCampType.Friend
		self._showMgr:showOrHideRole(value.id, isShow)
		if isShow then
			roleCount = roleCount + 1
			roleIdList[roleCount] = value.id
		end
	end
	if roleCount == 0 then
		callBack()
		return
	end
	local isDouble = roleCount % 2 == 0
	local mapData = self:getShowBlock(isDouble)
	local blockMapData, trans = self:getShowBlockPos(mapData)
	self._showMgr:showEdgesLine(false)
	self._showMgr:showEdgesWall(false)
	self._showMgr:setSceneEffectState(false)
	self._showMgr:refreshSelectedCube()
	self._showMgr:hideBattleMainPanel()
	self._showMgr:playEndBattle(trans, roleIdList, blockMapData, callBack)
end

function ClientBattleManager:allRoleActiveReport(delay)
	BattleCore.ds("BattleManager:allRoleActiveReport RoleActive")
	local reportData = {
		test = 1,
		delay = delay
	}
	self._battleReporter:addReport(GE.BattleReportType.AllRoleActive, reportData)
	self._battleReporter:packStep()
end

---@param type BattleMainPanelRoundShowType 展示回合开始的类型
---@param delay number? 延迟
function ClientBattleManager:showBattleStartReport(type, delay)
	BattleCore.ds("BattleManager:showBattleStartReport")
	---@class BattleMainPanelStartReportData
	---@field showType BattleMainPanelRoundShowType 展示回合开始的类型
	---@field delay number? 延迟
	local reportData = {
		showType = type,
		delay = delay
	}
	self._battleReporter:addReport(GE.BattleReportType.ShowBattleStart, reportData)
end

function ClientBattleManager:showBattleRoundReport(delay)
	BattleCore.ds("BattleManager:showBattleRoundReport")
	self._battleReporter:addReport(GE.BattleReportType.ShowBattleRound, nil)
end

function ClientBattleManager:showCurrCampReport(delay)
	BattleCore.ds("BattleManager:showCurrCampReport")
	local roundNum = self._battleMgr:getCurrentRound()
	---@class CampReportData
	---@field round integer 回合
	---@field camp BattleCampType 阵营
	---@field delay number 延迟
	local reportData = {
		round = roundNum,
		camp = self._roleMgr:actionCamp(),
		delay = delay
	}
	self._battleReporter:addReport(GE.BattleReportType.ShowCurrCamp, reportData)
end

---播放战斗音频
---@param skinConfig CharacterSkinTable
---@param AudioData table
---@param roleName LocalStrEnum?
function ClientBattleManager:playBattleAudio(skinConfig, AudioData, roleName)
	if self._showMgr == nil then
		return
	end
	self._showMgr:PlayBattleAudio(skinConfig, AudioData, roleName)
end
---endregion

---region 剧情相关
--演出开始
---@param endCallback function
function ClientBattleManager:storyStart(endCallback)
	if endCallback then
		self._storyMgr:setEndCallbackFunc(endCallback)
	end
	self._battleMgr:setBattleState(GE.BattleState.PlayStory)
end

--演出编辑器模式
function ClientBattleManager:storyEditorStart()
	self._storyMgr:setEditorMode(Config.isBattleStoryEditor)
	self._battleMgr:setBattleState(GE.BattleState.PlayStory)
end
---endregion

---region 上阵功能相关
---开始布阵准备
function ClientBattleManager:startFormation()
	-- self:initBattleSpeed()
	local levelConfig = self:getLevelConfig()
	self._showMgr:removeBlockTag()
	local curWeatherId = self._battleMgr:getCurWeatherId()
	local d = {
		weatherId = curWeatherId
	}
	self._formationRangeIdList = self._map:getFormationRange(levelConfig)
	for _, value in ipairs(self._formationRangeIdList) do
		self._formationRangeIdKVList[value] = true
	end
	self._showMgr:WeatherChange(d)
	self:playAllReports(function()
		if (levelConfig.skip_arry ~= 1 and self._battleMgr:isReplayMode() ~= true) then
			self._showMgr:refreshFormationRange(self._formationRangeIdList)
			self._showMgr:refreshBlockTag(levelConfig.cellTitle)
			local battleEventMgr = self._battleMgr:getBattleEventManager()
			battleEventMgr:playEventPerformance()
			self._inputMgr:SetCanInput(true)
			UIMgr:popUI("FormationPanel")
		else
			self:finishFormation()
		end
	end)
end

function ClientBattleManager:finishFormation()
	UIMgr:closeUI("FormationPanel")
	self._inputMgr:setBattleInputMouseClick()
	self._showMgr:openBattleMainPanel(function()
		self._showMgr:removeFormationRange()
		self._finishFormation = false
		if self._battleMgr:isReplayMode() then
			local BattleVerifyReplayer = require "BattleVerifyReplayer"
			BattleVerifyReplayer.onReplayFormationReady()
		end
		self._showMgr:showWaitAddMark()
		self._battleMgr:setBattleState(GE.BattleState.FormationFinish)
	end)
end
---endregion

---region 角色行动及其表现相关

function ClientBattleManager:resetAndStopActionState(isResetPos)
	self:stopActionState()
end

function ClientBattleManager:RemoveRoleSelectStateInFormation()
	self:removeMoveRange(true)
end

---@param clearSelectArea boolean? 是否清除选择区域
function ClientBattleManager:stopActionState(clearSelectArea)
	self._lastSkillSelectBlockId = nil
	self:removeMoveRange()
	self:removeSkillRange()
	self._showMgr:removeAllAimLine()
	self._isActionState = false
	self._showMgr:cancelSelectRole()
	if clearSelectArea then
		self._showMgr:refreshSelectedCube()
	end
	self._showMgr:hideRoleAction()
end

---@param role BattleRole
function ClientBattleManager:refreshRoleActionState(role, activeType, cancelAnim)
	activeType = activeType or GE.RoleActionType.Normal
	local selectRole = self._battleMgr:getSelectedRole()
	local selectRoleId = selectRole and selectRole.id or -1
	self:resetAndStopActionState(role.id ~= selectRoleId)
	local movePowType = GE.MovePowerType.Normal
	if (self._roleMgr:getLockRole() ~= nil) then
		movePowType = self._battleMgr:getMoveType()
	end
	self:hidePreviewHpChange()
	self:refreshRoleActionType(role, activeType, movePowType, cancelAnim)
end

---@param role BattleRole 角色
---@param actionType RoleActionType 行动类型
---@param movePowType MovePowerType 移动力类型
function ClientBattleManager:refreshRoleActionType(role, actionType, movePowType, cancelAnim)
	local needPlayAudio = self._lastSelectRoleID ~= role.id
	self._lastSelectRoleID = role.id
	local kvMoveList = role:getRoleKVMoveRange()
	self._moveRangeIdList = role:getRoleMoveRange()
	local isShowMoveRange = self:checkNeedShowBlockRange()
	if isShowMoveRange then
		self._showMgr:refreshMoveRange(self._moveRangeIdList, true, cancelAnim)
	end
	self._showMgr:removeAllTorpedoLine()
	self._showMgr:selectRole(role.id)

	if (actionType == GE.RoleActionType.Normal) then
		local chooseRangeIdList = role:getRoleAtkRange()
		self:refreshChooseRange(chooseRangeIdList, kvMoveList, true, false, cancelAnim)
	end

	if isShowMoveRange then
		self:showCharacterActionPanel(actionType)
		self._showMgr:showRoleInfo(role)
		if needPlayAudio then
			local skinConfig = role.skinConfig
			local audioData = skinConfig.battleChoose
			self:playBattleAudio(skinConfig, audioData, nil)
		end
	end
end

---检查
function ClientBattleManager:checkRemoveEventPerformance()
    local battleEventMgr = self._battleMgr:getBattleEventManager()
	battleEventMgr:removeEventPerformance()
end

---显示技能预扣除血量
---@param source BattleRole 技能来源角色
---@param target BattleRole 技能目标角色
---@param skillConfig SkillTable 技能配置
---@param skinConfig? CharacterSkinTable 皮肤配置
function ClientBattleManager:showPreviewHpChange(source, target, skillConfig, skinConfig)
    local skillMgr = self._battleMgr:getSkillManager()
	local damageData = skillMgr:getDamageData(source, target, skillConfig, skinConfig)
	local mathDamageData = target:mathDamage(damageData)
	local isRepair = damageData.atkCalculateType == GE.SkillCalculateType.Repair
	self._previewHpIsRepair = isRepair
	self._previewHpChangeValue = mathDamageData.dmgValue
	self._showMgr:ShowPreviewHpChange(target.id, self._previewHpChangeValue, isRepair)
	self._showPreviewHpList[#self._showPreviewHpList + 1] = target.id
end

function ClientBattleManager:hidePreviewHpChange()
	for _, roleId in ipairs(self._showPreviewHpList) do
		self._showMgr:HidePreviewHpChange(roleId)
	end
	self._showPreviewHpList = {}
end

function ClientBattleManager:getHpPreviewValue()
	return self._previewHpChangeValue, self._previewHpIsRepair
end

---显示角色行动范围
---@param blockRole BattleRole 角色
function ClientBattleManager:showRoleActionRange(blockRole)
	self:resetAndStopActionState(true)
	local moveRangeIdList = blockRole:getRoleMoveRange()
	local moveRangeKVList = blockRole:getRoleKVMoveRange()
	self._showMgr:refreshMoveRange(moveRangeIdList)
	local chooseRangeIdList = blockRole:getRoleAtkRange()
	self:refreshChooseRange(chooseRangeIdList, moveRangeKVList)
end

---endregion

---region 战斗UI相关
---@param actionType RoleActionType 行动类型
function ClientBattleManager:showCharacterActionPanel(actionType)
	local role = self._battleMgr:getSelectedRole()
	self._showMgr:showRoleAction(role, actionType)
end

function ClientBattleManager:uiEnterActionState()
	self._showMgr._uiBattleMain.ui:enterActionState()
end

---进入选择目标状态
function ClientBattleManager:uiEnterChooseState()
	self._showMgr._uiBattleMain.ui:enterChooseState()
end

function ClientBattleManager:uiEnterDoSkillState()
	self._showMgr._uiBattleMain.ui:enterDoSkillState()
end
---endregion

---初始化战斗速度
function ClientBattleManager:initBattleSpeed()
	local speedList = Config.GetConfigInfo("setFightSpeed")
	self._battleSpeed = MyPrefs:GetInt(GE.LocalCustomDataKey.setFightSpeed, 1)
	Time.timeScale = speedList[self._battleSpeed]
end

function ClientBattleManager:addBattleSpeed()
	local speedList = Config.GetConfigInfo("setFightSpeed")
	self._battleSpeed = self._battleSpeed + 1
	if (self._battleSpeed > #speedList) then
		self._battleSpeed = 1
	end
	MyPrefs:SetInt(GE.LocalCustomDataKey.setFightSpeed, self._battleSpeed)
	Time.timeScale = speedList[self._battleSpeed]
end

function ClientBattleManager:getBattleSpeed()
	return self._battleSpeed
end

---region 格子范围相关
function ClientBattleManager:getChooseRangeSourceBlock(targetBlock)
	return self._map:getChooseRangeSourceBlock(targetBlock)
end

---显示危险范围
function ClientBattleManager:showDangerRange()
	self._isShowDangerRange = true
	self._showMgr:removeDangerRange()
	local damgerRangelist = self._roleMgr:getDangerRange(GE.BattleCampType.Friend)
	self._showMgr:refreshDangerRange(damgerRangelist)
end

function ClientBattleManager:removeDangerRange()
	self._isShowDangerRange = false
	self._showMgr:removeDangerRange()
end

---是否显示危险范围
function ClientBattleManager:isShowDangerBlockRange()
	return self._isShowDangerRange
end

---@param isFormation boolean? 是否是布阵阶段
function ClientBattleManager:removeMoveRange(isFormation)
	self._showMgr:removeMoveRange()
	self._showMgr:removeSkillTypeIcon()
	if isFormation ~= true then
		self._showMgr:removeSkillCountIcon()
	end
end

---刷新行动范围
---@param chooseRangelist BlockData[]
---@param moveRangeList table<integer, BlockData>
---@param isActionRole boolean?
---@param isSelectSkill boolean?
---@param cancelAnim boolean?
function ClientBattleManager:refreshChooseRange(chooseRangelist, moveRangeList, isActionRole, isSelectSkill, cancelAnim)
	BattleCore.ds("ClientBattleManager:refreshChooseRange chooseRangelist", #chooseRangelist)
	if (self:checkNeedShowBlockRange()) then
		self._showMgr:refreshChooseRange(chooseRangelist, moveRangeList, isActionRole, cancelAnim)
	end
	if isActionRole then
		self:showSelectableTargets(isSelectSkill)
	end
end

---刷新技能范围
---@param skillRangeList BlockData[]
---@param skillsConfig SkillTable
---@param cancelAnim boolean?
function ClientBattleManager:refreshSkillRange(skillRangeList, skillsConfig, cancelAnim)
	self._chooseTargetState = true
	self:showSelectableTargets(true)
	self._showMgr:refreshSkillRange(skillRangeList, skillsConfig, cancelAnim)
end

function ClientBattleManager:removeSkillRange()
	self._skillRangeIdList = {}
	self._showMgr:setAllRoleHighlight({ state = false })
	self._showMgr:removeSkillRange()
end

---@param blockId integer? 格子ID
function ClientBattleManager:refreshSelectedCube(blockId)
	self._showMgr:refreshSelectedCube(blockId)
end

---检测是否显示格子范围提示，自动模式和不可操作阵营都不会显示格子，布阵状态显示格子，不做检查
---@return boolean 检测结果
function ClientBattleManager:checkNeedShowBlockRange()
	local isAutoMode = self._battleMgr:getIsAutoMode()
	local isEndCurRound = self._battleMgr:isEndCurRound()
	return self._finishFormation == false or self._roleMgr:isManualCamp() and isAutoMode == false and isEndCurRound == false
end

---获取可选择目标
---@param isSelectSkill boolean? 是否是选择技能
function ClientBattleManager:showSelectableTargets(isSelectSkill)
	self._showMgr:removeSkillTypeIcon()
	self._showMgr:removeSkillCountIcon()
	local curRole = self._battleMgr:getSelectedRole()
	local skillId = curRole.selectedSkill or curRole.normalSkill
	local skillConfig = Config.GetSkillInfo(skillId)
	local operateType = skillConfig.skillOperateType
	local needShowSkillIcon = self._notShowSKillCountOperationList[operateType] == nil
	if needShowSkillIcon == false then
		return
	end
	local list = self:getSelectableTargets()
	local ratio = nil
	local showType = 1
	if isSelectSkill then
		showType = 2
	else
		showType = skillId == curRole.normalSkill and 2 or 0
	end
	local atkCalculateType = skillConfig.atkCalculateType
	local needShowCountIcon = atkCalculateType == GE.SkillCalculateType.Normal or atkCalculateType == GE.SkillCalculateType.Repair
	if needShowCountIcon then
		local charRestraintConfig = Config.GetCharacterRestraintInfo(curRole.roleConfig.attribute)
		ratio = charRestraintConfig.ratio
	end
	for _, id in ipairs(list) do
		local block = self._battleMgr:getBlockById(id)
		if block then
			local role = block:tryGetRole()
			if role then
				local roleID = role.id
				--普通技能需要显示技能克制系数
				if ratio then
					local targetRestraintType = role.restraintType
                    local countNum = ratio[targetRestraintType]
					self._showMgr:showSkillCountIcon(roleID, countNum)
				end
				self._showMgr:showSkillTypeIcon(roleID, skillConfig, showType)
			end
		end
	end
end

function ClientBattleManager:getSelectableTargets()
	local selectableTargets = {}
	local selectRole = self._battleMgr:getSelectedRole()
	if (not selectRole) then
		return selectableTargets
	end
	local skillMgr = self._battleMgr:getSkillManager()
	local skillConfig = Config.GetSkillInfo(selectRole.selectedSkill or selectRole.normalSkill)
	local chooseRangelist = self._battleMgr:getChooseRangeIdList()
	for _, blockData in ipairs(chooseRangelist) do
		local block = self._battleMgr:getBlockById(blockData.blockId)
		local isPass = skillMgr:checkBlockRoleCanBeSelect(skillConfig, selectRole, block)
		if isPass then
			table.insert(selectableTargets, blockData.blockId)
		end
	end
	return selectableTargets
end
---endregion

---region 预移动相关(不需要通过战报播放的移动表现)
function ClientBattleManager:BattleRolePreMove(role, sourceBlock, chooseBlock, path, isUseSkill, delay)
	local skillConfig = Config.GetSkillInfo(role.selectedSkill)
	local skillMgr = self._battleMgr:getSkillManager()
	local afterMove = function()
		if not isUseSkill then
			return
		end
        local isPass = true
        local lineBlock = nil
        local showBlock = role:getShowBlock()
        if skillConfig.isTorpdeo == 1 then
            lineBlock = skillMgr:checkTorpedoSkillCanAttack(showBlock, chooseBlock)
            isPass = lineBlock == nil
        end
        if isPass then
			self:removeMoveRange()
			local rangeIdList = self._battleMgr._skillRangeIdList
			self._showMgr:refreshSkillEffectRange(rangeIdList, skillConfig, nil, nil, role)
			---刷新克制图标
			self._showMgr:removeSkillCountIcon()
			---刷新技能图标
			self._showMgr:removeSkillTypeIcon()
			local charRestraintConfig = Config.GetCharacterRestraintInfo(role.roleConfig.attribute)
			local ratio = charRestraintConfig.ratio
			local targetList = role:getCurSkillTarget()
			for _, block in ipairs(targetList) do
				local t = block:tryGetRole()
				if t then
					local roleID = t.id
					if self._roleMgr:isEnemyCamp(role, t) then
						local targetRestraintType = t.restraintType
						local countNum = ratio[targetRestraintType]
						self._showMgr:showSkillCountIcon(roleID, countNum)
					end
					self:showPreviewHpChange(role, t, skillConfig)
				end
			end

			self:uiEnterDoSkillState()
        else
            self._showMgr:createTorpedoLine(showBlock.id, lineBlock.id)
        end
    end

	local rangeList, rangeKVList = role:_getSkillRange()
	--判断在攻击范围内就不移动
	local needMove = chooseBlock ~= nil and rangeKVList[chooseBlock.id] == nil or true

	if needMove then
		---预移动时需要实时刷新所有敌方行动范围
		self._roleMgr:calculateAllRolesActionRange({ GE.BattleCampType.Enemy })
		local isShowDangerRange = self:isShowDangerBlockRange()
		if isShowDangerRange then
			self:showDangerRange()
		end
		local data = {
			id = role.id,
			blockId = sourceBlock.id,
			direction = chooseBlock and role.direction,
			path = path,
			delay = delay or 0
		}
		self._showMgr:roleMove(data, function()
			afterMove()
			--移动完同步角色朝向
			role.direction = self._showMgr:getRole(role.id).model:GetNowDirectionType()
			self:checkRoleMoveIsInBePrepareSkillTarget(role, false)
			self:showEnemiesAimLine(role)
		end)
	else
		afterMove()
	end
end

---@param role BattleRole
function ClientBattleManager:showEnemiesAimLine(role)
    self._showMgr:removeAllAimLine()
    local enemyList = self._roleMgr:getEnemiesCanHitRole(role)
    for _, enemy in ipairs(enemyList) do
        self._showMgr:createAimLine(enemy.id, role.id)
    end
end

---@param role BattleRole
---@param playInReport boolean?
function ClientBattleManager:checkRoleMoveIsInBePrepareSkillTarget(role, playInReport)
	local roleID = role.id
	local dList = self._battleMgr:getPrepareSkillFollowList(roleID)
	local skilMgr = self._battleMgr:getSkillManager()
    if dList then
        for _, d in ipairs(dList) do
            local sourceId = d.sourceId
            local roleBlock = role:getShowBlock()
            local skillConfig = Config.GetSkillInfo(d.skillId)
			if skillConfig then
				local sourceRole = self._roleMgr:getRole(sourceId)
				if sourceRole then
					local skillRangeType = skillConfig.rangeSelectType
					local skillEffectRange = skilMgr:GetSkillEffectRangeByRole(skillConfig, sourceRole)
					local blockIdList = self._map:getDiffuseRange(skillRangeType, roleBlock, skillEffectRange)
					if playInReport == true then
						---@type PrepareSkillReportData
						local reportData = {
							roleId = sourceId,
							blockDataList = blockIdList,
							delay = 0.1,
						}
						self._battleReporter:addReport(GE.BattleReportType.ShowPrepareSkillRange, reportData)
						self._battleReporter:packStep()
					else
						self._showMgr:refreshPrepareSkillRange(sourceId, blockIdList, roleID)
					end
				end
			end
        end
    end
end

function ClientBattleManager:SetAutoMode(isAuto)
	self._battleMgr:setAutoMode(isAuto)
	self._battleMgr:onChangeAutoMode()
	if self._isEndBattle == false and self._roleMgr:isManualCamp()
		and isAuto and self._roleCanDoAction then
		local role = self._battleMgr:getSelectedRole()
		if role and self._roleMgr:isActionCompleted(role) then
			BattleCore.es("ClientBattleManager:SetAutoMode role is completed, auto select role", role.roleConfig.name)
			role = nil
		end
		if not role then
			role = self._roleMgr:autoSelectRole()
		else
			role:resetPos()
			self._roleMgr:selectRole(role)
		end
		self:removeMoveRange()
	end
end

---@return boolean 当前阶段是否可以操作，逻辑层虽然已经到了可输入操作阶段，但是前端需要等战斗演出结束后才能操作
function ClientBattleManager:checkRoleCanDoAction()
	return self._roleCanDoAction == true
end

function ClientBattleManager:getMaxFormationCount()
	return maxSaveFormationCount
end

---存储预设的布阵ID列表
---@param levelType integer
---@param formationIdList FormationInfo[] 布阵ID列表
function ClientBattleManager:saveFormationList(levelType, formationIdList)
    if not savedFormationLIst[levelType] then
        savedFormationLIst[levelType] = {}
    end

    local changeList = savedFormationLIst[levelType]

    local roleBlockIndexList = {}
    for index, value in ipairs(changeList) do
		if value and value.roleCid ~= 0 then
			roleBlockIndexList[value.roleCid] = index
        end
    end

    for i = 1, maxSaveFormationCount do
        local formationData = formationIdList[i]
        if formationData == nil or formationData.roleCid == 0 then
			local cacheData = changeList[i]
			formationData = cacheData and {
				roleCid = cacheData.roleCid or 0,
				blockIndex = cacheData.blockIndex or i,
			} or { roleCid = 0, blockIndex = i }
        end

		local saveData = {
			roleCid = formationData.roleCid or 0,
			blockIndex = formationData.blockIndex or i,
		}

		if saveData.roleCid ~= 0 then
			local beforeIndex = roleBlockIndexList[saveData.roleCid] or 0
            if beforeIndex > 0 and beforeIndex ~= i then
				local tempData = changeList[i] or { roleCid = 0, blockIndex = i }
				changeList[i] = saveData
				changeList[beforeIndex] = tempData

				roleBlockIndexList[saveData.roleCid] = i
				if tempData.roleCid ~= 0 then
					roleBlockIndexList[tempData.roleCid] = beforeIndex
                end
            else
				changeList[i] = saveData
				roleBlockIndexList[saveData.roleCid] = i
            end
        else
			changeList[i] = saveData
        end
    end

	local saveStrList = {}
	for i = 1, maxSaveFormationCount do
		local formationData = changeList[i] or { roleCid = 0, blockIndex = i }
		saveStrList[i] = string.format("%s%s%s", formationData.roleCid or 0, formationDataStr, formationData.blockIndex or i)
	end
	local s = table.concat(saveStrList, contentStr)
    local key = string.format(levelFormationIdListKey, levelType)
    MyPrefs:SetString(key, s)
end

---获得预设的布阵ID列表
---@param levelType integer
---@return FormationInfo[] 布阵ID列表
function ClientBattleManager:getSavedFormationList(levelType)
	local r = savedFormationLIst[levelType]
	if not r then
		r = {}
		local key = string.format(levelFormationIdListKey, levelType)
		local s = MyPrefs:GetString(key, "")
		if s and string.len(s) > 0 then
			local formationIdList = string.split(s, contentStr)
			for i, v in ipairs(formationIdList) do
				local roleCidStr, blockIndexStr = string.match(v,
					"^(%-?%d+)" .. formationDataStr .. "(%-?%d+)$")
				r[i] = {
					roleCid = tonumber(roleCidStr) or 0,
					blockIndex = tonumber(blockIndexStr) or i,
				}
			end
		end
		savedFormationLIst[levelType] = r
	end
	return r
end

function ClientBattleManager:setCreateRoleCallback(callback)
	self._completeCreateRoleCallback = callback
end

function ClientBattleManager:getWaitCreateRoleNum()
	return self._waitCreateRoleNum or 0
end

---设置正在等待创建角色的数量
---@param num integer 数量
function ClientBattleManager:setWaitCreateRoleNum(num)
	-- self._waitCreateRoleNum = num
end

---开始异步加载角色
function ClientBattleManager:waitCreateRoleNum()
	if not self._waitCreateRoleNum then
		self._waitCreateRoleNum = 0
	end
	self._waitCreateRoleNum = self._waitCreateRoleNum + 1
end

---完成异步加载角色
function ClientBattleManager:completeCreateRoleNum()
	if not self._waitCreateRoleNum then
		self._waitCreateRoleNum = 0
	end
	self._waitCreateRoleNum = self._waitCreateRoleNum - 1
	if self._waitCreateRoleNum <= 0 then
		if self._completeCreateRoleCallback then
			self._completeCreateRoleCallback()
			self._completeCreateRoleCallback = nil
		end
	end
end

---是否正在创建角色
function ClientBattleManager:isCreatingRole()
	return self._waitCreateRoleNum > 0
end

return ClientBattleManager