module("tips.HeroEquipContrastTips", Class.impl(View))

panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
UIRes = UrlManager:getUIPrefabPath("tips/HeroEquipContrastTips.prefab")

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
end

-- 析构函数
function dtor(self)
    super.dtor(self)
end
function setMask(self)
    super.setMask(self)
    local trigger = self.mask:GetComponent(ty.LongPressOrClickEventTrigger)
    trigger:SetIsPassEvent(true)
end
-- 初始化UI
function configUI(self)
    super.configUI(self)

    self.m_Gos = {}
    self.m_Trans = {}

    local go = self.m_childGos["CurrTips"]
    self.m_Gos[1] = {}
    self.m_Trans[1] = {}
    local coms = gs.GoUtil.GetComsInChildren(go)
    local len = coms.Length - 1
    for i = 0, len do
        local trans = coms[i]
        self.m_Gos[1][trans.name] = trans.gameObject
        self.m_Trans[1][trans.name] = trans
    end

    local go = self.m_childGos["ContrastTips"]
    self.m_Gos[2] = {}
    self.m_Trans[2] = {}
    local coms = gs.GoUtil.GetComsInChildren(go)
    local len = coms.Length - 1
    for i = 0, len do
        local trans = coms[i]
        self.m_Gos[2][trans.name] = trans.gameObject
        self.m_Trans[2][trans.name] = trans
    end

    self.m_Gos[1]["BtnUnload"]:SetActive(false)
    self.m_Gos[1]["BtnBuild"]:SetActive(false)
    self.m_Gos[2]["BtnBuild"]:SetActive(true)
    self.m_Gos[2]["BtnReplace"]:SetActive(true)
end

function active(self, args)
    super.active(self, args)

    self.m_equipVo = args.propsVo
    self.m_equipVo2 = args.propsVo2

    if self.mEquipGrid then
        self.mEquipGrid:poolRecover()
        self.mEquipGrid = nil
    end

    if self.mEquipGrid2 then
        self.mEquipGrid2:poolRecover()
        self.mEquipGrid2 = nil
    end

    self.mEquipGrid = EquipGrid:poolGet()
    self.mEquipGrid:setData(self.m_equipVo, self.m_Gos[1]["EquipNode"].transform)
    self.mEquipGrid:setClickEnable(false)
    self.mEquipGrid:setShowLockState(false)

    self.mEquipGrid2 = EquipGrid:poolGet()
    self.mEquipGrid2:setData(self.m_equipVo2, self.m_Gos[2]["EquipNode"].transform)
    self.mEquipGrid2:setClickEnable(false)
    self.mEquipGrid2:setShowLockState(false)

    self.m_callFun = args.clickPos.callFun

    self:__update()

    if (self.m_equipVo) then
        self.m_equipVo:addEventListener(props.PropsVo.UPDATE, self.__update, self)
    end
    if (self.m_equipVo2) then
        self.m_equipVo2:addEventListener(props.PropsVo.UPDATE, self.__update, self)
    end
end

function deActive(self)
    super.deActive(self)

    self.m_childTrans["Content"].anchoredPosition = gs.Vector2.zero

    if (self.m_equipVo) then
        self.m_equipVo:removeEventListener(props.PropsVo.UPDATE, self.__update, self)
        self.m_equipVo:removeEventListener(self.m_equipVo.UPDATE_EQUIP_DETAIL_DATA, self.__update, self)
    end
    if (self.m_equipVo2) then
        self.m_equipVo2:removeEventListener(props.PropsVo.UPDATE, self.__update, self)
        self.m_equipVo2:removeEventListener(self.m_equipVo.UPDATE_EQUIP_DETAIL_DATA, self.__update, self)
    end

    if self.mEquipGrid then
        self.mEquipGrid:poolRecover()
        self.mEquipGrid = nil
    end

    if self.mEquipGrid2 then
        self.mEquipGrid2:poolRecover()
        self.mEquipGrid2 = nil
    end

    if (self.m_callFun) then
        self.m_callFun()
    end
end

function addAllUIEvent(self)
    self:addUIEvent(self.m_Gos[1]["BtnUnload"], self.__onUnloadClickHandler)
    self:addUIEvent(self.m_Gos[1]["BtnBuild"], self.__onBuildClickHandlerDef)
    self:addUIEvent(self.m_Gos[2]["BtnBuild"], self.__onBuildClickHandler)
    self:addUIEvent(self.m_Gos[2]["BtnReplace"], self.__onReplaceClickHandler)
