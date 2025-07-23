module("equipBuild.EquipInfoTipsItem", Class.impl(BaseComponent))

-- UI预制体名
UIRes = UrlManager:getUIPrefabPath("hero/item/EquipInfoTipsItem.prefab")

function __initData(self)
    super.__initData(self)
    self.showConstrast = true
    if self.mEquipGrid then
        self.mEquipGrid:poolRecover()
        self.mEquipGrid = nil
    end
    self:__recoverTxtGoDic()
    self:__recoverBtnGoDic()
    self:__recoverBtnPool()
end

function setData(self, cusData, cusIsAsyn, finishCall)
    if self.m_equipVo then
        self.m_equipVo:removeEventListener(props.PropsVo.UPDATE, self.__updateTop, self)
    end
    super.setData(self, cusData, cusIsAsyn, finishCall)
end

function __updateCustomView(self)
    if self.mEquipGrid then
        self.mEquipGrid:poolRecover()
        self.mEquipGrid = nil
    end

    self.mEquipGrid = EquipGrid2:poolGet()

    self.mEquipGrid:setData(self:getData(), self.m_childTrans["EquipNode"])
    self.mEquipGrid:setIsNew(false)
    self.m_equipVo = self:getData()
    self:updateView()
    if (self.m_equipVo) then
        self.m_equipVo:addEventListener(props.PropsVo.UPDATE, self.__updateTop, self)
    end
end

function updateView(self)
    self.m_equipVo:removeEventListener(self.m_equipVo.UPDATE_EQUIP_DETAIL_DATA, self.__updateView, self)
    local totalAttrList, totalAttrDic = self.m_equipVo:getTotalAttr()
    if (totalAttrList == nil and totalAttrDic == nil) then
        self.m_equipVo:addEventListener(self.m_equipVo.UPDATE_EQUIP_DETAIL_DATA, self.__updateView, self)
        return
    end

    self:__recoverTxtGoDic()
    self:__recoverBtnGoDic()
    self:__recoverBtnPool()
    self:__updateTop()
    self:__updateBottom()
end

-- 更新有效期倒计时
function __updateTickTime(self)
    local cdTime = self.m_equipVo.expiredTime - GameManager:getClientTime()
    if (cdTime <= 0) then
        --已过期
        self.mTxtName.text = self.m_equipVo:getName()
        self.m_textTime.text = _TT(4027)--"已过期"
        if (self.m_loopSn) then
            LoopManager:removeTimerByIndex(self.m_loopSn)
            self.m_loopSn = nil
        end
    else
        --未过期
        local timeStr = TimeUtil.getFormatTimeBySeconds_1(cdTime)
        self.mTxtName.text = self.m_equipVo:getName()
        self.m_textTime.text = timeStr
    end
end

