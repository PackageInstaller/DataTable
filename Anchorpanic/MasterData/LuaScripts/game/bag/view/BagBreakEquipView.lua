--[[
-----------------------------------------------------
@filename       : BagBreakEquipView
@Description    : 道具分解
@date           : 2021-10-30 11:14:05
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.bag.view.BagBreakEquipView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("bag/BagBreakEquipView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShow3DBg = 1

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setTxtTitle(_TT(4049))
    -- self:setBg("common_bg_015.jpg", true)
end
--析构
function dtor(self)
end

function initData(self)
    self.mItemList = {}
    self.mSortData = {}
end

-- 初始化
function configUI(self)
    self.mBtnBreak = self:getChildGO("mBtnBreak")
    self.mBtnPreview = self:getChildGO("mBtnPreview")
    self.mScrollContent = self:getChildTrans("Content")
    self.mItemScroller = self:getChildTrans("mItemScroller")
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mImgTitle = self:getChildGO("mImgTitle"):GetComponent(ty.AutoRefImage)
    self.mTxtBreakInfo = self:getChildGO("mTxtBreakInfo"):GetComponent(ty.Text)
    self.mTxtColorTitle = self:getChildGO("mTxtColorTitle"):GetComponent(ty.Text)

    self.mToggleG = self:getChildGO("mToggleG"):GetComponent(ty.Toggle)
    self.mToggleB = self:getChildGO("mToggleB"):GetComponent(ty.Toggle)
    self.mToggleP = self:getChildGO("mToggleP"):GetComponent(ty.Toggle)
    self.mToggleO = self:getChildGO("mToggleO"):GetComponent(ty.Toggle)
    -- 道具格子列表
    self.mGridScrollerGo = self:getChildGO("mGridScrollerGo")
    self.mGridScroller = self.mGridScrollerGo:GetComponent(ty.LyScroller)
    self.mGridScroller:SetItemRender(bag.BreakEquipScrollerItem)
    self.mGridScrollerRect = self:getChildGO("mGridScrollerRect"):GetComponent(ty.RectTransform)

    -- 排序页面
    self.mSortView = bag.BagNewSortView.new()
    self.mSortView:setParentTrans(self.UITrans)
    self.mSortView:setAlignCenter(564 - 223, 268.58 - 35.3)
    self.mSortView:isShowHeroWear(false)
    self.mSortView:setCallBack(self, self.onClickSortItemHandler)

    self.mImgTips = self:getChildGO("mImgTips")
    self.EmptyStateItem = self:getChildGO("EmptyStateItem")
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
    self.mTxtEmptyTip = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)
end

--激活
function active(self, args)
    super.active(self, args)
    self.tabType = args.tabType
    self.suitId = args.suitId
    self.mTxtTitle.text = bag.getPageName(self.tabType)
    self.mImgTitle:SetImg(bag.getIconURL(self.tabType), true)
    self.mSortData = {isDescending = true, sortList = bag.getSortList(self.tabType)}

    -- MoneyManager:setMoneyTidList()
    bag.BagManager:addEventListener(bag.BagManager.EVENT_BREAK_SHOW_UPDATE, self.onBreakShowUpdate, self)
    GameDispatcher:addEventListener(EventName.BAG_BREAK_UPDATE_VIEW, self.onSelectUpdate, self)
    GameDispatcher:addEventListener(EventName.BAG_BREAK_PRE_VIEW_CLOSE, self.onBreakPreSendBreak, self)
    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.onBagUpdateHandler, self)

    self:updateView(true)
    self:showBreakView()
    self:addToggleGEvent()
    self:addToggleBEvent()
    self:addTogglePEvent()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    bag.BagManager:removeEventListener(bag.BagManager.EVENT_BREAK_SHOW_UPDATE, self.onBreakShowUpdate, self)
    GameDispatcher:removeEventListener(EventName.BAG_BREAK_UPDATE_VIEW, self.onSelectUpdate, self)
    GameDispatcher:removeEventListener(EventName.BAG_BREAK_PRE_VIEW_CLOSE, self.onBreakPreSendBreak, self)
    bag.BagManager:removeEventListener(bag.BagManager.BAG_UPDATE, self.onBagUpdateHandler, self)

    self:resetData()
    self.mSortView:resetAll()

    bag.BagManager.propsOpState = nil
end

function initViewText(self)
    self:setBtnLabel(self.mBtnBreak, 4050, "分解")
    self.mTxtBreakInfo.text = _TT(4051) --"分解可获得"
    self.mTxtColorTitle.text = _TT(4053) --"选择品质"
    self.mTxtTips.text = _TT(4052) --"—可获得的道具—"
    self.mTxtEmptyTip.text = _TT(4017) --"- 当前暂无物品 -"
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnBreak, self.onBreak)
    self:addUIEvent(self.mBtnPreview, self.onPreview)
