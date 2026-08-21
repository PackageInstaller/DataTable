module("braceletBuild.BraceletStrengthenTab", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("braceletBuild/tab/BraceletStrengthenTab.prefab")

function initData(self)
    self.mMainItemsAttr = {}
    self.mGridList = {}
    self.mState = braceletBuild.strengthenState.CanNotStrengthen
    self.canAni = false
    self.mCurrentCount = 0

end

function initViewText(self)
    self.mTxtLv.text = "Lv."
    self.mTxtStrengInfo.text = "强化材料"
    self.mTxtStrengthen.text = "强化"
    self.mTxtReset.text = "清空材料"

    self.mTxtAuto.text = "自动选择"

    self.mTxtBreakLv.text = "等级上限"

    self.mTxtMax.text = "等级上限"
end

function configUI(self)

    self.mTextItemName = self:getChildGO("mTextItemName"):GetComponent(ty.Text)
    -- self.mImgBraceletsIcon = self:getChildGO("mImgBraceletsIcon"):GetComponent(ty.AutoRefImage)
    -- self.mImgButtum = self:getChildGO("mImgButtum"):GetComponent(ty.AutoRefImage)
    -- self.mImgRight = self:getChildGO("mImgRight"):GetComponent(ty.AutoRefImage)
    self.ShowBracelets = self:getChildGO("ShowBracelets")
    self.mStrengthenAttrItem = self:getChildGO("mStrengthenAttrItem")
    self.mStrengthenScrollView = self:getChildGO("mStrengthenScrollView"):GetComponent(ty.ScrollRect)
    self.mStrengthenProgressBgRT = self:getChildGO("mStrengthenProgressBg"):GetComponent(ty.RectTransform)
    self.mStrengthenProgressBgProRT = self:getChildGO("mStrengthenProgressBgPro"):GetComponent(ty.RectTransform)
    self.mTxtStrengthenExp = self:getChildGO("mTxtStrengthenExp"):GetComponent(ty.Text)

    -- 强化
    self.mGroupStrengthen = self:getChildGO("mGroupStrengthen")
    self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)

    self.mTxtStrengthenLvl = self:getChildGO("mTxtStrengthenLvl"):GetComponent(ty.Text)

    self.mCurrentMaxGroup = self:getChildGO("mCurrentMaxGroup")
    self.mTxtStrengthenMaxLvl = self:getChildGO("mTxtStrengthenMaxLvl"):GetComponent(ty.Text)

    self.mTxtStrengthenNextLvl = self:getChildGO("mTxtStrengthenNextLvl"):GetComponent(ty.Text)
    self.mTxtStrengthenTargetMaxLvl = self:getChildGO("mTxtStrengthenTargetMaxLvl"):GetComponent(ty.Text)

    self.mTxtStrengInfo = self:getChildGO("mTxtStrengInfo"):GetComponent(ty.Text)

    self.mStrengthenScroller = self:getChildGO("mStrengthenScroller"):GetComponent(ty.LyScroller)
    self.mStrengthenScroller:SetItemRender(braceletBuild.BraceletStrengthenShowltem)

    self.mBtnStrengthen = self:getChildGO("mBtnStrengthen")
    -- self.mBtnMaterialPanel = self:getChildGO("mBtnMaterialPanel")
    self.mTxtStrengthenCost = self:getChildGO("mTxtStrengthenCost"):GetComponent(ty.Text)
    self.mTxtStrengthen = self:getChildGO("mTxtStrengthen"):GetComponent(ty.Text)

    self.mBtnReset = self:getChildGO("mBtnReset")
    self.mTxtReset = self:getChildGO("mTxtReset"):GetComponent(ty.Text)

    self.mBtnAuto = self:getChildGO("mBtnAuto")
    self.mTxtAuto = self:getChildGO("mTxtAuto"):GetComponent(ty.Text)

    self:initSearchMenu()

    -- 改造
    self.mGroupBreakUp = self:getChildGO("mGroupBreakUp")
    self.mTxtBreakLv = self:getChildGO("mTxtBreakLv"):GetComponent(ty.Text)
    self.mTxtTupo = self:getChildGO("mTxtTupo"):GetComponent(ty.Text)
    self.mTxtBreakUpCurLvlNum = self:getChildGO("mTxtBreakUpCurLvlNum"):GetComponent(ty.Text)
    self.mTxtBreakUpNextLvlNum = self:getChildGO("mTxtBreakUpNextLvlNum"):GetComponent(ty.Text)
    -- self.BreakUpCostGrid

    self.mBreakUpCostItem = self:getChildGO("mBreakUpCostItem")

    self.mBreakUpScroller = self:getChildGO("mBreakUpScroller"):GetComponent(ty.ScrollRect)
    self.mBtnBreakUp = self:getChildGO("mBtnBreakUp")

    self.mTextBeakUpCost = self:getChildGO("mTextBeakUpCost"):GetComponent(ty.Text)
    self.mBreakUpCostIcon = self:getChildGO("mBreakUpCostIcon"):GetComponent(ty.AutoRefImage)

    -- 满级
    self.mGroupMaxTip = self:getChildGO("mGroupMaxTip")
    self.mTxtMax = self:getChildGO("mTxtMax"):GetComponent(ty.Text)
    self.mMaxtrengthenLvl = self:getChildGO("mMaxtrengthenLvl"):GetComponent(ty.Text)

    self.mMask = self:getChildGO("mMask")

    self:setGuideTrans("guide_BraceletStrengthen_Btn_Strengthen", self:getChildTrans("mBtnStrengthen"))
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnAuto, self.onBtnAutoClickHandler)
    self:addUIEvent(self.mBtnReset, self.onBtnResetClickHandler)
    self:addUIEvent(self.mBtnStrengthen, self.onBtnStrengthenClickHandler)
    self:addUIEvent(self.mBtnBreakUp, self.onBtnBreakUpClickHandler)

    self:addUIEvent(self.btnCloseMenu, self.onCloseMenu)