function __updateTop(self)
    self.mTxtName = self.m_childGos["TextName"]:GetComponent(ty.Text)
    self.m_textTime = self.m_childGos["TextTime"]:GetComponent(ty.Text)
    self.mTxtLv = self.m_childGos["mTxtLv"]:GetComponent(ty.Text)
    self.mTxtLv.text = self.m_equipVo.strengthenLvl
    -- 非限时道具
    if (not self.m_equipVo.expiredTime or self.m_equipVo.expiredTime <= 0) then
        self.mTxtName.text = self.m_equipVo:getName()
        self.m_textTime.text = ""
    else
        self:__updateTickTime()
        self.m_loopSn = LoopManager:addTimer(1, 0, self, __updateTickTime)

        local _recover = self.recover
        self.recover = function()
            _recover(self)
            if (self.m_loopSn) then
                LoopManager:removeTimerByIndex(self.m_loopSn)
                self.m_loopSn = nil
            end
        end
    end

    self.m_childGos["NodeEquip"]:SetActive(false)
    self.m_childGos["NodeBracelets"]:SetActive(false)
    if (self.m_equipVo.subType == PropsEquipSubType.SLOT_7) then  -- 手环
        self.m_childGos["NodeBracelets"]:SetActive(true)
        self:__resetRefineObjList()
        local isCanRefine = braceletsBuild.BraceletsRefineManager:isCanRefine(self.m_equipVo.tid)
        if (isCanRefine) then
            self.m_childGos["GroupRefineLvl"]:SetActive(true)

            local maxRefineLvl = braceletsBuild.BraceletsRefineManager:getMaxRefineLvl(self.m_equipVo.tid)
            for lvl = 1, maxRefineLvl do
                local item = SimpleInsItem:create(self.m_childGos["ItemRefineLvl"], self.m_childTrans["GroupRefineLvl"], "EquipInfoTipsItemItemRefineLvl")
                local isActive = false
                if (self.m_equipVo.refineLvl) then
                    isActive = self.m_equipVo.refineLvl >= lvl
                end
                item:getChildGO("ImgRefineLvl"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getBraceletsRefineLvlIconUrl(not isActive), true)
                table.insert(self.m_refineLvlObjList, item)
            end
        else
            self.m_childGos["GroupRefineLvl"]:SetActive(false)
        end
    else                                                        -- 普通芯片
        self.m_childGos["NodeEquip"]:SetActive(true)
        local str = PropsEquipSubTypeStr[self.m_equipVo.subType]
    end

    self.m_childGos["mImgPlan"]:SetActive(equipBuild.EquipPlanManager:isInEquipPlan(self.m_equipVo))

    local equipList = self.m_equipVo:getOtherRoleHeroEquipList()
    if equipList then
        --self.m_childGos["ImgShowLock"]:SetActive(false)
        self.m_childGos["BtnLock"]:SetActive(false)
        self.m_childGos["BtnUnLock"]:SetActive(false)
    else
        local function onLockHandler()
            local isLock = self.m_equipVo.isLock == 0 and 1 or 0
            GameDispatcher:dispatchEvent(EventName.REQ_PROPS_LOCK_CHANGE, { propsVo = self.m_equipVo, isLock = isLock })
        end
        self:addOnClick(self.m_childGos["BtnLock"], onLockHandler)
        self:addOnClick(self.m_childGos["BtnUnLock"], onLockHandler)
        self.m_childGos["BtnLock"]:SetActive(self.m_equipVo.isLock == 1)
        self.m_childGos["BtnUnLock"]:SetActive(self.m_equipVo.isLock == 0)
    end


    local _recover = self.recover
    self.recover = function()
        _recover(self)
        self:removeOnClick(self.m_childGos["BtnLock"], onLockHandler)
        self:removeOnClick(self.m_childGos["BtnUnLock"], onLockHandler)
    end
end

function __updateBottom(self)
    local groupLink = self.m_childGos["GroupLink"]
    local uiCodeList = self.m_equipVo.uiCodeList
    if (#uiCodeList <= 0) then
        groupLink:SetActive(false)
    else
        local _show = false
        for i = 1, #uiCodeList do
            local configVo = link.LinkManager:getLinkData(uiCodeList[i])
            if configVo then
                local isOpen = funcopen.FuncOpenManager:isOpen(uiCodeList[i], false)
                local item = SimpleInsItem:create(self.m_childGos["LinkItem"], groupLink.transform, self:__getGoUniqueName("LinkItem"))
                item:getChildGO("GroupLinkLock"):SetActive(not isOpen)
                item:getChildGO("GroupLinkUnLock"):SetActive(isOpen)
                item:getChildGO("TextLinkNameUnLock"):GetComponent(ty.Text).text = configVo:getLinkName2()
                item:getChildGO("TextLinkNameLock"):GetComponent(ty.Text).text = configVo:getLinkName2()
                item:getChildGO("TextLinkTip"):GetComponent(ty.Text).text = _TT(4062)
                local function _clickLinkFun()
                    if (isOpen) then
                        self:close()
                        gs.PopPanelManager.CloseAll()
                        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = uiCodeList[i] })
                    else
                        funcopen.FuncOpenManager:isOpen(uiCodeList[i], true)
                    end
                end
                item:addUIEvent("ImgClick", _clickLinkFun)
                table.insert(self.m_btnGoList, item)
                _show = true
            end
        end
        groupLink:SetActive(_show)
    end

    self:__updateAttr()
    self:__updateSkill()
    self:__updateTuPoAttachAttr()
    self:__updateSuit_2()
    self:__updateSuit_4()
    self:__updateRemake()
    self:__updateBtnList()
    self:updateHeroEquip()
    self:updateEquipRemakeIcon()
