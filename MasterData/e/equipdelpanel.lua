---@class EquipDelPanel : EquipDelPanel_Generate
---##################### 【EquipDelPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【EquipDelPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local EquipDelPanel = require "EquipDelPanel_Generate"

---@type FiltrateGroupData[]
local skinFiltrateCfg = {
    {
        tagName = LocalStrEnum.SkinFiltrate_1,
        selectType = FiltrateSelectType.MultiSelect,
        items = {
            {
                itemName = LocalStrEnum.buttonName1,
            },
        },
    },
    {
        tagName = LocalStrEnum.SkinFiltrate_2,
        selectType = FiltrateSelectType.MultiSelect,
        items = {
            {
                itemName = LocalStrEnum.buttonName2,
                val = 5,
            },
            {
                itemName = LocalStrEnum.buttonName3,
                val = 4,
            },
            {
                itemName = LocalStrEnum.buttonName4,
                val = 3,
            },
            {
                itemName = LocalStrEnum.buttonName5,
                val = 2,
            },
        },
    },
}

function EquipDelPanel:InitLogic(data)
    self.msgEventHandler = {
        {GameMsgType.RefreshTopResource, function()
            self.customBackPanel.customBackPanel:RefreshTopResource()
        end},
    }
    self.levelDelList = {}
    self.needDataList = {}
    self.delSelectBoxList = {}
    self.maxDelCount = 100 --最大分解数量
    self.systemId = 3
    self.NowModeList = {}
    self.openType = 0   --分解物品类型

    self.nowSortIndex = 1      --当前装备排序
    self.sortBtnlist = {}
    self.nowSortFace = 1

    self.customTips.customTips:setMono(self)
    
    ---@type FiltrateData
    self.filterData = {
        groups = skinFiltrateCfg,
        callback = BindSelf(self, self.OnFiltrateSelectCallBack)
    }

    self.delEquip.loopGridView:InitGridView(0, BindSelf(self, self.OnContentValueChange))
    UICommonUtils.CalculateColumnCount(self.delEquip.loopGridView)

end

--function EquipDelPanel:StartCreating(time)
--
--end

--function EquipDelPanel:StartEnter(time)
--
--end

--function EquipDelPanel:StartRemoving(time)
--
--end

--function EquipDelPanel:StartExit(time)
--
--end

function EquipDelPanel:OnOpen(data, initiative)
    self.openType = data and data.openType or GE.RewardType.Equipment
    -- self.delEquip.rectTransform.anchoredPosition = Vector2.New(1000, 98)
    -- self.delEquip.rectTransform:DOAnchorPosX(-702, 0.3):SetEase(DG.Tweening.Ease.Linear)
    -- self.delEquip.canvasGroup.alpha = 0
    -- self.delEquip.canvasGroup:DOFade(1, 0.4):SetEase(DG.Tweening.Ease.Linear)
    self:SetDelPanel(data, true)
end

function EquipDelPanel:SetDelPanel(data, isInit)
    self.levelDelList = {}
    
    self.delSelectBoxList = {}
    self.data = data
    -- if data.selList then
    --     self.delSelectBoxList = data.selList
    --     LuaLogger.e(tablex.dump(data.selList))
    -- end
    self.selectCountTxt.text.text = "<color=#1b8ae6>0</color>".."/"..self.maxDelCount
    
    self:SetView(false, isInit)
    if isInit then
        local index = self:moveToSel()
        if index then
            self.customTips.gameObject:SetActive(true)
            self.emptyPanel:SetActive(false)
            self:refreshMsgPanel(index)
        else
            self.emptyPanel:SetActive(true)
            self.customTips.gameObject:SetActive(false)
        end
    else
        local size = tablex.size(self.levelDelList)
        self.emptyPanel:SetActive(size == 0)
        self.customTips.gameObject:SetActive(false)
    end

    self:SetDelBoxState()
    self:__SetTopPart()
end

