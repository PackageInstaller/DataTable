---@class HomeWeaponProPanel : HomeWeaponProPanel_Generate
---##################### 【HomeWeaponProPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【HomeWeaponProPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local HomeWeaponProPanel = require "HomeWeaponProPanel_Generate"
local DoAfter = require("client.Main.Assets.Content.Lua.UI.Wnd.BombGamePanel").DoAfter

---@class BlueprintBox
    ---@field index integer                     --图纸索引
    ---@field obj BlueprintBox                  --图纸预制体
    ---@field config ItemTable                  --道具配置表
    ---@field proData WeaponProductionTable     --图纸配置表

---@class TagData
    ---@field tagId integer         --词条ID
    ---@field group integer         --分组
    ---@field priority integer      --优先级

---@class EffectData
    ---@field effectTag TagEffectType      --效果类型
    ---@field effectValue number           --效果值1
    ---@field effectValue2 number          --效果值2

function HomeWeaponProPanel:InitLogic(data)
    self.nowSelectBlueprint = nil           --当前选中的图纸

    ---@type BlueprintBox[]
    self.BlueprintBoxObjList = {}           --图纸预制体列表
    self.nowCount = 1                       --当前生产数量 默认为1
    self.tagEffectList = {}                 --TAG效果列表
    self.viewProList = {}                   --拥有道具的图纸列表
    self.isResourceSufficient = true        --资源是否充足
    self.btnSoundPath = string.format(Config.AudioPath.SE, "click")
end

--function HomeWeaponProPanel:StartCreating(time)
--
--end

--function HomeWeaponProPanel:StartEnter(time)
--
--end

--function HomeWeaponProPanel:StartRemoving(time)
--
--end

--function HomeWeaponProPanel:StartExit(time)
--
--end

function HomeWeaponProPanel:OnOpen(data, initiative)
    --导航栏
    self.customBackPanel.customBackPanel:Bind(GE.NavigationType.HomeWeaponProPanel, self)
    self.customBackPanel.customBackPanel:OverrideBackFunc(function()
        self.animator:SetTrigger("Out")
        self.animOverCallBack:SetCallBack(function()
            UIMgr:closeUI(self)
            self.customBackPanel.customBackPanel:ClearBackFunc()
        end)
    end)
    self.maskImage:SetActive(false)
    -- SetView 使用 FillTemplateContent 异步创建图纸格子，
    -- 必须等所有格子就绪后再调用 setSelectBlueprint（内部 msgView 依赖 BlueprintBoxObjList）
    self:SetView(function()
        -- 在 viewProList 中查找外部传入的 itemId，找不到则默认选第一个
        local selectIndex = 1
        if data and data.itemId then
            for i, value in ipairs(self.viewProList) do
                if value.itemId == data.itemId then
                    selectIndex = i
                    break
                end
            end
        end
        if #self.viewProList > 0 then
            self:setSelectBlueprint(selectIndex, true)
        end
        self.nowCountTxt.text.text = self.nowCount
    end)
end