end

-- 更新基础属性
function __updateAttr(self)
    if (self.m_equipVo.subType == PropsEquipSubType.SLOT_7) then  -- 手环
        local equipConfigVo = equip.EquipManager:getEquipConfigVo(self.m_equipVo.tid)
        local attrList = equipConfigVo.defaultAttrList
        for i = 1, #attrList do
            local vo = attrList[i]
            local itemCloneGo = self:__getTxtGo("AttrItem")
            itemCloneGo.transform:SetParent(self.m_childTrans["ShowAttr"], false)
            local textAttr = itemCloneGo.transform:Find("TextAttr"):GetComponent(ty.Text)
            if textAttr then
                textAttr.text = AttConst.getName(vo[1])
            end
            local textAttrValue = textAttr.transform:Find("TextAttrValue"):GetComponent(ty.Text)
            if textAttrValue then
                textAttrValue.text = "+" .. AttConst.getValueStr(vo[1], vo[2])
            end
        end
    else
        local mainAttrList, _ = self.m_equipVo:getMainAttr()
        for i = 1, #mainAttrList do
            local attrVo = mainAttrList[i]
            local attrTValue = attrVo.value
            local itemCloneGo = self:__getTxtGo("AttrItem")
            itemCloneGo.transform:SetParent(self.m_childTrans["ShowAttr"], false)
            local textAttr = itemCloneGo.transform:Find("TextAttr"):GetComponent(ty.Text)
            if textAttr then
                textAttr.text = AttConst.getName(attrVo.key)
            end
            local textAttrValue = textAttr.transform:Find("TextAttrValue"):GetComponent(ty.Text)
            if textAttrValue then
                textAttrValue.text = "+" .. AttConst.getValueStr(attrVo.key, attrTValue)
            end
        end
    end

    -- gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["ShowAttr"]);
end

-- 更新突破附加属性
function __updateTuPoAttachAttr(self)
    self.m_childGos["TextTitleTuPoAttach"]:GetComponent(ty.Text).text = _TT(1332) --"附加属性"

    local attachAttrList, attachAttrDic = self.m_equipVo:getTuPoAttachAttr()
    table.sort(attachAttrList, function(a, b)
        return a.breakUpRank < b.breakUpRank
    end)
    if (attachAttrList and #attachAttrList > 0) then
        self.m_childGos["GroupTuPoAttachAttr"]:SetActive(true)

        for i = 1, #attachAttrList do
            local attachAttrVo = attachAttrList[i]
            local itemCloneGo = self:__getTxtGo("TuPoAttachAttrItem")
            itemCloneGo.transform:SetParent(self.m_childTrans["ShowTuPoAttachAttr"], false)
            local textAttr = itemCloneGo.transform:Find("TextTuPoAttachAttr"):GetComponent(ty.Text)
            local textAttrTip = itemCloneGo.transform:Find("TextTuPoAttachAttrTip"):GetComponent(ty.Text)
            local imgUnLockIcon = itemCloneGo.transform:Find("ImgTuPoAttachUnLockIcon").gameObject
            local imgLockIcon = itemCloneGo.transform:Find("ImgTuPoAttachLockIcon").gameObject

            local color = "ffffffff"
            if (attachAttrVo.isActive) then
                textAttr.text = AttConst.getName(attachAttrVo.key) .. "+" .. AttConst.getValueStr(attachAttrVo.key, attachAttrVo.value)
                textAttrTip.gameObject:SetActive(false)
                -- textAttrTip.color = gs.ColorUtil.GetColor("ffffffff") 
                -- textAttrTip.text = AttConst.getValueStr(attachAttrVo.key, attachAttrVo.value)
            else
                textAttr.text = AttConst.getName(attachAttrVo.key) .. "+" .. AttConst.getValueStr(attachAttrVo.key, attachAttrVo.value)
                textAttrTip.gameObject:SetActive(true)
                -- textAttrTip.color = gs.ColorUtil.GetColor("FA3A2Bff") 
                textAttrTip.text = string.substitute(_TT(1309), attachAttrVo.breakUpRank - 1) --显示固定需要突破次数
                color = "82898cff"
            end
            textAttr.color = gs.ColorUtil.GetColor(color)
        end
    else
        self.m_childGos["GroupTuPoAttachAttr"]:SetActive(false)
    end

    -- gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["ShowTuPoAttachAttr"]);
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["GroupTuPoAttachAttr"]);
end

