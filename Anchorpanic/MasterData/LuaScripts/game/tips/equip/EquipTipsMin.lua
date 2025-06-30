module("tips.EquipTipsMin", Class.impl(View))

destroyTime = 0
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
UIRes = UrlManager:getUIPrefabPath("tips/EquipTipsMin.prefab")

BtnType = {
    -- 穿装备
    LOAD_EQUIP = 1,
    -- 脱装备
    UNLOAD_EQUIP = 2,
    -- 培养
    BUILD_EQUIP = 3,
    -- 更换
    REPLACE_EQUIP = 4,
    -- 培养2(大的)
    BUILD_EQUIP_2 = 100
}

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
end

--析构函数
function dtor(self)
    super.dtor(self)
end

--初始化UI
function configUI(self)
    super.configUI(self)

    self.mEquipNode = self:getChildTrans("EquipNode")
    self.mGroupRemakeLvl = self:getChildGO("GroupRemakeLvl")
end
function active(self, args)
    super.active(self, args)

    if self.mEquipGrid then
        self.mEquipGrid:poolRecover()
        self.mEquipGrid = nil
    end

    self.mEquipGrid = EquipGrid:poolGet()
    self.mEquipGrid:setData(args.propsVo,self.mEquipNode)
    self.mEquipGrid:setClickEnable(false)
    self.mEquipGrid:setShowLockState(false)
    self.mEquipGrid:setShowHeroIcon(false)
    self.mEquipGrid:setIsNew(false)
    
    self.m_equipVo = args.propsVo
    self.m_btnTypeList = args.typeList
    self.m_callFun = args.clickPos.callFun
    --self:__tempAction(args.clickPos)
    self:__updateView()

    if (self.m_equipVo) then
        self.m_equipVo:addEventListener(props.PropsVo.UPDATE, self.__updateView, self)

    end

end

function deActive(self)
    super.deActive(self)

    if self.mEquipGrid then
        self.mEquipGrid:poolRecover()
        self.mEquipGrid = nil
    end
  
    self.m_childTrans["Content"].anchoredPosition = gs.Vector2.zero

    if (self.m_equipVo) then
        self.m_equipVo:removeEventListener(self.m_equipVo.UPDATE_EQUIP_DETAIL_DATA, self.__updateView, self)
        self.m_equipVo:removeEventListener(props.PropsVo.UPDATE, self.__updateView, self)
    end
    if (self.m_callFun) then
        self.m_callFun()
    end
end

-- 初始化数据
function initData(self)
    self:__recoverTxtGoDic()
    self:__recoverBtnGoDic()

    -- 是否显示获取途径
    self.m_isShowLink = true
    -- 数据vo
    self.m_equipVo = nil
    -- 按钮类型列表
    self.m_btnTypeList = nil
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.m_childGos["TextLinkTitle"]:GetComponent(ty.Text).text = _TT(25020) -- "获取途径"
    self:setBtnLabel(self.m_childGos["BtnUse"], 4029, "使用")
    self:setBtnLabel(self.m_childGos["BtnBuild"], 4321, "培养")
    self:setBtnLabel(self.m_childGos["BtnReplace"], 4323, "替换")
    self:setBtnLabel(self.m_childGos["BtnLoad"], 4324, "穿戴")
    self:setBtnLabel(self.m_childGos["BtnUnload"], 4327, "卸下")
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
    self.m_txtGoDic[go:GetHashCode()] = { go = go, uniqueName = uniqueName }
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
    self.m_btnGoDic[go:GetHashCode()] = { go = go, uniqueName = uniqueName, type = type }
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