end

-- 初始化数据
function initData(self)
    self:__recoverTxtGoDic()
    self:__recoverBtnGoDic()
    self:__recoverBtnPool()

    -- 是否显示获取途径
    self.m_isShowLink = true
    -- 数据vo
    self.m_equipVo = nil
    self.m_equipVo2 = nil
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.m_Gos[1]["TextLinkTitle"]:GetComponent(ty.Text).text = _TT(25020) -- "获取途径"
    self.m_Gos[1]["TextCurrTitle"]:GetComponent(ty.Text).text = "当前穿戴" -- _TT(25020) -- "获取途径"
    self.m_Gos[2]["TextLinkTitle"]:GetComponent(ty.Text).text = _TT(25020) -- "获取途径"
    self:setBtnLabel(self.m_Gos[1]["BtnUnload"], 4327, "卸下")
    self:setBtnLabel(self.m_Gos[2]["BtnBuild"], 4321, "培养")
    self:setBtnLabel(self.m_Gos[2]["BtnReplace"], 4323, "替换")
end

function __update(self)
    self:__recoverTxtGoDic()
    self:__recoverBtnGoDic()
    self:__recoverBtnPool()
    self:__updateView()
    self:__updateView2()
end

------------------tips------------------
function __updateView(self)

    self.m_equipVo:removeEventListener(self.m_equipVo.UPDATE_EQUIP_DETAIL_DATA, self.__update, self)
    local totalAttrList, totalAttrDic = self.m_equipVo:getTotalAttr()
    if (totalAttrList == nil and totalAttrDic == nil) then
        self.m_equipVo:addEventListener(self.m_equipVo.UPDATE_EQUIP_DETAIL_DATA, self.__update, self)
        return
    end

    self:__updateTop(self.m_Gos[1], self.m_Trans[1], self.m_equipVo)
    self:__updateBottom(self.m_Gos[1], self.m_Trans[1], self.m_equipVo)
end
function __updateView2(self)

    self.m_equipVo2:removeEventListener(self.m_equipVo2.UPDATE_EQUIP_DETAIL_DATA, self.__update, self)
    local totalAttrList, totalAttrDic = self.m_equipVo2:getTotalAttr()
    if (totalAttrList == nil and totalAttrDic == nil) then
        self.m_equipVo2:addEventListener(self.m_equipVo2.UPDATE_EQUIP_DETAIL_DATA, self.__update, self)
        return
    end

    local totalAttrList, totalAttrDic = self.m_equipVo:getTotalAttr()
    if (totalAttrList == nil and totalAttrDic == nil) then
        self.m_equipVo:addEventListener(self.m_equipVo.UPDATE_EQUIP_DETAIL_DATA, self.__update, self)
        return
    end

    self:__updateTop(self.m_Gos[2], self.m_Trans[2], self.m_equipVo2)
    self:__updateBottom(self.m_Gos[2], self.m_Trans[2], self.m_equipVo2, self.m_equipVo)
    self:__updateHeroHead()
end
--------------------------------------------