-- 更新技能
function __updateSkill(self)
    if (self.m_equipVo.subType == PropsEquipSubType.SLOT_7) then  -- 手环
        self.m_childGos["GroupSkill"]:SetActive(true)
        local equipConfigVo = equip.EquipManager:getEquipConfigVo(self.m_equipVo.tid)
        local txtCloneGo = self:__getTxtGo("TextSkill")
        txtCloneGo.transform:SetParent(self.m_childTrans["ShowSkill"], false)
        txtCloneGo:GetComponent(ty.Text).text = equipConfigVo.defaultSkillDes-- HtmlUtil:color(des, "bababaff")
    else
        self.m_childGos["GroupSkill"]:SetActive(false)
        local skillEffectList, skillEffectDic = self.m_equipVo:getSkillEffect()
        if (skillEffectList and #skillEffectList > 0) then
            self.m_childGos["GroupSkill"]:SetActive(true)
            for i = 1, #skillEffectList do
                local skillVo = fight.SkillManager:getSkillRo(skillEffectList[i].skillId)
                self.m_childGos["TextTitleSkill"]:GetComponent(ty.Text).text = skillVo:getName()
                local des = equip.EquipSkillManager:getSkillDes(self.m_equipVo, skillEffectList[i])
                local txtCloneGo = self:__getTxtGo("TextSkill")
                txtCloneGo.transform:SetParent(self.m_childTrans["ShowSkill"], false)
                txtCloneGo:GetComponent(ty.Text).text = des-- HtmlUtil:color(des, "bababaff")
            end
        end
    end
    -- gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["ShowSkill"]);
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["GroupSkill"]);
end

