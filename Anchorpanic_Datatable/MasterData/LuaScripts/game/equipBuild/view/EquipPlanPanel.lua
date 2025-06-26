--[[ 
-----------------------------------------------------
@filename       : EquipPlanPanel
@Description    : 模组方案主界面
@date           : 2023-12-6 00:00:00
@Author         : Zzz
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("equipBuild.EquipPlanPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("equipBuild/EquipPlanPanel.prefab")
-- panelType = 1 -- 窗口类型 1 全屏 2 弹窗
-- destroyTime = -1 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setTxtTitle(_TT(1419))
    self:setUICode(LinkCode.HomePage)
    self:setBg("", false)
end

-- 取父容器
function getParentTrans(self)
    return super.getParentTrans(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.mSelectHeroId = nil
    self.mSelectEquipPlanId = nil
    self.mPlanItemDic = nil
    
    self.mMaxPos = 6
    self.mEquipSlotDic = nil
    self.mSlotObjDic = nil
    self.mCurrentClickPos = nil

    self.mAttrDic = {}
    self.mSuitDic = {}
end

function configUI(self)
    super.configUI(self)
    
    self.mTextPlanCount = self:getChildTrans("mTextPlanCount"):GetComponent(ty.Text)

    self.mGroupSlot = self:getChildGO("mGroupSlot")
    self.mSlotObjDic = {}
    for pos = 1, self.mMaxPos do
        local go = self:getChildGO("NodeSlot_" .. pos)
        local imgSelected = go.transform:Find('ImgSelected').gameObject
        local bar = go.transform:Find("mImgBg_1/mImgBar"):GetComponent(ty.Image)
        self.mSlotObjDic['Slot_' .. pos] = { go = go, image = go:GetComponent(ty.AutoRefImage), imgSelected = imgSelected, bar = bar }
        go.transform:Find('ImgIdxTap/TextIdx'):GetComponent(ty.Text).text = PropsEquipSubTypeStr[pos]
    end

    self.mBtnRenamePlan = self:getChildGO("mBtnRenamePlan")
    self.mBtnDelPlane = self:getChildGO("mBtnDelPlane")
    self.mBtnWearPlan = self:getChildGO("mBtnWearPlan")
    self.mTipNowPlan = self:getChildGO("mTipNowPlan")

    self.mTipUnSavePlan = self:getChildGO("mTipUnSavePlan")
    self.mBtnSavePlan = self:getChildGO("mBtnSavePlan")
    
    self.mScroll = self:getChildTrans("mScrollPlanList"):GetComponent(ty.LyScroller)
    self.mScroll:SetItemRender(equipBuild.EquipPlanScrollItem)

    self.mGroupAttr = self:getChildGO("mGroupAttr")
    self.mAttrContent = self:getChildTrans("mAttrContent")
    self.mAttrItem = self:getChildGO("mAttrItem")
    self.mGroupSuit = self:getChildGO("mGroupSuit")
    self.mSuitContent = self:getChildTrans("mSuitContent")
    self.mSuitItem = self:getChildGO("mSuitItem")
end

function initViewText(self)
    -- self.mTxtTip.text = _TT(23223)--"弹窗提示"
    -- self:setBtnLabel(self.m_btnConfirm, 1, "确定")
end

function addAllUIEvent(self)
    for pos = 1, self.mMaxPos do
        self:addUIEvent(self.mSlotObjDic['Slot_' .. pos].go, function() end, nil, pos, true)
    end

    self:addUIEvent(self.mBtnWearPlan, self.onClickWearPlanHandler)
    self:addUIEvent(self.mBtnDelPlane, self.onClickDelPlanHandler)
    self:addUIEvent(self.mBtnRenamePlan, self.onClickRenamePlanHandler)
    self:addUIEvent(self.mBtnSavePlan, self.onClickSavePlanHandler)
end

function close(self)
    super.close(self)
end

function onClickClose(self)
    super.onClickClose(self)
    -- UISceneBgUtil:reset()
    -- PostHandler:resetBloomValue()
end

-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    super.onCloseAllCall(self)
    -- UISceneBgUtil:reset()
    -- PostHandler:resetBloomValue()
end

function active(self, args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.RES_EQUIP_PLANE_LIST_DATA, self.onEquipPlanListUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.RES_EQUIP_PLANE_SAVE, self.onEquipPlanSaveHandler, self)
    GameDispatcher:addEventListener(EventName.RES_EQUIP_PLANE_CHANGE_NAME, self.onEquipPlanChangeNameHandler, self)
    GameDispatcher:addEventListener(EventName.RES_EQUIP_PLANE_DELETE, self.onEquipPlanDeleteHandler, self)
    GameDispatcher:addEventListener(EventName.RES_EQUIP_PLANE_WEAR, self.onEquipPlanWearHandler, self)
    equipBuild.EquipPlanManager:addEventListener(equipBuild.EquipPlanManager.EQUIP_PLAN_SELECT, self.onEquipPlanSelectHandler, self)
    -- UISceneBgUtil:create3DBg("arts/sceneModule/ui_mozu_01/prefabs/ui_mozu_01.prefab")
    -- PostHandler:setBloomValue(gs.CameraMgr:GetDefSceneCameraTrans(), 0.61, nil, 4.6, 1.5, 0.7, 0.236)

    self.mSelectHeroId = args
    self.mSelectEquipPlanId = nil
    equipBuild.EquipPlanManager:checkEmptyPlan()
    self:updateView()
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.RES_EQUIP_PLANE_LIST_DATA, self.onEquipPlanListUpdateHandler, self)
    GameDispatcher:removeEventListener(EventName.RES_EQUIP_PLANE_SAVE, self.onEquipPlanSaveHandler, self)
    GameDispatcher:removeEventListener(EventName.RES_EQUIP_PLANE_CHANGE_NAME, self.onEquipPlanChangeNameHandler, self)
    GameDispatcher:removeEventListener(EventName.RES_EQUIP_PLANE_DELETE, self.onEquipPlanDeleteHandler, self)
    GameDispatcher:removeEventListener(EventName.RES_EQUIP_PLANE_WEAR, self.onEquipPlanWearHandler, self)
    equipBuild.EquipPlanManager:removeEventListener(equipBuild.EquipPlanManager.EQUIP_PLAN_SELECT, self.onEquipPlanSelectHandler, self)
    if self.mScroll then
        self.mScroll:CleanAllItem(true)
    end
    self:clearAttrItem()
    self:clearSuitItem()
    self:clearEquipSlotItems()
    equipBuild.EquipPlanManager:deleteEmptyPlan()
end

function onClickWearPlanHandler(self)
    local equipPlanVo = equipBuild.EquipPlanManager:getEquipPlanVo(self.mSelectEquipPlanId)
    local isHasOtherHero = false
    for pos, equipId in pairs(equipPlanVo.equipPosDic) do
        local equipVo = bag.BagManager:getPropsVoById(equipId)
        if(equipVo and equipVo.heroId ~= nil and equipVo.heroId ~= 0 and equipVo.heroId ~= self.mSelectHeroId)then
            isHasOtherHero = true
        end
    end
    if(isHasOtherHero)then
        self:onOpenEquipPlaneWearTipPanelHandler(equipPlanVo)
    else
        GameDispatcher:dispatchEvent(EventName.REQ_EQUIP_PLANE_WEAR, {equipPlanId = equipPlanVo.id, heroId = equipBuild.EquipPlanManager:getHeroId()})
    end
end

function onClickDelPlanHandler(self)
    UIFactory:alertMessge(_TT(1420), true, function()
        local equipPlanVo = equipBuild.EquipPlanManager:getEquipPlanVo(self.mSelectEquipPlanId)
        GameDispatcher:dispatchEvent(EventName.REQ_EQUIP_PLANE_DELETE, {equipPlanId = equipPlanVo.id})
    end, _TT(1), nil, true, function()
    end, _TT(2), _TT(5), nil, nil)
    
end

function onClickRenamePlanHandler(self)
    local equipPlanVo = equipBuild.EquipPlanManager:getEquipPlanVo(self.mSelectEquipPlanId)
    GameDispatcher:dispatchEvent(EventName.OPEN_EQUIP_PLANE_CHANGE_NAME_PANEL, {isAddNew = false, equipPlanVo = equipPlanVo})
end

function onClickSavePlanHandler(self)
    local maxCount = sysParam.SysParamManager:getValue(SysParamType.EQUIP_PLAN_MAX_COUNT)
    if(#equipBuild.EquipPlanManager:getEquipPlanList() >= maxCount)then
        gs.Message.Show(_TT(1402))
    else
        local emptyEquipPlanVo = equipBuild.EquipPlanManager:getEmptyPlanVo()
        if(emptyEquipPlanVo)then
            if(table.nums(emptyEquipPlanVo.equipPosDic) > 0)then
                GameDispatcher:dispatchEvent(EventName.OPEN_EQUIP_PLANE_CHANGE_NAME_PANEL, {isAddNew = true, equipPlanVo = emptyEquipPlanVo})
            else
                gs.Message.Show(_TT(1403))
            end
        else
            gs.Message.Show(_TT(1413)) --"保存异常"
        end
    end
end

function onClickPlanItemHandler(self, args)
    gs.Message.Show(args)
end

function onEquipPlanListUpdateHandler(self, args)
    equipBuild.EquipPlanManager:checkEmptyPlan()
    self:updateView()
end

function onEquipPlanSaveHandler(self, args)
    if(self.mSelectEquipPlanId == args.equipPlanId)then
        equipBuild.EquipPlanManager:checkEmptyPlan()
        self:updateView()
    end
end

function onEquipPlanChangeNameHandler(self, args)
    if(self.mSelectEquipPlanId == args.equipPlanId)then
        self:updateView()
    end
end

function onEquipPlanDeleteHandler(self, args)
    if(self.mSelectEquipPlanId == args.equipPlanId)then
        self.mSelectEquipPlanId = nil
        equipBuild.EquipPlanManager:checkEmptyPlan()
        self:updateView()
    end
end

function onEquipPlanWearHandler(self, args)
    -- args.heroId
    if(self.mSelectEquipPlanId == args.equipPlanId)then
        self:updateView()
    end
end

function onEquipPlanSelectHandler(self, args)
    self.mSelectEquipPlanId = args.id
    self:updateView()
end

function updateView(self)
    local scrollList = self.mScroll.DataProvider
    if(scrollList and #scrollList > 0)then
        for i = 1, #scrollList do
            LuaPoolMgr:poolRecover(scrollList[i])
        end
    end

    local scrollDataList = equipBuild.EquipPlanManager:getEquipPlanList()
    local scrollList, defaultScrollIndex = self:getScrollList(scrollDataList)
    for i = 1, #scrollList do
        local scrollerVo = scrollList[i]
        local equipPlanVo = scrollerVo:getDataVo()
        if(not self.mSelectEquipPlanId and defaultScrollIndex == i)then
            self.mSelectEquipPlanId = equipPlanVo.id
        end
        scrollerVo:setSelect(self.mSelectEquipPlanId == equipPlanVo.id)
    end

    if self.mScroll.Count == 0 then
        self.mScroll.DataProvider = scrollList
        self.mScroll:ScrollToImmediately(defaultScrollIndex - 1)
    else
        self.mScroll:ReplaceAllDataProvider(scrollList)
    end

    -- self.mTextPlanCount.text = string.format("模组方案<size=22> %s/%s</size>", #scrollDataList, 0)
    self.mTextPlanCount.text = string.format(_TT(1414), #scrollDataList, sysParam.SysParamManager:getValue(SysParamType.EQUIP_PLAN_MAX_COUNT))
    self:updateSlotView()
    self:updateStateView()
    self:updateAttrView()
end

function getScrollList(self, scrollDataList)
    local defaultScrollIndex = 1
    local scrollList = {}
    local equipPlanList = scrollDataList or {}
    local emptyEquipPlanVo = equipBuild.EquipPlanManager:getEmptyPlanVo()
    if(emptyEquipPlanVo)then
        local scrollerVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
        scrollerVo:setArgs(true)
        scrollerVo:setSelect(nil)
        scrollerVo:setDataVo(emptyEquipPlanVo)
        table.insert(scrollList, scrollerVo)
    end
    for i = 1, #equipPlanList do
        local scrollerVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
        scrollerVo:setArgs(false)
        scrollerVo:setSelect(nil)
        scrollerVo:setDataVo(equipPlanList[i])
        table.insert(scrollList, scrollerVo)

        if(equipPlanList[i]:equalHeroEquipList(self.mSelectHeroId))then
            defaultScrollIndex = #scrollList
        end
    end
    return scrollList, defaultScrollIndex
end

function updateSlotView(self)
    self:clearEquipSlotItems()

    local equipPlanVo = equipBuild.EquipPlanManager:getEmptyPlanVo()
    if(not equipPlanVo or equipPlanVo.id ~= self.mSelectEquipPlanId and self.mSelectEquipPlanId ~= nil)then                                  -- 选择了正在用的方案
        equipPlanVo = equipBuild.EquipPlanManager:getEquipPlanVo(self.mSelectEquipPlanId)
    end

    local curHeroVo = hero.HeroManager:getHeroVo(self.mSelectHeroId)
    for pos = 1, self.mMaxPos do
        local slotData = self.mSlotObjDic['Slot_' .. pos]
        local needMilitaryLvl = sysParam.SysParamManager:getValue(SysParamType.EQUIP_NEED_MILITART_LVL)[pos]
        slotData.go.transform:Find("NeedLvl/NeedLvlTxt"):GetComponent(ty.Text).text = _TT(1304, needMilitaryLvl)
        slotData.go.transform:Find('NeedLvl').gameObject:SetActive(curHeroVo.militaryRank < needMilitaryLvl)
        slotData.imgSelected:SetActive(false)
        
        if(equipPlanVo)then
            local equipId = equipPlanVo.equipPosDic[pos]
            if(equipId)then
                local equipVo = bag.BagManager:getPropsVoById(equipId) 
                if (equipVo) then
                    local item = EquipGrid3:poolGet()
                    item:setData(equipVo, slotData.go.transform:Find('GridNode').transform)
                    item:setShowHeroIcon(false)
                    -- item:setClickEnable(false)
                    item:setIdxTap(false)
                    self.mEquipSlotDic[pos] = item
                    local color = ""
                    if equipVo.color == ColorType.GREEN then
                        color = "45cea2ff"
                    elseif equipVo.color == ColorType.BLUE then
                        color = "29acffff"
                    elseif equipVo.color == ColorType.VIOLET then
                        color = "ff72f1ff"
                    elseif equipVo.color == ColorType.ORANGE then
                        color = "ff9e35ff"
                    elseif equipVo.color == ColorType.RED then
                        color = "ff000aff"
                    end
                    slotData.bar.color = gs.ColorUtil.GetColor(color)
                else
                    slotData.bar.color = gs.ColorUtil.GetColor("90b1daff")
                end
        
                if not self.mEquipSlotDic[pos] and curHeroVo.militaryRank >= needMilitaryLvl then
                    slotData.go.transform:Find("mAddImg").gameObject:SetActive(true)
                else
                    slotData.go.transform:Find("mAddImg").gameObject:SetActive(false)
                end
            end
        else
            slotData.bar.color = gs.ColorUtil.GetColor("90b1daff")
        end
    end
end

function clearEquipSlotItems(self)
    if(self.mEquipSlotDic)then
        for slotPos, item in pairs(self.mEquipSlotDic) do
            item:poolRecover()
        end
    end
    self.mEquipSlotDic = {}

    for pos = 1, self.mMaxPos do
        local slotData = self.mSlotObjDic['Slot_' .. pos]
        slotData.go.transform:Find("NeedLvl/NeedLvlTxt"):GetComponent(ty.Text).text = ""
        slotData.go.transform:Find('NeedLvl').gameObject:SetActive(false)
        slotData.imgSelected:SetActive(false)
        slotData.go.transform:Find("mAddImg").gameObject:SetActive(false)
        slotData.bar.color = gs.ColorUtil.GetColor("90b1daff")
    end
end

function updateStateView(self)
    local emptyPlanVo = equipBuild.EquipPlanManager:getEmptyPlanVo()
    if(emptyPlanVo and emptyPlanVo.id == self.mSelectEquipPlanId)then                                               -- 选择了未保存方案
        self.mBtnRenamePlan:SetActive(false)
        self.mBtnDelPlane:SetActive(false)
        self.mBtnWearPlan:SetActive(false)
        self.mTipNowPlan:SetActive(false)
    
        self.mTipUnSavePlan:SetActive(true)
        self.mBtnSavePlan:SetActive(true)
    else                                                                                                            -- 选择了已保存方案
        if(self.mSelectEquipPlanId)then
            local equipPlanVo = equipBuild.EquipPlanManager:getEquipPlanVo(self.mSelectEquipPlanId)                 -- 选择了正在用的方案
            if(equipPlanVo)then
                local isNowUsePlan = equipPlanVo:equalHeroEquipList(self.mSelectHeroId)                 
                if(isNowUsePlan)then
                    self.mBtnRenamePlan:SetActive(true)
                    self.mBtnDelPlane:SetActive(true)
        
                    self.mBtnWearPlan:SetActive(false)
                    self.mTipNowPlan:SetActive(true)
        
                    self.mTipUnSavePlan:SetActive(false)
                    self.mBtnSavePlan:SetActive(false)
                else
                    self.mBtnRenamePlan:SetActive(true)
                    self.mBtnDelPlane:SetActive(true)
        
                    self.mBtnWearPlan:SetActive(true)
                    self.mTipNowPlan:SetActive(false)
        
                    self.mTipUnSavePlan:SetActive(false)
                    self.mBtnSavePlan:SetActive(false)
                end
            else
                self.mBtnRenamePlan:SetActive(false)
                self.mBtnDelPlane:SetActive(false)
    
                self.mBtnWearPlan:SetActive(false)
                self.mTipNowPlan:SetActive(false)
    
                self.mTipUnSavePlan:SetActive(false)
                self.mBtnSavePlan:SetActive(false)
            end
        else
            self.mBtnRenamePlan:SetActive(false)
            self.mBtnDelPlane:SetActive(false)

            self.mBtnWearPlan:SetActive(false)
            self.mTipNowPlan:SetActive(false)

            self.mTipUnSavePlan:SetActive(false)
            self.mBtnSavePlan:SetActive(false)
        end
    end
end

function updateAttrView(self)
    local equipPlanVo = equipBuild.EquipPlanManager:getEmptyPlanVo()
    if(not equipPlanVo or equipPlanVo.id ~= self.mSelectEquipPlanId and self.mSelectEquipPlanId ~= nil)then                                  -- 选择了正在用的方案
        equipPlanVo = equipBuild.EquipPlanManager:getEquipPlanVo(self.mSelectEquipPlanId)
    end

    local attrDic = {}
    local curHeroVo = hero.HeroManager:getHeroVo(self.mSelectHeroId)
    for pos = 1, self.mMaxPos do
        if(equipPlanVo)then
            local equipId = equipPlanVo.equipPosDic[pos]
            if(equipId)then
                local equipVo = bag.BagManager:getPropsVoById(equipId)
                equipVo:removeEventListener(equipVo.UPDATE_EQUIP_DETAIL_DATA, self.updateAttrView, self)
                local totalAttrList, totalAttrDic = equipVo:getTotalAttr()
                if (totalAttrList == nil and totalAttrDic == nil) then
                    equipVo:addEventListener(equipVo.UPDATE_EQUIP_DETAIL_DATA, self.updateAttrView, self)
                    return
                end

                if (equipVo) then
                    local mainAttrList, mainAttrDic = equipVo:getTotalAttr()
                    if next(mainAttrList) then
                        for i = 1, #mainAttrList do
                            local attrVo = mainAttrList[i]
                            local temp = attrDic[attrVo.key]
                            attrDic[attrVo.key] = (temp or 0) + attrVo.value
                        end
                    else
                        local equipConfigVo = equip.EquipManager:getEquipConfigVo(equipVo.tid)
                        local attrList = equipConfigVo.defaultAttrList
                        for i = 1, #attrList do
                            local vo = attrList[i]
                            local temp = attrDic[vo[1]]
                            attrDic[vo[1]] = (temp or 0) + vo[2]
                        end
                    end
                end
            end
        end
        local slotData = self.mSlotObjDic['Slot_' .. pos]
        local needMilitaryLvl = sysParam.SysParamManager:getValue(SysParamType.EQUIP_NEED_MILITART_LVL)[pos]
        slotData.go.transform:Find("NeedLvl/NeedLvlTxt"):GetComponent(ty.Text).text = _TT(1304, needMilitaryLvl)
        slotData.go.transform:Find('NeedLvl').gameObject:SetActive(curHeroVo.militaryRank < needMilitaryLvl)
        slotData.imgSelected:SetActive(false)
    end

    self:clearAttrItem()
    local showAttrList = { AttConst.ATTACK, AttConst.HP_MAX, AttConst.DEFENSE, AttConst.SPEED, AttConst.BASE_ATTACK_INC, AttConst.BASE_HP_INC, AttConst.DEFENSE_INC, AttConst.CRIT, AttConst.CRIT_DAMAGE }
    local showAttrData = {}
    showAttrData[AttConst.ATTACK] = { name = AttConst.getName(AttConst.ATTACK), iconImg = UrlManager:getAttrIconUrl(AttConst.ATTACK) }
    showAttrData[AttConst.HP_MAX] = { name = AttConst.getName(AttConst.HP_MAX), iconImg = UrlManager:getAttrIconUrl(AttConst.HP_MAX) }
    showAttrData[AttConst.DEFENSE] = { name = AttConst.getName(AttConst.DEFENSE), iconImg = UrlManager:getAttrIconUrl(AttConst.DEFENSE) }
    showAttrData[AttConst.SPEED] = { name = AttConst.getName(AttConst.SPEED), iconImg = UrlManager:getAttrIconUrl(AttConst.SPEED) }
    showAttrData[AttConst.BASE_ATTACK_INC] = { name = AttConst.getName(AttConst.BASE_ATTACK_INC), iconImg = UrlManager:getAttrIconUrl(AttConst.BASE_ATTACK_INC) }
    showAttrData[AttConst.BASE_HP_INC] = { name = AttConst.getName(AttConst.BASE_HP_INC), iconImg = UrlManager:getAttrIconUrl(AttConst.BASE_HP_INC) }
    showAttrData[AttConst.DEFENSE_INC] = { name = AttConst.getName(AttConst.DEFENSE_INC), iconImg = UrlManager:getAttrIconUrl(AttConst.DEFENSE_INC) }
    showAttrData[AttConst.CRIT] = { name = AttConst.getName(AttConst.CRIT), iconImg = UrlManager:getAttrIconUrl(AttConst.CRIT) }
    showAttrData[AttConst.CRIT_DAMAGE] = { name = AttConst.getName(AttConst.CRIT_DAMAGE), iconImg = UrlManager:getAttrIconUrl(AttConst.CRIT_DAMAGE) }

    for i = 1, #showAttrList do
        local key = showAttrList[i]
        local value = AttConst.getValueStr(key, attrDic[key] or 0)
        local item = SimpleInsItem:create(self.mAttrItem, self.mAttrContent, "HeroEquipPlanAttrItem")
        item:getChildGO("mTxtLockInfo"):GetComponent(ty.Text).text = value
        item:getChildGO("mTxtAttrDes"):GetComponent(ty.Text).text = showAttrData[key].name
        self.mAttrDic[i] = item
    end

    self:clearSuitItem()
    local suitIdDic = equip.EquipManager:getEquipSuitIdDic()
    local suitList = {}
    for suitId, equipTidDic in pairs(suitIdDic) do
        local count = 0
        for slotPos, item in pairs(self.mEquipSlotDic) do
            if (equipTidDic[item:getData().tid]) then
                count = count + 1
                if (count >= 4) then
                    break
                end
            end
        end
        local suitConfigVo = equip.EquipSuitManager:getEquipSuitConfigVo(suitId)
        if (suitConfigVo and count >= 2) then
            local skillVo = fight.SkillManager:getSkillRo(suitConfigVo.suitSkillId_2)
            table.insert(suitList, { name = suitConfigVo.name, count = 2, desc = skillVo:getDescTip() })
        end
        if (suitConfigVo and count >= 4 and suitConfigVo.suitSkillId_4 ~= 0) then
            local skillVo = fight.SkillManager:getSkillRo(suitConfigVo.suitSkillId_4)
            table.insert(suitList, { name = suitConfigVo.name, count = 4, desc = skillVo:getDescTip() })
        end
    end
    table.sort(suitList, function(v1, v2)
        if v1.count == v2.count then
            return true
        end
        return v1.count < v2.count
    end)
    for k, v in pairs(suitList) do
        self:addSuitItem(v.name, v.count, v.desc, v.name .. v.count)
    end
    self.mGroupSuit:SetActive(#suitList > 0)
end

function addSuitItem(self, suitName, suitCount, suitSkillDes, name)
    local item = SimpleInsItem:create(self.mSuitItem, self.mSuitContent, "HeroEquipPlanSuitItem")
    local icon = item:getChildGO("mIconSuit"):GetComponent(ty.AutoRefImage)
    local name = item:getChildGO("mTxtSuitName"):GetComponent(ty.Text)
    name.text = suitName
    local suitMenu = item:getChildGO("MenuSuit")
    local suitMenu4 = item:getChildGO("MenuSuit4piece")
    suitMenu:SetActive(suitCount == 2)
    suitMenu4:SetActive(suitCount == 4)

    local suitCountTxt, des
    if suitCount == 2 then
        suitCountTxt = item:getChildGO("mTxtTitleSuit"):GetComponent(ty.Text)
        des = item:getChildGO("mTxtSuitDes"):GetComponent(ty.Text)
    else
        suitCountTxt = item:getChildGO("mTxtTitle4Suit"):GetComponent(ty.Text)
        des = item:getChildGO("mTxtSuit4Des"):GetComponent(ty.Text)
    end
    suitCountTxt.text = _TT(1305, suitCount) .. ":"
    des.text = suitSkillDes
    self.mSuitDic[name] = item
end

function clearAttrItem(self)
    for id, item in pairs(self.mAttrDic) do
        item:poolRecover()
    end
    self.mAttrDic = {}
end

function clearSuitItem(self)
    for id, item in pairs(self.mSuitDic) do
        item:poolRecover()
    end
    self.mSuitDic = {}
end

function getPlanItem(self, equipPlanId)
    return self.mPlanItemDic[equipPlanId]
end

function clearPlanItemList(self)
    if(self.mPlanItemDic)then
        for i = 1, #self.mPlanItemDic do
            self.mPlanItemDic:recover()
        end
    end
    self.mPlanItemDic = {}
end

function onOpenEquipPlaneWearTipPanelHandler(self, args)
    if self.mEquipPlaneWearTipPanel == nil then
        self.mEquipPlaneWearTipPanel = equipBuild.EquipPlanWearTipPanel.new()
        self.mEquipPlaneWearTipPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEquipPlaneWearTipPanelHandler, self)
    end
    self.mEquipPlaneWearTipPanel:open(args)
end

function onDestroyEquipPlaneWearTipPanelHandler(self)
    self.mEquipPlaneWearTipPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEquipPlaneWearTipPanelHandler, self)
    self.mEquipPlaneWearTipPanel = nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]