function __updateTop(self, gos, trans, equipVo)
    self.mTxtName = gos["TextName"]:GetComponent(ty.Text)
    self.m_textTime = gos["TextTime"]:GetComponent(ty.Text)
    -- 非限时道具
    if (not equipVo.expiredTime or equipVo.expiredTime <= 0) then
        self.mTxtName.text = equipVo:getName()
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
    -- gos["ImgIcon"]:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPropsIconUrl(equipVo.tid), false)
    -- gos["ImgColor"]:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getEquipBgUrl(equipVo.color), false)
    -- gos["TextLvl"]:GetComponent(ty.Text).text = equipVo.strengthenLvl and "LV." .. equipVo.strengthenLvl or ""
    -- gos["ImgLvBg"]:SetActive(equipVo.strengthenLvl and true or false)
    -- trans["TextDes"]:GetComponent(ty.Text).text = equipVo:getDes()

    gos["NodeEquip"]:SetActive(false)
    gos["NodeBracelets"]:SetActive(false)
    gos["NodeOrder"]:SetActive(false)
    if (equipVo.subType == PropsEquipSubType.SLOT_7) then -- 手环
        gos["NodeBracelets"]:SetActive(true)
        self:__resetRefineObjList()
        local isCanRefine = braceletsBuild.BraceletsRefineManager:isCanRefine(equipVo.tid)
        if (isCanRefine) then
            gos["GroupRefineLvl"]:SetActive(true)
            gos["TextRefineTitle"]:GetComponent(ty.Text).text = "精炼："

            local maxRefineLvl = braceletsBuild.BraceletsRefineManager:getMaxRefineLvl(equipVo.tid)
            for lvl = 1, maxRefineLvl do
                local item = SimpleInsItem:create(gos["ItemRefineLvl"], trans["GroupRefineLvl"], "HeroEquipContrastTipsItemRefineLvl")
                item:getChildGO("ImgRefineLvl"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getBraceletsRefineLvlIconUrl(equipVo.refineLvl < lvl), true)
                table.insert(self.m_refineLvlObjList, item)
            end
        else
            gos["GroupRefineLvl"]:SetActive(false)
            gos["TextRefineTitle"]:GetComponent(ty.Text).text = ""
        end
    elseif (equipVo.type == PropsType.ORDER) then -- 序列物
        gos["NodeOrder"]:SetActive(true)
        gos["TextOrderTypeTitle"]:GetComponent(ty.Text).text = _TT(4061)
        gos["ImgSubType"]:GetComponent(ty.AutoRefImage):SetImg(bag.getOrderSubTypeIcon(equipVo.subType), false)
    else -- 普通芯片
        gos["NodeEquip"]:SetActive(true)
        -- local str = PropsEquipSubTypeStr[equipVo.subType]
        -- if(str)then
        --     gos["ImgPosBg"]:SetActive(true)
        --     gos["TextPos"]:GetComponent(ty.Text).text = bag.getEquipPosStr(equipVo.subType)
        --     -- gos["TextPosTitle"]:GetComponent(ty.Text).text = "部位："
        -- else
        --     gos["ImgPosBg"]:SetActive(false)
        --     gos["TextPosTitle"]:GetComponent(ty.Text).text = ""
        -- end

        -- 不按改造部位排列
        -- 更新改造的显示图
        -- 检测装备是否可改造
        -- local canRemakeCount = equipBuild.EquipRemakeManager:getRemakeCount(equipVo.tid)
        -- if (canRemakeCount > 0) then
        --     gos["GroupRemakeLvl"]:SetActive(true)
        --     -- gos["TextRemakeTitle"]:GetComponent(ty.Text).text = "改造："
        --     local remakePosAttrList, remakePosAttrDic = equipVo:getRemakeAttr()
        --     for i = 1, canRemakeCount do
        --         local color = ""
        --         local attrData = remakePosAttrDic[i]
        --         local img = gos["ImgRemake_" .. i]:GetComponent(ty.AutoRefImage)
        --         if (attrData == nil) then
        --             -- 灰
        --             color = "474C50FF"
        --         else
        --             local key = attrData.key
        --             local value = attrData.value
        --             local maxValue = attrData.maxValue
        --             if (value >= maxValue) then
        --                 -- 蓝
        --                 color = "00F6FFFF"
        --             else
        --                 -- 白
        --                 color = "474C50FF"
        --             end
        --         end

        --         local aaaaa = gs.ColorUtil.GetColor(color)
        --         img.color = gs.ColorUtil.GetColor(color)
        --     end
        -- else
        --     gos["GroupRemakeLvl"]:SetActive(false)
        --     -- gos["TextRemakeTitle"]:GetComponent(ty.Text).text = ""
        -- end
    end

    local function onLockHandler()
        local isLock = equipVo.isLock == 0 and 1 or 0
        GameDispatcher:dispatchEvent(EventName.REQ_PROPS_LOCK_CHANGE, {propsVo = equipVo, isLock = isLock})
    end
    self:addOnClick(gos["BtnLock"], onLockHandler)
    self:addOnClick(gos["BtnUnLock"], onLockHandler)
   
    gos["BtnLock"]:SetActive(equipVo.isLock == 1)
    gos["BtnUnLock"]:SetActive(equipVo.isLock == 0)

    local _recover = self.recover
    self.recover = function()
        _recover(self)
        self:removeOnClick(gos["BtnLock"], onLockHandler)
        self:removeOnClick(gos["BtnUnLock"], onLockHandler)
    end
end

