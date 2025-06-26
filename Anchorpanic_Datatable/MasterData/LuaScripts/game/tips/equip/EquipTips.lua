module("tips.EquipTips", Class.impl(tips.BaseTips))

UIRes = UrlManager:getUIPrefabPath("tips/EquipTips.prefab")

panelType = 2 -- 窗口类型 1 全屏 2 弹窗
destroyTime = -1 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isBlur = 0 -- 是否

BtnType = {-- 穿装备
    LOAD_EQUIP = 1, -- 脱装备
    UNLOAD_EQUIP = 2, -- 培养
    BUILD_EQUIP = 3, -- 更换
    REPLACE_EQUIP = 4, -- 培养2(大的)
    BUILD_EQUIP_2 = 100
}

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 520)
end

-- 析构函数
function dtor(self)
    super.dtor(self)
end

-- 初始化UI
function configUI(self)
    super.configUI(self)
    self.mClose = self:getChildGO("mBtnClose")

    self.mGroupRemakeLvl = self:getChildGO("GroupRemakeLvl")
    self.mLinkItem = self:getChildGO("mLinkItem")

    self.mTxtNotTips = self:getChildGO("mTxtNotTips"):GetComponent(ty.Text)
end

function active(self, args)
    super.active(self, args)
    if (self.base_childGos["gImgBg2"]) then
        self.base_childGos["gImgBg2"]:SetActive(true)
    end

    self.m_equipVo = args.propsVo
    self.m_btnTypeList = args.typeList
    if args.clickPos then
        self.m_callFun = args.clickPos.callFun
    end

    if args.ableToCultivate ~= nil then
        self:__checkIsAbleToCul()
    else
        self:getChildGO("mBtnGoToCul"):SetActive(false)
    end

    self:__tempAction(args.clickPos)
    self:__updateView()

    if (self.m_equipVo) then
        self.m_equipVo:addEventListener(props.PropsVo.UPDATE, self.__updateView, self)
    end

end

function addAllUIEvent(self)
    self:addUIEvent(self:getChildGO("mBtnGoToCul"), self.goToCultivate)
    self:addUIEvent(self.mClose, self.onCloseHandler)
end

function onCloseHandler(self)
    self:close()
end

function goToCultivate(self)
    if self.m_equipVo then
        if self.m_equipVo.subType == PropsEquipSubType.SLOT_7 then
            GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.HeroBraceletsStrengthen, param = { equipVo = self.m_equipVo, heroId = self.m_equipVo.heroId } })
        else
            GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.HeroEquipStrengthen, param = self.m_equipVo })
        end
        self:close()
    end
end

function deActive(self)
    super.deActive(self)
    self.m_childTrans["Content"].anchoredPosition = gs.Vector2.zero
    GameDispatcher:removeEventListener(EventName.UPDATE_PROPS_LOCK_STATE, self.updateLockState, self)
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

--[[    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.m_childGos["TextLinkTitle"]:GetComponent(ty.Text).text = _TT(25020) -- "获取途径"
    self:setBtnLabel(self.m_childGos["BtnUse"], 4029, "使用")
    self:setBtnLabel(self.m_childGos["BtnBuild"], 4321, "培养")
    self:setBtnLabel(self.m_childGos["BtnReplace"], 4323, "替换")
    self:setBtnLabel(self.m_childGos["BtnLoad"], 4324, "穿戴")
    self:setBtnLabel(self.m_childGos["BtnUnLoad"], 4327, "卸下")
    self:setBtnLabel(self:getChildGO("mBtnGoToCul"), 3516, "强化")
    self.m_childGos["mTxtNotTips"]:GetComponent(ty.Text).text = _TT(4399)
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

-- 功能开启Id 检查养成按钮
function __checkIsAbleToCul(self)
    if self.m_equipVo then
        if self.m_equipVo.subType == PropsEquipSubType.SLOT_7 then
            if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_BRACELETS_STRENGTHEN, false) then
                self:getChildGO("mBtnGoToCul"):SetActive(true)
            else
                self:getChildGO("mBtnGoToCul"):SetActive(false)
            end
        else
            if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_EQUIP_STRENGTHEN, false) then
                self:getChildGO("mBtnGoToCul"):SetActive(true)
            else
                self:getChildGO("mBtnGoToCul"):SetActive(false)
            end
        end
    end