--设置上方导航栏
function EquipDelPanel:__SetTopPart()
    if self.openType == GE.RewardType.Weapon then
        self.customBackPanel.customBackPanel:Bind(GE.NavigationType.EquipDel_Weapon)
    elseif self.openType == GE.RewardType.Equipment then
        self.customBackPanel.customBackPanel:Bind(GE.NavigationType.EquipDel_Equip)
    end
end

--设置分解可得到的右侧格子显示
function EquipDelPanel:SetDelBoxState()
    -- 以 itemId 为 key 聚合所有选中物品的分解奖励，保留完整的 {type, id, count} 格式
    local rewardMap = {}
    for _, v in pairs(self.levelDelList) do
        local needConfig = nil
        if self.openType == GE.RewardType.Equipment then
            needConfig = Config.GetEquipmentInfo(v.data.cid)
        elseif self.openType == GE.RewardType.Weapon then
            needConfig = Config.GetWeaponInfo(v.data.cid)
        end
        if needConfig and needConfig.decompose then
            local reward = needConfig.decompose[v.data.star]
            if reward and #reward >= 3 then
                local itemId = reward[2]
                if rewardMap[itemId] then
                    rewardMap[itemId][3] = rewardMap[itemId][3] + reward[3]
                else
                    rewardMap[itemId] = {reward[1], reward[2], reward[3]}
                end
            end
            -- 装备按等级返还经验材料
            if self.openType == GE.RewardType.Equipment then
                local equipExpConfig = Config.GetEquipLevelByGroupAndLevel(GE.EquipLevelType.Normal, needConfig.levelGroup, v.data.level)
                if equipExpConfig and equipExpConfig.decompose then
                    for _, expReward in pairs(equipExpConfig.decompose) do
                        if expReward and #expReward >= 3 then
                            local itemId = expReward[2]
                            if rewardMap[itemId] then
                                rewardMap[itemId][3] = rewardMap[itemId][3] + expReward[3]
                            else
                                rewardMap[itemId] = {expReward[1], expReward[2], expReward[3]}
                            end
                        end
                    end
                end
            end
        end
    end

    --self.weaponTypeIcon:SetActive(self.openType == GE.RewardType.Weapon)
    self.selectCountTxt.text.text = "<color=#1b8ae6>"..tablex.size(self.levelDelList).."</color>".."/"..self.maxDelCount

    local temp = {}
    for _, reward in pairs(rewardMap) do
        table.insert(temp, reward)
    end

    if tablex.size(temp) < 11 then
        for i = 1, 11 - tablex.size(temp) do
            table.insert(temp, {})
        end
    end
    self:FillTemplateContent(self.customBox, self.canGetList, tablex.size(temp), function(index, itemObj)
        local customBox = itemObj.customBox
        local customData = {
            disableClick = true,
        }
        if tablex.empty(temp[index]) then
            customData.nullDelItem = true
        end
        customBox:setMono(self)
        customBox:SetUIData(temp[index], customData)
    end)
    self.delEquip.loopGridView:RefreshAllShownItem2()   ---TODO

    local s = tablex.size(self.levelDelList)
    self.delOkBtn.gameObject:SetActive(s ~= 0)
    self.delOkBtn_1.gameObject:SetActive(s == 0)
end

--清空待分解列表
function EquipDelPanel:emptyDelList()
    self.levelDelList = {}
    self:SetDelBoxState()
end

