---@class EquipPanel : EquipPanel_Generate
---##################### 【EquipPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【EquipPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local EquipPanel = require "EquipPanel_Generate"

function EquipPanel:InitLogic(data)
    self.msgEventHandler = {
        {GameMsgType.RefreshTopResource, function()
            self.customBackPanel.customBackPanel:RefreshTopResource()
        end},
        {GameMsgType.OnWeaponChange, self.Refresh},
    }
    self.nowSelectMode = 0          --当前选择模式
    self.nowSelectEquip = {}        --当前选中装备信息
    self.selectIndex = 1
    self.roleData = {}
    self.reqMode = 0
    self.equipDataList = {}
    self.mode = nil
    self.fort = 0.4
    self.remainingLoad = 0          --角色剩余负载

    self.nowEquipSortIndex = 1      --当前装备排序
    self.equipSortBtnlist = {}
    self.nowEquipSortFace = 1
    self.equipList.loopGridView:InitGridView(0, BindCallback_NoParams(self, self.changeEquipBoxData))
    UIMgr:depositUI(self)
end

--function EquipPanel:StartCreating(time)
--
--end

--function EquipPanel:StartEnter(time)
--
--end

--function EquipPanel:StartRemoving(time)
--
--end

--function EquipPanel:StartExit(time)
-- 
--end

function EquipPanel:OnOpen(data, initiative)
    LuaLogger.ds("self.OnOpen")
    if initiative then
        self.roleData = data.roleData
        LuaLogger.ds("self.roleData", tablex.dump(self.roleData))
        self:SetModeView(data.part)
        self:setModeBtnView(data.mode)
        self:setShowView()
        self:SetWeaponView()
        self:ShowWeaponTypeIcon()
    else
        self:Refresh()
    end

    GuideMgr:StartGuideTrigger("EquipPanel")
end

--刷新界面
--@param mode 1:武器 2:装备
--@param isRefresh 是否刷新
function EquipPanel:SetModeView(mode, isRefresh)
    if mode == self.nowSelectMode and not isRefresh then
        return
    end
    self.nowSelectEquip = {}
    self.nowSelectMode = mode
    local roleConfig = Config.GetCharacterInfo(self.roleData.id)
    self.equipDataList = Me:getEquipListByPart(self.nowSelectMode, roleConfig.useEquipType)
    self:EquipSortInfo()
    self:setEquipSortView()
    if not isRefresh then
        if self.roleData.carryEquip[mode] ~= 0 then
            for key, value in pairs(self.equipDataList) do
                if value.id == self.roleData.carryEquip[mode] then
                    self.selectIndex = key
                    break
                end
            end
        else
            self.selectIndex = 1
        end
    else
        -- 刷新时保持原选中索引，越界则修正到末尾
        local listSize = tablex.size(self.equipDataList)
        if listSize <= 0 then
            self.selectIndex = 1
        elseif self.selectIndex > listSize then
            self.selectIndex = listSize
        end
    end
    self.nowSelectEquip = self.equipDataList[self.selectIndex]
    self:SetEquipMsgView(self.equipDataList[self.selectIndex])
    self:CheackEquipState()
    self.isNull:SetActive(tablex.size(self.equipDataList) <= 0)
    self.equipList.loopGridView:SetListItemCount(tablex.size(self.equipDataList), false)
    self.addAttr:SetActive(self.nowSelectEquip ~= nil)
    self.nameBg:SetActive(self.nowSelectEquip ~= nil)
    self.isMsgNull:SetActive(self.nowSelectEquip == nil)
    self:setShowView()
end

--装备列表格子数据回调
function EquipPanel:changeEquipBoxData(gridView, index, row, col)
    local loopListViewItem = gridView:GetShownItemByItemIndex(index)
    if loopListViewItem == nil then
        loopListViewItem = gridView:NewListViewItem("CustomBox")
    end
    local customBoxObj = loopListViewItem.gameObject
    EngineUtil.FillPeer(self.customBox, customBoxObj)

    local needIndex = index + 1
    local customBox = customBoxObj.customBox
    customBox:setMono(self)
    local data = {
        id = self.equipDataList[needIndex].cid,
        star = self.equipDataList[needIndex].star,
        isSelect = self.selectIndex == needIndex and true or false,
        scale = 0.8,
        isLock = self.equipDataList[needIndex].isLock,
        itemType = GE.ItemTypeIndex.equip,
        ownerId = self.equipDataList[needIndex].ownerId,
        itemNum = "Lv."..self.equipDataList[needIndex].level,
        rid = self.equipDataList[needIndex].id,
        ownerPanelName = self.uiConfig.id,
        listener = function()
            self.selectIndex = needIndex
            self.nowSelectEquip = self.equipDataList[needIndex]
            self:CheackEquipState()
            if self.nowSelectEquip then
                self:SetEquipMsgView(self.nowSelectEquip)
            end
            self.equipList.loopGridView:RefreshAllShownItem2()
        end
    }
    customBox:refreshUI(data)

    return loopListViewItem
