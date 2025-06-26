module("hero.HeroResonanceTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("hero/tab/HeroResonanceTab.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
end

function configUI(self)
    super.configUI(self)

    self.mMainGruop = self:getChildGO("mMainGruop")
    self.mSelectInfo = self:getChildGO("mSelectInfo")
    self.mActiveGroup = self:getChildGO("mActiveGroup")
    self.mUnActiveGroup = self:getChildGO("mUnActiveGroup")

    self.mBtnBack = self:getChildGO("mBtnBack")

    self.mInfolItem = self:getChildGO("mInfolItem")

    self.mTextName = self:getChildGO("mTextName"):GetComponent(ty.Text)
    self.mTextDesc = self:getChildGO("mTextDesc"):GetComponent(ty.Text)

    self.mTxt_1 = self:getChildGO("mTxt_1"):GetComponent(ty.Text)
    self.mTxt_2 = self:getChildGO("mTxt_2"):GetComponent(ty.Text)
    self.mTxt_3 = self:getChildGO("mTxt_3"):GetComponent(ty.Text)

    self.mTextUnlock = self:getChildGO("mTextUnlock"):GetComponent(ty.Text)
    self.mTxtMaxLvlTip = self:getChildGO("mTxtMaxLvlTip"):GetComponent(ty.Text)
    self.mTextActive = self:getChildGO("mTextActive"):GetComponent(ty.Text)

    self.mBtnGoto = self:getChildGO("mBtnGoto")
    self.mCostPopsGroup = self:getChildTrans("mCostPopsGroup")

    self.mMeetGroup = self:getChildGO("mMeetGroup")
    self.mUnMeetGroup = self:getChildGO("mUnMeetGroup")
    self.mBtnActive = self:getChildGO("mBtnActive")
    self.mTextPayNum = self:getChildGO("mTextPayNum"):GetComponent(ty.Text)
    self.mImgCostIcon = self:getChildGO("mImgCostIcon"):GetComponent(ty.AutoRefImage)

    self.mActiveCondition = self:getChildGO("mActiveCondition")
    self.mTxtCondition = self:getChildGO("mTxtCondition"):GetComponent(ty.Text)

    self.mGroupSpecialAttr = self:getChildTrans("mGroupSpecialAttr")
    self.mItemAttr = self:getChildGO("mItemAttr")

    self.mImgJob = self:getChildGO("mImgJob"):GetComponent(ty.AutoRefImage)

    self.NullAttr = self:getChildGO("NullAttr")
    self.mTxtEmptyTip = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)

    self.mImgSkillInfoBg = self:getChildGO("mImgSkillInfoBg"):GetComponent(ty.AutoRefImage)
end

function active(self, args)
    super.active(self, args)

    GameDispatcher:addEventListener(EventName.HERO_RESONANCE_SELECT, self.onResonanceSelect, self)
    GameDispatcher:addEventListener(EventName.HERO_RESONANCE_SERVER, self.onActiveReceive, self)

    self.heroId = args.heroId

    self:refreshView(self.heroId)

    self:onResonanceBack()

    if not self.scene then
        self.scene = UISceneBgUtil:create3DBg("arts/sceneModule/ui_xingyuan_01/prefabs/ui_xingyuan_01.prefab")
    end
end

function deActive(self)
    super.deActive(self)

    self:recoverResonanceItem()
    self:recoverPropsGrid()
    self:recoverAttrItem()

    self.m_selectResonancePos = nil

    GameDispatcher:removeEventListener(EventName.HERO_RESONANCE_SELECT, self.onResonanceSelect, self)
    GameDispatcher:removeEventListener(EventName.HERO_RESONANCE_SERVER, self.onActiveReceive, self)

    if (self.scene) then
        UISceneBgUtil:reset()
        self.scene = nil
    end
end

function initViewText(self)
    self.mTxt_1.text = _TT(110002)
    self.mTxt_2.text = _TT(110003)
    self.mTxt_3.text = _TT(93106)
    self.mTxtMaxLvlTip.text = _TT(110006)
    self.mTextActive.text = _TT(110008)
    self.mTxtCondition.text = _TT(110007)
    self.mTxtEmptyTip.text = _TT(110016)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnBack, self.onResonanceBack)
    self:addUIEvent(self.mBtnGoto, self.onGoto)
    self:addUIEvent(self.mBtnActive, self.onActive)

end

function onActiveReceive(self)
    if not self.mActivePos then
        return
    end

    if not self.m_resonanceItemList then
        return
    end

    local skillItem = self.m_resonanceItemList[self.mActivePos]
    if not skillItem then
        return
    end

    local fxGo = skillItem:getChildGO("mFx")
    fxGo:SetActive(true)

    LoopManager:setTimeout(2, nil, function ()
        fxGo:SetActive(false)
    end)
end