end

function onBtnBreakUpClickHandler(self)
    local isEnough = equipBuild.EquipStrengthenManager:getIsEnoughBreakUp(self.selectEquipVo.heroId, self.selectEquipVo.id)
    local breakUpConfigVo = equipBuild.EquipStrengthenManager:getBreakUpConfigVo(self.selectEquipVo.tid,
    self.selectEquipVo.tuPoRank + 1)

    if (isEnough) then
        if (MoneyUtil.judgeNeedMoneyCountByTid(breakUpConfigVo.costMoneyTid, breakUpConfigVo.costMoneyCount)) then
            GameDispatcher:dispatchEvent(EventName.REQ_EQUIP_BREAKUP, {
                heroId = self.selectEquipVo.heroId,
                equipId = self.selectEquipVo.id
            })
        end
    else
        gs.Message.Show(_TT(4306))
    end
end

-- 强化按钮点击
function onBtnStrengthenClickHandler(self)
    if (#self.mSelectEquipList <= 0) then
        gs.Message.Show(_TT(4308))
    else
        if self.materialPanel then
            self.materialPanel:close()
        end

        local addExp, needMoneyCount, needMoneyTid, addLvl = self:getSelectExpAndMoneyNum()
        if (MoneyUtil.judgeNeedMoneyCountByTid(needMoneyTid, needMoneyCount)) then
            local function onReqStrengthenHandler()
                local costList = {}
                for i = 1, #self.mSelectEquipList do
                    table.insert(costList, {
                        id = self.mSelectEquipList[i]:getDataVo().id,
                        count = self.mSelectEquipList[i]:getArgs()
                    })
                end
                self.mMask:SetActive(true)
                self.canAni = true
                GameDispatcher:dispatchEvent(EventName.REQ_EQUIP_STRENGTHEN, {
                    heroId = self.selectEquipVo.heroId,
                    equipId = self.selectEquipVo.id,
                    costList = costList
                })

                self.mSelectEquipList = {}
                braceletBuild.BraceletBuildManager:setSelectMaterialData(nil)

                --self:onBtnResetClickHandler()
            end
            local isNeedPopTip = false
            for i = 1, #self.mSelectEquipList do
                if (self.mSelectEquipList[i]:getDataVo().type == PropsType.EQUIP and
                self.mSelectEquipList[i]:getDataVo().color >= ColorType.VIOLET) then
                    isNeedPopTip = true
                    break
                end
            end
            if (isNeedPopTip) then
                UIFactory:alertMessge(_TT(4309), true, function()
                    onReqStrengthenHandler()
                end, _TT(1), nil, true, function()
                end, _TT(2), _TT(5), nil, RemindConst.BRACELETS_STRENGTHEN)
            else
                onReqStrengthenHandler()
            end
        end
    end
end

-- 重置按钮点击
function onBtnResetClickHandler(self)
    if self.materialPanel then
        self.materialPanel:clearSelectProps()
    end

    self.mSelectEquipList = {}
    braceletBuild.BraceletBuildManager:setSelectMaterialData(nil)

    self:showPanel()
end

-- 自动按钮点击
function onBtnAutoClickHandler(self)
    if (not self.selectEquipVo) then
        return
    end
    local selectEquipScrollList = braceletBuild.BraceletBuildManager:getSelectMaterialData()
    local fastAddCountLimit = sysParam.SysParamManager:getValue(SysParamType.BRACELET_MATERIAL_AUTO_COUNT)
    if #selectEquipScrollList >= fastAddCountLimit then
        gs.Message.Show(_TT(4357))
        return
    end
    local _addExp = 0
    local isEnough = false
    local breakUpConfigVo = equipBuild.EquipStrengthenManager:getBreakUpConfigVo(self.selectEquipVo.tid,
    self.selectEquipVo.tuPoRank)
    local _needExp = equipBuild.EquipStrengthenManager:getExpByStrengthLvl(self.selectEquipVo,
    self.selectEquipVo.strengthenLvl, breakUpConfigVo.equipTargetLvl)

    for i = 1, #selectEquipScrollList do
        local propsVo = selectEquipScrollList[i]:getDataVo()
        -- 判断数量不超上限
        local convertExp, needMoneyTid, needMoneyCount = equipBuild.EquipStrengthenManager:getConvertExp(propsVo)
        _addExp = _addExp + convertExp * selectEquipScrollList[i]:getArgs()
        -- 满足满级的经验
        if self.selectEquipVo.strengthenExp + _addExp >= _needExp then
            gs.Message.Show(_TT(4358))
            return
        end
    end

    local filterDic = {}
    for type in pairs(equipBuild.panelFilterTypeDic) do
        filterDic[type] = {}
        filterDic[type][equipBuild.filterSubTypeAll] = true
    end

    local equipId = self.selectEquipVo.id
    local scrollList = braceletBuild.BraceletBuildManager:getPropsScrollList(UseEffectType.ADD_BRACELET_EXP,
    self.selectEquipVo.id)
    scrollList = braceletBuild.BraceletBuildManager:getFilterList(scrollList, filterDic)
    equipBuild.EquipStrengthenManager:sortHandler(scrollList, equipBuild.panelSortType.COLOR, self.m_isDescending)



    if (scrollList and #scrollList > 0) then
        local name, colorList = self:getMenuName()
        for i = #scrollList, 1, -1 do
            local propsVo = scrollList[i]:getDataVo()

            if (table.indexof(colorList, propsVo.color) == false) then
                table.remove(scrollList, i)
            end

            if (propsVo.type == PropsType.EQUIP and (propsVo.heroId > 0 or propsVo.isLock == 1 or propsVo.strengthenLvl > 1 or propsVo.refineLvl >= 1)) then
                table.remove(scrollList, i)
            end

            for j = 1, #selectEquipScrollList do
                if propsVo.id == selectEquipScrollList[j]:getDataVo().id then
                    table.remove(scrollList, i)
                    break
                end
            end
        end

        if #scrollList <= 0 then
            gs.Message.Show(_TT(4378))
        end

        local _needMoneyTid = 0
        local _needMoneyCount = 0
        for i = 1, #scrollList do
            local propsVo = scrollList[i]:getDataVo()
            -- 判断数量不超上限
            if (#selectEquipScrollList < fastAddCountLimit) then
                local convertExp, needMoneyTid, needMoneyCount =                equipBuild.EquipStrengthenManager:getConvertExp(propsVo)
                local needCount = 0

                local has = 0
                local hasSelectedVo = nil
                for j = 1, #selectEquipScrollList do
                    if selectEquipScrollList[j]:getDataVo().id == propsVo.id then
                        hasSelectedVo = selectEquipScrollList[j]
                        has = selectEquipScrollList[j]:getArgs()
                        break
                    end
                end

                local forCount = propsVo.count - has

                for j = 1, forCount do
                    needCount = j
                    _addExp = _addExp + convertExp
                    if self.selectEquipVo.strengthenExp + _addExp >= _needExp then
                        isEnough = true
                        break
                    end
                end

                if hasSelectedVo == nil then
                    local scrollVo = LyScrollerSelectVo.new()
                    scrollVo:setDataVo(propsVo)
                    scrollVo:setArgs(needCount)
                    scrollVo:setSelect(true)
                    table.insert(selectEquipScrollList, scrollVo)
                else
                    hasSelectedVo:setArgs(hasSelectedVo:getArgs() + needCount)
                end
                -- 满足满级的经验
                if self.selectEquipVo.strengthenExp + _addExp >= _needExp then
                    isEnough = true
                    break
                end
            end
            if isEnough then
                break
            end
        end

        braceletBuild.BraceletBuildManager:setSelectMaterialData(selectEquipScrollList)
        self:showPanel()
    else
        gs.Message.Show(_TT(4378)) -- 无可选择的芯片
    end
end

function active(self, args)

    self:showPanel()

    GameDispatcher:addEventListener(EventName.OPEN_BRACELET_STRENGTHEN_MATERIAL_VIEW, self.onOpenMaterialViewHandler,
    self)

    equip.EquipManager:addEventListener(equip.EquipManager.UPDATE_EQUIP_DETAIL_DATA, self.onUpdateDetailHandler, self)

    GameDispatcher:addEventListener(EventName.SELECT_MATERIAL_CHANGE_EVENT, self.onMaterialChangeHandler, self)

    GameDispatcher:addEventListener(EventName.UPDATE_BRACELETS_STRENGTHEN_PANEL, self.onBraceletsUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_BRACELETS_BREAKUP_PANEL, self.onBraceletsBreakUpUpdateHandler, self)

    self.btnCloseMenu:SetActive(false)
    self.canAni = false
    self.mMask:SetActive(false)


end

function deActive(self)
    GameDispatcher:removeEventListener(EventName.OPEN_BRACELET_STRENGTHEN_MATERIAL_VIEW, self.onOpenMaterialViewHandler,
    self)
    equip.EquipManager:removeEventListener(equip.EquipManager.UPDATE_EQUIP_DETAIL_DATA, self.onUpdateDetailHandler, self)

    GameDispatcher:removeEventListener(EventName.SELECT_MATERIAL_CHANGE_EVENT, self.onMaterialChangeHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_BRACELETS_STRENGTHEN_PANEL, self.onBraceletsUpdateHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_BRACELETS_BREAKUP_PANEL, self.onBraceletsBreakUpUpdateHandler, self)
    self.mSelectEquipList = {}
    braceletBuild.BraceletBuildManager:setSelectMaterialData(nil)

    if (self.eventSn) then
        LoopManager:removeFrameByIndex(self.eventSn)
        self.eventSn = nil
    end
    self.canAni = false
    self.mMask:SetActive(false)
end

--详细数据更新
function onUpdateDetailHandler(self)
    -- if self.canAni then
    --     cusLog("等待其他协议返回")
    -- else
    self:showPanel()
    --end
end

-- 强化成功
function onBraceletsUpdateHandler(self, args)
    self.oldEquipVo = args.oldEquipVo
    self.curEquipVo = args.curEquipVo
    self.selectEquipVo = self.curEquipVo
    self.finishCall = args.finishCall
    self.mCurrentCount = 0
    self:playStrengthenAni()
end

-- 突破成功
function onBraceletsBreakUpUpdateHandler(self, args)
    self.oldEquipVo = args.oldEquipVo
    self.curEquipVo = args.curEquipVo
    self.selectEquipVo = self.curEquipVo
    --self:playStrengthenAni()
    self:showPanel()
end

--播放强化的动画
function playStrengthenAni(self)

    if (self.eventSn) then
        LoopManager:removeFrameByIndex(self.eventSn)
        self.eventSn = nil
    end

    self.mMaxTime = 2
    self.mCurrentMaxGroup:SetActive(true)
    self.mTxtStrengthenNextLvl.gameObject:SetActive(false)
    self.needCount = self.curEquipVo.strengthenLvl - self.oldEquipVo.strengthenLvl
    self.singTime = self.mMaxTime / (self.needCount + 1)
    self.mCurrentTime = 0
    self.eventSn = LoopManager:addFrame(0, 0, self, self.onLoopEvent)
end

function onLoopEvent(self)
    self.mCurrentTime = self.mCurrentTime + gs.Time.deltaTime
    local configVo = equipBuild.EquipStrengthenManager:getStrengthenConfigVo(self.curEquipVo.subType,
    self.curEquipVo.tid, self.curEquipVo.strengthenLvl)

    if self.mCurrentTime <= self.mMaxTime then
        local rem = self.mCurrentTime % self.singTime
        local curCount = math.floor(self.mCurrentTime / self.singTime)
        if curCount > self.mCurrentCount then
            self.mCurrentCount = curCount
            self:addEffect("fx_ui_common_strengthen", self.mStrengthenProgressBgRT, 0, 0, nil)
        end
        if curCount == self.needCount then
            self.mTxtStrengthenLvl.text = self.curEquipVo.strengthenLvl
            local value = math.min(self.curEquipVo.strengthenExp / configVo.needExp * rem / self.singTime, 1)
            gs.TransQuick:SizeDelta01(self.mStrengthenProgressBgProRT, self.mStrengthenProgressBgRT.sizeDelta.x * value)
        else
            self.mTxtStrengthenLvl.text = self.oldEquipVo.strengthenLvl + curCount
            gs.TransQuick:SizeDelta01(self.mStrengthenProgressBgProRT,
            self.mStrengthenProgressBgRT.sizeDelta.x * rem / self.singTime)
        end
    else
        self.mTxtStrengthenLvl.text = self.curEquipVo.strengthenLvl
        gs.TransQuick:SizeDelta01(self.mStrengthenProgressBgProRT, self.mStrengthenProgressBgRT.sizeDelta.x *
        self.curEquipVo.strengthenExp / configVo.needExp)
        if self.finishCall then
            self:finishCall()
            self.finishCall = nil
        end

        if (self.eventSn) then
            LoopManager:removeFrameByIndex(self.eventSn)
            self.eventSn = nil
            self.canAni = false
            self.mMask:SetActive(false)
            self:showPanel()
        end
    end
end

function onMaterialChangeHandler(self)
    self:showPanel()
end

function onOpenMaterialViewHandler(self, args)
    if self.materialPanel == nil then
        self.materialPanel = braceletBuild.BraceletMaterialPanel.new()
        local function _onDestroyPanelHandler(self)
            self.materialPanel:removeEventListener(View.EVENT_VIEW_DESTROY, _onDestroyPanelHandler, self)
            self.materialPanel = nil
        end
        self.materialPanel:addEventListener(View.EVENT_VIEW_DESTROY, _onDestroyPanelHandler, self)
    end
    self.materialPanel:setData(args)
    self.materialPanel:open()
end

function showPanel(self)
    self.selectEquipVo = braceletBuild.BraceletBuildManager:getOpenEquipVo()

    self.strengthenConfigVo = equipBuild.EquipStrengthenManager:getStrengthenConfigVo(self.selectEquipVo.subType,
    self.selectEquipVo.tid, self.selectEquipVo.strengthenLvl)
    if not self.strengthenConfigVo then
        self.mState = braceletBuild.strengthenState.CanNotStrengthen
    else
        self.breakUpConfigVo = equipBuild.EquipStrengthenManager:getBreakUpConfigVo(self.selectEquipVo.tid,
        self.selectEquipVo.tuPoRank)
        self.mMaxStrengthenLvl = equipBuild.EquipStrengthenManager:getMaxStrengthenLvl(self.selectEquipVo.tid)
        self.isCanBreakUp = equipBuild.EquipStrengthenManager:isCanBreakUp(self.selectEquipVo)

        if self.isCanBreakUp then
            self.mState = braceletBuild.strengthenState.BreakUp
        else
            if self.selectEquipVo.strengthenLvl < self.mMaxStrengthenLvl then
                self.mState = braceletBuild.strengthenState.Strengthen
            else
                self.mState = braceletBuild.strengthenState.MaxLvl
            end
        end
    end

    if self.canAni == true then
        return
    end

    self:updateCommonData()

    self.mGroupStrengthen:SetActive(false)
    self.mGroupBreakUp:SetActive(false)
    self.mGroupMaxTip:SetActive(false)


    if self.mState == braceletBuild.strengthenState.Strengthen then
        self:updateStrengthen()
    elseif self.mState == braceletBuild.strengthenState.BreakUp then
        self:updateBreakUp()
    elseif self.mState == braceletBuild.strengthenState.MaxLvl then
        self:updateMax()
    end
end

function updateCommonData(self)
    self.mTextItemName.text = self.selectEquipVo.name
    --   self.mImgBraceletsIcon:SetImg(UrlManager:getBraceletIconUrl(self.selectEquipVo.tid), false)
    -- self.mImgButtum:SetImg(UrlManager:getNraceletColorUrl(self.selectEquipVo.color), false)
    -- self.mImgRight:SetImg(UrlManager:getNraceletRightColorUrl(self.selectEquipVo.color), false)

    braceletBuild.BraceletBuildManager:setBraceletsInfo(self.selectEquipVo, self.ShowBracelets)

    self:clearMainAttrList()
    local mainAttrList, _ = self.selectEquipVo:getMainAttr()
    for i = 1, #mainAttrList do
        local item = SimpleInsItem:create(self.mStrengthenAttrItem, self.mStrengthenScrollView.content, "BraceletStrengthenTabmainAttrs")

        local mainKey = mainAttrList[i].key
        local mainValue = mainAttrList[i].value
        item:getChildGO("mTxtAttr"):GetComponent(ty.Text).text = AttConst.getName(mainKey)
        item:getChildGO("mTxtBeforeAttr"):GetComponent(ty.Text).text = AttConst.getValueStr(mainKey, mainValue)

        item:getChildGO("mTxtAfterAttr"):SetActive(false)
        item:getChildGO("mImgAttChange"):SetActive(false)
        table.insert(self.mMainItemsAttr, item)
    end
    self.mTxtStrengthenExp.text = self.selectEquipVo.strengthenExp .. "/" .. self.strengthenConfigVo.needExp
    --self.mTxtStrengthenExp.text = ""
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mStrengthenScrollView.transform)

end

function updateStrengthen(self)
    self.mGroupStrengthen:SetActive(true)
    local needExp = self.strengthenConfigVo.needExp
    local ratio = self.selectEquipVo.strengthenExp / needExp


    self.mTxtStrengthenLvl.text = self.selectEquipVo.strengthenLvl
    self.mTxtStrengthenMaxLvl.text = self.breakUpConfigVo.equipTargetLvl
    self.mTxtStrengthenTargetMaxLvl.text = self.breakUpConfigVo.equipTargetLvl
    gs.TransQuick:SizeDelta01(self.mStrengthenProgressBgProRT, self.mStrengthenProgressBgRT.sizeDelta.x * ratio)

    local addExp, needMoneyCount, needMoneyTid, addLvl = self:getSelectExpAndMoneyNum()
    -- 预览有提升
    if addLvl > 0 then
        self.mTxtStrengthenExp.text = (self.selectEquipVo.strengthenExp + addExp) .. "/" .. self.strengthenConfigVo.needExp
        self.mCurrentMaxGroup:SetActive(false)
        self.mTxtStrengthenNextLvl.gameObject:SetActive(true)
        self.mTxtStrengthenNextLvl.text = math.min(self.selectEquipVo.strengthenLvl + addLvl,
        self.breakUpConfigVo.equipTargetLvl)

        local preAttr = self.selectEquipVo:getStrengthenAttrByLvl(self.selectEquipVo.strengthenLvl + addLvl)
        if preAttr == nil then
            return
        end

        local mainAttrList, _ = self.selectEquipVo:getMainAttr()
        self:clearMainAttrList()

        for i = 1, #mainAttrList do

            local mainKey = mainAttrList[i].key
            local mainValue = mainAttrList[i].value

            local preKey = mainKey
            local preValue = 0

            preValue = braceletBuild.BraceletBuildManager:getKeyToValue(mainKey, preAttr)

            local item = SimpleInsItem:create(self.mStrengthenAttrItem, self.mStrengthenScrollView.content, "BraceletStrengthenTabmainAttrs")

            item:getChildGO("mTxtAttr"):GetComponent(ty.Text).text = AttConst.getName(mainKey)
            item:getChildGO("mTxtBeforeAttr"):GetComponent(ty.Text).text = AttConst.getValueStr(mainKey, mainValue)

            if preValue > 0 then
                item:getChildGO("mTxtAfterAttr"):GetComponent(ty.Text).text = AttConst.getValueStr(preKey,
                preValue - mainValue)
            end

            item:getChildGO("mTxtAfterAttr"):SetActive(preValue > 0 and mainValue ~= preValue)
            item:getChildGO("mImgAttChange"):SetActive(preValue > 0 and mainValue ~= preValue)
            table.insert(self.mMainItemsAttr, item)
        end
    else
        self.mTxtStrengthenExp.text = self.selectEquipVo.strengthenExp .. "/" .. self.strengthenConfigVo.needExp
        self.mCurrentMaxGroup:SetActive(true)
        self.mTxtStrengthenNextLvl.gameObject:SetActive(false)
        local mainAttrList, _ = self.selectEquipVo:getMainAttr()
        self:clearMainAttrList()
        for i = 1, #mainAttrList do
            local mainKey = mainAttrList[i].key
            local mainValue = mainAttrList[i].value
            local item = SimpleInsItem:create(self.mStrengthenAttrItem, self.mStrengthenScrollView.content, "BraceletStrengthenTabmainAttrs")
            item:getChildGO("mTxtAttr"):GetComponent(ty.Text).text = AttConst.getName(mainKey)
            item:getChildGO("mTxtBeforeAttr"):GetComponent(ty.Text).text = AttConst.getValueStr(mainKey, mainValue)

            item:getChildGO("mTxtAfterAttr"):SetActive(false)
            item:getChildGO("mImgAttChange"):SetActive(false)
            table.insert(self.mMainItemsAttr, item)
        end
    end

    local selectEquipScrollList = braceletBuild.BraceletBuildManager:getSelectMaterialData()
    local scrollList = {}
    self.mSelectEquipList = {}
    local equipId = self.selectEquipVo.id
    local maxCount = sysParam.SysParamManager:getValue(SysParamType.BRACELET_MATERIAL_AUTO_COUNT)
    for i = 1, maxCount do
        local scrollVo = LyScrollerSelectVo.new()
        scrollVo:setDataVo({
            index = i,
            targetEquipVo = self.selectEquipVo,
            equipScrollVo = selectEquipScrollList[i]
        })
        scrollVo:setSelect(false)
        if (selectEquipScrollList[i]) then
            table.insert(self.mSelectEquipList, selectEquipScrollList[i])
        end

        table.insert(scrollList, scrollVo)
    end

    self.mStrengthenScroller.DataProvider = scrollList
    self.mTxtStrengthenCost.text = needMoneyCount
    self.mTxtStrengthenCost.gameObject:SetActive(needMoneyCount > 0)
    if needMoneyCount > 0 then
        self.mTxtStrengthenCost.color = gs.ColorUtil.GetColor(
        MoneyUtil.judgeNeedMoneyCountByTid(needMoneyTid, needMoneyCount, false, false) and "FFFFFFFF" or "ed1941FF")
    end
end

-- 获取当前选择的材料道具可以增加的经验
function getSelectExpAndMoneyNum(self)
    local selectEquipScrollList = braceletBuild.BraceletBuildManager:getSelectMaterialData()
    local _addExp = 0
    local _needMoneyTid = 0
    local _needMoneyCount = 0
    for i = 1, #selectEquipScrollList do
        local propsVo = selectEquipScrollList[i]:getDataVo()
        local convertExp, needMoneyTid, needMoneyCount = equipBuild.EquipStrengthenManager:getConvertExp(propsVo)
        _addExp = _addExp + convertExp * selectEquipScrollList[i]:getArgs()
        _needMoneyTid = needMoneyTid
        _needMoneyCount = _needMoneyCount + needMoneyCount * selectEquipScrollList[i]:getArgs()
    end
    -- 动态增加的等级
    local _addLvl = 0
    local breakUpConfigVo = equipBuild.EquipStrengthenManager:getBreakUpConfigVo(self.selectEquipVo.tid,
    self.selectEquipVo.tuPoRank)
    local remaidExp = _addExp - (self.strengthenConfigVo.needExp - self.selectEquipVo.strengthenExp)
    if remaidExp > 0 and self.selectEquipVo.strengthenLvl < breakUpConfigVo.equipTargetLvl then
        _addLvl = 1
    end
    while (remaidExp > 0) do
        if self.selectEquipVo.strengthenLvl + _addLvl < breakUpConfigVo.equipTargetLvl then
            local configVo = equipBuild.EquipStrengthenManager:getStrengthenConfigVo(self.selectEquipVo.subType,
            self.selectEquipVo.tid, self.selectEquipVo.strengthenLvl + _addLvl)
            if configVo then
                remaidExp = remaidExp - configVo.needExp
                if remaidExp >= 0 then
                    _addLvl = _addLvl + 1
                end
            else
                remaidExp = 0
            end
        else
            remaidExp = 0
        end
    end
    return _addExp, _needMoneyCount, _needMoneyTid, _addLvl
end

function updateBreakUp(self)
    self.mTxtStrengthenExp.text = self.selectEquipVo.strengthenExp .. "/" .. 0
    self.mTxtBreakUpCurLvlNum.text = self.selectEquipVo.strengthenLvl
    self.mGroupBreakUp:SetActive(true)


    local breakUpConfigVo = equipBuild.EquipStrengthenManager:getBreakUpConfigVo(self.selectEquipVo.tid,
    self.selectEquipVo.tuPoRank + 1)
    self.mTxtBreakUpNextLvlNum.text = breakUpConfigVo.equipTargetLvl
    gs.TransQuick:SizeDelta01(self.mStrengthenProgressBgProRT, self.mStrengthenProgressBgRT.sizeDelta.x * 1)

    local strengthPreAttr = self.selectEquipVo:getBracelesAttrLvl(self.selectEquipVo.tuPoRank + 1)
    local mainAttrList, _ = self.selectEquipVo:getMainAttr()

    if strengthPreAttr == nil then
        cusLog("还没有数据")
        return
    end

    self:clearMainAttrList()
    for i = 1, #mainAttrList do
        local mainKey = mainAttrList[i].key
        local mainValue = mainAttrList[i].value

        local preKey = mainKey
        local preValue = 0

        preValue = braceletBuild.BraceletBuildManager:getKeyToValue(mainKey, strengthPreAttr)

        local item = SimpleInsItem:create(self.mStrengthenAttrItem, self.mStrengthenScrollView.content, "BraceletStrengthenTabmainAttrs")
        item:getChildGO("mTxtAttr"):GetComponent(ty.Text).text = AttConst.getName(mainKey)
        item:getChildGO("mTxtBeforeAttr"):GetComponent(ty.Text).text = AttConst.getValueStr(mainKey, mainValue)
        if preValue > 0 then
            item:getChildGO("mTxtAfterAttr"):GetComponent(ty.Text).text = AttConst.getValueStr(preKey,
            preValue - mainValue)
        end

        item:getChildGO("mImgAttChange"):SetActive(preValue > 0 and mainValue ~= preValue)
        item:getChildGO("mTxtAfterAttr"):SetActive(preValue > 0 and mainValue ~= preValue)
        table.insert(self.mMainItemsAttr, item)

    end

    self:recoverPropsGrid()

    local list = breakUpConfigVo.costPropsList
    for i = 1, #list do
        local item = SimpleInsItem:create(self.mBreakUpCostItem, self.mBreakUpScroller.content, "EquipStrengthenCostItem")
        local propsGrid = PropsGrid:create(item:getChildTrans("BreakUpCostGrid"), { list[i].tid, 1 }, 1)
        propsGrid:setIsShowCount(false)
        local ownNum = bag.BagManager:getPropsCountByTid(list[i].tid)
        item:setText("TextBreakUpCost", nil,
        HtmlUtil:color(ownNum, ownNum >= list[i].count and "ffffffff" or "fa3a2bff") .. "/" .. list[i].count)
        table.insert(self.mGridList, item)
        table.insert(self.mGridList, propsGrid)
    end

    self.mBreakUpCostIcon:SetImg(MoneyUtil.getMoneyIconUrlByTid(breakUpConfigVo.costMoneyTid), true)
    self.mTextBeakUpCost.text = breakUpConfigVo.costMoneyCount
    self.mTextBeakUpCost.color = gs.ColorUtil.GetColor(MoneyUtil.judgeNeedMoneyCountByTid(breakUpConfigVo
    .costMoneyTid,
    breakUpConfigVo.costMoneyCount, false, false) and "FFFFFFFF" or ColorUtil.RED_NUM)
end


function updateMax(self)
    self.mGroupMaxTip:SetActive(true)
    self.mTxtStrengthenExp.text = ""
    self.mMaxtrengthenLvl.text = self.selectEquipVo.strengthenLvl
    self:clearMainAttrList()
    local mainAttrList, _ = self.selectEquipVo:getMainAttr()
    for i = 1, #mainAttrList do
        local item = SimpleInsItem:create(self.mStrengthenAttrItem, self.mStrengthenScrollView.content, "BraceletStrengthenTabmainAttrs")

        local mainKey = mainAttrList[i].key
        local mainValue = mainAttrList[i].value
        item:getChildGO("mTxtAttr"):GetComponent(ty.Text).text = AttConst.getName(mainKey)
        item:getChildGO("mTxtBeforeAttr"):GetComponent(ty.Text).text = AttConst.getValueStr(mainKey, mainValue)

        item:getChildGO("mTxtAfterAttr"):SetActive(false)
        item:getChildGO("mImgAttChange"):SetActive(false)
        table.insert(self.mMainItemsAttr, item)
    end
    gs.TransQuick:SizeDelta01(self.mStrengthenProgressBgProRT, self.mStrengthenProgressBgRT.sizeDelta.x * 1)
end


function recoverPropsGrid(self)
    for i = 1, #self.mGridList do
        self.mGridList[i]:poolRecover()
    end
    self.mGridList = {}

end

function clearMainAttrList(self)
    for i = 1, #self.mMainItemsAttr do
        self.mMainItemsAttr[i]:poolRecover()
    end
    self.mMainItemsAttr = {}
end

function initSearchMenu(self)
    self.m_menu = self.m_menu or self:getChildGO('Menu')
    self.m_dropDown = self.m_dropDown or self:getChildGO('DropDown')
    self.m_itemSubMenu = self.m_itemSubMenu or self:getChildGO('ItemSubMenu')
    self.m_imgGoUp = self.m_imgGoUp or self:getChildGO('ImgUp')
    self.m_imgGoDown = self.m_imgGoDown or self:getChildGO('ImgDown')
    self.m_actImg = self.m_actImg or self:getChildGO("mActImg")

    self.btnCloseMenu = self:getChildGO("mBtnCloseMenu")
    self.btnCloseMenu:SetActive(false)

    local _active = self.active
    self.active = function()
        _active(self)
        self:__updateMenuList()
        self:__updateMenuView()
        self:addUIEvent(self.m_menu, self.__clickMenu)
    end

    local _deActive = self.deActive
    self.deActive = function()
        _deActive(self)
        self.m_isDescending = true
        self.m_isOpenMenu = false
        self.m_curMenuType = nil
    end
end

function onCloseMenu(self)
    self.m_isOpenMenu = false
    self:__updateMenuView()
end

function __clickMenu(self)
    self.m_isOpenMenu = not self.m_isOpenMenu
    self:__updateMenuView()
end

function __updateMenuList(self)
    -- 是否选择了降序
    self.m_isDescending = self.m_isDescending == nil and true or false
    -- 是否打开排序菜单
    self.m_isOpenMenu = false
    -- 当前的菜单类型列表数据
    self.m_menuList = self.m_menuList or { "BLUE", "VIOLET" }
    -- 当前选择的排序类型
    self.m_curMenuType = self.m_curMenuType or self.m_menuList[1]
    -- 当前的排序内容列表数据
    self.m_menuPageList = {}
    for i = 1, #self.m_menuList do
        local menuType = self.m_menuList[i]
        local name, colorList = self:getMenuName(menuType)
        table.insert(self.m_menuPageList, {
            page = menuType,
            nomalLan = name,
            nomalLanEn = ""
        })
    end
    if (self.tabBar) then
        self.tabBar:reset()
    end
    self.tabBar = CustomTabBar:create(self.m_itemSubMenu, self.m_dropDown.transform, self.__clickSubMenu, self)
    self.tabBar:setData(self.m_menuPageList)
    self.tabBar:setPage(self.m_curMenuType, false)
    self.tabBar:setDispatcherSame(false)
end

function __updateMenuView(self)
    -- 排序菜单状态
    self:setBtnLabel(self.m_menu, -1, self:getMenuName(self.m_curMenuType))
    self.m_dropDown:SetActive(self.m_isOpenMenu)
    self.m_imgGoUp:SetActive(self.m_isOpenMenu)
    self.m_imgGoDown:SetActive(not self.m_isOpenMenu)

    self.m_actImg:SetActive(self.m_isOpenMenu)
    self.btnCloseMenu:SetActive(self.m_isOpenMenu)
    -- self.mClickTouch:SetActive(self.m_isOpenMenu)
end

function getMenuName(self, menuType)
    menuType = menuType or self.m_curMenuType
    if (menuType == "GREEN") then
        return _TT(4344), { ColorType.GREEN } -- "绿色"
    elseif (menuType == "BLUE") then
        return _TT(4345), { ColorType.BLUE, ColorType.GREEN } -- "蓝色及以下"
    elseif (menuType == "VIOLET") then
        return _TT(4346), { ColorType.VIOLET, ColorType.BLUE, ColorType.GREEN } -- "紫色及以下"
    end
end

function __clickSubMenu(self, sortType)
    self.m_isOpenMenu = false

    self.m_curMenuType = sortType
    self:__updateMenuList()
    self:__updateMenuView()
end

return _M