function EquipDelPanel:SetView(isUpdate, isInit)
    if self.openType == GE.RewardType.Equipment then
        if not isUpdate then
            self.needDataList = {}
            local equipList = Me:getAllEquipData()
            for key, value in pairs(equipList) do
                local configData = Config.GetEquipmentInfo(value.cid)
                local temp = {
                    isIn = false,
                    data = value,
                    index = key,
                    config = configData,
                }
                local canSelected = not Me:checkEquipLockState(value.id) and value.ownerId == 0 and configData.equipType ~= GE.EquipType.rankUp and configData.equipType ~= GE.EquipType.sp
                if canSelected then
                    table.insert(self.needDataList, temp)
                    if isInit and self.data and self.data.selList then
                        for _, v in pairs(self.data.selList) do
                            if v == value.id then
                                temp.isIn = true
                                self.levelDelList[value.id] = temp
                            end
                        end
                    end
                end
            end
        end
        self:EquipSortInfo()
        self:setEquipSortView()
    elseif self.openType == GE.RewardType.Weapon then
        if not isUpdate then
            self.needDataList = {}
            local weaponList = Me:getAllWeaponData()
            for key, value in pairs(weaponList) do
                local configData = Config.GetWeaponInfo(value.cid)
                local temp = {
                    isIn = false,
                    data = value,
                    index = key,
                    config = configData,
                }
                local canSelected = not Me:checkWeaponLockState(value.id) and value.ownerId == 0 and value.level == 0
                if canSelected then
                    table.insert(self.needDataList, temp)
                end
            end
        end
        self:WeaponSortInfo()
        self:setWeaponSortView()
    end

    self.delEquip.loopGridView:SetListItemCount(#self.needDataList, false)
    self.delEquip.loopGridView:RefreshAllShownItem2()
end

function EquipDelPanel:refreshMsgPanel(index)
    self.emptyPanel:SetActive(false)
    if self.openType == GE.RewardType.Equipment then
        local equipData = self.needDataList[index].data
        self.customTips.customTips:SetUIData(
            {
                id = equipData.id,
                type = GE.RewardType.Equipment,
                navType = GE.NavigationType.EquipDelPanel,
                lockCallBack = function ()
                    if self.levelDelList[equipData.id] ~= nil then
                        self.levelDelList[equipData.id] = nil
                        self.needDataList[index].isIn = false
                        self:SetDelBoxState()
                    end
                    self.customTips.gameObject:SetActive(false)
                    self:SetView()
                end
            }
        )
    elseif self.openType == GE.RewardType.Weapon then
        local weaponData = self.needDataList[index].data
        self.customTips.customTips:SetUIData(
            {
                id = weaponData.id,
                type = GE.RewardType.Weapon,
                navType = GE.NavigationType.EquipDelPanel,
                lockCallBack = function ()
                    if self.levelDelList[weaponData.id] ~= nil then
                        self.levelDelList[weaponData.id] = nil
                        self.needDataList[index].isIn = false
                        self:SetDelBoxState()
                    end
                    self.customTips.gameObject:SetActive(false)
                    self:SetView()
                end
            }
        )
    end
end

function EquipDelPanel:moveToSel()
    local data = nil
    for _, value in pairs(self.levelDelList) do
        data = value
        break
    end
    if data then
        for index, v in pairs(self.needDataList) do
            if v.data.id == data.data.id then
                local item = self.delEquip.loopGridView:GetShownItemByItemIndex(index)
                if item ~= nil then
                    self:OnContentValueChange(self.delEquip.loopGridView, index, 0, 0)
                end
                return index
            end
        end
    end
    return nil
end

--快速选择
function EquipDelPanel:SelectFilter(modeList)
    self.NowModeList = modeList
    for _, value in pairs(self.needDataList) do
        local IsFilter = self:FilterState(modeList, value)
        --if not value.isIn then
            if IsFilter and tablex.size(self.levelDelList) < self.maxDelCount then
                value.isIn = true
                self.levelDelList[value.data.id] = value
            else
                value.isIn = false
                self.levelDelList[value.data.id] = nil
            end
        --end
    end
    self:SetDelBoxState()
end

--查询筛选状态
function EquipDelPanel:FilterState(modelist, data)
    local Filter = false
    local temp = modelist
    if temp and next(temp) then
        for k,v in pairs(temp) do
            local FilterConfig = Config.FilterInfo(v)
            if FilterConfig.type == 1 then            --强化筛选
                for _, d in pairs(FilterConfig.content) do
                    if d == 1 then      --排除已强化
                        Filter = data.data.level == 1
                    else
                        Filter = false
                    end
                end
            elseif FilterConfig.type == 2 then      --品质模式
                for _,d in pairs(FilterConfig.content) do
                    if data.config.quality == d then
                        Filter = true
                    end
                end
            end
        end
    else
        Filter = false
    end
    return Filter
end

--根据传入类型发送对应分解协议
function EquipDelPanel:doDelRequestByType(temp)
    local function onResponse(callBack)
        self.levelDelList = {}
        DLuaUtil.ClearChildren(self.canGetList.transform)
        self:SetDelBoxState()
        self:SetDelPanel()
        self:emptyDelList()
        Me:ReceiveReward(callBack.rewardList)
    end

    if self.openType == GE.RewardType.Equipment then
        Me:decomposeEquipReq({idList = temp}, onResponse)
    elseif self.openType == GE.RewardType.Weapon then
        Me:decomposeWeaponReq({idList = temp}, onResponse)
    end
end

--------------------------------------------------------------
--装备排序初始化
function EquipDelPanel:EquipSortInfo()
    self.sortTxt.text.text = LocalStrEnum["equipFilterType"..GE.EquipSortType[GE.EquipSortTypeName[self.nowSortIndex]]]
    self.sortBtnlist = {}
    self:FillTemplateContent(self.sortTypeBtn, self.sortSelectList, tablex.size(GE.EquipSortTypeName), function(index, sortTypeBtn)
        local temp = {
            obj = sortTypeBtn,
            key = index,
        }
        table.insert(self.sortBtnlist, temp)
        sortTypeBtn.sortTypeTxtOff.text.text =  LocalStrEnum["equipFilterType"..GE.EquipSortType[GE.EquipSortTypeName[index]]]
        sortTypeBtn.sortTypeTxt.text.text =  LocalStrEnum["equipFilterType"..GE.EquipSortType[GE.EquipSortTypeName[index]]]
        sortTypeBtn.isEx:SetActive(GE.EquipSortType[GE.EquipSortTypeName[index]] == GE.EquipSortType.nature)
        sortTypeBtn.scaleButton.onClick:RemoveAllListeners()
        sortTypeBtn.scaleButton.onClick:AddListener(function()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            self.nowSortIndex = index
            self.sortTxt.text.text = LocalStrEnum["equipFilterType"..GE.EquipSortType[GE.EquipSortTypeName[self.nowSortIndex]]]
            self.sortSelectList:SetActive(false)
            self.sortMask:SetActive(false)
            self:SetView(true)
            self:refreshSortView()
        end)
    end)
end

--武器排序初始化
function EquipDelPanel:WeaponSortInfo()
    self.sortTxt.text.text = LocalStrEnum["weaponFilterType"..GE.WeaponSortType[GE.WeaponSortTypeName[self.nowSortIndex]]]
    self.sortBtnlist = {}
    self:FillTemplateContent(self.sortTypeBtn, self.sortSelectList, tablex.size(GE.WeaponSortTypeName), function(index, sortTypeBtn)
        local temp = {
            obj = sortTypeBtn,
            key = index,
        }
        table.insert(self.sortBtnlist, temp)
        sortTypeBtn.sortTypeTxtOff.text.text =  LocalStrEnum["weaponFilterType"..GE.WeaponSortType[GE.WeaponSortTypeName[index]]]
        sortTypeBtn.sortTypeTxt.text.text =  LocalStrEnum["weaponFilterType"..GE.WeaponSortType[GE.WeaponSortTypeName[index]]]
        sortTypeBtn.isEx:SetActive(GE.WeaponSortType[GE.WeaponSortTypeName[index]] == GE.WeaponSortType.nature)
        sortTypeBtn.scaleButton.onClick:RemoveAllListeners()
        sortTypeBtn.scaleButton.onClick:AddListener(function()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            self.nowSortIndex = index
            self.sortTxt.text.text = LocalStrEnum["weaponFilterType"..GE.WeaponSortType[GE.WeaponSortTypeName[self.nowSortIndex]]]
            self.sortSelectList:SetActive(false)
            self.sortMask:SetActive(false)
            self:SetView(true)
            self:refreshSortView()
        end)
    end)
end

--设置装备排序详情
function EquipDelPanel:setEquipSortView()
    local function compare(a, b, primary, secondary, ascending)
        if primary(a, b) then
            return ascending
        elseif primary(b, a) then
            return not ascending
        else
            if secondary(a, b) then
                return ascending
            elseif secondary(b, a) then
                return not ascending
            else
                local a_config = Config.GetEquipmentInfo(a.data.cid)
                local b_config = Config.GetEquipmentInfo(b.data.cid)
                if a_config ~= nil and b_config ~= nil then
                    return a_config.id < b_config.id
                end
            end
        end
    end

    local function getPrimarySecondary()
        if self.nowSortIndex == GE.EquipSortType.default or self.nowSortIndex == GE.EquipSortType.level then
            return function(a, b) return a.data.level > b.data.level end,
                   function(a, b) return Config.GetEquipmentInfo(a.data.cid).quality > Config.GetEquipmentInfo(b.data.cid).quality end
        elseif self.nowSortIndex == GE.EquipSortType.quality then
            return function(a, b) return Config.GetEquipmentInfo(a.data.cid).quality > Config.GetEquipmentInfo(b.data.cid).quality end,
                   function(a, b) return a.data.level > b.data.level end
        end
    end

    local primary, secondary = getPrimarySecondary()
    local ascending = self.nowSortFace == 1

    table.sort(self.needDataList, function(a, b)
        return compare(a, b, primary, secondary, ascending)
    end)
end

--设置武器排序详情
function EquipDelPanel:setWeaponSortView()
    local function compare(a, b, primary, secondary, ascending)
        if primary(a, b) then
            return ascending
        elseif primary(b, a) then
            return not ascending
        else
            if secondary(a, b) then
                return ascending
            elseif secondary(b, a) then
                return not ascending
            else
                local a_config = Config.GetWeaponInfo(a.data.cid)
                local b_config = Config.GetWeaponInfo(b.data.cid)
                if a_config ~= nil and b_config ~= nil then
                    return a_config.id < b_config.id
                end
            end
        end
    end

    local function getPrimarySecondary()
        if self.nowSortIndex == GE.WeaponSortType.default or self.nowSortIndex == GE.WeaponSortType.level then
            return function(a, b) return a.data.level > b.data.level end,
                   function(a, b) return a.data.rare > b.data.rare end
        elseif self.nowSortIndex == GE.WeaponSortType.quality then
            return function(a, b) return a.data.rare > b.data.rare end,
                    function(a, b) return a.data.level > b.data.level end
        elseif self.nowSortIndex == GE.WeaponSortType.loadValue then
            return function(a, b) return a.data.load > b.data.load end,
                    function(a, b) return a.data.level > b.data.level end
        elseif self.nowSortIndex == GE.WeaponSortType.point then
            return function(a, b) return a.data.point > b.data.point end,
                    function(a, b) return a.data.level > b.data.level end
        end
    end

    local primary, secondary = getPrimarySecondary()
    local ascending = self.nowSortFace == 1

    table.sort(self.needDataList, function(a, b)
        return compare(a, b, primary, secondary, ascending)
    end)
end

--刷新排序显示
function EquipDelPanel:refreshSortView()
    for k,v in pairs(self.sortBtnlist) do
        v.obj.isOpen:SetActive(self.nowSortIndex == v.key)
    end
end

--function EquipDelPanel:OnClose(initiative)
--
--end

--function EquipDelPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function EquipDelPanel:OnRefresh(data)
--
--end

--[[
/BackPanel/BackBtn onClick 
--]]
function EquipDelPanel:backBtn_ScaleButton_onClick(backBtn)
    UIMgr:closeUI(self)
end

--[[
/BackPanel/BackMainlBtn onClick 
--]]
function EquipDelPanel:backMainlBtn_ScaleButton_onClick(backMainlBtn)
    UIMgr:closeUI(self)
end

--[[
/BackPanel/HelpBtn onClick 
--]]
function EquipDelPanel:helpBtn_ScaleButton_onClick(helpBtn)

end

--[[
/ResBg/AddBtn onClick 
--]]
function EquipDelPanel:addBtn_ScaleButton_onClick(addBtn)

end

--[[
/DelPanel/DelEquip/Viewport/DelEquip/DelEquipBox/EquipBtn onClick 
--]]
function EquipDelPanel:equipBtn_ScaleButton_onClick(equipBtn)

end

--[[
/DelPanel/DelOkBtn onClick 
--]]
function EquipDelPanel:delOkBtn_ScaleButton_onClick(delOkBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if tablex.size(self.levelDelList) <= 0 then
        return
    end

    local temp = {}
    local isRankHigh = false
    for key, value in pairs(self.levelDelList) do
        if self.openType == GE.RewardType.Equipment then
            if value.config.quality >= 4 then
                isRankHigh = true
            end
        elseif self.openType == GE.RewardType.Weapon then
            if value.config.rare >= 4 then
                isRankHigh = true
            end
        end
        table.insert(temp, value.data.id)
    end

    if isRankHigh then
        UIMgr:popUI("MsgBox", {title = "提示", 
            content = "当前选择中存在高品质装备，是否分解?",
            type = MsgBoxType.OKCancel,
            okCallback = function()
                self:doDelRequestByType(temp)
        end,})
        return
    end

    self:doDelRequestByType(temp)
end

--[[
/DelPanel/FastSelectBtn onClick 
--]]
function EquipDelPanel:fastSelectBtn_ScaleButton_onClick(fastSelectBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)

   UIMgr:popUICover("SkinGoodsFiltrateBox", self.filterData)

    --UIMgr:popUICover("EquipDelFastPanel", self.NowModeList)
end

--[[
/SortBtn onClick 
--]]
function EquipDelPanel:sortBtn_ScaleButton_onClick(sortBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.sortSelectList:SetActive(not self.sortSelectList.activeSelf)
    self.sortMask:SetActive(self.sortSelectList.activeSelf)
    if self.sortSelectList.activeSelf then
        self:refreshSortView()
    end
end

--[[
/OrderBtn onClick 
--]]
function EquipDelPanel:orderBtn_ScaleButton_onClick(orderBtn)
    
end

--[[
/ItemBox onClick 
--]]
function EquipDelPanel:itemBox_ScaleButton_onClick(itemBox)

end
--[[
/SortMask onClick 
--]]
function EquipDelPanel:sortMask_Button_onClick(sortMask)
    self.sortSelectList:SetActive(false)
    self.sortMask:SetActive(false)
end

--[[
/SortPanel/SortBg/SortStateBtn onClick 
--]]
function EquipDelPanel:sortStateBtn_ScaleButton_onClick(sortStateBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.nowSortFace == 1 then
        self.nowSortFace = 2
    elseif self.nowSortFace == 2 then
        self.nowSortFace = 1
    end
    self.sortStateBtn.upImg:SetActive(self.nowSortFace == 2)
    self.sortStateBtn.downImg:SetActive(self.nowSortFace == 1)
    self:SetView(true)
    --self:Refresh()
    
    self.sortSelectList:SetActive(false)
    self.sortMask:SetActive(false)
end

--[[
/SortTypeBtn onClick 
--]]
function EquipDelPanel:sortTypeBtn_ScaleButton_onClick(sortTypeBtn)

end

--[[
/CustomSortBox/FiltrateBtn onClick 
--]]
function EquipDelPanel:filtrateBtn_ScaleButton_onClick(filtrateBtn)

end

--[[
/CustomSortBox/LikeFiltrateBtn onClick 
--]]
function EquipDelPanel:likeFiltrateBtn_ScaleButton_onClick(likeFiltrateBtn)

end

---更新滑动列表
---@param index integer 数据索引
---@param gridView SuperScrollView.LoopGridView
---@param index integer
---@param row integer
---@param col integer
function EquipDelPanel:OnContentValueChange(gridView, index, row, col)
    local loopItem = gridView:GetShownItemByItemIndex(index)
    if loopItem == nil then
        loopItem = gridView:NewListViewItem("DelEquipItem")
    end
    local obj = loopItem.gameObject
    index = index + 1
    EngineUtil.FillPeer(self.delEquipItem, obj)
    local data = self.needDataList[index]
    if data == nil then
        obj:SetActive(false)
        return 
    end

    ---@type CustomBox
    local customBox = obj.customBox
    if self.levelDelList[self.needDataList[index].data.id] ~= nil then
        self.needDataList[index].isIn = true
    end
    local rdata = {
        id = self.needDataList[index].data.cid,
        type = self.openType,
        num = 1,
    }
    local data = {
        scale = 1,
        isIn = self.needDataList[index].isIn,
        star = self.needDataList[index].data.star,
    }
    data.itemNum = "Lv."..self.needDataList[index].data.level
    data.isLock = self.needDataList[index].isLock
    data.isInIsOne = true
    data.listener = function()
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        if tablex.size(self.levelDelList) == self.maxDelCount then   
            if self.needDataList[index].isIn then
                self.needDataList[index].isIn = false
                self.levelDelList[self.needDataList[index].data.id] = nil
            else
                UICommonUtils.PopToast("可选择数量达到上限")
            end
        else
            if self.needDataList[index].isIn then
                self.needDataList[index].isIn = false
                self.levelDelList[self.needDataList[index].data.id] = nil
            else
                self.needDataList[index].isIn = true       
                self.levelDelList[self.needDataList[index].data.id] = self.needDataList[index]
            end
        end
        --TODO: 这里写左侧详情更新
        self.customTips.gameObject:SetActive(true)
        self:refreshMsgPanel(index)
        self:SetDelBoxState()

        local item = self.delEquip.loopGridView:GetShownItemByItemIndex(index)
        if item ~= nil then
            self:OnContentValueChange(self.delEquip.loopGridView, index, 0, 0)
        end
    end
    customBox:setMono(self)
    customBox:SetUIData(rdata, data)

    return loopItem
end

function EquipDelPanel:OnFiltrateSelectCallBack(filtrateOperation)
    if filtrateOperation == nil then
        return
    end
    local filter = false
    local qualitys = {}
    for i = 1, #self.filterData.groups do
        local g = filtrateOperation[i]
        if g == nil then
            goto continue
        end
        local group = self.filterData.groups[i]
        for j = 1, #group.items do
            local isSelect = tablex.indexof(g, j) > 0
            group.items[j].isSelect = isSelect

            if isSelect then
                if i == 1 then
                    filter = group.items[j].val == 1
                elseif i == 2 then
                    table.insert(qualitys, group.items[j].val) 
                end
            end
        end
        ::continue::
    end

    for _, value in pairs(self.needDataList) do
        if tablex.size(self.levelDelList) >= self.maxDelCount then
            value.isIn = false
            self.levelDelList[value.data.id] = nil
            goto continue
        end
        local isFilter = true
        if filter then  
            isFilter = value.data.level == 1
        end

        local isQuality = true
        isQuality = tablex.indexof(qualitys, value.config.quality) > 0

        local isSelect = isFilter and isQuality
        if isSelect then
            value.isIn = true
            self.levelDelList[value.data.id] = value
        else
            value.isIn = false
            self.levelDelList[value.data.id] = nil
        end
        ::continue::
    end

    self:SetDelBoxState()
end

--[[
/AdjustRoot/DelOkBtn_1 onClick 
--]]
function EquipDelPanel:delOkBtn_1_ScaleButton_onClick(delOkBtn_1)

end

return EquipDelPanel