--设置显示
-- 注意：内部使用 FillTemplateContent 异步创建图纸格子，
-- 所有依赖 BlueprintBoxObjList 的逻辑（如 setSelectBlueprint/msgView）须通过 onComplete 回调延后执行。
---@param onComplete function? 所有图纸格子异步创建完毕后的回调
function HomeWeaponProPanel:SetView(onComplete)
    --遍历图纸表找到拥有道具的图纸
    ---@type WeaponProductionTable
    local ProList = Config.GetAllConfig("WeaponProductionTable")
    local guideProlist = {}
    self.viewProList = {}
    for _, ProData in pairs(ProList) do
        local itemData = Me:getItemById(ProData.itemId)
        if itemData then
            -- normal类型图纸数量为0时不显示
            if (ProData.useType ~= GE.BlueprintType.normal or itemData.num > 0) and ProData.useType ~= GE.BlueprintType.Guide then
                table.insert(self.viewProList, ProData)
            end
            if ProData.useType == GE.BlueprintType.Guide then
                table.insert(guideProlist, ProData)
            end
        end
    end
    --引导用
    local userData = Me:getUserData()
    if not userData.GotGuideBlueprintAward then
        self.viewProList = guideProlist
    end

    table.sort(self.viewProList, function(a, b)
        if a.useType ~= b.useType then
            return a.useType < b.useType
        end
        if a.blueprintRarety ~= b.blueprintRarity then
            return a.blueprintRarity > b.blueprintRarity
        end
        return a.id > b.id
    end)
    self.BlueprintBoxObjList = {}
    --填充左侧图纸列表
    local totalCount = tablex.size(self.viewProList)
    local createdCount = 0
    if totalCount == 0 then
        self:tagListInfo()
        if onComplete then onComplete() end
        return
    end
    
    self:FillTemplateContent(self.blueprintBox, self.content, totalCount, function(index, blueprintBox)
        --获取图纸信息
        local ProData = self.viewProList[index]                               --图纸信息
        local ItemConfig = Config.GetItemInfo(ProData.itemId)           --道具信息
        local ItemData = Me:getItemById(ProData.itemId)                 --道具数据
        if not ItemConfig or not ItemData then
            return 
        end

        local temp = {
            index = index,
            obj = blueprintBox,
            config = ItemConfig,
            proData = ProData,
        }
        table.insert(self.BlueprintBoxObjList, temp)
        blueprintBox:SetActive(true)

        --设置图纸信息
        blueprintBox.blueprintNameTxt.text.text = ProData.blueprintName
        blueprintBox.blueprintMsgTxt.text.text = ItemConfig.describe
        blueprintBox.select:SetActive(self.nowSelectBlueprint == index)

        --设置图纸图标信息
        local data = {
            id = ItemConfig.id,
            type = GE.RewardType.ItemProp,
            num = ItemData.num
        }
        local customData = {
            disableClick = true,
        }
        if ProData.useType == GE.BlueprintType.infnity or ProData.useType == GE.BlueprintType.Guide then
            customData.itemNum = "∞"
        end
        blueprintBox.customBox.customBox:setMono(self)
        blueprintBox.customBox.customBox:SetUIData(data, customData)
        blueprintBox.red:SetActive(RedPointMgr:GetRedDotState("NewItem".. ItemConfig.id) == false)
        --添加点击事件
        blueprintBox.scaleButton.onClick:RemoveAllListeners()
        blueprintBox.scaleButton.onClick:AddListener(function()
            self:clickBlueprintBtn(index)
            LuaLogger.ds("ItemConfig.id", ItemConfig.id)
        end)
        -- 所有格子创建完毕后触发新手引导，并通知外部回调
        createdCount = createdCount + 1
        if createdCount == totalCount then
            GuideMgr:StartGuideTrigger("HomeWeaponProPanel")
            if onComplete then
                onComplete()
            end
        end
    end)

    self:tagListInfo()
end

--蓝图格子点击方法
function HomeWeaponProPanel:clickBlueprintBtn(index)
    self:play2DSound(self.btnSoundPath)
    self:setSelectBlueprint(index)
    self:SetView()
end

--设置选中图纸
---@param index integer
function HomeWeaponProPanel:setSelectBlueprint(index, isRefresh)
    local ProData = self.viewProList[index]
    if ProData then
        RedPointMgr:SetRedDotState("NewItem".. ProData.itemId, true)
        RedPointMgr:Refresh("GraphPaperRedJudge")
    end
    if index == self.nowSelectBlueprint and not isRefresh then
        return
    end
    self.nowCount = 1
    self.nowCountTxt.text.text = self.nowCount
    self.nowSelectBlueprint = index
    for _, value in pairs(self.BlueprintBoxObjList) do
        value.obj.select:SetActive(value.index == index)
    end

    self:msgView()
end

function HomeWeaponProPanel:canAddCount(count)
    local boxData = self.BlueprintBoxObjList[self.nowSelectBlueprint]
    for i = 1, 4 do
        local configData = boxData.proData.commonCost[i]
        if configData and next(configData) then
            local ItemConfig = Config.GetItemInfo(configData[1])
            if not ItemConfig then return false end
            local ItemData = Me:getItemById(ItemConfig.id)
            local effectMsg = self:findEffectByItemId(ItemConfig.id)
            local effectPercent = effectMsg and effectMsg[3] or 0
            local needCount = (configData[2] - math.floor(configData[2] * effectPercent / 100)) * count
            local nowCount = ItemData and ItemData.num or 0
            if nowCount < needCount then
                return false
            end
        end
    end
    local ProData = self:getNowBlueprint()
    if not ProData then return false end
    local needResData = Me:getItemById(ProData.ExtraCost[1])
    local needCount = ProData.ExtraCost[2] * count
    local nowCount = needResData and needResData.num or 0
    if nowCount < needCount then
        return false
    end
    return true
end