function __updateBottom(self, gos, trans, equipVo, conEquipVo)
    local groupLink = gos["GroupLink"]
    local uiCodeList = equipVo.uiCodeList
    if (#uiCodeList <= 0) then
        groupLink:SetActive(false)
    else
        local _show = false
        for i = 1, #uiCodeList do
            local configVo = link.LinkManager:getLinkData(uiCodeList[i])
            if configVo then
                local isOpen = funcopen.FuncOpenManager:isOpen(uiCodeList[i], false)
                local item = SimpleInsItem:create(gos["LinkItem"], groupLink.transform, self:__getGoUniqueName("LinkItem"))
                item:getChildGO("GroupLinkLock"):SetActive(not isOpen)
                item:getChildGO("GroupLinkUnLock"):SetActive(isOpen)
                item:getChildGO("TextLinkNameUnLock"):GetComponent(ty.Text).text = configVo:getLinkName2()
                item:getChildGO("TextLinkNameLock"):GetComponent(ty.Text).text = configVo:getLinkName2()
                item:getChildGO("TextLinkTip"):GetComponent(ty.Text).text = _TT(4062)
                local function _clickLinkFun()
                    self:close()
                    gs.PopPanelManager.CloseAll()
                    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = uiCodeList[i]})
                end
                item:addUIEvent("ImgClick", _clickLinkFun)
                table.insert(self.m_btnGoList, item)
                _show = true
            end
        end
        groupLink:SetActive(_show)
    end

    self:__updateAttr(gos, trans, equipVo, conEquipVo)
    self:__updateSkill(gos, trans, equipVo)
    self:__updateTuPoAttachAttr(gos, trans, equipVo)
    self:__updateSuit_2(gos, trans, equipVo)
    self:__updateSuit_4(gos, trans, equipVo)
    self:__updateRemake(gos, trans, equipVo)
end

-- 更新基础属性
function __updateAttr(self, gos, trans, equipVo, conEquipVo)
    local mainAttrList, _ = equipVo:getMainAttr()
    for i = 1, #mainAttrList do
        local attrVo = mainAttrList[i]
        local attrTValue = attrVo.value
        local itemCloneGo = self:__getTxtGo("AttrItem")
        itemCloneGo.transform:SetParent(trans["ShowAttr"], false)
        local textAttr = itemCloneGo.transform:Find("TextAttr"):GetComponent(ty.Text)
        if textAttr then
            textAttr.text = AttConst.getName(attrVo.key)
        end
        local textAttrValue = textAttr.transform:Find("TextAttrValue"):GetComponent(ty.Text)
        if textAttrValue then

            if conEquipVo then
                local cStr = ""
                local _, cAttrDic = conEquipVo:getMainAttr()
                local cV = cAttrDic[attrVo.key]
                if cV ~= nil then
                    if cV > attrTValue then
                        cStr = HtmlUtil:color(string.format(" (%s%s)", HtmlUtil:bold("↓"), AttConst.getValueStr(attrVo.key, cV - attrTValue)), "D53529")
                    elseif cV < attrTValue then
                        cStr = HtmlUtil:color(string.format(" (%s%s)", HtmlUtil:bold("↑"), AttConst.getValueStr(attrVo.key, attrTValue - cV)), "03950D")
                    end
                end
                textAttrValue.text = "+" .. AttConst.getValueStr(attrVo.key, attrTValue) .. cStr
            else
                textAttrValue.text = "+" .. AttConst.getValueStr(attrVo.key, attrTValue)
            end
        end
    end

    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(trans["ShowAttr"]);
end