end

function updateLockState(self,args)
    if self.m_equipVo.id == args.id then
        self.m_equipVo:setLockState(args.lock)
    end
    self:__updateTop()
end

function __updateView(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_PROPS_LOCK_STATE, self.updateLockState, self)
    self.m_equipVo:removeEventListener(self.m_equipVo.UPDATE_EQUIP_DETAIL_DATA, self.__updateView, self)
    
    GameDispatcher:addEventListener(EventName.UPDATE_PROPS_LOCK_STATE, self.updateLockState, self)
    local totalAttrList, totalAttrDic = self.m_equipVo:getTotalAttr()
    if (totalAttrList == nil and totalAttrDic == nil) then
        self.m_equipVo:addEventListener(self.m_equipVo.UPDATE_EQUIP_DETAIL_DATA, self.__updateView, self)
        return
    end

    self:__recoverTxtGoDic()
    self:__recoverBtnGoDic()
    self:__recoverBtnPool()
    --更新左侧图标
    self:__updateLeftIcon()
    self:__updateTop()
    self:__updateBottom()
    self:__updateGuide()
end

--更新左侧图标
function __updateLeftIcon(self)

    --手环图标
    if self.m_equipVo.subType == PropsEquipSubType.SLOT_7 then
        self.m_childGos["mImgEquipIcon"]:SetActive(true)
        self.m_childGos["mImgBraceletBg"]:SetActive(true)
        if not self.mImgBraceletIcon then
            self.mImgBraceletIcon = self.m_childGos["mImgBraceletIcon"]:GetComponent(ty.AutoRefImage)
        end

        if not self.mImgBraceletBg then
            self.mImgBraceletBg = self.m_childGos["mImgBraceletBg"]:GetComponent(ty.AutoRefImage)
        end

        self.mImgBraceletIcon:SetImg(UrlManager:getPropsIconUrl(self.m_equipVo.tid), false)
        --self.mImgBraceletBg:SetImg(UrlManager:getNraceletColorUrl(self.m_equipVo.color), false)

        -- local vo = self.m_propsVo and self.m_propsVo or self.m_equipVo
        local skillEffectList, skillEffectDic = self.m_equipVo:getSkillEffect()
        if skillEffectList then
            if next(skillEffectList) then
                self.m_childGos["mRefineGroup"]:SetActive(true)
                for i = 1, 6 do
                    self.m_childGos["mImgRefine" .. i]:SetActive(i <= self.m_equipVo.refineLvl)
                end
            else
                self.m_childGos["mRefineGroup"]:SetActive(false)
            end
        else
            self.m_childGos["mRefineGroup"]:SetActive(false)
        end

    else
        --模组图标
        self.m_childGos["mImgEquipIcon"]:SetActive(true)
        self.m_childGos["mImgBraceletBg"]:SetActive(false)
        if not self.mImgEquipIcon then
            self.mImgEquipIcon = self.m_childGos["mImgEquipIcon"]:GetComponent(ty.AutoRefImage)
        end
        self.mImgEquipIcon:SetImg(UrlManager:getPropsIconUrl(self.m_equipVo.tid), false)

        local remakePosAttrList, remakePosAttrDic = self.m_equipVo:getRemakeAttr()
        if remakePosAttrList then
            if next(remakePosAttrList) then
                self.m_childGos["mRemakeGroup"]:SetActive(true)
                for i = 1, 2 do
                    self.m_childGos["mImgRemake" .. i]:SetActive(i <= #remakePosAttrList)
                end
            else
                self.m_childGos["mRemakeGroup"]:SetActive(false)
            end
        else
            self.m_childGos["mRemakeGroup"]:SetActive(false)
        end
    end

    -- 左侧品质泛光
    if not self.mImgLeftColorBg then
        self.mImgLeftColorBg = self.m_childGos["mImgLeftColorBg"]:GetComponent(ty.AutoRefImage)
    end
    self.mImgLeftColorBg.color = gs.ColorUtil.GetColor(ColorUtil:getPropBgColor(self.m_equipVo.color))

end

function __updateTop(self)
    self.mTxtName = self.m_childGos["TextName"]:GetComponent(ty.Text)
    -- 非限时道具
    if (not self.m_equipVo.expiredTime or self.m_equipVo.expiredTime <= 0) then
        self.mTxtName.text = self.m_equipVo:getName()
    end
    if (self.m_equipVo.subType == PropsEquipSubType.SLOT_7) then -- 手环
        self.m_childGos["NodeBracelets"]:SetActive(true)
        self.m_childGos["NodeEquip"]:SetActive(false)
        self:__resetRefineObjList()
    else -- 普通芯片
        self.m_childGos["NodeEquip"]:SetActive(true)
        self.m_childGos["NodeBracelets"]:SetActive(false)
        local str = PropsEquipSubTypeStr[self.m_equipVo.subType]
        if (str) then
            self.m_childGos["mImgEquipPosBg"]:SetActive(true)
            if not self.mImgEquipPosBg then
                self.mImgEquipPosBg = self:getChildGO("mImgEquipPosBg"):GetComponent(ty.AutoRefImage)
            end
            self.mImgEquipPosBg:SetImg(UrlManager:getEquipSlot(self.m_equipVo.subType), false)
            --  self.m_childGos["TextPos"]:GetComponent(ty.Text).text = bag.getEquipPosStr(self.m_equipVo.subType)
        else
            self.m_childGos["mImgEquipPosBg"]:SetActive(false)
        end
    end

    if self.m_equipVo.subType ~= PropsEquipSubType.SLOT_7 then
        self.m_childGos["mImgPlan"]:SetActive(self.m_equipVo.id and equipBuild.EquipPlanManager:isInEquipPlan(self.m_equipVo))
    else
        self.m_childGos["mImgPlan"]:SetActive(false)
    end

    local equipList = self.m_equipVo:getOtherRoleHeroEquipList()
    if equipList then

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
    local groupLink = self:getChildGO("GroupLink")
    local uiCodeList = self.m_equipVo.uiCodeList
    if (#uiCodeList <= 0) then
        groupLink:SetActive(false)
    else
        local _show = false
        for i = 1, #uiCodeList do
            local configVo = link.LinkManager:getLinkData(uiCodeList[i])
            if configVo then
                local isOpen = funcopen.FuncOpenManager:isOpen(uiCodeList[i], false)
                local item = SimpleInsItem:create(self.mLinkItem, groupLink.transform, self:__getGoUniqueName("LinkItem"))
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

    self:__updateBaseAttr()
    self:__updateEmpowerAttr()
    self:__updateSkill()
    self:__updateTuPoAttachAttr()

    self:__updateSuit_2()
    self:__updateSuit_4()
    self:__updateRemake()
    self:__updateBtnList()

    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["BtnContent"]);
end

-- 更新基础属性
function __updateBaseAttr(self)

    local mainAttrList, _ = self.m_equipVo:getMainAttr()
    if next(mainAttrList) then
        for i = 1, #mainAttrList do
            local attrVo = mainAttrList[i]
            local attrTValue = attrVo.value
            local itemCloneGo = self:__getTxtGo("AttrItem")
            itemCloneGo.transform:SetParent(self.m_childTrans["BaseAttrContent"], false)

            local textAttr = itemCloneGo.transform:Find("TextAttr"):GetComponent(ty.Text)
            if textAttr then
                textAttr.text = AttConst.getName(attrVo.key)
            end
            local textAttrValue = textAttr.transform:Find("TextAttrValue"):GetComponent(ty.Text)
            if textAttrValue then
                textAttrValue.text = "+" .. AttConst.getValueStr(attrVo.key, attrTValue)
            end
            -- end
        end
    else
        local equipConfigVo = equip.EquipManager:getEquipConfigVo(self.m_equipVo.tid)
        local attrList = equipConfigVo.defaultAttrList
        for i = 1, #attrList do
            local vo = attrList[i]
            local itemCloneGo = self:__getTxtGo("AttrItem")
            itemCloneGo.transform:SetParent(self.m_childTrans["BaseAttrContent"], false)
            local textAttr = itemCloneGo.transform:Find("TextAttr"):GetComponent(ty.Text)
            if textAttr then
                textAttr.text = AttConst.getName(vo[1])
            end
            local textAttrValue = textAttr.transform:Find("TextAttrValue"):GetComponent(ty.Text)
            if textAttrValue then
                textAttrValue.text = "+" .. AttConst.getValueStr(vo[1], vo[2])
            end
        end
    end

    self.mTxtNotTips.gameObject:SetActive(#mainAttrList==0 and 
    self.m_equipVo.subType ~= PropsEquipSubType.SLOT_7)

    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["BaseAttrContent"]);
