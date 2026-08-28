
--region global define
local require   = require
local import    = import
local isNull    = isNull
local isNotNull = isNotNull
local CfUtils   = CfUtils
--endregion

--region import
local util             = require 'XLua.util'
local CoWait           = CS.Engine.Lib.CoWait
---@type ClubGVGUtils
local ClubGVGUtils     = import('Game.UI.Club.GVG.ClubGVGUtils')
local URPCameraController =  CS.Game.Native.URP.URPCameraController.Instance
local UIDragProxy = CS.Engine.UI.EventDragProxy
local UIEventProxy = CS.Engine.UI.UIEventProxy

local cs_coroutine     = require "XLua.cs_coroutine"
--endregion

--region define
local SetActive        = CfUtils.SetActive
local GVGConstants     = ClubGVGUtils.Constants
local GetTimeHMS2      = CfUtils.GetTimeHMS2

--endregion

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupMainDialog.prefab > name: OverseaClubGvgGroupMainDialog
---@class ClubGVGGroupMainDialog
---@field Env                           	ClubGVGGroupMainDialog                  
---@field controller                    	Engine.UI.UILuaDialog                   
---@field Container                     	UnityEngine.CanvasGroup                 	@ 0    
---@field Countdown                     	UnityEngine.RectTransform               	@ 1    
---@field ImgText                       	Game.Native.Common.UISwitchImage        	@ 2    
---@field ImgText2                      	Game.Native.Common.UISwitchImage        	@ 3    
---@field ImgBg                         	Game.Native.Common.UISwitchImage        	@ 4    
---@field TextDesc                      	CustomText                              	@ 5    
---@field BtnExplain                    	UnityEngine.RectTransform               	@ 6    
---@field TextNumber                    	Game.Native.Common.UISwitchTextMeshPro  	@ 7    
---@field OverseaChatBtnNode            	UnityEngine.RectTransform               	@ 8    
---@field ButtonGroup                   	UnityEngine.RectTransform               	@ 9    
---@field BtnBattleReport               	UnityEngine.RectTransform               	@ 10   
---@field BtnRank                       	UnityEngine.RectTransform               	@ 11   
---@field BtnTask                       	UnityEngine.RectTransform               	@ 12   
---@field BtnChange                     	UnityEngine.RectTransform               	@ 13   
---@field BtnTeam                       	UnityEngine.RectTransform               	@ 14   
---@field TextLifeNum                   	CustomText                              	@ 15   
---@field BtnReborn                     	UnityEngine.RectTransform               	@ 16   
---@field Reborn                        	UnityEngine.RectTransform               	@ 17   
---@field BtnRebornQuantity             	UnityEngine.RectTransform               	@ 18   
---@field BtnRebornTextNumber           	TMPro.TextMeshProUGUI                   	@ 19   
---@field LifeUp                        	UnityEngine.RectTransform               	@ 20   
---@field MessageGroup                  	UnityEngine.RectTransform               	@ 21   
---@field EnemyRaid                     	UnityEngine.RectTransform               	@ 22   
---@field EnemyRaidTextNumber           	TMPro.TextMeshProUGUI                   	@ 23   
---@field Marching                      	UnityEngine.RectTransform               	@ 24   
---@field MarchingTextNumber            	TMPro.TextMeshProUGUI                   	@ 25   
---@field BtnShow                       	UnityEngine.RectTransform               	@ 26   
---@field BtnShowImage                  	Game.Native.Common.UISwitchImage        	@ 27   
---@field MapInfoContainer              	UnityEngine.RectTransform               	@ 28   
---@field ExtraPanel                    	UnityEngine.CanvasGroup                 	@ 29   
---@field BuildingDetail                	UnityEngine.RectTransform               	@ 30   
---@field SliderContainer               	UnityEngine.RectTransform               	@ 31   
---@field SliderContainerArea           	UnityEngine.RectTransform               	@ 32   
---@field Slider                        	UnityEngine.UI.Slider                   	@ 33   
---@field BtnLarge                      	UnityEngine.RectTransform               	@ 34   
---@field BtnSmall                      	UnityEngine.RectTransform               	@ 35   
local ClubGVGGroupMainDialog = Class('ClubGVGGroupMainDialog')