-- 更新突破附加属性
function __updateTuPoAttachAttr(self, gos, trans, equipVo)
    gos["TextTitleTuPoAttach"]:GetComponent(ty.Text).text = "附加属性" -- "附加属性"

    local attachAttrList, attachAttrDic = equipVo:getTuPoAttachAttr()
    if (attachAttrList and #attachAttrList > 0) then
        gos["GroupTuPoAttachAttr"]:SetActive(true)

        for i = 1, #attachAttrList do
            local attachAttrVo = attachAttrList[i]
            local itemCloneGo = self:__getTxtGo("TuPoAttachAttrItem")
            itemCloneGo.transform:SetParent(trans["ShowTuPoAttachAttr"], false)
            local textAttr = itemCloneGo.transform:Find("TextTuPoAttachAttr"):GetComponent(ty.Text)
            local textAttrTip = itemCloneGo.transform:Find("TextTuPoAttachAttr/TextTuPoAttachAttrTip"):GetComponent(ty.Text)
            local imgUnLockIcon = itemCloneGo.transform:Find("ImgTuPoAttachUnLockIcon").gameObject
            local imgLockIcon = itemCloneGo.transform:Find("ImgTuPoAttachLockIcon").gameObject

            local mImgTuPoAttachLockState = itemCloneGo.transform:Find("mImgTuPoAttachLockState"):GetComponent(ty.Image)
            local mTxtTuPoAttachLockState= itemCloneGo.transform:Find("mImgTuPoAttachLockState/mTxtTuPoAttachLockState"):GetComponent(ty.Text)

            if (attachAttrVo.isActive) then
                textAttr.text = HtmlUtil:color(AttConst.getName(attachAttrVo.key) .. HtmlUtil:color("+" .. AttConst.getValueStr(attachAttrVo.key, attachAttrVo.value), "03950dff"), "404548ff")
                textAttrTip.gameObject:SetActive(false)
                -- imgUnLockIcon:SetActive(true)
                mImgTuPoAttachLockState.color = gs.ColorUtil.GetColor("00a03cff")
                mTxtTuPoAttachLockState.text = _TT(1098)
                -- imgLockIcon:SetActive(false)
            else
                textAttr.text = HtmlUtil:color(AttConst.getName(attachAttrVo.key) .. "+" .. AttConst.getValueStr(attachAttrVo.key, attachAttrVo.value), "82898cff")
                textAttrTip.gameObject:SetActive(true)
                -- imgUnLockIcon:SetActive(false)
                -- imgLockIcon:SetActive(true)
                mImgTuPoAttachLockState.color = gs.ColorUtil.GetColor("404548ff")
                mTxtTuPoAttachLockState.text = _TT(44503)
                textAttrTip.text = string.substitute(_TT(1309), attachAttrVo.breakUpRank - equipVo.tuPoRank)
            end
        end
    else
        gos["GroupTuPoAttachAttr"]:SetActive(false)
    end

    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(trans["ShowTuPoAttachAttr"]);
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(trans["GroupTuPoAttachAttr"]);
end

-- 更新技能
function __updateSkill(self, gos, trans, equipVo)
    gos["GroupSkill"]:SetActive(false)
    local skillEffectList, skillEffectDic = equipVo:getSkillEffect()
    if (skillEffectList and #skillEffectList > 0) then
        gos["GroupSkill"]:SetActive(true)

        for i = 1, #skillEffectList do
            local skillVo = fight.SkillManager:getSkillRo(skillEffectList[i].skillId)
            gos["TextTitleSkill"]:GetComponent(ty.Text).text = skillVo:getName()
            local des = equip.EquipSkillManager:getSkillDes(equipVo, skillEffectList[i])
            local txtCloneGo = self:__getTxtGo("TextSkill")
            txtCloneGo.transform:SetParent(trans["ShowSkill"], false)
            txtCloneGo:GetComponent(ty.Text).text = des -- HtmlUtil:color(des, "bababaff")
        end
    end

    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(trans["ShowSkill"]);
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(trans["GroupSkill"]);
end

-- -- 更新套装属性
-- function __updateSuit(self, gos, trans, equipVo)
--     gos["TextTitleSuit"]:GetComponent(ty.Text).text = _TT(4063)

--     local equipConfigVo = equip.EquipManager:getEquipConfigVo(equipVo.tid)
--     local suitId = equipConfigVo.suitId
--     local suitConfigVo = equip.EquipSuitManager:getEquipSuitConfigVo(suitId)
--     if (not suitConfigVo or (suitConfigVo.suitSkillId_2 <= 0 and suitConfigVo.suitSkillId_4 <= 0)) then
--         gos["GroupSuit"]:SetActive(false)
--     else
--         gos["GroupSuit"]:SetActive(true)

--         local count = 0
--         local suitIdDic = equip.EquipManager:getEquipSuitIdDic()
--         local equipTidDic = suitIdDic[suitId]
--         local equipList = equipVo:getOtherRoleHeroEquipList()
--         if not equipList then
--             local heroVo = hero.HeroManager:getHeroVo(equipVo.heroId)
--             equipList = heroVo.equipList
--         end
--         if (equipList) then
--             for i = 1, #equipList do
--                 local propsVo = equipList[i]
--                 if (equipTidDic[propsVo.tid]) then
--                     count = count + 1
--                     if (count >= 4) then
--                         break
--                     end
--                 end
--             end
--         end

--         -- 2件套描述
--         if (suitConfigVo.suitSkillId_2 > 0) then
--             local colorStr
--             if (count >= 2) then
--                 colorStr = ColorUtil.BLUE_NUM
--             else
--                 colorStr = "82898cff"
--             end
--             local txtCloneGo = self:__getTxtGo("TextSuitDes")
--             txtCloneGo.transform:SetParent(trans["ShowSuit"], false)
--             -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color("套装" .. suitId .. "的2件套 [触发技能id:" .. suitConfigVo.suitSkillId_2 .. "]", colorStr)
--             txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(suitConfigVo.name .. _TT(4037), colorStr)

--             txtCloneGo = self:__getTxtGo("TextSuitDes")
--             txtCloneGo.transform:SetParent(trans["ShowSuit"], false)
--             -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color("技能id:" .. suitConfigVo.suitSkillId_2 .. "的描述", colorStr)
--             local skillVo = fight.SkillManager:getSkillRo(suitConfigVo.suitSkillId_2)
--             txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(skillVo:getDesc(), colorStr)
--         end
--         -- 4件套描述
--         if (suitConfigVo.suitSkillId_4 > 0) then
--             local colorStr
--             if (count >= 4) then
--                 colorStr = ColorUtil.BLUE_NUM
--             else
--                 colorStr = "82898cff"
--             end
--             local txtCloneGo = self:__getTxtGo("TextSuitDes")
--             txtCloneGo.transform:SetParent(trans["ShowSuit"], false)
--             -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color("套装" .. suitId .. "的4件套 [触发技能id:" .. suitConfigVo.suitSkillId_4 .. "]", colorStr)
--             txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(suitConfigVo.name .. _TT(4038), colorStr)

--             txtCloneGo = self:__getTxtGo("TextSuitDes")
--             txtCloneGo.transform:SetParent(trans["ShowSuit"], false)
--             -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color("技能id:" .. suitConfigVo.suitSkillId_4 .. "的描述", colorStr)
--             local skillVo = fight.SkillManager:getSkillRo(suitConfigVo.suitSkillId_4)
--             txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(skillVo:getDesc(), colorStr)
--         end
--     end
--     gs.LayoutRebuilder.ForceRebuildLayoutImmediate(trans["ShowSuit"]);
-- end

-- 更新2件套装属性
function __updateSuit_2(self, gos, trans, equipVo)
    gos["TextTitleSuit_2"]:GetComponent(ty.Text).text = _TT(4037) -- "2件套"

    local function _update(name)
        gos["GroupSuit_2"]:SetActive(name ~= nil)
        gos["GroupSuitTitle"]:SetActive(name ~= nil)
        gos["TextSuitTitle"]:GetComponent(ty.Text).text = name
    end
    local equipConfigVo = equip.EquipManager:getEquipConfigVo(equipVo.tid)
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
        local equipList = equipVo:getOtherRoleHeroEquipList()
        if not equipList then
            local heroVo = hero.HeroManager:getHeroVo(equipVo.heroId)
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

            local mImgTuPoAttachLockState = gos["mImgSuitDes2LockState"]:GetComponent(ty.Image)
            local mTxtTuPoAttachLockState= gos["mTxtSuitDes2LockState"]:GetComponent(ty.Text)

            local colorStr
            if (count >= 2) then
                colorStr = "404548ff"
                mImgTuPoAttachLockState.color = gs.ColorUtil.GetColor("00a03cff")
                mTxtTuPoAttachLockState.text = _TT(1098)

                -- gos["ImgSuitTitleBg_2"]:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("tips/tips_8.png"), true)
                gos["ImgSuitTitleIcon_2"]:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon4Path("common_5429.png"), true)
            else
                colorStr = "82898cff"

                mImgTuPoAttachLockState.color = gs.ColorUtil.GetColor("404548ff")
                mTxtTuPoAttachLockState.text = _TT(44503)

               
                -- gos["ImgSuitTitleBg_2"]:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("tips/tips_9.png"), true)
                gos["ImgSuitTitleIcon_2"]:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon4Path("common_5402.png"), true)
            end
            -- local txtCloneGo = self:__getTxtGo("TextSuitDes_2")
            -- txtCloneGo.transform:SetParent(trans["ShowSuit_2"], false)
            -- -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color("套装" .. suitId .. "的2件套 [触发技能id:" .. suitConfigVo.suitSkillId_2 .. "]", colorStr)
            -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(suitConfigVo.name .. "2件套", colorStr)
            local txtCloneGo = self:__getTxtGo("TextSuitDes_2")
            txtCloneGo.transform:SetParent(trans["ShowSuit_2"], false)
            -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color("技能id:" .. suitConfigVo.suitSkillId_2 .. "的描述", colorStr)
            local skillVo = fight.SkillManager:getSkillRo(suitConfigVo.suitSkillId_2)
            txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(skillVo:getDesc(), colorStr)
        end
    end

    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(trans["ShowSuit_2"])
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(trans["GroupSuit_2"])
end