end

-- 点击排序item
function onClickSortItemHandler(self)
    self.mSortData = {isDescending = self.mSortView:getIsDescending(), sortList = self.mSortView:getSortTypeList()}
    self:updateView(false)
end

function showSortView(self)
    -- 可能由外部指定显示套装，放在这里先加上个套装菜单和部位菜单
    -- local suitConfigList = equip.EquipSuitManager:getFormatSuitConfigList(nil, nil)
    -- table.insert(suitConfigList, 1, -1)
    -- local showSuitConfigVo = equip.EquipSuitManager:getEquipSuitConfigVo(self.suitId)
    -- self.mSortView:addSuitMenu(suitConfigList, showSuitConfigVo, false)
    self.mSortView:showDetailFilterMenu(true)
    self.mSortView:addPosMenu({-1, PropsEquipSubType.SLOT_1, PropsEquipSubType.SLOT_2, PropsEquipSubType.SLOT_3, PropsEquipSubType.SLOT_4, PropsEquipSubType.SLOT_5, PropsEquipSubType.SLOT_6}, nil, false)

    self.mSortView:addSortMenu(bag.getSortList(self.tabType), nil, true, false)
end

function onBagUpdateHandler(self)
    self:updateView()
    self:showBreakView()
end

-- 在预览点击分解
function onBreakPreSendBreak(self)
    self:resetData()
    self:updateView()
end

function onBreakShowUpdate(self, args)
    self:showBreakView(args)
end

function onSelectUpdate(self)
    self:updatePropsListView(false)
end

function addToggleGEvent(self)
    local function onToggle(val)
        self.toggleChange(self, 1)
    end
    self.mToggleG.onValueChanged:AddListener(onToggle)
end
function addToggleBEvent(self)
    local function onToggle(val)
        self.toggleChange(self, 2)
    end
    self.mToggleB.onValueChanged:AddListener(onToggle)
end
function addTogglePEvent(self)
    local function onToggle(val)
        self.toggleChange(self, 3)
    end
    self.mToggleP.onValueChanged:AddListener(onToggle)
end

function addToggleOEvent(self)
    local function onToggle(val)
        self.toggleChange(self, 4)
    end
    self.mToggleO.onValueChanged:AddListener(onToggle)
end

-- 快捷添加
function toggleChange(self, cusType)
    local list = self:getTypsList(cusType)
    local state = nil
    if cusType == 1 then
        local isOn = self.mToggleG.isOn
        state = isOn and 1 or 0
    elseif cusType == 2 then
        local isOn = self.mToggleB.isOn
        state = isOn and 1 or 0
    elseif cusType == 3 then
        local isOn = self.mToggleP.isOn
        state = isOn and 1 or 0
    else
        local isOn = self.mToggleO.isOn
        state = isOn and 1 or 0
    end

    bag.BagManager:dispatchEvent(bag.BagManager.EVENT_SELECT_TYPES_OVER, {type = cusType, state = state, list = list})
end

-- 取类型道具列表
function getTypsList(self, cusType)
    local propsList = self:getPrpsList()
    local list = {}
    for i, vo in ipairs(propsList) do
        if bag.BagManager:getBreakBaseData(vo.tid, 2) then
            if cusType == 1 and vo.color == ColorType.GREEN and vo.isLock == 0 and vo.heroId == 0 and not equipBuild.EquipPlanManager:isInEquipPlan(vo) then
                table.insert(list, vo.id)
            end
            if cusType == 2 and vo.color == ColorType.BLUE and vo.isLock == 0 and vo.heroId == 0 and not equipBuild.EquipPlanManager:isInEquipPlan(vo) then
                table.insert(list, vo.id)
            end
            if cusType == 3 and vo.color == ColorType.VIOLET and vo.isLock == 0 and vo.heroId == 0 and not equipBuild.EquipPlanManager:isInEquipPlan(vo) then
                table.insert(list, vo.id)
            end

            if cusType == 4 and vo.color == ColorType.ORANGE and vo.isLock == 0 and vo.heroId == 0 and not equipBuild.EquipPlanManager:isInEquipPlan(vo) then
                table.insert(list, vo.id)
            end
        end
    end
    return list
end