function ClubGVGGroupMainDialog:__init()
    self._isShowContainer = true
    self._isShowSafeMode = false
    self._isShowBanner = false
    self._path2Env = {}
    self._path2loading = {}

    self._btnTeamLuaEnv = nil
    ---@type OverseaChatButtonNode
    self._chatButtonNode = nil

    
end


function ClubGVGGroupMainDialog:__delete()
    self.controller = nil
end


function ClubGVGGroupMainDialog:Awake()
    self.controller.IsCameraState = false
    ---@type UnityEngine.GameObject
    self.TaskRedPoint = GameUtils.GetRedPointGo(self.BtnTask)

end


function ClubGVGGroupMainDialog:OnFocus(focus)
    self.controller.CacheCanvas.enabled = focus
    Events.Broadcast(GVGConstants.EventNames.FocusHomeDialog, focus)
    if focus then
        Events.Broadcast(ClubGVGUtils.Constants.EventNames.SetCameraShowState, true)
        URPCameraController:SetMainCameraActive(false)
        CfUtils.RefreshTopGoodsNew({self._rebirthGoodsId}, false, true)
        CfUtils.SetTopCommonCb(function ()
            ClubGVGUtils.CloseScene()
        end)
    else
        CfUtils.ResetNavigatorCustomBackAction()
    end
end


function ClubGVGGroupMainDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:OnInit()
        self:FreshUI(true)
        self:FreshTaskRedPoint()
    end))
    return coWait
end


-- function ClubGVGGroupMainDialog:OnShow()
--     ---@type Engine.Lib.CoWait
--     local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

--     end))
--     return coWait
-- end


function ClubGVGGroupMainDialog:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:RemoveListeners()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end


--region init 

function ClubGVGGroupMainDialog:OnInit()
    self:InitData()
    self:InitUI()
    self:InitAction()
    self:InitListeners()
end

function ClubGVGGroupMainDialog:InitData()
    self._freesRebirthTimes    = ClubGVGUtils.GetParamValue(GVGConstants.ParamsId.FreeRebirthTimes)
    self._rebirthGoodsId       = ClubGVGUtils.GetParamValue(GVGConstants.ParamsId.RebirthGoodsId)
    self._rebirthGoodsBuyGoodsId = ClubGVGUtils.GetParamValue(GVGConstants.ParamsId.RebirthGoodsBuyGoodsId)
    -- self._streamerDurationSeconds = ClubGVGUtils.GetParamValue(GVGConstants.ParamsId.StreamerDurationSeconds)

    ---@type ClubGVGMgr
    self._mgr               = ClubGVGUtils.GetMgr()
    ---@type ClubGVGComponent
    self._comp              = ClubGVGUtils.GetComp()

    self._mapScaleType = self._mgr:GetMapScaleType()
end

function ClubGVGGroupMainDialog:InitUI()
    self.Slider.value = self._mapScaleType
end