-- 更新套装属性
function __updateSuit(self)
    self.m_childGos["TextTitleSuit"]:GetComponent(ty.Text).text = _TT(4063)

    local equipConfigVo = equip.EquipManager:getEquipConfigVo(self.m_equipVo.tid)
    local suitId = equipConfigVo.suitId
    local suitConfigVo = equip.EquipSuitManager:getEquipSuitConfigVo(suitId)
    if (not suitConfigVo or (suitConfigVo.suitSkillId_2 <= 0 and suitConfigVo.suitSkillId_4 <= 0)) then
        self.m_childGos["GroupSuit"]:SetActive(false)
    else
        self.m_childGos["GroupSuit"]:SetActive(true)

        local count = 0
        local suitIdDic = equip.EquipManager:getEquipSuitIdDic()
        local equipTidDic = suitIdDic[suitId]
        local equipList = self.m_equipVo:getOtherRoleHeroEquipList()
        if not equipList then
            local heroVo = hero.HeroManager:getHeroVo(self.m_equipVo.heroId)
            equipList = heroVo.equipList
        end
        if (equipList) then
            for i = 1, #equipList do
                local propsVo = equipList[i]
                if (equipTidDic[propsVo.tid]) then
                    count = count + 1
                    if (count >= 4) then
                        break
                    end
                end
            end
        end

        -- 2件套描述
        if (suitConfigVo.suitSkillId_2 > 0) then
            local colorStr
            if (count >= 2) then
                colorStr = ColorUtil.BLUE_NUM
            else
                -- colorStr = "ffffffff"
            end
            local txtCloneGo = self:__getTxtGo("TextSuitDes")

            txtCloneGo.transform:SetParent(self.m_childTrans["ShowSuit"], false)
            -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color("套装" .. suitId .. "的2件套 [触发技能id:" .. suitConfigVo.suitSkillId_2 .. "]", colorStr)
            txtCloneGo:GetComponent(ty.Text).text = suitConfigVo.name .. _TT(4037)

            txtCloneGo = self:__getTxtGo("TextSuitDes")
            txtCloneGo.transform:SetParent(self.m_childTrans["ShowSuit"], false)
            -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color("技能id:" .. suitConfigVo.suitSkillId_2 .. "的描述", colorStr)
            local skillVo = fight.SkillManager:getSkillRo(suitConfigVo.suitSkillId_2)
            txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(skillVo:getDesc(), colorStr)
        end
        -- 4件套描述
        if (suitConfigVo.suitSkillId_4 > 0) then
            local colorStr
            if (count >= 4) then
                colorStr = ColorUtil.BLUE_NUM
            else
                -- colorStr = "ffffffff"
            end
            local txtCloneGo = self:__getTxtGo("TextSuitDes")
            txtCloneGo.transform:SetParent(self.m_childTrans["ShowSuit"], false)
            -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color("套装" .. suitId .. "的4件套 [触发技能id:" .. suitConfigVo.suitSkillId_4 .. "]", colorStr)
            txtCloneGo:GetComponent(ty.Text).text = suitConfigVo.name .. _TT(4038)

            txtCloneGo = self:__getTxtGo("TextSuitDes")
            txtCloneGo.transform:SetParent(self.m_childTrans["ShowSuit"], false)
            -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color("技能id:" .. suitConfigVo.suitSkillId_4 .. "的描述", colorStr)
            local skillVo = fight.SkillManager:getSkillRo(suitConfigVo.suitSkillId_4)
            txtCloneGo:GetComponent(ty.Text).text = skillVo:getDesc()
        end
    end
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["ShowSuit"]);
end

-- 更新2件套装属性
function __updateSuit_2(self)
    self.m_childGos["TextTitleSuit_2"]:GetComponent(ty.Text).text = _TT(4037)--"2件套"

    local function _update(name)
        self.m_childGos["GroupSuit_2"]:SetActive(name ~= nil)
        self.m_childGos["GroupSuitTitle"]:SetActive(name ~= nil)
        self.m_childGos["TextSuitTitle"]:GetComponent(ty.Text).text = _TT(1316)
    end
    local equipConfigVo = equip.EquipManager:getEquipConfigVo(self.m_equipVo.tid)
    if (not equipConfigVo) then
        _update(nil)
        return
    end
    local suitId = equipConfigVo.suitId
    local suitConfigVo = equip.EquipSuitManager:getEquipSuitConfigVo(suitId)
    if (not suitConfigVo or suitConfigVo.suitSkillId_2 <= 0) then
        _update(nil)
    else
        _update(suitConfigVo.name)

        local count = 0
        local suitIdDic = equip.EquipManager:getEquipSuitIdDic()
        local equipTidDic = suitIdDic[suitId]
        local equipList = self.m_equipVo:getOtherRoleHeroEquipList()
        if not equipList then
            local heroVo = hero.HeroManager:getHeroVo(self.m_equipVo.heroId)
            if (heroVo) then
                equipList = heroVo.equipList
            end
        end
        if (equipList) then
            for i = 1, #equipList do
                local propsVo = equipList[i]
                if (equipTidDic[propsVo.tid]) then
                    count = count + 1
                    if (count >= 4) then
                        break
                    end
                end
            end
        end

        -- 2件套描述
        if (suitConfigVo.suitSkillId_2 > 0) then
            local colorStr = "ffffffff"
            if (count >= 2) then

                self.m_childGos["ImgSuitTitleIcon_2"]:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon4Path("common_5429.png"), true)
            else
                colorStr = "82898cff"
                self.m_childGos["ImgSuitTitleIcon_2"]:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon4Path("common_5402.png"), true)
            end
            local txtCloneGo = self:__getTxtGo("TextSuitDes_2")
            txtCloneGo.transform:SetParent(self.m_childTrans["ShowSuit_2"], false)
            local skillVo = fight.SkillManager:getSkillRo(suitConfigVo.suitSkillId_2)
            txtCloneGo:GetComponent(ty.Text).text = skillVo:getDescTip()
            txtCloneGo:GetComponent(ty.Text).color = gs.ColorUtil.GetColor(colorStr)
            self.m_childGos["TextTitleSuit_2"]:GetComponent(ty.Text).color = gs.ColorUtil.GetColor(colorStr)
            self:getChildGO("ImgSuitTitleBg_2"):GetComponent(ty.Image).color = gs.ColorUtil.GetColor(colorStr)
        end
    end

    -- gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["ShowSuit_2"])
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["GroupSuit_2"])
end

