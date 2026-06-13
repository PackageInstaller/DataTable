local PlantPopupCtrl = BaseClass("PlantPopupCtrl", BaseUICtrl)
local M = PlantPopupCtrl

local itemCtrl = require("UI.Ctrl.Common.CommonItemCtrl")
local itemView = require("UI.View.Common.ItemPfbView")

function M:Init()
    self._preStamp = 0
    self._timeGap = 0
    self._furnitureId = 0
    self._state = DormConst.PlantType.Fall

    self._view.node_list:Init(itemCtrl, itemView)
    local binder = Bind(self, self.OnChangeState)
    local eventId = UIMessageNames.DORM_PLANT_STATE
    self._timerBind = Bind(self, self._PlantTimerCallBack)
    self._changeState = EventMgr:AddListener(eventId, binder)
end

function M:OnEnter(furnitureId)
    -- body
    self:OnChangeState(furnitureId)
end

function M:OnClose()
    if self._timer then
        self._timer:Stop()
        self._timer = nil
    end
    self._preStamp = 0
    self._timeGap = 0
    self._furnitureId = 0
    self._state = DormConst.PlantType.Fall
    EventMgr:RemoveListener(UIMessageNames.DORM_PLANT_STATE, self._changeState)
end

function M:_SetRewardGroup(groupId)
    local itemCfg = ConfigHelper.GetCfgByLua("itemGroup", groupId)
    if not itemCfg then
        Logger.LogError(string.format("itemGroup is null. ID:%s", groupId))
        return
    end
    local list = {}
    for i = 1, itemCfg.items.Length do
        local idx = i - 1
        local Id = itemCfg.items[idx]
        local Num = itemCfg.cnts[idx]
        if Id > 0 and Num > 0 then
            table.insert(list, { itemId = Id, numType = ItemNumberType.TOTLE, itemNum = Num })
        end
    end
    self._view.node_list:SetDataList(list)
end

function M:OnChangeState(furnitureId)
    self._furnitureId = furnitureId
    local plant = DormDataMgr:GetRolePlantConfig(furnitureId)
    local stage = DormDataMgr:GetRolePlantStage(furnitureId) -- 生长阶段
    self._state = DormDataMgr:GetRolePlantState(furnitureId) -- 生长状态
    local endStamp = DormDataMgr:GetRolePlantTime(furnitureId)

    if stage >= DormConst.PlantType.Complete then
        self._timeGap = plant.reward[1]
    else
        self._timeGap = plant.growTime[stage + 1]
    end

    local descId = plant.stageDesc and plant.stageDesc[stage + 1] or 0
    self._preStamp = endStamp - self._timeGap -- 上次操作的时间
    self._view.plantName:SetText(plant.name)
    self._view.plantGrow:SetText(4130)
    self._view.plantStage1:SetActive(stage == 0)
    self._view.plantStage2:SetActive(stage == 1)
    self._view.plantStage3:SetActive(stage >= 2)
    self._view.plantTips:SetText(4131)
    self._view.plantState:SetText(descId)

    self:_PlantTimerCallBack()
    self:_SetRewardGroup(plant.reward[2])

    if self._timer then self._timer:Stop() end
    self._timer = nil

    if self._state == DormConst.PlantType.Fall then
        return
    end

    self._timer = TimerManager:GetInstance():GetTimer(1, self._timerBind, self)
    self._timer:Start()
end

function M:_PlantTimerCallBack()
    local curStamp = TimeUtil.GetNowTimeStamp()
    if self._state == DormConst.PlantType.Fall then
        curStamp = DormDataMgr:GetRolePlantPestTime(self._furnitureId)
    end
    local passTime = math.min(curStamp - self._preStamp, self._timeGap) -- 从上次到现在经过的时间
    local passTimeStr = TimeUtil.ConvertTimeForm(passTime)
    local nextTimeStr = TimeUtil.ConvertTimeForm(self._timeGap)
    self._view.plantSlider:SetFillAmount(passTime / self._timeGap)
    self._view.plantTime:SetText(passTimeStr .. "/" .. nextTimeStr)
    if self._view.plantSlider:GetFillAmount() >= 1 and self._timer then
        self._timer:Stop()
        self._timer = nil
    end
end

return PlantPopupCtrl