end

-- 更新赋能属性
function __updateEmpowerAttr(self)
    local empowerAttrList = self.m_equipVo:getBracelet_remake_attr()
    self.m_childGos["EmpowerGroupAttr"]:SetActive(not table.empty(empowerAttrList))
    for i = 1, #empowerAttrList do
        local key = empowerAttrList[i].attrType
        local value = empowerAttrList[i].attrValue

        local itemCloneGo = self:__getTxtGo("AttrItem")
        itemCloneGo.transform:SetParent(self.m_childTrans["EmpowerAttrContent"], false)

        local textAttr = itemCloneGo.transform:Find("TextAttr"):GetComponent(ty.Text)
        if textAttr then
            textAttr.text = AttConst.getName(key)
        end
        local textAttrValue = textAttr.transform:Find("TextAttrValue"):GetComponent(ty.Text)
        if textAttrValue then
            textAttrValue.text = "+" .. AttConst.getValueStr(key, value)
        end
    end
end

-- 更新突破附加属性
function __updateTuPoAttachAttr(self)
    self.m_childGos["TextTitleTuPoAttach"]:GetComponent(ty.Text).text = "附加属性" -- "附加属性"

    local attachAttrList, attachAttrDic = self.m_equipVo:getTuPoAttachAttr()
    if (attachAttrList and #attachAttrList > 0) then
        self.m_childGos["GroupTuPoAttachAttr"]:SetActive(true)

        for i = 1, #attachAttrList do
            local attachAttrVo = attachAttrList[i]
            local itemCloneGo = self:__getTxtGo("TuPoAttachAttrItem")
            itemCloneGo.transform:SetParent(self.m_childTrans["ShowTuPoAttachAttr"], false)
            local textAttrTile = itemCloneGo.transform:Find("TextTuPoAttachTile"):GetComponent(ty.Text)
            local textAttr = itemCloneGo.transform:Find("TextTuPoAttachAttr"):GetComponent(ty.Text)
            local textAttrTip = itemCloneGo.transform:Find("TextTuPoAttachAttrTip"):GetComponent(ty.Text)
            local imgUnLockIcon = itemCloneGo.transform:Find("ImgTuPoAttachUnLockIcon").gameObject
            local imgLockIcon = itemCloneGo.transform:Find("ImgTuPoAttachLockIcon").gameObject
            if (attachAttrVo.isActive) then
                textAttr.text = HtmlUtil:color("+" .. AttConst.getValueStr(attachAttrVo.key, attachAttrVo.value), "038008")
                textAttrTile.text = HtmlUtil:color(AttConst.getName(attachAttrVo.key), "202226ff")
                textAttrTip.gameObject:SetActive(false)
                imgUnLockIcon:SetActive(true)
                imgLockIcon:SetActive(false)
            else
                textAttr.text = HtmlUtil:color("+" .. AttConst.getValueStr(attachAttrVo.key, attachAttrVo.value), "404546")
                textAttrTile.text = HtmlUtil:color(AttConst.getName(attachAttrVo.key), "404546")
                textAttrTip.gameObject:SetActive(true)
                imgUnLockIcon:SetActive(false)
                imgLockIcon:SetActive(true)
                -- textAttrTip.text = string.substitute("突破{0}次解锁", attachAttrVo.breakUpRank - (self.m_equipVo.tuPoRank or 1))
                textAttrTip.text = string.substitute("突破{0}次解锁", attachAttrVo.breakUpRank - 1) -- 显示固定需要突破次数
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
    if (self.m_equipVo.subType == PropsEquipSubType.SLOT_7) then -- 手环
        self.m_childGos["GroupSkill"]:SetActive(true)
        self.m_childGos["TextTitleSkill"]:GetComponent(ty.Text).text = _TT(1399) --"烙痕效果"
        local skillEffectList, skillEffectDic = self.m_equipVo:getSkillEffect()
        -- local skillVo = fight.SkillManager:getSkillRo(skillEffectList[i].skillId)
        if next(skillEffectList) then
            local des = equip.EquipSkillManager:getBraceletTipsSkillDes(self.m_equipVo, skillEffectList[1])
            local txtCloneGo = self:__getTxtGo("TextSkill")
            txtCloneGo.transform:SetParent(self.m_childTrans["ShowSkill"], false)
            local tmpLink_txtCloneGo = txtCloneGo:GetComponent(ty.TextMeshProLink)
            tmpLink_txtCloneGo:SetEventCall(notice.HrefUtil.commonTitleDesLinkData)
            txtCloneGo:GetComponent(ty.TMP_Text).text = des -- HtmlUtil:color(des, "bababaff")
        else
            local equipConfigVo = equip.EquipManager:getEquipConfigVo(self.m_equipVo.tid)
            local txtCloneGo = self:__getTxtGo("TextSkill")
            txtCloneGo.transform:SetParent(self.m_childTrans["ShowSkill"], false)
            local tmpLink_txtCloneGo = txtCloneGo:GetComponent(ty.TextMeshProLink)
            tmpLink_txtCloneGo:SetEventCall(notice.HrefUtil.commonTitleDesLinkData)
            txtCloneGo:GetComponent(ty.TMP_Text).text = equipConfigVo.defaultSkillDes -- HtmlUtil:color(des, "bababaff")
        end
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
                local tmpLink_txtCloneGo = txtCloneGo:GetComponent(ty.TextMeshProLink)
                tmpLink_txtCloneGo:SetEventCall(notice.HrefUtil.commonTitleDesLinkData)
                txtCloneGo:GetComponent(ty.TMP_Text).text = des -- HtmlUtil:color(des, "bababaff")
            end
        end
    end
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["ShowSkill"]);
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["GroupSkill"]);
end