-- 更新4件套装属性
function __updateSuit_4(self)
    self.m_childGos["TextTitleSuit_4"]:GetComponent(ty.Text).text = _TT(4038)--"4件套"

    local equipConfigVo = equip.EquipManager:getEquipConfigVo(self.m_equipVo.tid)
    if (not equipConfigVo) then
        self.m_childGos["GroupSuit_4"]:SetActive(false)
        return
    end
    local suitId = equipConfigVo.suitId
    local suitConfigVo = equip.EquipSuitManager:getEquipSuitConfigVo(suitId)
    if (not suitConfigVo or suitConfigVo.suitSkillId_4 <= 0) then
        self.m_childGos["GroupSuit_4"]:SetActive(false)
    else
        self.m_childGos["GroupSuit_4"]:SetActive(true)

        local count = 0
        local suitIdDic = equip.EquipManager:getEquipSuitIdDic()
        local equipTidDic = suitIdDic[suitId]
        local equipList = self.m_equipVo:getOtherRoleHeroEquipList()
        if not equipList then
            local heroVo = hero.HeroManager:getHeroVo(self.m_equipVo.heroId)
            if (heroVo) then
                equipList = heroVo.equipList
            end
        end
        if (equipList) then
            for i = 1, #equipList do
                local propsVo = equipList[i]
                if (equipTidDic[propsVo.tid]) then
                    count = count + 1
                    if (count >= 4) then
                        break
                    end
                end
            end
        end

        -- 4件套描述
        if (suitConfigVo.suitSkillId_4 > 0) then
            local colorStr = "ffffffff"
            if (count >= 4) then
            else
                colorStr = "82898cff"
            end

            local txtCloneGo = self:__getTxtGo("TextSuitDes_4")
            txtCloneGo.transform:SetParent(self.m_childTrans["ShowSuit_4"], false)
            local skillVo = fight.SkillManager:getSkillRo(suitConfigVo.suitSkillId_4)
            txtCloneGo:GetComponent(ty.Text).text = skillVo:getDescTip()
            txtCloneGo:GetComponent(ty.Text).color = gs.ColorUtil.GetColor(colorStr)
            self.m_childGos["TextTitleSuit_4"]:GetComponent(ty.Text).color = gs.ColorUtil.GetColor(colorStr)
            self:getChildGO("ImgSuitTitleBg_4"):GetComponent(ty.Image).color = gs.ColorUtil.GetColor(colorStr)
        end
    end

    -- gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["ShowSuit_4"]);
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["GroupSuit_4"]);
end

