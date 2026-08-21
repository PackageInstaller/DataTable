---@class ActivityFirstChargePanel : ActivityFirstChargePanel_Generate
---##################### 【ActivityFirstChargePanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【ActivityFirstChargePanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local ActivityFirstChargePanel = require "ActivityFirstChargePanel_Generate"

function ActivityFirstChargePanel:InitLogic(data)
    self.msgEventHandler = {
        --刷新任务按钮状态
        -- {GameMsgType.MissionRefresh, self.RefreshBtnState},
        {GameMsgType.MissionRefresh, self.RefreshUI},
    }
    self.timer = {}--界面元素渐入定时器
end

--function ActivityFirstChargePanel:StartCreating(time)
--
--end

--function ActivityFirstChargePanel:StartEnter(time)
--
--end

--function ActivityFirstChargePanel:StartRemoving(time)
--
--end

--function ActivityFirstChargePanel:StartExit(time)
--
--end

-- data = {
--     isFromActivity = bool --是否是活动入口进来
--     cfg = table --活动配置数据
-- }
function ActivityFirstChargePanel:OnOpen(data, initiative)
    LuaLogger.ds("ActivityFirstChargePanel:OnOpen", tablex.dump(data))
    if initiative then
        self._activityConfig = data.cfg
        self.bg.image.enabled = not data.isFromActivity
        self.closebtn:SetActive(not data.isFromActivity)
        self._isFromActivity = data.isFromActivity
        if data.isFromActivity then
            --活动
            -- self.btnGroup.rectTransform.localPosition = Vector3.New(806.3, -426.7, 0)
            -- self.activityGoBtn.rectTransform.localPosition = Vector3.New(755.1, 170.8, 0)
            -- self.middleDis.rectTransform.localPosition = Vector3.New(555.47, -124.9, 0)
        else
            --弹窗
            -- self.btnGroup.rectTransform.localPosition = Vector3.New(663.1, -463, 0)
            -- self.activityGoBtn.rectTransform.localPosition = Vector3.New(627.6, 117.4, 0)
            -- self.middleDis.rectTransform.localPosition = Vector3.New(403.9, -124.9, 0)
        end
        self:RefreshUI(initiative)
    end
end

--刷新界面
function ActivityFirstChargePanel:RefreshUI(initiative)
    local taskgroup = self._activityConfig.TaskGroup[1]
    local taskList = Config.GetTaskInfoByTaskTypeAndGroup(GE.MissionType.FirstCharge, taskgroup)
    self._missionConfig = taskList[1]
    LuaLogger.ds("ActivityFirstChargePanel:RefreshUI _missionConfig", tablex.dump(self._missionConfig))
    local rewardList = self._missionConfig.Award
    local missionData = Me:getMissionListById(self._missionConfig.id)
    local isGet = missionData.state == GE.MissionState.Received or missionData.state == GE.MissionState.Closed
    self:FillTemplateContent(self.box, self.middleDis, tablex.size(rewardList), function (index, box)
        local data = rewardList[index]
        local customBox = box.customBox
        customBox.customBox:setMono(self)
        --LuaLogger.ds("ActivityFirstChargePanel:RefreshUI data", tablex.dump(data))
        customBox.customBox:SetUIData(data, {isGet = isGet})
        local itemType = GE.RewardType.ItemProp
        local name = ""
        if data[1] == GE.RewardType.ItemProp then
            name = Config.GetItemInfo(data[2]).itemName
        elseif data[1] == GE.RewardType.Character then
            name = Config.GetCharacterInfo(data[2]).name
		elseif data[1] == GE.RewardType.Equipment then
            name = Config.GetEquipmentInfo(data[2]).name
        elseif data[1] == GE.RewardType.Weapon then
            name = Config.GetWeaponInfo(data[2]).name
        elseif data[1] == GE.RewardType.Skin then
            name = Config.GetCharacterSkinInfo(data[2]).skinName
        end
        box.desc.text.text = name
        --道具红点
        local missionData = Me:getMissionListById(self._missionConfig.id)
        customBox.customBox.redPoint:SetActive(missionData.state == GE.MissionState.Unclaimed)
        if initiative then
            box.canvasGroup.alpha = 0
            local timer = DLuaTimer:DoAfter(0.07 * index, function()
                if box and box.canvasGroup then
                    box.canvasGroup.alpha = 0
                    box.canvasGroup:DOFade(1, 0.2)
                end
            end)
            table.insert(self.timer, timer)
        end
    end)
    self:RefreshBtnState()
end

function ActivityFirstChargePanel:RefreshBtnState()
    local missionData = Me:getMissionListById(self._missionConfig.id)
    LuaLogger.ds("ActivityFirstChargePanel:RefreshBtnState missionData", tablex.dump(missionData))
    self.getBtn:SetActive(missionData.state == GE.MissionState.Unclaimed)
    -- self.redPoint:SetActive(missionData.state == GE.MissionState.Unclaimed)

    self.goBtn:SetActive(missionData.state == GE.MissionState.Progress)
    self.doneBtn:SetActive(missionData.state == GE.MissionState.Received or
        missionData.state == GE.MissionState.Closed)
end

function ActivityFirstChargePanel:OnClose(initiative)
    --清理界面元素渐入定时器
    for _, timer in pairs(self.timer) do
        DLuaTimer:RemoveTimer(timer)
    end
    self.timer = {}
end

--function ActivityFirstChargePanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function ActivityFirstChargePanel:OnRefresh(data)
--
--end

--[[
/bg/btnGroup/getBtn onClick  领取奖励
--]]
function ActivityFirstChargePanel:getBtn_ScaleButton_onClick(getBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, "click"))
    Me:GetMissionRewardReq({self._missionConfig.id}, function(data)
    end)
end

--[[ 
/bg/btnGroup/doneBtn onClick  已领取
--]]
function ActivityFirstChargePanel:doneBtn_ScaleButton_onClick(doneBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, "click"))
end

--[[
/bg/activityGoBtn onClick 前往活动
--]]
function ActivityFirstChargePanel:activityGoBtn_ScaleButton_onClick(activityGoBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, "click"))
    -- local activityPanel = UIMgr:GetUI("ActivityPanel")
    -- if activityPanel then
    --     activityPanel:onSelect(self._activityConfig.activityPara[2])
    -- end
    LuaLogger.ds("跳转数据", tablex.dump(self._activityConfig.activityPara))
    local canTurnTo = UICommonUtils.CanUseSkipJudge(self._activityConfig.activityPara[2], true)
    if canTurnTo then
        UICommonUtils.CommonTurnTo(self._activityConfig.activityPara[2], nil, function()
        end)
    end
end

--[[
/bg/btnGroup/goBtn onClick 跳转商店
--]]
function ActivityFirstChargePanel:goBtn_ScaleButton_onClick(goBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, "click"))
    LuaLogger.ds("跳转数据", tablex.dump(self._activityConfig.activityPara))
    local canTurnTo = UICommonUtils.CanUseSkipJudge(self._activityConfig.activityPara[1], true)
    if canTurnTo then
        -- if self._isFromActivity then
        --     -- 如果是从活动入口进来的，关闭活动面板
        --     UIMgr:hideUI("ActivityPanel")
        -- end
        UICommonUtils.CommonTurnTo(self._activityConfig.activityPara[1], nil, function()
            --跳转后隐藏活动界面
            UIMgr:hideUI("ActivityPanel")
        end)
    end
end

return ActivityFirstChargePanel
