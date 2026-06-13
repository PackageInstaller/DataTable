-- 预制体 OtakuMainUI
local OtakuRoomCtrl = BaseClass("OtakuRoomCtrl", require("UI.Ctrl.Common.BaseSubCtrl"))
local M = OtakuRoomCtrl
local OtakuRoomType = OtakuType.OtakuRoomType
local RoomStateLiveType = OtakuType.RoomStateLiveType
local ETableState = EnumConst.ETableState
local maxCabinOpenCondition = 4

function M:Awake(type, index, mainMgr, roomData)
    self.m_isClose = false
    self.m_MainMgr = mainMgr
    self.m_Index = index
    self.m_Type = type
    self.m_ResConfig = roomData or OtakuRoomDataMgr:GetInstance():GetHouseResByTypeIndex(self.m_Type, self.m_Index)

    -- 宿舍特殊
    if self.m_Type == OtakuRoomType.EST_Dormitory then
        self.m_RoomState = OtakuType.RoomStateType.Dormitory
        self._view.upPanel:SetActive(false)
        self._view.roomState:SetState(self.m_RoomState)
        self._view.name:SetText(self.m_ResConfig.name)
        self._view.icon:SetPic(self.m_ResConfig.icon)
        return
    end

    -- 没有房间信息 就当做没有建造
    if not roomData then
        self:_SetLockState()
        return
    end

    self:Refresh(roomData)
end

function M:Update()
    if not self.m_RoomData then
        self:_SetLockState()
        return
    end

    -- 刷新一下房间数据
    self.m_RoomData = OtakuRoomDataMgr:GetInstance():RoomDataByRoomId(self.m_RoomData:RoomId())
    self:Refresh(self.m_RoomData)
end

-- 刷新房间信息
function M:Refresh(roomData)
    self.m_RoomData = roomData
    self:_SetRoomState()
    self:_SetTypeState()
    self:_SetNumState()
    self:_SetUIState()
    self:_BuildingBar()
end

-- 设置UI
function M:_SetUIState()
    self._view.roomState:SetState(self.m_RoomState)
    self._view.typeState:SetState(self.m_RoomContentState)
    self._view.name:SetText(self.m_RoomData:Name())
    self._view.icon:SetPic(self.m_RoomData:Icon())
    -- 代码优化通讯舱状态 暂时先这样 最优的办法是同个uistate控制
    if self.m_Type ~= OtakuRoomType.EST_Communication then
        local maxLevel = self.m_RoomData:MaxLevel()
        self._view.dotList:Update(self.m_RoomData:Level(), maxLevel)
        self._view.upPanel:SetActive(self.m_RoomData:IsUpLevel())
    end
end

function M:_SetNumState()
    local type = self.m_RoomData:Type()
    if type == OtakuRoomType.EST_Canteen then
        self:_SetCanteenNumState()
    else
        self:_SetOtherNumState()
    end
end

-- 餐厅人员数量
function M:_SetCanteenNumState()
    local level = self.m_RoomData:Level()
    local allNum = self.m_RoomData:LevelConfig()[level].seatLimit
    local cdNum = self:_GetEatNums()
    self._view.numText:SetText(tostring(cdNum))
    self._view.maxText:SetText("/" .. allNum)
end

function M:_GetEatNums()
    local num = 0
    local nowTimer = TimeUtil.GetNowTimeStamp()
    local dinings = self.m_RoomData:GetDinings()

    for _, diningData in pairs(dinings) do
        if diningData.state == ETableState.Cleaning then
            if diningData.EndTick > nowTimer then
                num = num + 1
            else
                diningData.state = ETableState.None
            end
        end
    end
    return num
end

function M:_SetOtherNumState()
    local state = self.m_RoomData:IsHaveHunger() and 2 or 1
    local curNum = self.m_RoomData:CurRoleLiveNum()
    local maxNum = self.m_RoomData:RoleDeployMaxNum()
    self._view.numState:SetState(state)
    self._view.numText:SetText(tostring(curNum))
    self._view.maxText:SetText("/" .. tostring(maxNum))
    self._view.roleNumItem:SetActive(maxNum > 0)
end

-- 设置房间状态
function M:_SetRoomState()
    if self.m_Type == OtakuRoomType.EST_Communication then
        self._view.upPanel:SetActive(false)
        self.m_RoomState = OtakuType.RoomStateType.Dormitory
        return
    end

    self.m_RoomState = OtakuType.RoomStateType.Build
    if self.m_RoomData:Builded() then
        self.m_RoomState = OtakuType.RoomStateType.Normal
    elseif self.m_RoomData:RemainTime() > 0 then
        self.m_RoomState = OtakuType.RoomStateType.Building
    end