-- 更新4件套装属性
function __updateSuit_4(self, gos, trans, equipVo)
    gos["TextTitleSuit_4"]:GetComponent(ty.Text).text = _TT(4038) -- "4件套"

    local equipConfigVo = equip.EquipManager:getEquipConfigVo(equipVo.tid)
    if (not equipConfigVo) then
        gos["GroupSuit_4"]:SetActive(false)
        return
    end
    local suitId = equipConfigVo.suitId
    local suitConfigVo = equip.EquipSuitManager:getEquipSuitConfigVo(suitId)
    if (not suitConfigVo or suitConfigVo.suitSkillId_4 <= 0) then
        gos["GroupSuit_4"]:SetActive(false)
    else
        gos["GroupSuit_4"]:SetActive(true)

        local count = 0
        local suitIdDic = equip.EquipManager:getEquipSuitIdDic()
        local equipTidDic = suitIdDic[suitId]
        local equipList = equipVo:getOtherRoleHeroEquipList()
        if not equipList then
            local heroVo = hero.HeroManager:getHeroVo(equipVo.heroId)
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

            local mImgTuPoAttachLockState = gos["mImgSuitDes2LockState"]:GetComponent(ty.Image)
            local mTxtTuPoAttachLockState= gos["mTxtSuitDes2LockState"]:GetComponent(ty.Text)

            local colorStr
            if (count >= 4) then
                mImgTuPoAttachLockState.color = gs.ColorUtil.GetColor("00a03cff")
                mTxtTuPoAttachLockState.text = _TT(1098)

                colorStr = "404548ff"
                -- gos["ImgSuitTitleBg_4"]:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("tips/tips_8.png"), true)
                gos["ImgSuitTitleIcon_4"]:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon4Path("common_5429.png"), true)
            else
                colorStr = "82898cff"
                mImgTuPoAttachLockState.color = gs.ColorUtil.GetColor("404548ff")
                mTxtTuPoAttachLockState.text = _TT(44503)


             
                -- gos["ImgSuitTitleBg_4"]:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("tips/tips_9.png"), true)
                gos["ImgSuitTitleIcon_4"]:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon4Path("common_5402.png"), true)
            end
            -- local txtCloneGo = self:__getTxtGo("TextSuitDes_4")
            -- txtCloneGo.transform:SetParent(trans["ShowSuit_4"], false)
            -- -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color("套装" .. suitId .. "的4件套 [触发技能id:" .. suitConfigVo.suitSkillId_4 .. "]", colorStr)
            -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(suitConfigVo.name .. "4件套", colorStr)
            local txtCloneGo = self:__getTxtGo("TextSuitDes_4")
            txtCloneGo.transform:SetParent(trans["ShowSuit_4"], false)
            -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color("技能id:" .. suitConfigVo.suitSkillId_4 .. "的描述", colorStr)
            local skillVo = fight.SkillManager:getSkillRo(suitConfigVo.suitSkillId_4)
            txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(skillVo:getDesc(), colorStr)
        end
    end

    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(trans["ShowSuit_4"]);
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(trans["GroupSuit_4"]);
end

