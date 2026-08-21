---@class BattleRepeatPanel : BattleRepeatPanel_Generate
---##################### 【BattleRepeatPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【BattleRepeatPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local BattleRepeatPanel = require "BattleRepeatPanel_Generate"
local SetNumView = require("SetNumView")
function BattleRepeatPanel:InitLogic(data)
    self.msgEventHandler = {
        {GameMsgType.RefreshBattleRepeatPanel, self.InitPanel},
    }
    self.needBattleNum = 1
    self.selectFormationId = 1
    self.nowSelectFormationBox = nil
    self.canGoBattle = true

    ---@type SetNumView
    local lua_setNumView = SetNumView:new(self.setNumView.gameObject)
    lua_setNumView:InitGenerate()
    self.lua_setNumView = lua_setNumView
end

function BattleRepeatPanel:InitPanel()
    self:setRepeatData()
    -- self:setFormationData()

    self.lua_setNumView:SetData({
        maxNum = self:GetMaxCount(),
        onValueChange = function(curVal)
            self:setNeedStrengthByCount(curVal)
        end
    })
end

--function BattleRepeatPanel:StartCreating(time)
--
--end

--function BattleRepeatPanel:StartEnter(time)
--
--end

--function BattleRepeatPanel:StartRemoving(time)
--
--end

--function BattleRepeatPanel:StartExit(time)
--
--end

function BattleRepeatPanel:OnOpen(data, initiative)
    self.battleType = data and data.battleType or GE.LevelBattleType.Normal
    self.levelId = data and data.levelId or 0
    self:InitPanel()
end

function BattleRepeatPanel:setRepeatData()
    if self.battleType == GE.LevelBattleType.Simulated then
        local activityData = Me:getSimulatedActivityData()
        local hisMaxFloor = activityData.maxFloor
        local quickFloor = hisMaxFloor - Config.GetConfigInfo("PveExerciseStoreyPass")
        local sweepCost, sweepReward = {0,0}, {}
        local floorConfigMap = Config.GetAllConfig("PveExerciseStoreyTable")
        for _, floorConfig in pairs(floorConfigMap) do
            if floorConfig.storeyNum <= quickFloor then
                local floorData = activityData.simulatedLevelMap and activityData.simulatedLevelMap[floorConfig.id]
                if not floorData then
                    sweepCost[1] = floorConfig.passCost[1]
                    sweepCost[2] = (sweepCost[2] or 0) + floorConfig.passCost[2]
                    for _, award in pairs(floorConfig.passReward) do
                        table.insert(sweepReward, award)
                    end
                end
            end
        end
        self.levelConfig = {
            enterCost = {sweepCost[1], 0},
            victoryCost = sweepCost,
            nomalDropShow = sweepReward,
            quickFloor = quickFloor,
            cleanNum = -1,
        }
    else
        self.levelConfig = Config.GetPveLevelInfo(self.levelId)
    end

    self.setSimulatedInfo:SetActive(self.battleType == GE.LevelBattleType.Simulated)
    self.lua_setNumView.gameObject:SetActive(self.battleType == GE.LevelBattleType.Normal)

    self.allStrengthText.text.text = UICommonUtils.SetResourceFormatByType(GE.ResourceType.Strength)
end

function BattleRepeatPanel:setNeedStrengthByCount(val)
    self.needBattleNum = val
    local useStrengthNum = self.needBattleNum * (self.levelConfig.enterCost[2] + self.levelConfig.victoryCost[2])
    local residueStrengthNum = UICommonUtils.SetResourceFormatByType(GE.ResourceType.Strength) - useStrengthNum
    self.canGoBattle = residueStrengthNum >= 0

    self.allStrengthTextDesc.text.color = self.canGoBattle and Color.NewFromStr("1879E1") or Color.NewFromStr("ED1616")
    self.needStrengthText.text.color = self.canGoBattle and Color.NewFromStr("1879E1") or Color.NewFromStr("ED1616")
    self.allStrengthTextDesc.text.text = self.canGoBattle and "扫荡后" or "体力不足"
    self.needStrengthText.text.text = self.canGoBattle and residueStrengthNum or UICommonUtils.SetResourceFormatByType(GE.ResourceType.Strength)

    local rewardList = self.levelConfig.nomalDropShow
    self:FillTemplateContent(self.customBox, self.rewardList, #rewardList, function (index, itemObj)
        local rewardData = rewardList[index]
        local customBox = itemObj.customBox
        --[[local data = {
            id = rewardData[2],
            isFrist = rewardData.isFrist,
        }
        if rewardData[1] == GE.RewardType.ItemProp then
            data.itemType = GE.ItemTypeIndex.item
        elseif rewardData[1] == GE.RewardType.Equipment then
            data.itemType = GE.ItemTypeIndex.equip
        elseif rewardData[1] == GE.RewardType.Weapon then
            data.itemType = GE.ItemTypeIndex.weapon
        end
        if rewardData[3] ~= 0 then
            data.itemNum = "x"..rewardData[3] * self.needBattleNum
        end]]
        local data = tablex.clone(rewardData)
        data.num = rewardData[3] * self.needBattleNum
        customBox:setMono(self)
        customBox:SetUIData(data)
    end)

    if self.battleType == GE.LevelBattleType.Simulated then
        self.sweepFloorTxt.text.text = string.format("当前可扫荡到<color=#1879E1>第%s层</color>", self.levelConfig.quickFloor)
    end

    self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, "ItemIcon_"..GE.ResourceType.Strength), self.strengthIcon.image)
end

