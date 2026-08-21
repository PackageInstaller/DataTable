---@class DispatchBattlePanel : DispatchBattlePanel_Generate
---##################### 【DispatchBattlePanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【DispatchBattlePanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local DispatchBattlePanel = require "DispatchBattlePanel_Generate"

function DispatchBattlePanel:InitLogic(data)

end

--function DispatchBattlePanel:StartCreating(time)
--
--end

--function DispatchBattlePanel:StartEnter(time)
--
--end

--function DispatchBattlePanel:StartRemoving(time)
--
--end

--function DispatchBattlePanel:StartExit(time)
--
--end

function DispatchBattlePanel:OnOpen(data, initiative)
    ---@type DispatchPointData
    self.pointData = data.pointData
    self.pointCfg = data.pointCfg
    self.roleIdList = data.roleIdList
    self.roleItemList = {}
    self:initUI()
    self.aniTimer = DLuaTimer:DoAfter(1, function()
        self:doAni()
    end)
    self.timerList = {}
    
end

function DispatchBattlePanel:initUI()
    self.enemy.ef:SetActive(false)
    local monsterCfg = Config.GetMonsterInfo(self.pointCfg.monster)
    if not monsterCfg then
        LuaLogger.e("DispatchBattlePanel:initUI monsterCfg is nil")
        return
    end
    local farmePath = string.format(Config.SpritePath.RankFrameSmall, monsterCfg.rank)
    self:LoadSpriteAsync(farmePath, self.enemy.frameImg.image)
    
    local count = tablex.size(self.pointData.beginEnergy)
    local posList = self:calculateCenteredPos(count, 20, 186)
    self:FillTemplateContent(self.role, self.roleRoot, count, function (index, itemObj)
        itemObj.transform.localPosition = Vector3.New(posList[index], 0, 0)
        local roleId = self.roleIdList[index]
        if not roleId then
            LuaLogger.e("DispatchBattlePanel:initUI roleId is nil at index: " .. index)
            return
        end
        local roleHeadBox = itemObj.roleHeadBox
        roleHeadBox.roleHeadBox:setMono(self)
        roleHeadBox.roleHeadBox:refreshUI({roleId = roleId})
        local colorIndex, color = Me:getDispatchEnergyIndexAndColor(self.pointData.beginEnergy[index])
        for i = 1, 3 do
            if i == colorIndex then
                itemObj["hpIcon"..i].gameObject:SetActive(true)
            end
        end
        --LuaLogger.e("begin index".. index .. ","..self.pointData.beginEnergy[index])
        itemObj.hpText.text.text = string.format("<color=#%s>%s</color>/100", color, self.pointData.beginEnergy[index])
        itemObj.hpProgress.image.fillAmount = self.pointData.beginEnergy[index] / 100
        itemObj.hpProgress.image.color = Color.NewFromStr(color)
        table.insert(self.roleItemList, itemObj)
    end)
end

function DispatchBattlePanel:calculateCenteredPos(count, spacing, objectWidth)
    local positions = {}
    if count < 1 then
        return positions
    end
    -- 计算总宽度 (考虑物体宽度和间距)
    local totalWidth = count * objectWidth + (count - 1) * spacing
    -- 计算起始位置 (使整体居中)
    local startX = -totalWidth / 2 + objectWidth / 2
    -- 计算每个物体的中心位置
    for i = 1, count do
        positions[i] = startX + (i - 1) * (objectWidth + spacing)
    end
    return positions
end

function DispatchBattlePanel:doAni()
    -- Update logic if needed
    local timer
    for i, itemObj in ipairs(self.roleItemList) do
        timer = DLuaTimer:DoAfter(0.1 + (i - 1) * 0.5, function()
            itemObj.transform:DOLocalMoveY(50, 0.3):SetEase(DG.Tweening.Ease.OutBack):OnComplete(function()
                if self.enemy.ef.activeSelf == true then
                    self.enemy.ef:SetActive(false)
                end
                self.enemy.ef:SetActive(true)
                itemObj.transform:DOLocalMoveY(0, 0.1):SetEase(DG.Tweening.Ease.InBack)
            end)
        end)
        table.insert(self.timerList, timer)
    end
    local time = 0.1 + tablex.size(self.roleItemList) * 0.5
    timer = DLuaTimer:DoAfter(time, function()
        self.enemy.transform:DOLocalMoveY(209-50, 0.3):SetEase(DG.Tweening.Ease.OutBack):OnComplete(function()
            for i, itemObj in ipairs(self.roleItemList) do
                if itemObj.ef.activeSelf == true then
                    itemObj.ef:SetActive(false)
                end
                itemObj.ef:SetActive(true)
            end
            self.enemy.transform:DOLocalMoveY(209, 0.1):SetEase(DG.Tweening.Ease.InBack):OnComplete(function()
                self:refreshEnergy()
            end)
        end)
    end)
    table.insert(self.timerList, timer)
end

function DispatchBattlePanel:refreshEnergy()
    for i, itemObj in ipairs(self.roleItemList) do
        local index, color = Me:getDispatchEnergyIndexAndColor(self.pointData.endEnergy[i])
        for j = 1, 3 do
            if j == index then
                itemObj["hpIcon"..j].gameObject:SetActive(true)
            end
        end
        itemObj.hpText.text.text = string.format("<color=#%s>%s</color>/100", color, self.pointData.endEnergy[i])
        itemObj.hpProgress.image.fillAmount = self.pointData.endEnergy[i] / 100
        itemObj.hpProgress.image.color = Color.NewFromStr(color)
    end
end

function DispatchBattlePanel:OnClose(initiative)
    if self.aniTimer then
        DLuaTimer:RemoveTimer(self.aniTimer)
    end
    for _, timer in ipairs(self.timerList) do
        if timer then
            DLuaTimer:RemoveTimer(timer)
        end
    end
    
    for i, itemObj in ipairs(self.roleItemList) do
        if itemObj.ef.activeSelf == true then
            itemObj.ef:SetActive(false)
        end
    end
end

-- function DispatchBattlePanel:OnDestroy()
--     self.super:OnDestroy(self)
-- end

--function DispatchBattlePanel:OnRefresh(data)
--
--end

--[[
/Bg onClick 
--]]
function DispatchBattlePanel:bg_Button_onClick(bg)
    UIMgr:closeUI(self)
end

return DispatchBattlePanel