function onActive(self)
    if not self.m_selectResonancePos then
        return
    end

    local configVo = self.m_resonanceConfigVo[self.m_selectResonancePos]
    local costList = configVo:getCost()
    for _, cost in pairs(costList) do
        local haveNum = bag.BagManager:getPropsCountByTid(cost.tid)
        if haveNum < cost.num then
            gs.Message.Show(_TT(156))
            return
        end
    end

    if not MoneyUtil.judgeNeedMoneyCountByTid(configVo.pay_tid, configVo.pay_num) then
        return
    end

    self.mActivePos = self.m_selectResonancePos

    GameDispatcher:dispatchEvent(EventName.HERO_REQRESONANCE, {heroId = self.heroId, pos = self.m_selectResonancePos})
end

function onGoto(self)
    -- GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = LinkCode.HeroLvUp})
    GameDispatcher:dispatchEvent(EventName.CHANGE_HERO_TAB, true)
end

function onResonanceBack(self)
    self.mMainGruop:SetActive(false)
    self.mMainGruop:SetActive(true)
    self.mSelectInfo:SetActive(false)

    self:refreshMainView()

    -- GameDispatcher:dispatchEvent(EventName.HERO_RESONANCE_SELECT)
end

function refreshView(self, heroId)
    if heroId ~= self.heroId then
        return
    end

    self.m_heroVo = hero.HeroManager:getHeroVo(self.heroId)
    self.m_resonanceConfigVo = hero.HeroManager:getHeroResonanceConfigVo(self.m_heroVo.tid)

    self.mImgJob:SetImg(UrlManager:getIconPath(string.format("heroResonance/icon_0%s.png", self.m_heroVo.professionType)), false)
    self:refreshMainView()

    if self.m_selectResonancePos then
        self:onResonanceSelect(self.m_selectResonancePos)
    end
end

function refreshMainView(self)
    local bigResonanceConfigDic = {}
    local activeAttrList =
    {
        [1] = {},
        [2] = {},
    }

    self:recoverResonanceItem()
    for i = 1, #self.m_resonanceConfigVo do
        local configVo = self.m_resonanceConfigVo[i]
        local isActive = self.m_heroVo:getActiveResonancePos(i)

        local isCanActive = true
        if i == 1 then
            local needLvl = sysParam.SysParamManager:getValue(SysParamType.HERO_RESONANCE_NEEDLVL)
            local militaryRank = self.m_heroVo.militaryRank
            local isRank = militaryRank >= needLvl

            isCanActive = isRank
        else
            for _, pre_id in pairs(configVo.pre_id) do
                local active = self.m_heroVo:getActiveResonancePos(pre_id)
                if not active then
                    isCanActive = false
                    break
                end
            end
        end

        ---货币跟小号暂时不需要
        -- if isCanActive then
        --     local haveNum = MoneyUtil.getMoneyCountByTid(configVo.pay_tid)
        --     local pay_numStr = MoneyUtil.shortValueStr(configVo.pay_num)
        --     if haveNum < configVo.pay_num then
        --         isCanActive = false
        --     end
        -- end

        -- local costList = configVo:getCost()
        -- for _, cost in pairs(costList) do
        --     local haveNum = bag.BagManager:getPropsCountByTid(cost.tid)
        --     if haveNum < cost.num then
        --         isCanActive = false
        --         break
        --     end
        -- end

        local skillGo = self.m_childGos[string.format("mSkillItem (%s)", i)]
        if skillGo and not gs.GoUtil.IsGoNull(skillGo) then
            local data = {configVo = configVo, isActive = isActive, isCanActive = isCanActive}

            local resonanceItem = hero.HeroResonanceSkillItem:create2(skillGo, false)
            resonanceItem:setData(data)
            self.m_resonanceItemList[i] = resonanceItem
        end

        local lineGo = self.m_childGos[string.format("line (%s)", i)]
        if lineGo and not gs.GoUtil.IsGoNull(lineGo) then
            lineGo:SetActive(not isActive)
        end
        if configVo.type == 2 then
            bigResonanceConfigDic[configVo.pos] = isActive
        end

        if isActive then
            if configVo.type == 2 then
                table.insert(activeAttrList[configVo.type], {desc = configVo:getDesc()})
            else
                if activeAttrList[configVo.type][configVo.attr[1]] then
                    activeAttrList[configVo.type][configVo.attr[1]] = activeAttrList[configVo.type][configVo.attr[1]] + configVo.attr[2]
                else
                    activeAttrList[configVo.type][configVo.attr[1]] = configVo.attr[2]
                end
            end
        end
    end

    local resonanceCount = self.m_heroVo:getActivesSkillResonanceCount()
    for i = 1, 5 do
        local signGo = self.m_childGos[string.format("mImgSkillSign_%s", i)]
        if signGo and not gs.GoUtil.IsGoNull(signGo) then
            if i > resonanceCount then
                signGo:GetComponent(ty.AutoRefImage):SetImg("arts/ui/pack/heroResonance/res_pnl_04.png", false)
            else
                signGo:GetComponent(ty.AutoRefImage):SetImg("arts/ui/pack/heroResonance/res_pnl_05.png", false)
            end
        end
    end

    local isEmpty = table.empty(activeAttrList)
    self.NullAttr:SetActive(isEmpty)

    self:recoverAttrItem()
    if not isEmpty then
        for i = 1, #activeAttrList do
            for attr_key, attr_val in pairs(activeAttrList[i]) do
                local item = SimpleInsItem:create(self.mItemAttr, self.mGroupSpecialAttr, "hero_resonance_attrItem")
                table.insert(self.m_attrItem, item)

                local str = ""
                if type(attr_val) == "table" then
                    str = attr_val.desc
                else
                    str = string.format("%s+%s", AttConst.getName(attr_key), AttConst.getValueStr(attr_key, attr_val))
                end
                item:getChildGO("mTextDesc"):GetComponent(ty.Text).text = str
            end
        end
    end