end

-- 设置舱室状态
function M:_SetTypeState()
    self.m_RoomContentState = OtakuType.RoomContentStateType.Normal

    local type = self.m_RoomData:Type()
    if type == OtakuRoomType.EST_Produce then
        self:_ProduceState()
    elseif type == OtakuRoomType.EST_Communication then
        self:_CommunicationState()
    elseif type == OtakuRoomType.EST_Canteen then
        self:_CanteenState()
    elseif type == OtakuRoomType.EST_Compose then
        self:_ComposeState()
    elseif type == OtakuRoomType.EST_Survey then
        self:_SurveyState()
    elseif type == OtakuRoomType.EST_Kitchen then
        self:_KitchenState()
    end
end

-- 设置建造建造中UI状态
function M:_BuildingBar()
    if self.m_RoomState ~= OtakuType.RoomStateType.Building then
        return
    end

    self:_OnTimerCallBack()
end

-- 设置建造完成UI状态
function M:_SetBuildState()
    self.m_RoomState = OtakuType.RoomStateType.Builded
    self._view.roomState:SetState(self.m_RoomState)
    self:_OnBuildTimerCallBack()
end

-- 设置锁定UI状态
function M:_SetLockState()
    local canBuild, CanShow = self:_GetIsLock()
    if CanShow == false then
        self.m_RoomState = OtakuType.RoomStateType.BlackMask
        for i = 1, maxCabinOpenCondition do
            self.m_LockItems[i]:SetActive(false)
        end
    else
        self.m_RoomState = canBuild and OtakuType.RoomStateType.Build or OtakuType.RoomStateType.Lock
    end
    self._view.roomState:SetState(self.m_RoomState)
    self._view.upPanel:SetActive(false)
    self._view.name:SetText(self.m_ResConfig.name)
    self._view.icon:SetPic(self.m_ResConfig.icon)
end

-- 解锁信息设置
function M:_GetIsLock()
    local index = 1
    local LockCount = 0
    local maxLockCount = 0
    if self.m_ResConfig.openCondition then
        for i = 1, #self.m_ResConfig.openCondition do
            local unLock = GameHelper.CheckLockByOpenConditionId(self.m_ResConfig.openCondition[i]);
            local text = OtakuHelper.GetRoomLockByString(self.m_ResConfig.openCondition[i])
            local state = unLock and 2 or 1
            self.m_LockItems[i].state:SetState(state)
            self.m_LockItems[i].text:SetText(text)
            self.m_LockItems[i]:SetActive(true)
            if unLock == false then
                LockCount = LockCount + 1
            end
        end
        index = #self.m_ResConfig.openCondition + 1
        maxLockCount = #self.m_ResConfig.openCondition
    end

    local canBuild, bridgeLevel, isFrontBuild = self.m_MainMgr:IsCompose(self.m_Type, self.m_Index)

    -- 第一个舱室不显示修复上一舱室
    if self.m_Index == 1 then
        self.m_LockItems[index]:SetActive(false)
    else
        self.m_LockItems[index]:SetActive(false)
        self.m_LockItems[index].text:SetText(5763)
        if isFrontBuild == false then
            self.m_LockItems[index].state:SetState(1)
            LockCount = LockCount + 1
        else
            self.m_LockItems[index].state:SetState(2)
        end
        maxLockCount = maxLockCount + 1
    end
    local unLockCount = maxLockCount - LockCount
    local canShow = unLockCount >= 2 or unLockCount >= maxLockCount
    return canBuild and unLockCount >= maxLockCount, canShow
end

-- 制造室状态
function M:_ProduceState()
    if self.m_RoomData:IsFinish() then
        local makeItemId = self.m_RoomData:MakeItemId()
        local makeItem = ConfigHelper.GetCfgByLua("makeItem", makeItemId) or {}
        self._view.itemIcon:SetItemIcon(makeItem.item)

        self.m_RoomState = OtakuType.RoomStateType.Reward
        self._view.roomState:SetState(self.m_RoomState)
    elseif self.m_RoomData:IsRoomStop() then
        self.m_RoomContentState = OtakuType.RoomContentStateType.Stop
    elseif not self.m_RoomData:IsRoomMaking() then
        self.m_RoomContentState = OtakuType.RoomContentStateType.ProduceFree
    else
        self.m_RoomContentState = OtakuType.RoomContentStateType.Producing
    end