function onBreak(self)
    local idList = bag.BagManager:getBreakList()
    if not idList or #idList <= 0 then
        gs.Message.Show(_TT(4022)) --'列表为空不可分解'
        return
    end

    local isBuild = false
    local hasOrangeProps = false
    for i, v in ipairs(idList) do
        local propsVo = bag.BagManager:getPropsVoById(idList[i])
        if not hasOrangeProps and propsVo.color >= ColorType.ORANGE then
            hasOrangeProps = true
        end

        if not isBuild and propsVo.type == PropsType.EQUIP and propsVo.subType == PropsEquipSubType.SLOT_7 then
            if propsVo.strengthenLvl > 1 or propsVo.refineLvl > 0 then
                isBuild = true
            else
                local equipBracelet_remake_attr = propsVo:getBracelet_remake_attr()
                if not table.empty(equipBracelet_remake_attr) then
                    isBuild = true
                end
            end
        end
    end

    local nextBuild = function ()
        if isBuild then
            UIFactory:alertMessge(_TT(93124), true, function() --'分解的道具中包含已经培养过的道具，是否继续分解？'
                self:sendBreak()
            end, nil, nil, true, nil, nil, nil, nil, RemindConst.PROPS_BREAK_BUILD) --确定
            return
        else
            self:sendBreak()
        end
    end

    if hasOrangeProps then
        UIFactory:alertMessge(_TT(4023), true, function() --'分解的道具中包含橙色品质的道具，是否继续分解？'
            nextBuild()
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, RemindConst.PROPS_BREAK_COLOR) --确定
        return
    end

    nextBuild()
end

function onPreview(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_BAG_BREAK_PRE_VIEW, {tabType = self.tabType, suitId = self.suitId})
end

function sendBreak(self)
    GameDispatcher:dispatchEvent(EventName.REQ_BREAK_PROPS)
    self:resetData()
    self:updateView()
end

function updateView(self, cusIsInit)
    if (cusIsInit) then
        self:showSortView()
    end
    self:updatePropsListView(cusIsInit)
    self:updateEmptyTip()
end

function getBagType(self)
    return bag.BagType.Equip
end