end

--设置右侧装备详情
--@param equipData 装备数据
function EquipPanel:SetEquipMsgView(equipData)
    local NowNature = {}
    if self.roleData.carryEquip[self.nowSelectMode] ~= 0 then
        local NowNatureData = Me:getEquipNatureDataById(self.roleData.carryEquip[self.nowSelectMode])
        for key, value in pairs(NowNatureData) do
            NowNature[value.type] = value
        end
    end

    self.skillPanel:SetActive(false)
    if equipData and next(equipData) then
        local equipConfig = Config.GetEquipmentInfo(equipData.cid)
        self.nameTxt.text.text = equipConfig.name
        self.levelTxt.text.text = equipData.level
        self.maxLevelTxt.text.text = "/"..equipConfig.levelMax[equipData.star]
        local isSp = equipConfig.equipType == GE.EquipType.sp
        self.spBtn:SetActive(isSp)
        self.isLock:SetActive(not isSp and equipData.isLock)
        self.lockBtn:SetActive(not isSp)

        self:FillTemplateContent(self.starBox, self.starList, #equipConfig.levelMax, function(index, starBox)
            starBox.isOn:SetActive(index <= equipData.star)
        end)

        --六维显示
        local NatureData = Me:getEquipNatureDataById(equipData.id)
        local temp = {}
        for key, value in pairs(NatureData) do
            temp[value.type] = value
        end

        -- DLuaUtil.ClearChildren(self.attributeList.transform)
        self:FillTemplateContent(self.attributeBox, self.attributeList, tablex.size(temp), function(index, attributeBox)
            local boxData = {
                boxType = GE.ItemTypeIndex.equip,
                attrData = temp[index],
                boxIndex = index,
                oldAttrList = NowNature,
            }
            attributeBox.attributeBox:setMono(self)
            attributeBox.attributeBox:setAttrBoxData(boxData)
        end)
        --技能信息显示
        self.skillPanel:SetActive(true)
        local nowEffectId = Me:getEquipEffectIdByid(equipData.id)
        local nowEffectStage = Me:getEquipEffectStageByid(equipData.id)
        local equipSkill = equipConfig.skill
        local skillConfig = {}
        local str = LocalStrEnum.ActionFailReason_EquipLevelUpTips
        local romanNumerals = {"I", "II", "III", "IV", "V"}
        if nowEffectId == nil and tablex.next(equipSkill) == nil then  --当前效果为空且配置skill也为空，视为没有特殊效果
            self.nullEffect:SetActive(true)
            self.hasEffect:SetActive(false)
            self.effectLevel.text.text = ""
            self.effectLevelMsg.text.text = ""
            self.skillTxt:SetActive(false)
        elseif nowEffectId == nil and tablex.next(equipSkill) ~= nil then --当前效果为空但配置skill不为空，视为有特殊效果但未解锁
            self.nullEffect:SetActive(false)
            self.hasEffect:SetActive(true)
            self.effectLevel.text.text = ""
            self.effectLevelMsg.text.text = string.format(str, equipConfig.unLockSkillLv[1])
            self.skillTxt:SetActive(true)
            local nextEffectId = equipSkill[1] or 0
            skillConfig = Config.GetSkillInfo(nextEffectId)
            --修改描述透明度意为未生效
            local c1 = self.skillTxt.text.color
            self.skillTxt.text.color = Color.New(c1.r, c1.g, c1.b, 0.65)
        else
            self.nullEffect:SetActive(false)
            self.hasEffect:SetActive(true)
            self.effectLevel.text.text = romanNumerals[nowEffectStage].." "..LocalStrEnum.AffectionLevel
            self.effectLevelMsg.text.text = ""
            self.skillTxt:SetActive(true)
            skillConfig = Config.GetSkillInfo(nowEffectId)
            local c2 = self.skillTxt.text.color
            self.skillTxt.text.color = Color.New(c2.r, c2.g, c2.b, 1)
        end
        if skillConfig and skillConfig.desKey then
            self.skillTxt.text.text = skillConfig.desKey
        else
            self.skillTxt.text.text = ""
        end
    end