function ClubGVGGroupMainDialog:InitAction()
    local Bind            = Bind
    local SetButtonAction = SetButtonAction
    SetButtonAction(self.BtnShow,         Bind(self, self.OnClickBtnShowAction))
    SetButtonAction(self.BtnExplain,      Bind(self, self.OnClickBtnExplainAction))
    SetButtonAction(self.BtnBattleReport, Bind(self, self.OnClickBtnBattleReportAction))
    SetButtonAction(self.BtnTask,         Bind(self, self.OnClickBtnTaskAction))
    SetButtonAction(self.BtnRank,         Bind(self, self.OnClickBtnRankAction))
    SetButtonAction(self.BtnChange,       Bind(self, self.OnClickBtnChangeAction))
    SetButtonAction(self.BtnTeam,         Bind(self, self.OnClickBtnTeamAction))
    SetButtonAction(self.BtnReborn,       Bind(self, self.OnClickBtnRebornAction))
    SetButtonAction(self.Marching,        Bind(self, self.OnClickMarchingAction))
    SetButtonAction(self.EnemyRaid,       Bind(self, self.OnClickEnemyRaidAction))
    SetButtonAction(self.BtnSmall,       Bind(self, self.OnClickBtnSmallAction))
    SetButtonAction(self.BtnLarge,       Bind(self, self.OnClickBtnLargeAction))

    
    local Slider = self.Slider
    Slider.onValueChanged:AddListener(Bind(self, self.OnSliderValueChange))

    --- 由于在gvg 使用 easy touch 默认无视掉ui时间 这里要做滑动屏蔽  所以新起个area用来接受给slide传递事件
    local eventObj = self.SliderContainerArea.gameObject
    local dragProxy = UIDragProxy.Create(eventObj)
    dragProxy.onPointerDrag = function (eventData)
        Slider:OnDrag(eventData)

    end
    dragProxy.onInitializePotentialDrag = function (eventData)
        Slider:OnInitializePotentialDrag(eventData)

    end

    local eventProxy = UIEventProxy.Create(eventObj)
    eventProxy.onPointerDown = function (eventData)
        Events.Broadcast(GVGConstants.EventNames.ChangeBuildingDetailsShowState, false)
        Slider:OnPointerDown(eventData)
    end
    eventProxy.onPointerUp = function (eventData)
        Events.Broadcast(GVGConstants.EventNames.ChangeBuildingDetailsShowState, true)
    end
end

function ClubGVGGroupMainDialog:InitListeners()
    local EventNames = ClubGVGUtils.Constants.EventNames
    local Bind = Bind
    self._listeners = CfUtils.EventsDecorated({
        [EventNames.DataUpdate]            = Bind(self, self.OnEventDataUpdate),
        [EventNames.ChangeStageStatus]     = Bind(self, self.OnEventChangeStageStatus),
        [EventNames.ChangeCountDown]       = Bind(self, self.OnEventChangeCountDown),
        [EventNames.ShowBuildingDetails]   = Bind(self, self.OnEventShowBuildingDetails),
        [EventNames.ReceiveRecord]         = Bind(self, self.OnEventReceiveRecord),
        [EventNames.RequestSuccess]        = Bind(self, self.OnEventRequestSuccess),
        [EventNames.UpdateTaskRedPoint]    = Bind(self, self.OnEventUpdateTaskRedPoint),

    })    
end
function ClubGVGGroupMainDialog:RemoveListeners()
    CfUtils.EventsUndecorated(self._listeners)
    self._listeners = nil
end

--endregion 


--region logic 

function ClubGVGGroupMainDialog:FreshUI(isInit)
    self:FreshCountdown(GameUtils.GetServerTime())
    self:FreshStageStatus(isInit)
    self:FreshChatNode()
    self:FreshTeamBtnStatus()
    self:FreshRebirthTimes()
    self:FreshMessageGroup()
    
end

function ClubGVGGroupMainDialog:FreshCountdown(curSeconds)
    ---@type ClubGVGHomeDojo
    local dojo             = self:GetDojo()
    local stage            = dojo.stage
    local stageLeftSeconds = dojo.stageEndSeconds - curSeconds
    self.TextNumber.text = CfUtils.GetTimeHMS2(stageLeftSeconds)

end

function ClubGVGGroupMainDialog:FreshStageStatus(isChange)
    if not isChange then
        return
    end
    ---@type ClubGVGHomeDojo
    local dojo     = self:GetDojo()
    local stage                     = dojo.stage
    local status           = stage == ClubGVGUtils.Constants.Stage.Preview and 1 or 2
    self.ImgText.Status    = status
    self.ImgText2.Status   = status
    self.ImgBg.Status      = status
    self.TextDesc.text      = status == 1 and localize("活动开始倒计时") or localize("大乱斗倒计时")
    self.TextNumber.Status = status
end