-- 更新套装属性
function __updateSuit(self)
    self.m_childGos["TextTitleSuit"]:GetComponent(ty.Text).text = _TT(4063)
    self.m_childGos["TextTitleSuit"]:SetActive(false)

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
                colorStr = "bababaff"
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
                colorStr = "bababaff"
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
    self.m_childGos["TextTitleSuit_2"]:GetComponent(ty.Text).text = _TT(4037) -- "2件套"

    local function _update(name)
        self.m_childGos["GroupSuit_2"]:SetActive(name ~= nil)
        self.m_childGos["GroupSuitTitle"]:SetActive(name ~= nil)
        -- self.m_childGos["GroupSuitTitle"]:SetActive(false)
        -- self.m_childGos["TextSuitTitle"]:GetCbg_2omponent(ty.Text).text = name
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
            local colorStr
            if (count >= 2) then
                colorStr = "000000ff"
                self.m_childGos["ImgSuitTitleBg_2"]:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("tips/tips_8.png"), true)
                self.m_childGos["ImgSuitTitleIcon_2"]:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon4Path("common_5429.png"), true)
            else
                colorStr = "202226"
                self.m_childGos["ImgSuitTitleBg_2"]:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("tips/tips_9.png"), true)
                self.m_childGos["ImgSuitTitleIcon_2"]:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon4Path("common_5222.png"), true)
            end
            -- local txtCloneGo = self:__getTxtGo("TextSuitDes_2")
            -- txtCloneGo.transform:SetParent(self.m_childTrans["ShowSuit_2"], false)
            -- -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color("套装" .. suitId .. "的2件套 [触发技能id:" .. suitConfigVo.suitSkillId_2 .. "]", colorStr)
            -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(suitConfigVo.name .. "2件套", colorStr)
            local txtCloneGo = self:__getTxtGo("TextSuitDes_2")
            txtCloneGo.transform:SetParent(self.m_childTrans["ShowSuit_2"], false)
            -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color("技能id:" .. suitConfigVo.suitSkillId_2 .. "的描述", colorStr)
            local skillVo = fight.SkillManager:getSkillRo(suitConfigVo.suitSkillId_2)
            txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(skillVo:getDesc(), colorStr)
        end
    end

    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["ShowSuit_2"])
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["GroupSuit_2"])