--显示右侧图纸详细信息
function HomeWeaponProPanel:msgView()
    self.isResourceSufficient = true
    local boxData = self.BlueprintBoxObjList[self.nowSelectBlueprint]
    local data = {
        id = boxData.config.id,
        type = GE.RewardType.ItemProp,
        num = self.nowCount,
    }
    self.nowSelectBox.customBox:setMono(self)
    self.nowSelectBox.customBox:SetUIData(data, {disableClick = true,})

    for i = 1, 4 do
        local configData = boxData.proData.commonCost[i]
        local resBox = self["resBox_"..i]
        if configData and next(configData) then
            local ItemConfig = Config.GetItemInfo(configData[1])
            local ItemData = Me:getItemById(ItemConfig.id)
            local effectMsg = self:findEffectByItemId(ItemConfig.id)
            local effectPercent = effectMsg and effectMsg[3] or 0
            local newNeedCount = (configData[2] - math.floor(configData[2] * effectPercent / 100)) * self.nowCount
            local countTexFormat = "<color=#333333>%s/%s</color>"
            local nowCount = ItemData and ItemData.num or 0
            if ItemData and ItemData.num < newNeedCount then
                countTexFormat = "<color=#ff3838>%s</color><color=#333333>/%s</color>"
            end

            if ItemData == nil or ItemData.num < newNeedCount then
                self.isResourceSufficient = false
            end

            resBox.isNull:SetActive(false)
            resBox.msgBg:SetActive(effectMsg ~= nil)
            resBox.msgTxt.text.text = effectMsg and "消耗-"..effectPercent.."%" or ""
            resBox.countBg:SetActive(true)
            resBox.countTxt.text.text = string.format(countTexFormat, UICommonUtils.FormatNumber(nowCount)
            , UICommonUtils.FormatNumber(newNeedCount))

            resBox.resIconImg:SetActive(true)
            self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, ItemConfig.icon), resBox.resIconImg.image)
        else
            resBox.isNull:SetActive(true)
            resBox.countBg:SetActive(false)
        end
    end
    self:setNeedResCount()
end

--获取TAG信息
function HomeWeaponProPanel:tagListInfo()
    local tagList = Me:getHomeSignal(GE.CoustructionEnum.Armory)
    self.tagEffectList = {}

    for _, value in pairs(tagList) do
        local signalConfig = Config.SignalInfo(value.signalId)
        if signalConfig then
            local group = signalConfig.group
            local priority = signalConfig.priority
            local existingTag = self.tagEffectList[group]

            if not existingTag or priority > existingTag.priority then
                self.tagEffectList[group] = {
                    tagId = signalConfig.id,
                    group = group,
                    priority = priority,
                    effect = signalConfig.effect
                }
            end
        else
            LuaLogger.es("signalConfig配置未找到：", value.signalId)
        end
    end

    local finalTagList = {}
    for _, tagData in pairs(self.tagEffectList) do
        local effect = tagData.effect
        if not tablex.find(finalTagList, effect) then
            table.insert(finalTagList, effect)
        end
    end

    self.tagEffectList = finalTagList
end

--根据道具ID查找TAG效果
---@param itemId integer
---@return EffectData?
function HomeWeaponProPanel:findEffectByItemId(itemId)
    for _, tagData in pairs(self.tagEffectList) do
        if tagData[1] == GE.TagEffectType.expendReduction then
            if tagData[2] == itemId then
                return tagData
            end
        end
    end
    return nil
end

--获取当前选中图纸的数据
---@return WeaponProductionTable
function HomeWeaponProPanel:getNowBlueprint()
    local ProData = self.viewProList[self.nowSelectBlueprint]
    if ProData then
       return ProData
    end
end

--增加数量
---@param count integer
function HomeWeaponProPanel:AddCount(count)
    if self:canAddCount(self.nowCount + count) == false then
        UICommonUtils.PopToast("资源不足")
        return
    end
    self.nowCount = self.nowCount + count
    local ProData = self:getNowBlueprint()
    local itemData = Me:getItemById(ProData.itemId)
    local itemCount = itemData and itemData.num or 1
    local maxCount = tonumber(Config.GetConfigInfo("weaponProduction"))

    if ProData.useType == GE.BlueprintType.normal and self.nowCount > itemCount then
        self.nowCount = itemCount
    elseif self.nowCount > maxCount then
        self.nowCount = maxCount
    end

    if self.nowCount == itemCount or self.nowCount == maxCount then
        UICommonUtils.PopToast("已达到最大生产数量")
    end
    self:msgView()
    self.nowCountTxt.text.text = self.nowCount