function ClubGVGGroupMainDialog:FreshChatNode()
    ---@type OverseaChatButtonNode
    local env = self:GetChatBtnNodeLuaEnv()
    if isNull(env) then return end
    local ChatConstants = import('Game.OverseaChat.ChatConstants')
    env:SetChannelFilter({ChatConstants.Channels.Union})
    env:SetButtonCallback(function()
        CfUtils.DialogOpen(Constants.UITypeIds.OverseaChatMainDialog, {type = ChatConstants.Channels.Union})
    end)

end

---FreshTeamBtnStatus
---刷新团队按钮状态
function ClubGVGGroupMainDialog:FreshTeamBtnStatus()
    ---@type ClubGVGGroupMainBtnTeam
    local env          = self:GetBtnTeamLuaEnv()
    if isNull(env) then return end
    local stageStatus = env:FreshUI()
    local dojo = self:GetDojo()
    SetActive(self.BtnChange, dojo.clubIsDie == 0 and (stageStatus == GVGConstants.StageStatus.PrepareComplete or stageStatus == GVGConstants.StageStatus.BattleStageAndNonAcceded))
    
end

function ClubGVGGroupMainDialog:FreshTeamBtnRebirthEffect(isShow)
    ---@type ClubGVGGroupMainBtnTeam
    local env          = self:GetBtnTeamLuaEnv()
    if isNull(env) then return end
    env:FreshRebirthEffectShowStatus(isShow)
end

function ClubGVGGroupMainDialog:FreshTeamEntranceShowStatus(isShow)
    ---@type ClubGVGGroupMainBtnTeam
    local env          = self:GetBtnTeamLuaEnv()
    if isNull(env) then return end
    env:FreshTeamEntranceShowStatus(isShow)
end

---FreshRebirthTimes
---刷新重生次数 
function ClubGVGGroupMainDialog:FreshRebirthTimes()
    ---@type ClubGVGHomeDojo
    local dojo              = self:GetDojo()
    if dojo.clubIsDie == 1 then
        SetActive(self.BtnReborn, false)
        return
    end
    local leftRebirthTimes  = dojo.leftRebirthTimes
    local freesRebirthTimes = self._freesRebirthTimes
    local stageStatus = self._mgr:GetStageStatus()

    SetActive(self.BtnReborn, (stageStatus == GVGConstants.StageStatus.InBattle or leftRebirthTimes == 0))

    self.BtnRebornTextNumber.text = string.format("%s/%s", leftRebirthTimes, freesRebirthTimes)

    self.TextLifeNum.text = localize("剩余复活次数_num_", {_num_ = leftRebirthTimes})

    SetActive(self.LifeUp, leftRebirthTimes == 0)
    SetActive(self.Reborn, leftRebirthTimes > 0)
    
end

function ClubGVGGroupMainDialog:FreshMessageGroup()
    --- 强敌来袭 ： 跟工会走 
    self:FreshEnemyMarching()

    --- 刷新行军 ： 跟自己走
    self:FreshMarching()

end

function ClubGVGGroupMainDialog:FreshEnemyMarching()
    local seconds = self._mgr:GetEnemyMarchSeconds()
    self:FreshMarchSeconds(self.EnemyRaid, self.EnemyRaidTextNumber, seconds)
end

function ClubGVGGroupMainDialog:FreshMarching()
    local seconds = self._mgr:GetMarchSeconds()
    self:FreshMarchSeconds(self.Marching, self.MarchingTextNumber, seconds)
end

---FreshMarchSeconds
---@param node UnityEngine.RectTransform
---@param timeNode TMPro.TextMeshProUGUI
---@param seconds number
function ClubGVGGroupMainDialog:FreshMarchSeconds(node, timeNode, seconds)
    local isShow = seconds ~= nil
    SetActive(node, isShow)
    if isShow then
        timeNode.text = GetTimeHMS2(seconds)
    end
    
end

function ClubGVGGroupMainDialog:FreshBuildingCountdown(curSeconds)
    ---@type ClubGVGGroupBuildingDetails
    local env = self:GetBuildingDetailsEnv()
    if isNull(env) then return end
    env:UpdateCountDown(curSeconds)

end