end

--设置武器显示
function EquipPanel:SetWeaponView()
    local weaponList = self.roleData.carryWeapon
    local loadValue = 0
    local weaponRatio = 0
    local roleConfig = Config.GetCharacterInfo(self.roleData.id)
    if weaponList then
        for i = 1, 2 do
            if weaponList[i] ~= nil and weaponList[i] ~= 0 then
                self["weaponBtn_"..i].showBtn:SetActive(true)
                self["weaponBtn_"..i].isNull:SetActive(false)
                self["nullBtn_"..i]:SetActive(false)
                local weaponData = Me:getWeaponDataById(weaponList[i])
                local weaponConfig = Config.GetWeaponInfo(weaponData.cid)
                weaponRatio = weaponRatio + ((weaponData.accuracy * weaponData.quality * weaponConfig.bulletNum) / 1000000)
                self["weaponPanel_"..i].msgPanel:SetActive(true)
                self["weaponPanel_"..i].weaponNameText.text.text = weaponConfig.name
                self["weaponPanel_"..i].weaponLevel.text.text = "+"..weaponData.level
                self["weaponPanel_"..i].scoreText.text.text = math.floor((weaponConfig.bulletNum * weaponData.accuracy * weaponData.quality / 1000))
                self["weaponPanel_"..i].amountNum.text.text = weaponConfig.weaponTypeDec
                self["weaponPanel_"..i].accuracyNum.text.text = weaponData.accuracy
                self["weaponPanel_"..i].qualityNum.text.text = weaponData.quality
                self:FillTemplateContent(self["weaponPanel_"..i].weaponLoadBox, self["weaponPanel_"..i].weaponLoadList, weaponConfig.load, function(index, weaponLoadBox)
                    weaponLoadBox:SetActive(true)
                end)
                self:LoadSpriteAsync(string.format(Config.SpritePath.WeaponTypePath, weaponConfig.type), self["weaponPanel_"..i].weaponTypeIcon.image)
                self:LoadSpriteAsync(string.format(Config.SpritePath.EquipShowRankBg, weaponConfig.rare), self["weaponBtn_"..i].rareBg.image)
                self:LoadSpriteAsync(string.format(Config.SpritePath.WeaponIconPath, weaponConfig.icon), self["weaponBtn_"..i].equipIcon.image)
                self["weaponPanel_"..i].isLock:SetActive(weaponData.isLock)
                self["weaponPanel_"..i].lockBtn.scaleButton.onClick:RemoveAllListeners()
                self["weaponPanel_"..i].lockBtn.scaleButton.onClick:AddListener(function()
                    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
                    local data = {weaponId = weaponList[i]}
                    Me:changeWeaponLockStateReq(data, function()
                        self:Refresh()
                    end)
                end)
                local needAttrList = {}
                for attrType, attrData in pairs(weaponData.attributeValue) do
                    local entryList = Config.GetWeaponEntryInfoByGroup(attrType)
                    local data = {
                        name = entryList[1].name,
                        valueType = entryList[1].type,
                        value = attrData.value,
                        type = entryList[1].attributeId,
                        isSpecial = attrData.isSpecial,
                    }
                    needAttrList[attrData.id] = data
                end
                self["weaponPanel_"..i].skillPanel:SetActive(false)
                self:FillTemplateContent(self.attributeBox, self["weaponPanel_"..i].attributeList, #weaponConfig.entryUnlock, function(index, attributeBox)
                    local boxData = {
                        boxType = GE.ItemTypeIndex.weapon,
                        attrData = needAttrList[index],
                        weaponConfig = weaponConfig,
                        weaponData = weaponData,
                        boxIndex = index,
                    }
                    attributeBox.attributeBox:setMono(self)
                    attributeBox.attributeBox:setAttrBoxData(boxData)

                    if needAttrList[index] then
                        if needAttrList[index].valueType == GE.WeaponEntryAttrType.specialSkill then--特殊技能
                            self["weaponPanel_"..i].skillPanel:SetActive(true)
                            local skillConfig = Config.GetSkillInfo(needAttrList[index].value)
                            self["weaponPanel_"..i].weaponSkillTxt.text.text = skillConfig.desKey
                        end
                    end
                end)
                loadValue = loadValue + weaponConfig.load
            else
                self["nullBtn_"..i]:SetActive(true)
                self["weaponPanel_"..i].msgPanel:SetActive(false)
                self["weaponBtn_"..i].showBtn:SetActive(false)
                self["weaponBtn_"..i].isNull:SetActive(true)
            end
        end
    else
        self.WeaponBtn_1.showBtn:SetActive(false)
        self.WeaponBtn_2.showBtn:SetActive(false)
    end
    weaponRatio = weaponRatio + roleConfig.baseDamageRate
    self.nowLoadTxt.text.text = loadValue
    self.maxLoadTxt.text.text = self.roleData.load
    self.scoreTxt.text.text = math.floor(weaponRatio * 100) .."%"
    self.scoreShadowTxt.text.text = math.floor(weaponRatio * 100) .."%"
    self.remainingLoad = self.roleData.load - loadValue

    local weaponUnLock = Me:getWeaponLockStateById(self.roleData.id)
    local isLocked = not weaponUnLock
    self.weaponPanel_2.isBtnLock:SetActive(isLocked)
    self.weaponPanel_2.isNull:SetActive(not isLocked)
    self.weaponBtn_2.isNull:SetActive(not isLocked)
    self.weaponBtn_2.isLock:SetActive(isLocked)
    self.weaponPanel_2.stateTxt.text.text = isLocked and "未解锁" or "添加舰装"
    local nullBtn2Color = self.nullBtn_2.image.color
    self.nullBtn_2.image.color = Color.New(nullBtn2Color.r, nullBtn2Color.g, nullBtn2Color.b, isLocked and 130/255 or 1)

    -- 这里调整负载值效果显示
    for i = 1, 12 do
        self["loadBox_"..i]:SetActive(i <= roleConfig.loadMax)     --一共显示多少个
        self["loadBox_"..i].nullBg:SetActive(i <= self.roleData.load) --已经解锁了的
        self["loadBox_"..i].isOn:SetActive(i <= loadValue) --已经解锁了的
    end