-- 更新改造属性
function __updateRemake(self, gos, trans, equipVo)
    gos["TextTitleRemake"]:GetComponent(ty.Text).text = _TT(4039) -- "改造属性"

    gos["GroupRemake"]:SetActive(false)
    local remakePosAttrList, remakePosAttrDic = equipVo:getRemakeAttr()
    for pos, attrData in pairs(remakePosAttrDic) do
        local key = attrData.key
        local value = attrData.value
        local maxValue = attrData.maxValue
        local txtCloneGo = self:__getTxtGo("TextRemakeDes")
        local mImgTuPoAttachLockState = txtCloneGo.transform:Find("mImgRemakeLockState"):GetComponent(ty.Image)
        local mTxtTuPoAttachLockState = txtCloneGo.transform:Find("mImgRemakeLockState/mTxtRemakeLockState"):GetComponent(ty.Text)

        mImgTuPoAttachLockState.color = gs.ColorUtil.GetColor("00a03cff")
        mTxtTuPoAttachLockState.text = _TT(1098)

        local colorStr = ""
        if (value >= maxValue) then
            colorStr = ColorUtil.RED_NUM
          
        else
            colorStr = ColorUtil.BLUE_NUM
            -- mImgTuPoAttachLockState.color = gs.ColorUtil.GetColor("404548ff")
            -- mTxtTuPoAttachLockState.text = _TT(44503)
        end

  
        txtCloneGo.transform:SetParent(trans["ShowRemake"], false)
        txtCloneGo:GetComponent(ty.Text).text = AttConst.getName(key) .. "+" .. HtmlUtil:color(AttConst.getValueStr(key, maxValue), "03950dff")
        gos["GroupRemake"]:SetActive(true)
    end

    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(trans["GroupRemake"]);
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(trans["ShowRemake"]);
end