-- 更新改造属性
function __updateRemake(self)
    self.m_childGos["TextTitleRemake"]:GetComponent(ty.Text).text = _TT(4039)--"改造属性"

    self.m_childGos["GroupRemake"]:SetActive(false)
    local remakePosAttrList, remakePosAttrDic = self.m_equipVo:getRemakeAttr()

    if remakePosAttrDic == nil then
        return
    end

    for pos, attrData in pairs(remakePosAttrDic) do
        local key = attrData.key
        local value = attrData.value
        local maxValue = attrData.maxValue

        local txtCloneGo = self:__getTxtGo("TextRemakeDes")
        local colorStr = "ffffffff"
        txtCloneGo.transform:SetParent(self.m_childTrans["ShowRemake"], false)

        txtCloneGo:GetComponent(ty.Text).text = AttConst.getName(key) .. "+" .. AttConst.getValueStr(key, value)
        txtCloneGo:GetComponent(ty.Text).color = gs.ColorUtil.GetColor(colorStr)
        self.m_childGos["GroupRemake"]:SetActive(true)
    end

    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["GroupRemake"]);
    -- gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["ShowRemake"]);
end

-- 更新装备改造属性标识
function updateEquipRemakeIcon(self)
    local canRemakeCount = equipBuild.EquipRemakeManager:getRemakeCount(self.m_equipVo.tid)
    local remakePosAttrList, remakePosAttrDic = self.m_equipVo:getRemakeAttr()

    if remakePosAttrList == nil and remakePosAttrDic == nil then
        self.m_childGos["mGroupRemake"]:SetActive(false)
        return
    end

    if canRemakeCount <= 0 or table.nums(remakePosAttrDic) == 0 then
        self.m_childGos["mGroupRemake"]:SetActive(false)
        return
    end

    self.m_childGos["mGroupRemake"]:SetActive(true)
    for i = 1, canRemakeCount do
        local color = ""
        local attrData = remakePosAttrDic[i]
        local imgRemakeObj = self.m_childGos["mImgRemake_" .. i]

        if attrData == nil then
            -- 没有具体的内容 直接跳过
            imgRemakeObj:SetActive(false)
            break
        else
            imgRemakeObj:SetActive(true)
        end
        local img = imgRemakeObj:GetComponent(ty.AutoRefImage)

        local key = attrData.key
        local value = attrData.value
        local maxValue = attrData.maxValue
        if (value >= maxValue) then
            -- 蓝
            color = "FFFFFFFF"
        else
            -- 白
            color = "FFFFFFFF"
        end
        img.color = gs.ColorUtil.GetColor(color)
    end
end

function updateHeroEquip(self)
    local equipHero = self.m_childGos["mImgEquipHero"]
    local mImgCircleBg = self.m_childGos["mImgCircleBg"]

    equipHero:SetActive(false)
    mImgCircleBg:SetActive(false)
    self.m_childGos["mTxtCurrent"]:SetActive(self.m_equipVo.heroId == equipBuild.EquipBuildManager:getHeroId())
    if (self.m_equipVo.heroId > 0 and self.m_equipVo.heroId ~= equipBuild.EquipBuildManager:getHeroId()) then
        local heroVo = hero.HeroManager:getHeroVo(self.m_equipVo.heroId)
        if (heroVo) then
            local iconUrl = UrlManager:getHeroHeadCircularByModel(heroVo:getHeroModel())
            equipHero:GetComponent(ty.AutoRefImage):SetImg(iconUrl, false)
            equipHero:SetActive(true)
            mImgCircleBg:SetActive(true)
        end
    end

    self.m_childGos["GroupBtn"]:SetActive(self.showConstrast or self.showExchange)
end

--隐藏相关信息
function setHideHero(self, bool)
    local equipHero = self.m_childGos["mImgEquipHero"]
    local mImgCircleBg = self.m_childGos["mImgCircleBg"]

    equipHero:SetActive(bool)
    mImgCircleBg:SetActive(bool)
    self.m_childGos["mTxtCurrent"]:SetActive(bool)
end