end

--显示可携带武器类型图标
function EquipPanel:ShowWeaponTypeIcon()
    local roleConfig = Config.GetCharacterInfo(self.roleData.id)
    local weaponType = roleConfig.useWeaponType
    self:FillTemplateContent(self.typeIcon, self.typeList, #weaponType, function(index, typeBox)
        self:LoadSpriteAsync(string.format(Config.SpritePath.WeaponTypePath, weaponType[index]), typeBox.image)
    end)
end

--确认穿戴状态
function EquipPanel:CheackEquipState()
    if not self.nowSelectEquip then
        self.levelUpBtn:SetActive(false)
        self.disboardBtn:SetActive(false)
        return
    end

    self.levelUpBtn:SetActive(true)
    self.disboardBtn:SetActive(true)
    self.disBoardGray:SetActive(false)
    if self.roleData.carryEquip and next(self.roleData.carryEquip) then
        if self.nowSelectEquip.ownerId ~= 0 and self.nowSelectEquip.ownerId ~= self.roleData.id then
            self.disboardTxt.text.text = "替 换"
            self.reqMode = 3
        else
            if self.roleData.carryEquip[self.nowSelectMode] == self.nowSelectEquip.id then
                self.disBoardGray:SetActive(true)
                self.disboardTxt.text.text = "卸 下"
                self.reqMode = 1
            elseif self.roleData.carryEquip[self.nowSelectMode] == nil or self.roleData.carryEquip[self.nowSelectMode] == 0 then
                self.disboardTxt.text.text = "穿 戴"
                self.reqMode = 2
            else
                self.disboardTxt.text.text = "替 换"
                self.reqMode = 3
            end
        end
    else
        if self.nowSelectEquip.ownerId ~= 0 then
            self.disboardTxt.text.text = "替 换"
            self.reqMode = 3
        else
            self.disboardTxt.text.text = "穿 戴"
            self.reqMode = 2
        end
    end