end

--减少数量
---@param count integer
function HomeWeaponProPanel:reduceCount(count)
    self.nowCount = self.nowCount - count
    if self.nowCount < 1 then
        self.nowCount = 1
        UICommonUtils.PopToast("已达到最小生产数量")
    end
    self:msgView()
    self.nowCountTxt.text.text = self.nowCount
end

--设置需要的资源数量
function HomeWeaponProPanel:setNeedResCount()
    local ProData = self:getNowBlueprint()
    local needResConfig = Config.GetItemInfo(ProData.ExtraCost[1])
    if not needResConfig then return end

    self.resIcon:SetActive(true)
    self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, needResConfig.icon), self.resIcon.image)

    local needResData = Me:getItemById(needResConfig.id)
    local needCount = ProData.ExtraCost[2] * self.nowCount
    local countText = needResData and needResData.num >= needCount and "<color=#333333>"..needCount.."</color>" or "<color=#ff3838>"..needCount.."</color>"

    if needResData == nil or needResData.num < needCount then
        self.isResourceSufficient = false
    end

    self.needResCountTxt.text.text = countText
end

function HomeWeaponProPanel:RefreshUI()
    -- 记录当前选中图纸的ID，刷新后重新定位（须在 SetView 重置 viewProList 之前保存）
    local curProData = self.viewProList[self.nowSelectBlueprint]
    local curId = curProData and curProData.id
    -- SetView 使用 FillTemplateContent 异步创建图纸格子，
    -- 必须等所有格子就绪后再调用 setSelectBlueprint（内部 msgView 依赖 BlueprintBoxObjList）
    self:SetView(function()
        -- 在新列表中找回之前选中的图纸，若已被移除则选第一个
        local newIndex = 1
        if curId then
            for i, v in ipairs(self.viewProList) do
                if v.id == curId then
                    newIndex = i
                    break
                end
            end
        end
        self:setSelectBlueprint(newIndex, true)
        self.nowCountTxt.text.text = self.nowCount
        self.customBackPanel.customBackPanel:RefreshTopResource()
    end)
end

--function HomeWeaponProPanel:OnClose(initiative)
--
--end

--function HomeWeaponProPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function HomeWeaponProPanel:OnRefresh(data)
--
--end

--[[
/MsgPanel/CountCheackPanel/ReduceOneBtn onClick 
--]]
function HomeWeaponProPanel:reduceOneBtn_ScaleButton_onClick(reduceOneBtn)
    self:play2DSound(self.btnSoundPath)
    self:reduceCount(1)
end

--[[
/MsgPanel/CountCheackPanel/ReduceTenBtn onClick 
--]]
function HomeWeaponProPanel:reduceTenBtn_ScaleButton_onClick(reduceTenBtn)
    self:play2DSound(self.btnSoundPath)
    self:reduceCount(10)
end

--[[
/MsgPanel/CountCheackPanel/AddOneBtn onClick 
--]]
function HomeWeaponProPanel:addOneBtn_ScaleButton_onClick(addOneBtn)
    self:play2DSound(self.btnSoundPath)
    self:AddCount(1)
end

--[[
/MsgPanel/CountCheackPanel/AddTenBtn onClick 
--]]
function HomeWeaponProPanel:addTenBtn_ScaleButton_onClick(addTenBtn)
    self:play2DSound(self.btnSoundPath)
    self:AddCount(10)
end

--[[
/MsgPanel/MakeBtn onClick 
--]]
function HomeWeaponProPanel:makeBtn_ScaleButton_onClick(makeBtn)
    self:play2DSound(self.btnSoundPath)
    if not self.isResourceSufficient then
        UICommonUtils.PopToast("资源不足")
        return
    end
    self.efProduce:SetActive(true)
    self.maskImage:SetActive(true)
    DLuaTimer:DoAfter(2, function()
        self.efProduce:SetActive(false)
        Me:weaponProductionReq({blueprintId = self:getNowBlueprint().id, count = self.nowCount}, function()
            self:RefreshUI()
            self.maskImage:SetActive(false)
        end)
    end)
end

--[[
/ProMsgBtn onClick 
--]]
function HomeWeaponProPanel:proMsgBtn_ScaleButton_onClick(proMsgBtn)
    self:play2DSound(self.btnSoundPath)
    local ProData = self:getNowBlueprint()
    UIMgr:popUICover("HomeWeaponProMsgPanel", {Id = ProData.id})
end

return HomeWeaponProPanel