function __updateView(self)
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
    self:__updateGuide()
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
    -- self.m_childGos["ImgIcon"]:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPropsIconUrl(self.m_equipVo.tid), false)
    -- self.m_childGos["ImgColor"]:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getEquipBgUrl(self.m_equipVo.color), false)
    -- self.m_childGos["TextLvl"]:GetComponent(ty.Text).text = self.m_equipVo.strengthenLvl and "LV." .. self.m_equipVo.strengthenLvl or ""
    
    self.m_childGos["NodeEquip"]:SetActive(false)
    self.m_childGos["NodeBracelets"]:SetActive(false)
    self.m_childGos["NodeOrder"]:SetActive(false)
    if (self.m_equipVo.subType == PropsEquipSubType.SLOT_7) then  -- 手环
        self.m_childGos["NodeBracelets"]:SetActive(true)
        self:__resetRefineObjList()
        local isCanRefine = braceletsBuild.BraceletsRefineManager:isCanRefine(self.m_equipVo.tid)
        if (isCanRefine) then
            self.m_childGos["GroupRefineLvl"]:SetActive(true)

            local maxRefineLvl = braceletsBuild.BraceletsRefineManager:getMaxRefineLvl(self.m_equipVo.tid)
            for lvl = 1, maxRefineLvl do
                local item = SimpleInsItem:create(self.m_childGos["ItemRefineLvl"], self.m_childTrans["GroupRefineLvl"])
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
    elseif (self.m_equipVo.type == PropsType.ORDER) then          -- 序列物
        self.m_childGos["NodeOrder"]:SetActive(true)
        self.m_childGos["TextOrderTypeTitle"]:GetComponent(ty.Text).text = _TT(4061)
        self.m_childGos["ImgSubType"]:GetComponent(ty.AutoRefImage):SetImg(bag.getOrderSubTypeIcon(self.m_equipVo.subType), false)
    else                                                        -- 普通芯片
        self.m_childGos["NodeEquip"]:SetActive(true)
        local str = PropsEquipSubTypeStr[self.m_equipVo.subType]
        -- if (str) then
        --     --self.m_childGos["ImgPosBg"]:SetActive(true)
        --     --self.m_childGos["TextPos"]:GetComponent(ty.Text).text = bag.getEquipPosStr(self.m_equipVo.subType)
        -- else
        --     --self.m_childGos["ImgPosBg"]:SetActive(false)
        -- end

        -- 不按改造部位排列
        -- 更新改造的显示图
        -- 检测装备是否可改造
        -- local canRemakeCount = equipBuild.EquipRemakeManager:getRemakeCount(self.m_equipVo.tid)
        -- if (canRemakeCount > 0) then
        --     self.m_childGos["GroupRemakeLvl"]:SetActive(true)
        --     local remakePosAttrList, remakePosAttrDic = self.m_equipVo:getRemakeAttr()
        --     for i = 1, canRemakeCount do
        --         local color = ""
        --         local attrData = remakePosAttrDic[i]
        --         local img = self.m_childGos["ImgRemake_" .. i]:GetComponent(ty.AutoRefImage)
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
        --     self.m_childGos["GroupRemakeLvl"]:SetActive(false)
        -- end
    end

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
        --self.m_childGos["ImgShowLock"]:SetActive(self.m_equipVo.isLock == 1)
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
    -- self:__updateNuclearAttr()
    -- self:__updateSuit()
    self:__updateSuit_2()
    self:__updateSuit_4()
    self:__updateRemake()
    self:__updateBtnList()

    --gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["BtnContent"]);
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

    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["ShowAttr"]);
end