end

-- 更新4件套装属性
function __updateSuit_4(self)
    self.m_childGos["TextTitleSuit_4"]:GetComponent(ty.Text).text = _TT(4038) -- "4件套"

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
            local colorStr
            if (count >= 4) then
                colorStr = "000000ff"
                self.m_childGos["ImgSuitTitleBg_4"]:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("tips/tips_8.png"), true)
                self.m_childGos["ImgSuitTitleIcon_4"]:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon4Path("common_5429.png"), true)
            else
                colorStr = "202226"
                self.m_childGos["ImgSuitTitleBg_4"]:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("tips/tips_9.png"), true)
                self.m_childGos["ImgSuitTitleIcon_4"]:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon4Path("common_5222.png"), true)
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
    self.m_childGos["TextTitleRemake"]:GetComponent(ty.Text).text = _TT(4039) -- "改造属性"

    self.m_childGos["GroupRemake"]:SetActive(false)
    local remakePosAttrList, remakePosAttrDic = self.m_equipVo:getRemakeAttr()

    if remakePosAttrDic == nil then
        return
    end

    for pos, attrData in pairs(remakePosAttrDic) do
        local key = attrData.key
        local value = attrData.value
        local maxValue = attrData.maxValue
        local colorStr = ""
        if (value >= maxValue) then
            colorStr = ColorUtil.RED_NUM
        else
            colorStr = ColorUtil.BLUE_NUM
        end

        local txtCloneGo = self:__getTxtGo("TextRemakeDes")
        txtCloneGo.transform:SetParent(self.m_childTrans["ShowRemake"], false)

        txtCloneGo:GetComponent(ty.Text).text = AttConst.getName(key) .. "+" .. HtmlUtil:color(AttConst.getValueStr(key, value), "03950D")
        self.m_childGos["GroupRemake"]:SetActive(true)
    end

    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["GroupRemake"]);
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["ShowRemake"]);
end