function ClubGVGGroupMainDialog:ReloadBuildingDetails(buildingId)
    ---@type ClubGVGGroupBuildingDetails
    local env = self:GetBuildingDetailsEnv()
    if isNull(env) then return end
    env:ReloadUI(buildingId)
end

function ClubGVGGroupMainDialog:FreshTaskRedPoint()
    local dojo = self._mgr:GetHomeDojo()
    --- 服务器-1为不显示  0为显示  大于0为秒数之后显示
    local taskTips = dojo.taskTips
    SetActive(self.TaskRedPoint, taskTips == 0)

end

function ClubGVGGroupMainDialog:ShowSecondConfirmDeath(leftRebirthTimes)
    GameUtils.SecondConfirm(localize("是否立即死亡并在出生点重生"), function ()
        self._mgr:RequestDeath()
    end, nil, localize("重生消耗一次复活机会(剩余_num_次)，精力回满", {_num_ = leftRebirthTimes}))

end

function ClubGVGGroupMainDialog:ShowSecondConfirmRebirth()
    -- self._rebirthGoodsId
    local num = GoodsUtils.GetThingNo(self._rebirthGoodsId)
    if num <= 0 then
        -- GameUtils.Toast(localize("复活次数为0，无法重生"))
        ClubGVGUtils.ShowRebirthGoodsExchange()
        return
    end
    if self._mgr:GetIsConfirmTick() then
        self._mgr:RequestRebirth({{goodsId = self._rebirthGoodsId, num = -1}})
        return
    end

    ---@type GoodsVo
    local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(self._rebirthGoodsId)
    GameUtils.SecondConfirm(localize("剩余1个_name_，使用后增加1次复活次数，是否确认", {_name_ = vo.name}), function ()
        self._mgr:RequestRebirth({{goodsId = self._rebirthGoodsId, num = -1}})
    end, nil, nil, nil, vo, nil, nil, function (isConfirmTick)
        self._mgr:SetIsConfirmTick(isConfirmTick)
    end)

end

--endregion 


--region get/set 

---@return ClubGVGHomeDojo
function ClubGVGGroupMainDialog:GetDojo()
    return self._comp:GetDojo()
end


---@return OverseaChatButtonNode
function ClubGVGGroupMainDialog:GetChatBtnNodeLuaEnv()
    if isNull(self._chatButtonNode) then
        ---@type OverseaChatButtonNode
        self._chatButtonNode = CfUtils.GetLuaScr(self.OverseaChatBtnNode, ClubGVGUtils.Constants.LuaPath.OverseaChatButtonNode)
    end
    return self._chatButtonNode
end

---@return ClubGVGGroupMainBtnTeam
function ClubGVGGroupMainDialog:GetBtnTeamLuaEnv()
    if isNull(self._btnTeamLuaEnv) then
        ---@type ClubGVGGroupMainBtnTeam
        self._btnTeamLuaEnv = CfUtils.GetLuaScr(self.BtnTeam, ClubGVGUtils.Constants.LuaPath.ClubGVGGroupMainBtnTeam)
    end
    return self._btnTeamLuaEnv
end

---@return ClubGVGGroupBuildingDetails
function ClubGVGGroupMainDialog:GetBuildingDetailsEnv()
    if isNull(self._buildingDetailsEnv) then
        ---@type ClubGVGGroupBuildingDetails
        local luaEnv = CfUtils.GetLuaScr(self.BuildingDetail, ClubGVGUtils.Constants.LuaPath.ClubGVGGroupBuildingDetails)
        self._buildingDetailsEnv = luaEnv
    end
    return self._buildingDetailsEnv
end


---endregion 


--region handler 

function ClubGVGGroupMainDialog:OnClickBtnShowAction()
    self._isShowContainer = not self._isShowContainer
    SetActive(self.Container, self._isShowContainer)
    self.BtnShowImage.Status = self._isShowContainer and 1 or 2

end

function ClubGVGGroupMainDialog:OnClickBtnExplainAction()
    CfUtils.ShowModuleToast(Constants.SystemToggleIds.Id4006)

end