function __getGoUniqueName(self, goName)
    return self.__cname .. "_" .. goName
end

function __recoverBtnPool(self)
    if (self.m_btnGoList) then
        for _, btnItem in pairs(self.m_btnGoList) do
            btnItem:poolRecover()
        end
    end
    self.m_btnGoList = {}
end

function __getTxtGo(self, goName)
    local uniqueName = self:__getGoUniqueName(goName)
    local go = gs.GOPoolMgr:GetOther(uniqueName)
    if (not go or gs.GoUtil.IsGoNull(go)) then
        if (self.m_childGos and self.m_childGos[goName]) then
            go = gs.GameObject.Instantiate(self.m_childGos[goName])
        end
    end
    go:SetActive(true)
    self.m_txtGoDic[go:GetHashCode()] = {go = go, uniqueName = uniqueName}
    return go
end

function __recoverTxtGoDic(self)
    if (self.m_txtGoDic) then
        for hashCode, data in pairs(self.m_txtGoDic) do
            gs.GOPoolMgr:RecoverOther(data.uniqueName, data.go)
        end
    end
    self.m_txtGoDic = {}
end

function __getBtnGo(self, goName, type)
    local uniqueName = self:__getGoUniqueName(goName)
    local go = gs.GOPoolMgr:GetOther(uniqueName)
    if (not go or gs.GoUtil.IsGoNull(go)) then
        if (self.m_childGos and self.m_childGos[goName]) then
            go = gs.GameObject.Instantiate(self.m_childGos[goName])
        end
    end
    self.m_btnGoDic[go:GetHashCode()] = {go = go, uniqueName = uniqueName, type = type}
    return go
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

function __onUnloadClickHandler(self)
    GameDispatcher:dispatchEvent(EventName.REQ_HERO_DEL_EQUIP, {equipVo = self.m_equipVo})
    self:close()
end

function __onBuildClickHandlerDef(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_EQUIP_BUILD_PANEL, {equipVo = self.m_equipVo})
    self:close()
end

function __onBuildClickHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_EQUIP_BUILD_PANEL, {equipVo = self.m_equipVo2})
    self:close()
end

function __onReplaceClickHandler(self)
    hero.HeroEquipManager:dispatchEvent(hero.HeroEquipManager.HERO_BAG_EQUIP_SELECT, {equipVo = self.m_equipVo2})
    self:close()
end

function __updateHeroHead(self)
    local head = self.m_Gos[2]["GroupHead"]
    if self.m_equipVo2.heroId ~= 0 then
        head:SetActive(true)
        local img = self.m_Gos[2]["ImgHeroHead"]:GetComponent(ty.AutoRefImage)
        local heroVo = hero.HeroManager:getHeroVo(self.m_equipVo2.heroId)
        img:SetImg(UrlManager:getHeroHeadUrl(heroVo.tid), false)
    else
        head:SetActive(false)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(4063):	"套装"
	语言包: _TT(4062):	"<未解锁>"
	语言包: _TT(4061):	"类型："
	语言包: _TT(4038):	"4件套"
	语言包: _TT(4037):	"2件套"
	语言包: _TT(1309):	"突破{0}次解锁"
]]