end

-- 餐厅状态设置
function M:_CanteenState()
    if self.m_RoomData:IsEnd() then
        self.m_RoomContentState = OtakuType.RoomContentStateType.EatFree
    else
        self.m_RoomContentState = OtakuType.RoomContentStateType.Eating
    end
end

-- 合成状态设置
function M:_ComposeState()
    self.m_RoomContentState = OtakuType.RoomContentStateType.ComposeFree
end

-- 通讯室状态
function M:_CommunicationState()
end

-- 通讯室状态
function M:_SurveyState()
    local roomData = OtakuRoomDataMgr:GetInstance():RoomDatasByRoomType(OtakuRoomType.EST_Survey)

    for i, v in ipairs(roomData) do
        local ids = v:GetFinishSurveyIds()

        if #ids > 0 then
            self.m_RoomState = OtakuType.RoomStateType.Reward
            self._view.roomState:SetState(self.m_RoomState)
            return
        end
    end
end

-- 厨房状态
function M:_KitchenState()
    self.m_RoomContentState = OtakuType.RoomContentStateType.KitchenFree
end

-- 初始化
function M:Init()
    self.m_LockItems = {}
    for i = 1, maxCabinOpenCondition do
        self.m_LockItems[i] = self._view.lockItem:Instantiate()
    end
    self._view:onClick(Bind(self, self._OnClick))
    self._view.buildBtn:onClick(Bind(self, self._OnBuildClick))
    self:ShowPanel()
end

-- 打开相应的舱室
function M:_OnClick()
    if self.m_RoomState == OtakuType.RoomStateType.Lock or self.m_RoomState == OtakuType.RoomStateType.Build or self.m_RoomState == OtakuType.RoomStateType.Building or self.m_RoomState == OtakuType.RoomStateType.Builded or self.m_RoomState == OtakuType.RoomStateType.BlackMask then
        return
    end

    local type = self.m_Type
    if type == OtakuRoomType.EST_Bridge then
        UIContextMgr:GetInstance():Show("BridgeUI", self.m_RoomData)
    elseif type == OtakuRoomType.EST_Communication then
        JumpMgr:GetInstance():Execute(77)
    elseif type == OtakuRoomType.EST_Dormitory then
        JumpMgr:GetInstance():Execute(6)
    elseif type == OtakuRoomType.EST_Compose then
        JumpMgr:GetInstance():Execute(75)
    elseif type == OtakuRoomType.EST_Survey then
        JumpMgr:GetInstance():Execute(76)
    elseif type == OtakuRoomType.EST_Produce then
        local roomIndex = self.m_RoomData:RoomIndex()
        if roomIndex == 1 then
            JumpMgr:GetInstance():Execute(72)
        elseif roomIndex == 2 then
            JumpMgr:GetInstance():Execute(78)
        else
            JumpMgr:GetInstance():Execute(79)
        end
    elseif type == OtakuRoomType.EST_Canteen then
        local roomIndex = self.m_RoomData:RoomIndex()
        if roomIndex == 1 then
            JumpMgr:GetInstance():Execute(74)
        else
            JumpMgr:GetInstance():Execute(80)
        end
    elseif type == OtakuRoomType.EST_Kitchen then
        JumpMgr:GetInstance():Execute(94)
    else
        OtakuRoomDataMgr:GetInstance():EnterRoomStudioByType(type, self.m_RoomData:RoomId())
    end
end

function M:_OnBuildClick()
    if self.m_RoomState == OtakuType.RoomStateType.Build then
        OtakuRoomDataMgr:GetInstance():RequestBuildStudio(self.m_Type, Bind(self, self._OnBuildStudioCallBack))
    end
end

function M:_OnBuildStudioCallBack(roomdata)
    self.m_RoomData = roomdata
    self.m_MainMgr:UpdateAllRoom()
end

-- 时间及时
function M:_OnTimerCallBack()
    self.timercoroutine = coroutine.start(function()
        coroutine.waitforseconds(1.5)
        if self.m_isClose == false then
            self:_SetBuildState()
        end
    end)
end

function M:_OnBuildTimerCallBack()
    self.buildTimercoroutine = coroutine.start(function()
        coroutine.waitforseconds(0.5)
        if self.m_isClose == false then
            self:Refresh(self.m_RoomData)
        end
    end)
end

function M:OnDispose()
    self.m_isClose = true
    M.super.OnDispose(self)
end

return OtakuRoomCtrl