end

--切换当前模式
function EquipPanel:setModeBtnView(mode)
    if mode == self.mode then
        return
    end
    self.mode = mode
    self.weaponBtn.isSelect:SetActive(self.mode == 1)
    self.equipBtn.isSelect:SetActive(self.mode == 2)
    self.weaponImg:SetActive(self.mode == 1)

    if self.mode == 1 then
        --导航栏
        self.customBackPanel.customBackPanel:Bind(GE.NavigationType.EquipPanel_Weapon, self)
        self.customBackPanel.customBackPanel:OverrideBackFunc(function()
            self.weaponMode.animation:Play("WeaponOut")
            self.weaponMode.animOverCallBack:SetCallBack(function()
                UIMgr:closeSpecificUI(self)
                self.customBackPanel.customBackPanel:ClearBackFunc()
            end)
        end)
        self.equipMode:SetActive(false)
        self.weaponMode:SetActive(true)
        local functionState = Me:getFunctionOpenStateById(GE.FunctionOpenModule.WeaponFuse)
        self.weaponFuseBtn.isLock:SetActive(functionState == GE.FunctionOpenState.Lock)
        self.weaponFuseBtn.isNew:SetActive(functionState == GE.FunctionOpenState.Open)
    elseif self.mode == 2 then
        --导航栏
        self.customBackPanel.customBackPanel:Bind(GE.NavigationType.EquipPanel_Equip, self)
        self.customBackPanel.customBackPanel:OverrideBackFunc(function()
            self.equipMode.animation:Play("EquipOut")
            self.equipMode.animOverCallBack:SetCallBack(function()
                UIMgr:closeSpecificUI(self)
                self.customBackPanel.customBackPanel:ClearBackFunc()
            end)
        end)
        self.equipMode:SetActive(true)
        self.weaponMode:SetActive(false)
        self:EquipSortInfo()
    end
end

--设置展示装备显示
function EquipPanel:setShowView()
    for i = 1, 4 do
        local customBoxObj = self["showBox_"..i].customBox
        local customBox = customBoxObj.customBox
        local data = {}
        self["showBox_"..i].isSelect:SetActive(self.nowSelectMode == i)
        self["showBox_"..i].typeTxt.text.text = LocalStrEnum["EquipmentType"..i]
        if self.roleData.carryEquip and self.roleData.carryEquip[i] ~= 0 then
            customBoxObj:SetActive(true)
            local equipData = Me:getEquipDataByid(self.roleData.carryEquip[i])
            data.id = equipData.cid
            data.star = equipData.star
            data.itemNum = "Lv."..equipData.level
            data.itemType = GE.ItemTypeIndex.equip
            data.rid = equipData.id
            data.disableClick = true
            data.ownerPanelName = self.uiConfig.id,
            customBox:setMono(self)
            customBox:refreshUI(data)
        else
            customBoxObj:SetActive(false)
        end
        self["showBox_"..i].showBtn.scaleButton.onClick:RemoveAllListeners()
        self["showBox_"..i].showBtn.scaleButton.onClick:AddListener(function()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            self:SetShowBtnOnClick(i)
        end)
    end
    --新增背景舰种更换
    local roleConfig = Config.GetCharacterInfo(self.roleData.id)
    local path = string.format(Config.SpritePath.EquipBasePic, roleConfig.attribute)
    self.iconImg:SetActive(true)
    self:LoadSpriteAsync(path, self.iconImg.image)
    self:showAnimView()
end

--根据当前选中设置动画
function EquipPanel:showAnimView()
    -- local seq = DOTween.Sequence()
    -- seq:Append(
    --     self["showBox_"..self.nowSelectMode].rectTransform:DOScale(Vector3.New(1, 1, 1), 0.3):SetEase(DG.Tweening.Ease.Linear)
    -- )
    -- seq:AppendCallback(function()
    --     self["showBox_"..self.nowSelectMode].animation:Play("showLoop")
    -- end)
    -- seq:SetAutoKill(true)
    -- seq:Play()
    -- for i = 1, 4 do
    --     if i ~= self.nowSelectMode then
    --         self["showBox_"..i].animation:Stop()
    --         local seq = DOTween.Sequence()
    --         seq:Append(self["showBox_"..i].rectTransform:DOScale(Vector3.New(0.8, 0.8, 1), 0.3):SetEase(DG.Tweening.Ease.Linear))
    --         seq:SetAutoKill(true)
    --         seq:Play()
    --     end
    -- end