end

function recoverAttrItem(self)
    if self.m_attrItem then
        for _, item in pairs(self.m_attrItem) do
            item:poolRecover()
        end
    end

    self.m_attrItem = {}
end

function recoverResonanceItem(self)
    if self.m_resonanceItemList then
        for _, item in pairs(self.m_resonanceItemList) do
            item:poolRecover()
        end
    end

    self.m_resonanceItemList = {}
end

function onResonanceSelect(self, resonanace_pos)
    if not resonanace_pos then
        return
    end

    self.m_selectResonancePos = resonanace_pos

    self.mMainGruop:SetActive(false)
    self.mSelectInfo:SetActive(true)

    local isActive = self.m_heroVo:getActiveResonancePos(resonanace_pos)
    self.mUnActiveGroup:SetActive(not isActive)
    self.mActiveGroup:SetActive(isActive)

    if not self.m_selectResonanceItem then
        self.m_selectResonanceItem = hero.HeroResonanceSkillItem:create2(self.mInfolItem)
    end

    local configVo = self.m_resonanceConfigVo[resonanace_pos]
    self.m_selectResonanceItem:setData({configVo = configVo})

    self.mTextName.text = configVo:getTitle()
    local str = ""
    if configVo.type == 2 then
        str = configVo:getDesc()
        self.mImgSkillInfoBg:SetImg("arts/ui/pack/heroResonance/res_pnl_06.png")
    else
        str = string.format("%s+%s", AttConst.getName(configVo.attr[1]), AttConst.getValueStr(configVo.attr[1], configVo.attr[2]))
        self.mImgSkillInfoBg:SetImg("arts/ui/pack/heroResonance/res_pnl_01.png")
    end
    self.mTextDesc.text = str

    local isCanActive = true
    if resonanace_pos == 1 then
        local needLvl = sysParam.SysParamManager:getValue(SysParamType.HERO_RESONANCE_NEEDLVL)
        local militaryRank = self.m_heroVo.militaryRank
        if militaryRank < needLvl then
            local list = {"Ⅰ", "Ⅱ", "Ⅲ", "Ⅳ", "Ⅴ", "Ⅵ", "Ⅶ", "Ⅷ", "Ⅸ", "Ⅹ"}
            local numStr = list[needLvl]
            self.mTextUnlock.text = _TT(110005, numStr)

            isCanActive = false
        end

        self.mBtnGoto:SetActive(not isCanActive)
        self.mTextUnlock.gameObject:SetActive(not isCanActive)
        self.mActiveCondition:SetActive(false)
    else
        for _, pre_id in pairs(configVo.pre_id) do
            local active = self.m_heroVo:getActiveResonancePos(pre_id)
            if not active then
                isCanActive = false
                break
            end
        end

        self.mBtnGoto:SetActive(false)
        self.mTextUnlock.gameObject:SetActive(false)
        self.mActiveCondition:SetActive(not isCanActive)
    end

    if isCanActive then
        local haveNum = MoneyUtil.getMoneyCountByTid(configVo.pay_tid)
        local pay_numStr = MoneyUtil.shortValueStr(configVo.pay_num)
        if haveNum >= configVo.pay_num then
            self.mTextPayNum.text = pay_numStr
        else
            self.mTextPayNum.text = string.format("<color=#%s>%s</color>", "fa3a2b", pay_numStr)
        end
        self.mImgCostIcon:SetImg(MoneyUtil.getMoneyIconUrlByTid(configVo.pay_tid), false)
    end

    self.mMeetGroup:SetActive(isCanActive)
    self.mUnMeetGroup:SetActive(not isCanActive)

    self:recoverPropsGrid()
    local costList = configVo:getCost()
    for _, cost in pairs(costList) do
        local props = PropsGrid:createByData({tid = cost.tid, num = cost.num, parent = self.mCostPopsGroup, scale = 0.8, showUseInTip = true})
        props:setIsShowCount(false)
        local haveNum = bag.BagManager:getPropsCountByTid(cost.tid)
        props:setShowNum(haveNum, cost.num)
        table.insert(self.m_costPropsList, props)
    end
end

function recoverPropsGrid(self)
    if self.m_costPropsList then
        for k, v in pairs(self.m_costPropsList) do
            v:poolRecover()
        end
    end

    self.m_costPropsList = {}

end

return _M
