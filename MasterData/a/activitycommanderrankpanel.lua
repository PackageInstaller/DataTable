---@class ActivityCommanderRankPanel : ActivityCommanderRankPanel_Generate
---##################### 【ActivityCommanderRankPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【ActivityCommanderRankPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local ActivityCommanderRankPanel = require "ActivityCommanderRankPanel_Generate"

function ActivityCommanderRankPanel:InitLogic(data)
    self.rewardEnum = {
        normalReward = 1,--普通奖励
        payReward = 2,--氪金奖励
    }

    self.cRankTaskCfglist = {}--指挥官等级任务配置列表

    self.rewardBoxObjList = {}--人物格子对象列表

    self.finishTaskIdList = {}--已完成任务id列表

    self.canClickSpine = true--是否可以点击spine
end

--function ActivityCommanderRankPanel:StartCreating(time)
--
--end

--function ActivityCommanderRankPanel:StartEnter(time)
--
--end

--function ActivityCommanderRankPanel:StartRemoving(time)
--
--end

--function ActivityCommanderRankPanel:StartExit(time)
--
--end

function ActivityCommanderRankPanel:OnOpen(data, initiative)
    self.activityCfg = data.cfg
    self:getactivityData()
    self:setRewardData()
end

--获取活动数据
function ActivityCommanderRankPanel:getactivityData()
    --获取是否购买氪金档位标签
    local minipassData = Me.miniPassMap[self.activityCfg.id]
    self.isBuyPayGoods = minipassData and minipassData.openExtraReward or false
end

--设置奖励数据
function ActivityCommanderRankPanel:setRewardData()
    --获取解锁高级奖励价格及内容
    self.payGoodsId = self.activityCfg.activityPara[1]
    local giftCfg = Config.GetGiftInfo(self.payGoodsId)
    self.priceText.text.text = giftCfg.Cost
    self.notPriceText.text.text = giftCfg.Cost
    self.tipsTxt.text.text = string.format("购买后直接获得 <size=36><color=#FFEB66>%s</color></size>", giftCfg.Items_get[1][3])
    self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, "ItemIcon_"..giftCfg.Items_get[1][2]), self.tipsGetIcon.image)

    self.timeTxt.text.text = "活动完成后次日<color=#FFEB66>5：00</color>关闭"

    --左侧按钮动画
    self.leftPart:SetActive(false)
    --spine人物加载
    local spineName = "Role_20000"
    local prefabPath = string.format(Config.PrefabPath.RoleSpine, spineName, spineName)
    self:LoadGameObjectAsync(prefabPath, function (obj)
        local spineObject = obj
        spineObject:SetParent(self.spineRoot.transform)
        spineObject.transform.localPosition = Vector3.zero
        spineObject.transform.localScale = Vector3.one
        --关闭spine物理效果
        local objSpine = spineObject:GetComponent("SkeletonGraphic")
        objSpine.PhysicsPositionInheritanceFactor = Vector2.zero
        --初始化动画状态
        local objSpineAnim = spineObject:GetComponent("SkeletonAnimation")
        local animationState = objSpineAnim.AnimationState
        animationState:SetAnimation(GE.RoleSpineActionType.Action, "idle_action", true)
        animationState:SetAnimation(GE.RoleSpineActionType.Emote, "idle", true)
        --初始化点击事件
        spineObject.transform:Find("ClickBtn").gameObject:SetActive(true)
        self:doClioAction(spineObject.transform:Find("ClickBtn"):GetComponent("Button"), animationState)
        --角色入场
        self.animator:SetTrigger("RoleIn")
        self.leftPart:SetActive(true)
    end)

    --显示任务奖励列表
    local taskCfgList = Config.GetTaskInfoByTaskTypeAndGroup(GE.MissionType.CommanderRank, 1)
    for _, taskCfg in pairs(taskCfgList) do
        if not self.cRankTaskCfglist[taskCfg.type] then
            self.cRankTaskCfglist[taskCfg.type] = {}
        end
        table.insert(self.cRankTaskCfglist[taskCfg.type], taskCfg)
    end
    for _, taskCfglist in pairs(self.cRankTaskCfglist) do
        table.sort(taskCfglist, function(a, b)
            return a.id < b.id
        end)
    end
    --LuaLogger.ds("ActivityCommanderRankPanel", "指挥官等级任务配置列表", tablex.dump(self.cRankTaskCfglist))

    self:creatRewardbox(false)
end

--初始化spine点击
function ActivityCommanderRankPanel:doClioAction(button, animationState)
    local clickTimes = 0
    local waitTime = 4.5
    button.onClick:RemoveAllListeners()
    button.onClick:AddListener(function()
        if not self.canClickSpine then
            return
        end
        if clickTimes <= 5 then
            animationState:SetAnimation(GE.RoleSpineActionType.Action, "shy_action", false)
            animationState:SetAnimation(GE.RoleSpineActionType.Emote, "shy", false)
            animationState:AddAnimation(GE.RoleSpineActionType.Action, "idle_action", true, waitTime)
            animationState:AddAnimation(GE.RoleSpineActionType.Emote, "idle", true, waitTime)
            clickTimes = clickTimes + 1
        else
            animationState:SetAnimation(GE.RoleSpineActionType.Action, "sp1_action", false)
            animationState:SetAnimation(GE.RoleSpineActionType.Emote, "sp1", false)
            animationState:AddAnimation(GE.RoleSpineActionType.Action, "idle_action", true, waitTime)
            animationState:AddAnimation(GE.RoleSpineActionType.Emote, "idle", true, waitTime)
            clickTimes = 0
            self.canClickSpine = false
            self.clickSpineTimer = DLuaTimer:DoAfter(waitTime + 1, function()
                self.canClickSpine = true
                self.clickSpineTimer = nil
            end)
        end
    end)