function ClubGVGGroupMainDialog:OnClickBtnBattleReportAction()
    CfUtils.DialogOpen(Constants.UITypeIds.ClubGvgGroupFightMessageDialog, {}, {UIArgs(Constants.UITypeIds.ClubGvgGroupMainDialog)})
end

function ClubGVGGroupMainDialog:OnClickBtnTaskAction()
    CfUtils.DialogOpen(Constants.UITypeIds.LadderStruggleTaskRewardDialog, {systemName = Constants.SystemToggleIds.Id4006, isCameraState = false})
end

function ClubGVGGroupMainDialog:OnClickBtnRankAction()
    CfUtils.DialogOpen(Constants.UITypeIds.ClubGvgGroupRankingsDialog, nil, {UIArgs(Constants.UITypeIds.ClubGvgGroupMainDialog)})
end

function ClubGVGGroupMainDialog:OnClickBtnChangeAction()
    CfUtils.DialogOpen(Constants.UITypeIds.ClubGvgGroupEditTeamPopup, nil, {UIArgs(Constants.UITypeIds.ClubGvgGroupMainDialog)})
end

function ClubGVGGroupMainDialog:OnClickBtnTeamAction()
    ---@type ClubGVGMgr
    local mgr          = self._mgr
    local dojo = mgr:GetHomeDojo()
    if dojo.rebirthTime > GameUtils.GetServerTime() then
        GameUtils.Toast(localize("复活中"))
        return
    end
    local stageStatus = mgr:GetStageStatus()
    
    if stageStatus == GVGConstants.StageStatus.PrepareAndUneditedTeam 
    or stageStatus == GVGConstants.StageStatus.BattleStageAndUneditedTeam 
    then
        CfUtils.DialogOpen(Constants.UITypeIds.ClubGvgGroupEditTeamPopup, nil, {UIArgs(Constants.UITypeIds.ClubGvgGroupMainDialog)})
    elseif stageStatus == GVGConstants.StageStatus.BattleStageAndNonAcceded then
        
        local leftRebirthTimes = dojo.leftRebirthTimes
        if leftRebirthTimes > 0 then
            --- 发送加入战场
            self._mgr:RequestJoin()
        else
            self:ShowSecondConfirmRebirth()
        end

    else
        local playerPlace = checkNumber(dojo.playerPlace)
        local buildingId = playerPlace == 0 and checkNumber(dojo.clubPlace) or playerPlace
        Events.Broadcast(GVGConstants.EventNames.FocusBuilding, buildingId)

    end

end

function ClubGVGGroupMainDialog:OnClickBtnRebornAction()
    ---@type ClubGVGHomeDojo
    local dojo = self._mgr:GetHomeDojo()
    if GameUtils.GetServerTime() < dojo.rebirthTime then
        GameUtils.Toast(localize("重生中"))
        return
    end
    local leftRebirthTimes = dojo.leftRebirthTimes
    self:CheckAndHandleReborn(leftRebirthTimes)
end

function ClubGVGGroupMainDialog:CheckAndHandleReborn(leftRebirthTimes)
    if leftRebirthTimes <= 0 then
        self:ShowSecondConfirmRebirth()     
        return
    end
    
   self:ShowSecondConfirmDeath(leftRebirthTimes)
end

function ClubGVGGroupMainDialog:OnClickMarchingAction()
    local seconds, marchInfo = self._mgr:GetMarchSeconds()
    if seconds == nil or marchInfo == nil then
        return
    end
    local endBuilding = checkNumber(marchInfo.endBuilding)
    Events.Broadcast(GVGConstants.EventNames.FocusBuilding, endBuilding)

end

function ClubGVGGroupMainDialog:OnClickEnemyRaidAction()
    local seconds, marchInfo = self._mgr:GetEnemyMarchSeconds()
    if seconds == nil or marchInfo == nil then
        return
    end

    local endBuilding = checkNumber(marchInfo.endBuilding)
    Events.Broadcast(GVGConstants.EventNames.FocusBuilding, endBuilding)

end

function ClubGVGGroupMainDialog:OnClickBtnSmallAction()
    self.Slider.value = GVGConstants.MapScaleType.Default