end

--展示按钮点击
function EquipPanel:SetShowBtnOnClick(index)
    if self.nowSelectMode == index then
        return
    end
    self:SetModeView(index)
    self.equipList.loopGridView:RefreshAllShownItem2()
    self:showAnimView()
end

--转圈动画
function EquipPanel:RingAnimView()
    self["showBox_"..self.nowSelectMode].ringImg.rectTransform:Rotate(Vector3(0, 0, 0.4))
end

-----------------------------------------------------------------------------
--装备排序初始化
function EquipPanel:EquipSortInfo()
    self.equipMode.sortTxt.text.text = LocalStrEnum["equipFilterType"..GE.EquipSortType[GE.EquipSortTypeName[self.nowEquipSortIndex]]]
    self.equipSortBtnlist = {}
    self:FillTemplateContent(self.sortTypeBtn, self.sortSelectList, tablex.size(GE.EquipSortTypeName), function(index, sortTypeBtn)
        local temp = {
            obj = sortTypeBtn,
            key = index,
        }
        table.insert(self.equipSortBtnlist, temp)
        sortTypeBtn.sortTypeTxtOff.text.text =  LocalStrEnum["equipFilterType"..GE.EquipSortType[GE.EquipSortTypeName[index]]]
        sortTypeBtn.sortTypeTxt.text.text =  LocalStrEnum["equipFilterType"..GE.EquipSortType[GE.EquipSortTypeName[index]]]
        sortTypeBtn.isEx:SetActive(GE.EquipSortType[GE.EquipSortTypeName[index]] == GE.EquipSortType.nature)
        sortTypeBtn.scaleButton.onClick:RemoveAllListeners()
        sortTypeBtn.scaleButton.onClick:AddListener(function()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            self.nowEquipSortIndex = index
            self.equipMode.sortTxt.text.text = LocalStrEnum["equipFilterType"..GE.EquipSortType[GE.EquipSortTypeName[self.nowEquipSortIndex]]]
            self.sortSelectList:SetActive(false)
            self.sortMask:SetActive(false)
            self:SetModeView(self.nowSelectMode, true)
            self.equipList.loopGridView:RefreshAllShownItem2()
            --self:Refresh()
            self:refreshSortView()
        end)
    end)
end

--刷新排序显示
function EquipPanel:refreshSortView()
    if self.mode == 2 then
        for k,v in pairs(self.equipSortBtnlist) do
            v.obj.isOpen:SetActive(self.nowEquipSortIndex == v.key)
        end
    end
end

--设置装备排序详情
function EquipPanel:setEquipSortView()
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
                local a_config = Config.GetEquipmentInfo(a.cid)
                local b_config = Config.GetEquipmentInfo(b.cid)
                if a_config ~= nil and b_config ~= nil then
                    return a_config.id < b_config.id
                end
            end
        end
    end

    local function getPrimarySecondary()
        if self.nowEquipSortIndex == GE.EquipSortType.default or self.nowEquipSortIndex == GE.EquipSortType.level then
            return function(a, b) return a.level > b.level end,
                   function(a, b) return Config.GetEquipmentInfo(a.cid).quality > Config.GetEquipmentInfo(b.cid).quality end
        elseif self.nowEquipSortIndex == GE.EquipSortType.quality then
            return function(a, b) return Config.GetEquipmentInfo(a.cid).quality > Config.GetEquipmentInfo(b.cid).quality end,
                   function(a, b) return a.level > b.level end
        end
    end

    local primary, secondary = getPrimarySecondary()
    local ascending = self.nowEquipSortFace == 1

    table.sort(self.equipDataList, function(a, b)
        return compare(a, b, primary, secondary, ascending)
    end)
end

function EquipPanel:Update()
    --self:RingAnimView()
end

--function EquipPanel:OnClose(initiative)
--
--end

--function EquipPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function EquipPanel:OnRefresh(data)
--
--end