function getPrpsList(self)
    -- 普通筛选
    -- local suitFilterType = self.mSortView:getSuitFilterType()
    -- local suitId = suitFilterType ~= -1 and suitFilterType.suitId or suitFilterType
    -- local slotPos = self.mSortView:getPosFilterType() ~= -1 and self.mSortView:getPosFilterType() or nil
    -- local propsList = bag.BagManager:getBagPagePropsList(self.tabType, suitId, slotPos, self.mSortData, self:getBagType())
    -- for i = #propsList, 1, -1 do
    --     if (propsList[i].heroId > 0) then
    --         table.remove(propsList, i)
    --     end
    -- end
    -- return propsList

    -- 特殊筛选
    local colorList, suitIdList, mainAttrKeyList, attachAttrKeyList = self.mSortView:getDetailFilterData()
    local slotPosList = self.mSortView:getPosFilterType() ~= -1 and {self.mSortView:getPosFilterType()} or nil
    local equipList = bag.BagManager:getBagPagePropsList(self.tabType, suitIdList, slotPosList, colorList, self.mSortData, self:getBagType())
    for i = #equipList, 1, -1 do
        local equipVo = equipList[i]
        if (equipVo.heroId > 0) then
            table.remove(equipList, i)
        elseif((mainAttrKeyList and #mainAttrKeyList > 0) or (attachAttrKeyList and #attachAttrKeyList > 0))then
            local filterMainAttrList, filterMainAttrDic, filterAttachAttrList, filterAttachAttrDic = nil, nil, nil, nil
            local totalAttrList, totalAttrDic = equipVo:getTotalAttr()
            if (totalAttrList == nil and totalAttrDic == nil) then
                filterMainAttrList, filterMainAttrDic, filterAttachAttrList, filterAttachAttrDic = equipVo:getFilterAttr()
            else
                filterMainAttrList, filterMainAttrDic = equipVo:getMainAttr()
                filterAttachAttrList, filterAttachAttrDic = equipVo:getTuPoAttachAttr()
            end

            local isHadRemove = false
            if(not isHadRemove and mainAttrKeyList)then
                local isInMainAttr = false
                for _, key in pairs(mainAttrKeyList) do
                    if(filterMainAttrDic[key])then
                        isInMainAttr = true
                        break
                    end
                end
                if(not isInMainAttr)then
                    isHadRemove = true
                    table.remove(equipList, i)
                end
            end

            if(not isHadRemove and attachAttrKeyList)then
                local isHadAllAttachAttr = true
                for _, key in pairs(attachAttrKeyList) do
                    if(not filterAttachAttrDic[key])then
                        isHadAllAttachAttr = false
                        break
                    end
                end
                if(not isHadAllAttachAttr)then
                    isHadRemove = true
                    table.remove(equipList, i)
                end
            end
        end
    end
    return equipList
end

function updatePropsListView(self, cusIsInit)
    local propsList = self:getPrpsList()
    local scrollList = {}
    for pos = 1, #propsList do
        local propsVo = propsList[pos]
        if ((propsVo.isLock ~= 1 or propsVo.heroId == 0) and not equipBuild.EquipPlanManager:isInEquipPlan(propsVo)) then
            local scrollerVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
            scrollerVo:setDataVo(propsVo)
            scrollerVo:setSelect(false)
            table.insert(scrollList, scrollerVo)
        end
    end

    self:recoverListData(self.mGridScroller.DataProvider)
    if (cusIsInit == nil or cusIsInit == true) then
        self.mGridScroller.DataProvider = scrollList
    else
        -- 避免列表跳动
        if (self.mGridScrollerRect.anchoredPosition.y <= 5) then
            self.mGridScroller.DataProvider = scrollList
        else
            self.mGridScroller:ReplaceAllDataProvider(scrollList)
        end
    end
end

function recoverListData(self, list)
    if (list and #list > 0) then
        for i, v in ipairs(list) do
            LuaPoolMgr:poolRecover(v)
        end
    end
end

function updateEmptyTip(self)
    if (self.mGridScroller.Count > 0) then
        self:__setEmptyTip(false)
    else
        self:__setEmptyTip(true)
    end
end

-- 设置空物品提示
function __setEmptyTip(self, isEmpty)
    if (isEmpty) then
        self.EmptyStateItem:SetActive(true)
    else
        self.EmptyStateItem:SetActive(false)
    end
end

-- 分解预览更新
function showBreakView(self, args)
    self:cancelToggeState(args)
    self:clearBreakList()
    local idList = bag.BagManager:getBreakList()
    if not idList then
        return
    end
    local list = {}
    for i, v in ipairs(idList) do
        local propsVo = bag.BagManager:getPropsVoById(idList[i])
        local data = bag.BagManager:getBreakBaseData(propsVo.tid, 2)
        for i, v in ipairs(data.propsList) do
            if not list[v.tid] then
                list[v.tid] = v.count
            else
                list[v.tid] = list[v.tid] + v.count
            end
        end
    end
    for tid, count in pairs(list) do
        local propsVo = props.PropsManager:getPropsVo({tid = tid, num = count})
        local grid = PropsGrid:create(self.mScrollContent, propsVo, 1)
        grid:setIsShowCount(false)
        grid:setIsShowCount2(true)

        table.insert(self.mItemList, grid)
    end

    local len = #idList
    self:setBtnLabel(self.mBtnPreview, 4026, string.format("已选:%s", len), len) --"已选：" .. HtmlUtil:colorAndSize(len, "81cdffff", 22)
    self:onScollOver()
    if (#list > 0) or (#self:getPrpsList() > 0) then
        self.mImgTips:SetActive(false)
    else
        self.mImgTips:SetActive(true)
    end
end

-- 取消全选状态
function cancelToggeState(self, args)
    if not args or args.state == 1 then
        return
    end
    local propsVo = bag.BagManager:getPropsVoById(args.id)
    if self.mToggleG.isOn and propsVo.color == ColorType.GREEN then
        self.mToggleG.onValueChanged:RemoveAllListeners()
        self.mToggleG.isOn = false
        self:addToggleGEvent()
    end
    if self.mToggleB.isOn and propsVo.color == ColorType.BLUE then
        self.mToggleB.onValueChanged:RemoveAllListeners()
        self.mToggleB.isOn = false
        self:addToggleBEvent()
    end
    if self.mToggleP.isOn and propsVo.color == ColorType.VIOLET then
        self.mToggleP.onValueChanged:RemoveAllListeners()
        self.mToggleP.isOn = false
        self:addTogglePEvent()
    end

    if self.mToggleO.isOn and propsVo.color == ColorType.ORANGE then
        self.mToggleO.onValueChanged:RemoveAllListeners()
        self.mToggleO.isOn = false
        self:addToggleOEvent()
    end
end

-- 滚动到最新
function onScollOver(self)
    local scollOver = function()
        if self.mScrollContent.sizeDelta.y >= self.mItemScroller.rect.size.y then
            local pos = self.mScrollContent.anchoredPosition
            local _y = self.mScrollContent.sizeDelta.y - self.mItemScroller.rect.size.y + 10
            TweenFactory:move2LPosY(self.mScrollContent, _y, 0.3)
        end
    end
    self:clearTimeout(self.tid)
    self.tid = self:setTimeout(0.1, scollOver)
end

function clearBreakList(self)
    for i = #self.mItemList, 1, -1 do
        local item = self.mItemList[i]
        item:poolRecover()
        table.remove(self.mItemList, i)
    end
end

function resetData(self)
    self.mToggleG.isOn = false
    self.mToggleB.isOn = false
    self.mToggleP.isOn = false
    self.mToggleO.isOn = false
    self.mIsOpenPreview = false
    self:clearBreakList()
    -- 清楚缓存数据
    bag.BagManager:clearSellBreakData()
end

-- 移除
function destroy(self, isAuto)
    super.destroy(self, isAuto)
    if self.mSortView then
        self.mSortView:destroy()
        self.mSortView = nil
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