function __updateBtnList(self)
    gs.TransQuick:SizeDelta02(self.m_childTrans["GameAction"], 609)
    gs.TransQuick:SizeDelta02(self.m_childTrans["GroupBottom"], 490)

    local contrast = self.m_childGos["mBtnContrast"]
    local exchange = self.m_childGos["mBtnExchange"]
    local _clickContrastBtn = function()
        -- 打开对比界面
        GameDispatcher:dispatchEvent(EventName.OPEN_BRACELETS_CONTRAST_TIPS, self.m_equipVo)
    end
    local clickExchangeBtn = function()
        hero.HeroEquipManager:dispatchEvent(hero.HeroEquipManager.HERO_BAG_EQUIP_SELECT, { equipVo = self.m_equipVo })
    end
    contrast:SetActive(self.m_equipVo.heroId ~= equipBuild.EquipBuildManager:getHeroId())
    exchange:SetActive(false)
    self:addOnClick(contrast, _clickContrastBtn)
    self:addOnClick(exchange, clickExchangeBtn)
    -- end
    -- end
end

function setContrastActive(self, isActive)
    self.showConstrast = isActive
    if (self.m_isLoadFinish) then
        self.m_childGos["GroupBtn"]:SetActive(isActive)
        self.m_childGos["GroupBtn"]:SetActive(isActive)
    end
end

function setExchangeActive(self, isActive)
    self.showExchange = isActive
    if (self.m_isLoadFinish) then
        self.m_childGos["mBtnExchange"]:SetActive(isActive)
        self.m_childGos["GroupBtn"]:SetActive(isActive)
    end
end

function __getTxtGo(self, goName)
    local uniqueName = self:__getGoUniqueName(goName)
    go = SimpleInsItem:create(self.m_childGos[goName], self.m_childTrans[goName].parent, "TxtGo" .. goName)
    go:getGo():SetActive(true)
    self.m_txtGoDic[go:getGo():GetHashCode()] = { go = go, uniqueName = uniqueName }
    return go:getGo()
end

function __getBtnGo(self, goName, type)
    local uniqueName = self:__getGoUniqueName(goName)
    local go = gs.GOPoolMgr:GetOther(uniqueName)
    if (not go or gs.GoUtil.IsGoNull(go)) then
        if (self.m_childGos and self.m_childGos[goName]) then
            go = gs.GameObject.Instantiate(self.m_childGos[goName])
        end
    end
    self.m_btnGoDic[go:GetHashCode()] = { go = go, uniqueName = uniqueName, type = type }
    return go
end

function __getGoUniqueName(self, goName)
    return self.__cname .. "_" .. goName
end

function __recoverTxtGoDic(self)
    if (self.m_txtGoDic) then
        for hashCode, data in pairs(self.m_txtGoDic) do
            if (data.go) then
                -- logAll(data.go, data.uniqueName)
                data.go:poolRecover()
            end
        end
    end
    self.m_txtGoDic = {}
end

function __recoverBtnGoDic(self)
    if (self.m_btnGoDic) then
        for hashCode, data in pairs(self.m_btnGoDic) do
            self:removeOnClick(data.go)
            gs.GOPoolMgr:RecoverOther(data.uniqueName, data.go)
        end
    end
    self.m_btnGoDic = {}
end

-- 回收精炼等级图标预制体
function __resetRefineObjList(self)
    if (self.m_refineLvlObjList) then
        for _, obj in pairs(self.m_refineLvlObjList) do
            obj:poolRecover()
        end
    end
    self.m_refineLvlObjList = {}
end

function __recoverBtnPool(self)
    if (self.m_btnGoList) then
        for _, btnItem in pairs(self.m_btnGoList) do
            btnItem:poolRecover()
        end
    end
    self.m_btnGoList = {}
end

-- 在资源销毁前，对需要回收的资源进行回收处理
function poolRecover(self)
    if self.m_equipVo then
        self.m_equipVo:removeEventListener(self.m_equipVo.UPDATE_EQUIP_DETAIL_DATA, self.__updateView, self)
        self.m_equipVo:removeEventListener(props.PropsVo.UPDATE, self.__updateTop, self)
    end
    if self.mEquipGrid then
        self.mEquipGrid:poolRecover()
        self.mEquipGrid = nil
    end
    super.poolRecover(self)
    self:initData()
end

return _M