--[[
/MsgPanel/LevelUpBtn onClick 
--]]
function EquipPanel:levelUpBtn_ScaleButton_onClick(levelUpBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    UIMgr:popUI("EquipIntensifyPanel", {data = self.nowSelectEquip.id, mode = 1})
end

function EquipPanel:Refresh()
    LuaLogger.ds("self.roleData", tablex.dump(self.roleData))
    self.roleData = Me:getPlayerHero(self.roleData.id)
    local roleConfig = Config.GetCharacterInfo(self.roleData.id)
    self.equipDataList = Me:getEquipListByPart(self.nowSelectMode, roleConfig.useEquipType)
    self:CheackEquipState()
    self:SetModeView(self.nowSelectMode, true)
    self.equipList.loopGridView:RefreshAllShownItem2()
    self:SetEquipMsgView(self.nowSelectEquip)
    self:SetWeaponView()
end

--[[
/MsgPanel/DisboardBtn onClick 
--]]
function EquipPanel:disboardBtn_ScaleButton_onClick(disboardBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local data = {
        charId = self.roleData.id,
        partId = self.nowSelectMode,
        equipId = self.nowSelectEquip.id
    }

    if self.reqMode == 2 then
        Me:setCharEquipReq(data, function()
            UICommonUtils.PopToast("穿戴成功")
            self:Refresh()
        end)
    elseif self.reqMode == 1 then
        local data = {
            equipId = self.nowSelectEquip.id
        }
        Me:removeCharEquipReq(data, function()
            UICommonUtils.PopToast("卸下成功")
            self:Refresh()
        end)
    elseif self.reqMode == 3 then
        local function setCharEquip(data)
            Me:setCharEquipReq(data, function()
                UICommonUtils.PopToast("更换成功")
                self:Refresh()
            end)
        end
        if self.nowSelectEquip.ownerId ~= 0 then
            local roleConfig = Config.GetCharacterInfo(self.nowSelectEquip.ownerId)
            UIMgr:popUI("MsgBox", {title = "提示", 
                content = "该舰装已被"..roleConfig.name.."装备，是否替换",
                type = MsgBoxType.OKCancel,
                okCallback = function()
                    setCharEquip(data)
                end,
            })
        else
            setCharEquip(data)
        end
    end
end

function EquipPanel:setCharEquip(data)
    
end

--[[
/EquipBox onClick 
--]]
function EquipPanel:equipBox_ScaleButton_onClick(customBox)

end

--[[
/EquipBox/EquipBtn onClick 
--]]
function EquipPanel:equipBtn_ScaleButton_onClick(equipBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:setModeBtnView(2)
end

--[[
/BackPanel/BackMainlBtn onClick 
--]]
function EquipPanel:backMainlBtn_ScaleButton_onClick(backMainlBtn)

end

--[[
/BackPanel/HelpBtn onClick 
--]]
function EquipPanel:helpBtn_ScaleButton_onClick(helpBtn)

end

--[[
/WeaponBtn onClick 
--]]
function EquipPanel:weaponBtn_ScaleButton_onClick(weaponBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:setModeBtnView(1)
end

--[[
/EquipList/Viewport/Content/ItemBox onClick 
--]]
function EquipPanel:itemBox_ScaleButton_onClick(itemBox)

end

--[[
/EquipPanel/OrderBtn onClick 
--]]
function EquipPanel:orderBtn_ScaleButton_onClick(orderBtn)

end

--[[
/MsgPanel/NameBg/LockBtn onClick 
--]]
function EquipPanel:lockBtn_ScaleButton_onClick(lockBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.nowSelectEquip then
        local data = {
            equipId = self.nowSelectEquip.id
        }
        Me:changeEquipLockStateReq(data, function()
            self:Refresh()
        end)
    end 
end

--[[
/MsgPanel/MsgBtn onClick 
--]]
function EquipPanel:msgBtn_ScaleButton_onClick(msgBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    UIMgr:popUI("EquipMsgPanel", {equipData = self.nowSelectEquip})
end

--[[
/MsgPanel/DelBtn onClick 
--]]
function EquipPanel:delBtn_ScaleButton_onClick(delBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    UIMgr:popUI("EquipDelPanel", {})
end

--[[
/ShowPanel/ShowBox_1/ShowBtn onClick 
--]]
function EquipPanel:showBtn_ScaleButton_onClick(showBtn)

end

--[[
/WeaponMode/WeaponBtn_1 onClick 
--]]
function EquipPanel:weaponBtn_1_ScaleButton_onClick(weaponBtn_1)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local openData = {
        partId = 1,
        roleId = self.roleData.id,
    }
    UIMgr:popUI("WeaponPanel", openData)
end

--[[
/WeaponMode/WeaponBtn_2 onClick 
--]]
function EquipPanel:weaponBtn_2_ScaleButton_onClick(weaponBtn_2)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --第二武器根据解锁状态开放
    local weaponUnLock = Me:getWeaponLockStateById(self.roleData.id)
    if not weaponUnLock then
        UICommonUtils.PopToast("未开放！")
        return
    end
    local openData = {
        partId = 2,
        roleId = self.roleData.id,
    }
    UIMgr:popUI("WeaponPanel", openData)
end

--[[
/WeaponMode/ScoreBg/ScoreHelpBtn onClick 
--]]
function EquipPanel:scoreHelpBtn_ScaleButton_onClick(scoreHelpBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.tipsMsgBox.tipsMsgBox:initPanel(scoreHelpBtn, 1001)
end

--[[
/WeaponMode/WeaponPanel_1/NullBtn_1 onClick 
--]]
function EquipPanel:nullBtn_1_ScaleButton_onClick(nullBtn_1)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local openData = {
        partId = 1,
        roleId = self.roleData.id,
    }
    UIMgr:popUI("WeaponPanel", openData)
end

--[[
/WeaponMode/WeaponPanel_2/NullBtn_2 onClick 
--]]
function EquipPanel:nullBtn_2_ScaleButton_onClick(nullBtn_2)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --第二武器根据解锁状态开放
    local weaponUnLock = Me:getWeaponLockStateById(self.roleData.id)
    if not weaponUnLock then
        UICommonUtils.PopToast("未开放！")
        return
    end
    local openData = {
        partId = 2,
        roleId = self.roleData.id,
    }
    UIMgr:popUI("WeaponPanel", openData)
end

--[[
/WeaponFuseBtn onClick 
--]]
function EquipPanel:weaponFuseBtn_ScaleButton_onClick(weaponFuseBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local functionState = Me:getFunctionOpenStateById(GE.FunctionOpenModule.WeaponFuse)
    local functionOpenConfig = Config.GetFunctionOpenInfo(GE.FunctionOpenModule.WeaponFuse)
    if functionState == GE.FunctionOpenState.Lock then
        UICommonUtils.PopToast(functionOpenConfig.unlockKey)
        return
    elseif functionState == GE.FunctionOpenState.Open then
        Me:readFunctionReq({functionId = GE.FunctionOpenModule.WeaponFuse})
    end
    UIMgr:popUI("WeaponFusePanel")
end

--[[
/SortMask onClick 
--]]
function EquipPanel:sortMask_Button_onClick(sortMask)
    self.sortSelectList:SetActive(false)
    self.sortMask:SetActive(false)
end

--[[
/EquipMode/EquipPanel/SortPanel/SortBg/SortBtn onClick 
--]]
function EquipPanel:sortBtn_ScaleButton_onClick(sortBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.sortSelectList:SetActive(not self.sortSelectList.activeSelf)
    self.sortMask:SetActive(self.sortSelectList.activeSelf)
    if self.sortSelectList.activeSelf then
        self:refreshSortView()
    end
end

--[[
/EquipMode/EquipPanel/SortPanel/SortBg/SortStateBtn onClick 
--]]
function EquipPanel:sortStateBtn_ScaleButton_onClick(sortStateBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.nowEquipSortFace == 1 then
        self.nowEquipSortFace = 2
    elseif self.nowEquipSortFace == 2 then
        self.nowEquipSortFace = 1
    end
    self.sortStateBtn.upImg:SetActive(self.nowEquipSortFace == 2)
    self.sortStateBtn.downImg:SetActive(self.nowEquipSortFace == 1)
    self:SetModeView(self.nowSelectMode, true)
    self.equipList.loopGridView:RefreshAllShownItem2()
    --self:Refresh()
    
    self.sortSelectList:SetActive(false)
    self.sortMask:SetActive(false)
end

--[[
/EquipMode/AdjustRoot/MsgPanel/NameBg/SpBtn onClick 
--]]
function EquipPanel:spBtn_ScaleButton_onClick(spBtn)
    self:play2DSound(self.btnSoundPath)
    UICommonUtils.PopToast(LocalStrEnum.ActionFailReason_RareEquipTips)
end

return EquipPanel