function BattleRepeatPanel:setFormationData()
    local formationList = ClientData:GetNowFormationList()
    local needList = {}
    for _,v in pairs(formationList) do
        if next(v.FormationList) then
            table.insert(needList, v)
        end
    end
    self:FillTemplateContent(self.preFormationBox, self.content, #needList, function (index,formationBox)
        formationBox.formationText.text.text = "预编组"..needList[index].id
        formationBox.selectText.text.text = "预编组"..needList[index].id
        formationBox.button.onClick:RemoveAllListeners()
        formationBox.button.onClick:AddListener(function ()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            self.selectFormationId = needList[index].id
            self:selectFormationBox(formationBox)
        end)

        if index == 1 then--默认选中第一编队
            self.selectFormationId = needList[index].id
            self:selectFormationBox(formationBox)
        end

        --角色头像格子
        local formationList = needList[index].FormationList
        self:FillTemplateContent(self.formationRole, formationBox.roleList, #formationList, function (index,roleBox)
            local roleUid = formationList[index]
            local roleHeadBox = roleBox.roleHeadBox
            roleHeadBox.roleHeadBox:setMono(self)
            roleHeadBox.roleHeadBox:refreshUI({roleId = roleUid})
        end)
    end)
end

function BattleRepeatPanel:selectFormationBox(formationBox)
    if self.nowSelectFormationBox then
        self.nowSelectFormationBox.isSelect:SetActive(false)
    end
    self.nowSelectFormationBox = formationBox
    self.nowSelectFormationBox.isSelect:SetActive(true)
end

--界面关闭
function BattleRepeatPanel:playCloseAnim()
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeSpecificUI(self)
    end)
end

--function BattleRepeatPanel:OnClose(initiative)
--
--end

--function BattleRepeatPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function BattleRepeatPanel:OnRefresh(data)
--
--end

---@return integer, integer
function BattleRepeatPanel:GetMaxCount()
    local count = math.modf(
        Me:getTicketData().num / (self.levelConfig.enterCost[2] + self.levelConfig.victoryCost[2])
    )
    if self.levelConfig ~= nil and self.levelConfig.cleanNum ~= -1 then
        local levelInfo = Me:getLevelDataByid(self.levelId)
        local curCount = (levelInfo and levelInfo.dailyBattleNum) or 0

        local addCount = Me:GetCycleCardPrivilegeAddCount(PrivilegeType["LevelMapCleanAddCount_" .. self.levelConfig.typemain])
        local lastCount = self.levelConfig.cleanNum + addCount - curCount
        count = math.min(lastCount, count)
    end
    
    return math.max(1, count), count
end

--[[
/RepeatInfo/StrengthInfo/StrengthiconBg/AddStrengthBtn onClick 
--]]
function BattleRepeatPanel:addStrengthBtn_ScaleButton_onClick(addStrengthBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    UIMgr:popUICover("BuyTicketPanel", {})
end

--[[
/Bg/RepeatInfo/CacelBtn onClick 
--]]
function BattleRepeatPanel:cacelBtn_ScaleButton_onClick(cacelBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Back)
    self:playCloseAnim()
end

--[[
/Bg/RepeatInfo/OkBtn onClick 
--]]
function BattleRepeatPanel:okBtn_ScaleButton_onClick(okBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if not self.canGoBattle then
        UIMgr:popUICover("BuyTicketPanel", {})
        return
    end

    local _, maxCount = self:GetMaxCount()
    if self.needBattleNum > maxCount then
        UICommonUtils.PopToast(LocalStrEnum.ActionFailReason_CleanNumNotEnough)
        return
    end

    if self.battleType == GE.LevelBattleType.Simulated then
        Me:simulatedSweepReq({formationId = self.selectFormationId}, function(respData)
            GameMsgMgr:sendEvent(GameMsgType.RefreshSimulatedLevel)
            self:playCloseAnim()
        end)
    else
        local data = {
            levelId = self.levelId,
            repeatNum = self.needBattleNum,
            formationId = self.selectFormationId,
        }
        --扫荡回包可能触发升级Toast，先寄存避免与结算界面冲突
        UIMgr:startDepositToast(GE.DepositToastType.BattleRepeat)
        Me:battleRepeatReq(data, function(respData)
            self:playCloseAnim()
            UIMgr:popUICover("RepeatRewardPanel", {levelId = data.levelId, repeatNum = data.repeatNum,
                rewardList = respData.rewardList,singleList = respData.singleRewardList,
                extraRewardList = respData.extraRewardList, extraSingleList = respData.extraSingleList,})
            GameMsgMgr:sendEvent(GameMsgType.FunctionOpenMapUpdate)
        end)
    end
    
end

--[[
/Mask onClick 
--]]
function BattleRepeatPanel:mask_Button_onClick(mask)
    self:playCloseAnim()
end

--[[
/BoxBg/Title/exitBtn onClick 右上角退出按钮
--]]
function BattleRepeatPanel:exitBtn_ScaleButton_onClick(exitBtn)
    self:playCloseAnim()
end

--[[
/BoxBg/RepeatInfo/SetNumView/numSlider onValueChanged 
--]]
function BattleRepeatPanel:numSlider_Slider_onValueChanged(numSlider,value)

end

--[[
/BoxBg/RepeatInfo/SetNumView/minusBtn onClick 
--]]
function BattleRepeatPanel:minusBtn_ScaleButton_onClick(minusBtn)

end

--[[
/BoxBg/RepeatInfo/SetNumView/plusBtn onClick 
--]]
function BattleRepeatPanel:plusBtn_ScaleButton_onClick(plusBtn)

end

--[[
/BoxBg/RepeatInfo/SetNumView/maxBtn onClick 
--]]
function BattleRepeatPanel:maxBtn_ScaleButton_onClick(maxBtn)

end

return BattleRepeatPanel