-- 更新突破附加属性
function __updateTuPoAttachAttr(self)
    self.m_childGos["TextTitleTuPoAttach"]:GetComponent(ty.Text).text = "附加属性"--"附加属性"

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
            local textAttrTip = itemCloneGo.transform:Find("TextTuPoAttachAttr/TextTuPoAttachAttrTip"):GetComponent(ty.Text)
            local imgUnLockIcon = itemCloneGo.transform:Find("ImgTuPoAttachUnLockIcon").gameObject
            local imgLockIcon = itemCloneGo.transform:Find("ImgTuPoAttachLockIcon").gameObject

            local mImgTuPoAttachLockState = itemCloneGo.transform:Find("mImgTuPoAttachLockState"):GetComponent(ty.Image)
            local mTxtTuPoAttachLockState= itemCloneGo.transform:Find("mImgTuPoAttachLockState/mTxtTuPoAttachLockState"):GetComponent(ty.Text)

            if (attachAttrVo.isActive) then
                textAttr.text = HtmlUtil:color(AttConst.getName(attachAttrVo.key) .. HtmlUtil:color("+" .. AttConst.getValueStr(attachAttrVo.key, attachAttrVo.value), "03950dff"), "404548ff")
                --textAttrTip.text = string.substitute(_TT(1309), attachAttrVo.breakUpRank - 1)
                textAttrTip.gameObject:SetActive(false)
                mImgTuPoAttachLockState.color = gs.ColorUtil.GetColor("00a03cff")
                mTxtTuPoAttachLockState.text = _TT(1098)
            else
                textAttr.text = HtmlUtil:color(AttConst.getName(attachAttrVo.key) .. "+" .. AttConst.getValueStr(attachAttrVo.key, attachAttrVo.value), "82898cff")
                textAttrTip.gameObject:SetActive(true)
                textAttrTip.text = string.substitute(_TT(1309), attachAttrVo.breakUpRank - 1) --显示固定需要突破次数

                mImgTuPoAttachLockState.color = gs.ColorUtil.GetColor("404548ff")
                mTxtTuPoAttachLockState.text = _TT(44503)
            end
        end
    else
        self.m_childGos["GroupTuPoAttachAttr"]:SetActive(false)
    end

    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["ShowTuPoAttachAttr"]);
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
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["ShowSkill"]);
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
                colorStr = "82898cff"

             
            end
            local txtCloneGo = self:__getTxtGo("TextSuitDes")

         

            txtCloneGo.transform:SetParent(self.m_childTrans["ShowSuit"], false)
            -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color("套装" .. suitId .. "的2件套 [触发技能id:" .. suitConfigVo.suitSkillId_2 .. "]", colorStr)
            txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(suitConfigVo.name .. _TT(4037), colorStr)

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
                colorStr = "82898cff"
            end
            local txtCloneGo = self:__getTxtGo("TextSuitDes")
            txtCloneGo.transform:SetParent(self.m_childTrans["ShowSuit"], false)
            -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color("套装" .. suitId .. "的4件套 [触发技能id:" .. suitConfigVo.suitSkillId_4 .. "]", colorStr)
            txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(suitConfigVo.name .. _TT(4038), colorStr)

            txtCloneGo = self:__getTxtGo("TextSuitDes")
            txtCloneGo.transform:SetParent(self.m_childTrans["ShowSuit"], false)
            -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color("技能id:" .. suitConfigVo.suitSkillId_4 .. "的描述", colorStr)
            local skillVo = fight.SkillManager:getSkillRo(suitConfigVo.suitSkillId_4)
            txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(skillVo:getDesc(), colorStr)
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
        -- self.m_childGos["TextSuitTitle"]:GetComponent(ty.Text).text = name
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

            local mImgTuPoAttachLockState = self.m_childGos["mImgSuitDes2LockState"]:GetComponent(ty.Image)
            local mTxtTuPoAttachLockState= self.m_childGos["mTxtSuitDes2LockState"]:GetComponent(ty.Text)

            local colorStr
            if (count >= 2) then
                colorStr = "404548ff"
                mImgTuPoAttachLockState.color = gs.ColorUtil.GetColor("00a03cff")
                mTxtTuPoAttachLockState.text = _TT(1098)

                self.m_childGos["ImgSuitTitleIcon_2"]:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon4Path("common_5429.png"), true)
            else
                mImgTuPoAttachLockState.color = gs.ColorUtil.GetColor("404548ff")
                mTxtTuPoAttachLockState.text = _TT(44503)

                colorStr = "82898cff"
                self.m_childGos["ImgSuitTitleIcon_2"]:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon4Path("common_5402.png"), true)
            end
            local txtCloneGo = self:__getTxtGo("TextSuitDes_2")
            txtCloneGo.transform:SetParent(self.m_childTrans["ShowSuit_2"], false)
            local skillVo = fight.SkillManager:getSkillRo(suitConfigVo.suitSkillId_2)
            txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(skillVo:getDesc(), colorStr)
        end
    end

    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["ShowSuit_2"])
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

            local mImgTuPoAttachLockState = self.m_childGos["mImgSuitDes4LockState"]:GetComponent(ty.Image)
            local mTxtTuPoAttachLockState= self.m_childGos["mTxtSuitDes4LockState"]:GetComponent(ty.Text)

            local colorStr
            if (count >= 4) then
                colorStr = "404548ff"

                mImgTuPoAttachLockState.color = gs.ColorUtil.GetColor("00a03cff")
                mTxtTuPoAttachLockState.text = _TT(1098)

            else
                colorStr = "82898cff"

                mImgTuPoAttachLockState.color = gs.ColorUtil.GetColor("404548ff")
                mTxtTuPoAttachLockState.text = _TT(44503)

            end

            local txtCloneGo = self:__getTxtGo("TextSuitDes_4")
            txtCloneGo.transform:SetParent(self.m_childTrans["ShowSuit_4"], false)
            local skillVo = fight.SkillManager:getSkillRo(suitConfigVo.suitSkillId_4)
            txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(skillVo:getDesc(), colorStr)
        end
    end

    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["ShowSuit_4"]);
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
        local mImgTuPoAttachLockState = txtCloneGo.transform:Find("mImgRemakeLockState"):GetComponent(ty.Image)
        local mTxtTuPoAttachLockState = txtCloneGo.transform:Find("mImgRemakeLockState/mTxtRemakeLockState"):GetComponent(ty.Text)
        mImgTuPoAttachLockState.color = gs.ColorUtil.GetColor("00a03cff")
        mTxtTuPoAttachLockState.text = _TT(1098)
        local colorStr = ""
        if (value >= maxValue) then
            -- mImgTuPoAttachLockState.color = gs.ColorUtil.GetColor("00a03cff")
            -- mTxtTuPoAttachLockState.text = _TT(1098)

            colorStr = ColorUtil.RED_NUM
        else
            -- mImgTuPoAttachLockState.color = gs.ColorUtil.GetColor("404548ff")
            -- mTxtTuPoAttachLockState.text = _TT(44503)
            colorStr = ColorUtil.BLUE_NUM
        end

     

        txtCloneGo.transform:SetParent(self.m_childTrans["ShowRemake"], false)

        txtCloneGo:GetComponent(ty.Text).text = AttConst.getName(key) .."+".. HtmlUtil:color(AttConst.getValueStr(key, value), "03950dff")
        self.m_childGos["GroupRemake"]:SetActive(true)
    end

    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["GroupRemake"]);
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["ShowRemake"]);
end