function __updateBtnList(self)
    -- gs.TransQuick:SizeDelta02(self.m_childTrans["GameAction"], 586)
    -- gs.TransQuick:SizeDelta02(self.m_childTrans["GroupBottom"], 468)
    if (self.m_btnTypeList and #self.m_btnTypeList > 0) then
        gs.TransQuick:SizeDelta02(self.m_childTrans["Scroller"], 333)
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
                if (btnType == tips.EquipTips.BtnType.BUILD_EQUIP) or (btnType == tips.EquipTips.BtnType.BUILD_EQUIP_2) then -- 培养
                    GameDispatcher:dispatchEvent(EventName.OPEN_EQUIP_BUILD_PANEL, { equipVo = self.m_equipVo })
                elseif (btnType == tips.EquipTips.BtnType.LOAD_EQUIP) then -- 穿戴
                    hero.HeroEquipManager:dispatchEvent(hero.HeroEquipManager.HERO_BAG_EQUIP_SELECT, { equipVo = self.m_equipVo })
                elseif (btnType == tips.EquipTips.BtnType.UNLOAD_EQUIP) then -- 卸下
                    GameDispatcher:dispatchEvent(EventName.REQ_HERO_DEL_EQUIP, { equipVo = self.m_equipVo })
                elseif (btnType == tips.EquipTips.BtnType.REPLACE_EQUIP) then -- 更换
                    hero.HeroEquipManager:dispatchEvent(hero.HeroEquipManager.HERO_BAG_EQUIP_CHANGE, { equipVo = self.m_equipVo })
                end
                self:close()
            end
            btn:SetActive(true)
            self:addUIEvent(btn, _clickEquipBtn)
        end

    else
        gs.TransQuick:SizeDelta02(self.m_childTrans["Scroller"], 460)
    end
end

--重写基类
function __tempAction(self, clickPosData)

end

function __updateGuide(self)
    if self.m_equipVo.tid == 5011 then
        self:setGuideTrans("Equip_Load_4", self.m_childTrans["BtnLoad"])
    elseif self.m_equipVo.tid == 5012 then
        self:setGuideTrans("Equip_Load_7", self.m_childTrans["BtnLoad"])
    end
end

-- 在资源销毁前，对需要回收的资源进行回收处理
function recover(self)
    super.recover(self)
    self:initData()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
语言包: _TT(4063):"套装"
语言包: _TT(4062):"<未解锁>"
语言包: _TT(4061):"类型："
语言包: _TT(1316):"套装属性"
语言包: _TT(4038):"4件套"
语言包: _TT(4037):"2件套"
]]