end

--生成奖励格子
function ActivityCommanderRankPanel:creatRewardbox(isRefresh)
    self.finishTaskIdList = {}
    local rewardNum = tablex.size(self.cRankTaskCfglist[self.rewardEnum.normalReward])
    self:FillTemplateContent(self.rewardBox, self.content, rewardNum, function (index,rewardBox)
        rewardBox.canvasGroup.alpha = 0

        --任务描述
        local normalTaskCfg = self.cRankTaskCfglist[self.rewardEnum.normalReward][index]
        local payTaskCfg = self.cRankTaskCfglist[self.rewardEnum.payReward][index]
        rewardBox.rankText.text.text = normalTaskCfg.complete[2]
        rewardBox.rankTitleText.text.text = "指挥官等级"

        local idList = {}
        --奖励格子
        local taskData = Me:getMissionListById(normalTaskCfg.id)
        if not taskData then
            LuaLogger.es("任务数据不存在，任务id:", normalTaskCfg.id)
            return
        end
        local canGet = taskData.state == GE.MissionState.Unclaimed
        self:FillTemplateContent(self.customBox, rewardBox.normalRoot, 1, function (index2,itemObj)
            local customBox = itemObj.customBox
            local rewardData = normalTaskCfg.Award[1]
            customBox:setMono(self)
            customBox:SetUIData(rewardData, {isGet = taskData.state == GE.MissionState.Received})
            if canGet then
                table.insert(idList, normalTaskCfg.id)
                table.insert(self.finishTaskIdList, normalTaskCfg.id)
            end
        end)
        rewardBox.normalLockIcon:SetActive(not canGet and taskData.state ~= GE.MissionState.Received)
        rewardBox.canGet:SetActive(canGet)

        local paytaskData = Me:getMissionListById(payTaskCfg.id)
        local payCanGet = paytaskData.state == GE.MissionState.Unclaimed
        self:FillTemplateContent(self.customBox, rewardBox.payRoot, 1, function (index2,itemObj)
            local customBox = itemObj.customBox
            local rewardData = payTaskCfg.Award[1]
            customBox:setMono(self)
            customBox:SetUIData(rewardData, {isGet = paytaskData.state == GE.MissionState.Received})
            if payCanGet and self.isBuyPayGoods then
                table.insert(idList, payTaskCfg.id)
                table.insert(self.finishTaskIdList, payTaskCfg.id)
            end
        end)
        rewardBox.payCanGet:SetActive(payCanGet and self.isBuyPayGoods)
        rewardBox.lockIcon:SetActive((not payCanGet or not self.isBuyPayGoods) and paytaskData.state ~= GE.MissionState.Received)
        --领取奖励按钮逻辑
        if self.isBuyPayGoods then
            rewardBox.lockMask:SetActive(false)
            rewardBox.getBtn.transform.localScale = Vector3.New(2,1,1)
        end
        --点击事件
        rewardBox.getBtn:SetActive(canGet or (payCanGet and self.isBuyPayGoods))
        rewardBox.getBtn.button.onClick:RemoveAllListeners()
        rewardBox.getBtn.button.onClick:AddListener(function()
            self:getCommanderRankReward(idList)
        end)

        --显示动画
        if isRefresh then
            rewardBox.canvasGroup.alpha = 1
        else
            DLuaTimer:DoAfter(0.05 * index, function()
                rewardBox.canvasGroup:DOFade(1, 0.2)
            end)
        end
    end)

    self.payLocked:SetActive(not self.isBuyPayGoods)
    self.goBtn:SetActive(not self.isBuyPayGoods)
    self.notGoBtn:SetActive(self.isBuyPayGoods)
end

--领取奖励按钮逻辑
function ActivityCommanderRankPanel:getCommanderRankReward(idList)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if tablex.next(idList) then
        Me:GetMissionRewardReq(idList, function()
            self:creatRewardbox(true)
        end)
    end
end

--function ActivityCommanderRankPanel:OnClose(initiative)
--
--end

function ActivityCommanderRankPanel:OnDestroy()
	--self.super:OnDestroy(self)
    if self.clickSpineTimer then
        DLuaTimer:RemoveTimer(self.clickSpineTimer)
        self.clickSpineTimer = nil
    end
    self.super:OnDestroy(self)
end

--function ActivityCommanderRankPanel:OnRefresh(data)
--
--end

--[[
/OnceGetBtn onClick 
--]]
function ActivityCommanderRankPanel:onceGetBtn_ScaleButton_onClick(onceGetBtn)
    self:getCommanderRankReward(self.finishTaskIdList)
end

--[[
/GoBtn onClick 
--]]
function ActivityCommanderRankPanel:goBtn_ScaleButton_onClick(goBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.isBuyPayGoods then
        return
    end
    UICommonUtils.Pay(self.payGoodsId, function()
        self:getactivityData()
        self:creatRewardbox(true)
        local ActivityPanel = UIMgr:getUIData("ActivityPanel")
        if ActivityPanel then
            ActivityPanel.ui:onSelect(self.activityCfg.id)
        end
    end)
end

--[[
/NotGoBtn onClick 
--]]
function ActivityCommanderRankPanel:notGoBtn_ScaleButton_onClick(notGoBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
end

return ActivityCommanderRankPanel