function __updateBtnList(self)
    gs.TransQuick:SizeDelta02(self.m_childTrans["GameAction"], 642)
    gs.TransQuick:SizeDelta02(self.m_childTrans["GroupBottom"], 524)

    self.m_childGos["BtnBuild"]:SetActive(false)
    self.m_childGos["BtnLoad"]:SetActive(false)
    self.m_childGos["BtnUnload"]:SetActive(false)
    self.m_childGos["BtnReplace"]:SetActive(false)

    if (self.m_btnTypeList and #self.m_btnTypeList > 0) then
        for i = 1, #self.m_btnTypeList do
            local btnType = self.m_btnTypeList[i]
            local btn = nil
            if (btnType == tips.EquipTips.BtnType.BUILD_EQUIP) then
                btn = self.m_childGos["BtnBuild"]
            elseif (btnType == tips.EquipTips.BtnType.LOAD_EQUIP) then
                btn = self.m_childGos["BtnLoad"]
            elseif (btnType == tips.EquipTips.BtnType.UNLOAD_EQUIP) then
                btn = self.m_childGos["BtnUnload"]
            elseif (btnType == tips.EquipTips.BtnType.REPLACE_EQUIP) then
                btn = self.m_childGos["BtnReplace"]
            end
            local function _clickEquipBtn()
                if (btnType == tips.EquipTips.BtnType.BUILD_EQUIP) or (btnType == tips.EquipTips.BtnType.BUILD_EQUIP_2) then         -- 培养
                    GameDispatcher:dispatchEvent(EventName.OPEN_EQUIP_BUILD_PANEL, { equipVo = self.m_equipVo })
                elseif (btnType == tips.EquipTips.BtnType.LOAD_EQUIP) then      -- 穿戴
                    hero.HeroEquipManager:dispatchEvent(hero.HeroEquipManager.HERO_BAG_EQUIP_SELECT, { equipVo = self.m_equipVo })
                elseif (btnType == tips.EquipTips.BtnType.UNLOAD_EQUIP) then    -- 卸下
                    GameDispatcher:dispatchEvent(EventName.REQ_HERO_DEL_EQUIP, { equipVo = self.m_equipVo })
                elseif (btnType == tips.EquipTips.BtnType.REPLACE_EQUIP) then     -- 更换
                    hero.HeroEquipManager:dispatchEvent(hero.HeroEquipManager.HERO_BAG_EQUIP_CHANGE, {  pos =  self.m_equipVo.subType, equipVo = self.m_equipVo })
                end
                self:close()
            end
            btn:SetActive(true)
            self:addUIEvent(btn, _clickEquipBtn)
        end
    end
end

-- 在资源销毁前，对需要回收的资源进行回收处理
function recover(self)
    super.recover(self)
    self:initData()
end



function __updateGuide(self)
    if self.m_equipVo.tid == 5011 then
        self:setGuideTrans("Equip_Load_4", self.m_childTrans["BtnLoad"])
    elseif self.m_equipVo.tid == 5012 then
        self:setGuideTrans("Equip_Load_7", self.m_childTrans["BtnLoad"])
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(4063):	"套装"
	语言包: _TT(4062):	"<未解锁>"
	语言包: _TT(4061):	"类型："
	语言包: _TT(1316):	"套装属性"
	语言包: _TT(4038):	"4件套"
	语言包: _TT(4037):	"2件套"
]]