end

function ClubGVGGroupMainDialog:OnClickBtnLargeAction()
    self.Slider.value = GVGConstants.MapScaleType.Secondary
end

function ClubGVGGroupMainDialog:OnSliderValueChange(num)
    num = checkInt(num)
    if self._mapScaleType == num  then
        return
    end
    self._mgr:SetMapScaleType(num)
    self._mapScaleType = num
    Events.Broadcast(GVGConstants.EventNames.ChangeOrthographicSize, num)
  
end

function ClubGVGGroupMainDialog:OnEventChangeStageStatus()
    self:FreshTeamBtnStatus()
end

function ClubGVGGroupMainDialog:OnEventChangeCountDown(curSeconds)
    self:FreshCountdown(curSeconds)
    self:FreshMessageGroup()
    self:FreshBuildingCountdown(curSeconds)
end

function ClubGVGGroupMainDialog:OnEventShowBuildingDetails(buildingId, isReload)
    ---@type ClubGVGGroupBuildingDetails
    local env = self:GetBuildingDetailsEnv()
    if isNotNull(env) then
        if isReload then
            env:ReloadUI(buildingId)
        else
            env:FreshUI(buildingId)
        end
    end
end

function ClubGVGGroupMainDialog:OnEventReceiveRecord(dataType, data, isFindSelf, extraData)
    local bid = data.bid
    if dataType == GVGConstants.ReportId.Join then
        local playerId = checkNumber(data.pid)
        if isFindSelf then
            self:FreshTeamBtnStatus()
            self:FreshRebirthTimes()
        end
    elseif dataType == GVGConstants.ReportId.March then
        if isFindSelf then
            self:FreshTeamBtnStatus()
        end
        bid = data.pa[#data.pa]
    elseif dataType == GVGConstants.ReportId.Player_Die then
        local isClubDie = extraData.isClubDie 
        if isFindSelf and isClubDie then
            self:FreshUI(false)
        end
    elseif dataType == GVGConstants.ReportId.Building_Atk then
        if isFindSelf then
            self:FreshTeamBtnStatus()
        end

    end

    if bid then
        local buildingId = checkNumber(bid)
        self:ReloadBuildingDetails(buildingId)
    end
end


function ClubGVGGroupMainDialog:OnEventDataUpdate(triggerType, data, extraData)
    if triggerType == GVGConstants.TriggerType.Stage_Change then
        self:FreshStageStatus(true)
        self:FreshTeamBtnStatus()

    elseif triggerType == GVGConstants.TriggerType.Atk_Player_Limit_Remove then
        local isPlayerDie = extraData.isPlayerDie
        if isPlayerDie then
            self:FreshUI(false)
        else
            self:FreshTeamBtnStatus()
        end
    elseif triggerType == GVGConstants.TriggerType.March_Complete then
        local isSelf = extraData
        self:FreshTeamBtnStatus()

    elseif triggerType == GVGConstants.TriggerType.Rebirth_Limit_Remove then
        self:FreshTeamBtnRebirthEffect(true)
        self:FreshTeamBtnStatus()
        self:FreshRebirthTimes()

    elseif triggerType == GVGConstants.TriggerType.Rebirth_Effect_Remove then
        self:FreshTeamBtnRebirthEffect(false)
        self:FreshTeamEntranceShowStatus(true)

    end

    if data and data.bid then
        -- print("OnEventDataUpdate---->>>", table.toString(data))
        local buildingId = checkNumber(data.bid)
        self:ReloadBuildingDetails(buildingId)
    end
end

function ClubGVGGroupMainDialog:OnEventRequestSuccess(interface)
    if interface == Interfaces.OverseaClubGVGHome then
        self:FreshUI(false)
    elseif interface == Interfaces.OverseaClubGVGRebirth then
        self:FreshRebirthTimes()

    end

end

function ClubGVGGroupMainDialog:OnEventUpdateTaskRedPoint()
    self:FreshTaskRedPoint()

end

---endregion 


return ClubGVGGroupMainDialog
