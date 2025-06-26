--[[ 
-----------------------------------------------------
@filename       : OrderFactoryPanel
@Description    : 序列物加工厂
@date           : 2021-06-23 20:23:43
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.orderFactory.view.OrderFactoryPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("orderFactory/OrderFactoryPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setBg("orderFactory_bg.jpg", false, "orderFactory")
end
--析构  
function dtor(self)
end

function initData(self)
    self.mMaterialItemList = {}
    self.mJobItemList = {}
    self.mMaterialTweenDic = {}
    self.curJobItem = nil
    -- 筛选类型
    self.mSortType = 0
    -- 选择的装备vo
    self.m_selectEquipVo = nil
    -- 已穿戴的装备界面起始X坐标
    self.m_hasStartPosX = 700
    -- 已选择的装备格子
    self.m_hasSelectGrid = nil
    -- 已选择的获取资源的保存类型
    self.m_hasSelectSaveType = "HasSelectSaveType"
end

-- 初始化
function configUI(self)
    -- self.mTxtListTitle = self:getChildGO("mTxtListTitle"):GetComponent(ty.Text)
    self.mGroupList = self:getChildTrans("mGroupList")

    self.mTxtOrderName = self:getChildGO("mTxtOrderName"):GetComponent(ty.Text)
    self.mGroupMaterialShow = self:getChildGO("mGroupMaterialShow")
    self.mImgProduct = self:getChildGO("mImgProduct"):GetComponent(ty.AutoRefImage)
    self.mImgMaterialInfoBg = self:getChildGO("mImgMaterialInfoBg")
    self.mTxtMaterial = self:getChildGO("mTxtMaterial"):GetComponent(ty.Text)

    self.mGroupMaterial = self:getChildTrans("mGroupMaterial")
    self.mGroupBagTrans = self:getChildTrans("mGroupBagTrans")

    self.mBtnClear = self:getChildGO("mBtnClear")
    self.mBtnProcess = self:getChildGO("mBtnProcess")
    self.mBtnOneKey = self:getChildGO("mBtnOneKey")
    self.mGroupCost = self:getChildGO("mGroupCost")
    self.mTxtCostLab = self:getChildGO("mTxtCostLab"):GetComponent(ty.Text)
    self.mTxtCost = self:getChildGO("mTxtCost"):GetComponent(ty.Text)
    self.mImgCostIcon = self:getChildGO("mImgCostIcon"):GetComponent(ty.AutoRefImage)

    self.mMeterialScroller = self:getChildGO("mMeterialScroller"):GetComponent(ty.LyScroller)
    self.mMeterialScroller:SetItemRender(orderFactory.OrderFactoryBagScrollerItem)
    self.mTxtEmptyTip = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)

    self.frameView = self:getChildGO('frameView')
    self.mImgPrevent = self:getChildGO('mImgPrevent')
    self.m_groupHasSelect = self:getChildGO('GroupHasSelect')
    self.m_groupHasSelectCG = self.m_groupHasSelect:GetComponent(ty.CanvasGroup)
    self.m_rectHasSelect = self.m_groupHasSelect:GetComponent(ty.RectTransform)

    self.mGroupFilter = self:getChildTrans("mGroupFilter")

    self:createMaterialItem()
end

--激活
function active(self)
    super.active(self)
    orderFactory.OrderFactoryManager:addEventListener(orderFactory.OrderFactoryManager.EVENT_MATERIAL_SELECT_UPDATE, self.onEquipListSelectHandler, self)
    orderFactory.OrderFactoryManager:addEventListener(orderFactory.OrderFactoryManager.EVENT_PROCESS_SUCCESS, self.onProcessSuccessHandler, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.onMoneyUpdateHandler, self)

    self:updateJobList()
    self:updateFilterList()
    self:updateCost()
    self:updateOrderBagView(true)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    orderFactory.OrderFactoryManager:removeEventListener(orderFactory.OrderFactoryManager.EVENT_MATERIAL_SELECT_UPDATE, self.onEquipListSelectHandler, self)
    orderFactory.OrderFactoryManager:removeEventListener(orderFactory.OrderFactoryManager.EVENT_PROCESS_SUCCESS, self.onProcessSuccessHandler, self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.onMoneyUpdateHandler, self)
    self:recoverMaterialItemList()
    self:recoverJobItemList()
    self:__cleanSimObj()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
    self.mTxtCostLab.text = _TT(43703) --"消耗"
    self.mTxtEmptyTip.text = _TT(43701) --"无符合条件的序列物"
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mGroupBagTrans.gameObject, self.onCloseBagView)
    self:addUIEvent(self.mBtnProcess, self.onProcessHandler)
    self:addUIEvent(self.mBtnClear, self.onClearSelect)
    self:addUIEvent(self.mBtnOneKey, self.onOnekey)
    self:addUIEvent(self.mImgPrevent, self.onCloseTips)
    self:addUIEvent(self.frameView, self.onCloseTips)
end

function onEquipListSelectHandler(self, args)
    self:updateOrderBagView(false)
    self:updateMaterialItem()

    if self.mIsOneKey then
        return
    end

    self:__cleanSimObj(self.m_hasEquipSaveType)
    if args.state == 1 then
        self.m_selectEquipVo = bag.BagManager:getPropsVoById(args.id)
        self:updateHasSelectVisible(true)
    else
        self:updateHasSelectVisible(false)
    end
end
function onProcessSuccessHandler(self)
    self:onClearSelect()
    self:updateHasSelectVisible(false)
end

function onProcessHandler(self)
    if not orderFactory.OrderFactoryManager:isFullMaterial() then
        -- gs.Message.Show2("材料不足")
        gs.Message.Show2(_TT(43702))
        return
    end
    if not MoneyUtil.judgeNeedMoneyCountByTid(self.mSeleclVo.payType, self.mSeleclVo.payNum, false, true) then
        return
    end
    GameDispatcher:dispatchEvent(EventName.REQ_ORDER_PROCESS, { processId = self.mSeleclVo.id })
end

function onMoneyUpdateHandler(self)
    self:updateCost()
end

-- 清楚选择
function onClearSelect(self)
    orderFactory.OrderFactoryManager:clearSelectMaterialList()
    self:updateOrderBagView(true)
    self:updateMaterialItem()
end

-- 一键添加
function onOnekey(self)
    self.mIsOneKey = true
    self:onClearSelect()
    self:onKeyAddHandler()
    self.mIsOneKey = false
end

function onCloseTips(self)
    self.m_selectEquipVo = nil
    self:updateHasSelectVisible()
end

-- 一键添加数据处理
function onKeyAddHandler(self)
    local equipList = orderFactory.OrderFactoryManager:getEquipList(bag.BagTabType.ORDER, self.mMaterialColor, self.mSortType)
    if not equipList or #equipList <= 0 then
        -- gs.Message.Show("无符合条件的序列物")
        gs.Message.Show(_TT(43701))
        return
    end
    for i = 1, #equipList do
        local equipVo = equipList[i]
        orderFactory.OrderFactoryManager:setSelectMaterialList(equipVo.id)
        if orderFactory.OrderFactoryManager:isFullMaterial() then
            break
        end
    end
end

-- 更新消耗
function updateCost(self)
    if not self.mSeleclVo then
        return
    end
    self.mTxtCost.text = self.mSeleclVo.payNum
    self.mImgCostIcon:SetImg(MoneyUtil.getMoneyIconUrlByTid(self.mSeleclVo.payType), true)
end

-- 更新加工列表
function updateJobList(self)
    self:recoverJobItemList()
    local list = orderFactory.OrderFactoryManager:getProcessList()
    for i, v in ipairs(list) do
        local item = SimpleInsItem:create(self:getChildGO("GroupJobItem"), self.mGroupList, "OrderFactoryPanelJobItem")
        item:getChildGO("mImgOrder"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(string.format("orderFactory/orderFactory_tab_%s.png", v.color)), true)
        -- item:setText("mTxtName", v.productDes)
        -- item:setText("mTxtMsg", v.materialDes)
        gs.TransQuick:LPosX(item:getChildTrans("mImgOrder"), -7.7)
        item:getChildGO("mImgSelect"):SetActive(false)
        item:getChildGO("mImgQuestion"):SetActive(false)
        item:addUIEvent("mBtnJob", function()
            self:onJobSelect(v, item)
        end)
        table.insert(self.mJobItemList, item)

        if i == 1 then
            self:onJobSelect(v, item)
        end
    end
end
-- 回收项
function recoverJobItemList(self)
    if self.mJobItemList then
        for i, v in pairs(self.mJobItemList) do
            v:poolRecover()
        end
    end
    self.mJobItemList = {}
    self.curJobItem = nil
end

function onJobSelect(self, vo, item)
    if self.curJobItem == item then
        return
    end
    if self.curJobItem then
        self.curJobItem:getChildGO("mImgSelect"):SetActive(false)
        self.curJobItem:getChildGO("mImgQuestion"):SetActive(false)
        gs.TransQuick:LPosX(self.curJobItem:getChildTrans("mImgOrder"), -7.7)
    end
    self.curJobItem = item
    self.curJobItem:getChildGO("mImgSelect"):SetActive(true)
    self.curJobItem:getChildGO("mImgQuestion"):SetActive(true)
    gs.TransQuick:LPosX(self.curJobItem:getChildTrans("mImgOrder"), 21.5)

    self:onClearSelect()
    self:updateProduceArea(vo)
    
    if self.mAllFilterItem then
        self:onFilterSelect(0, self.mAllFilterItem)
    end
end

-- 更新生产区域
function updateProduceArea(self, cusVo)
    if cusVo then
        self.mSeleclVo = cusVo
        self.mGroupMaterialShow:SetActive(true)
        self.mImgMaterialInfoBg:SetActive(true)
        self.mBtnProcess:SetActive(true)
        self.mGroupCost:SetActive(true)
        self.mBtnClear:SetActive(true)
        self.mTxtOrderName.gameObject:SetActive(true)
        self.mImgProduct.gameObject:SetActive(true)
        self.mImgProduct:SetImg(UrlManager:getPackPath(string.format("orderFactory/orderFactory_product_%s.png", cusVo.color)), true)
        self.mTxtMaterial.text = _TT(cusVo.materialDes)
        self.mTxtOrderName.text = _TT(cusVo.productDes)

        self.mMaterialColor = self.mSeleclVo.materialColor
        self:showMaterialItem(cusVo)
        self:updateOrderBagView(true)
        self:updateCost()
        -- 设置材料数量
        orderFactory.OrderFactoryManager.needMaterialCount = cusVo.materialNum
    else
        self.mGroupMaterialShow:SetActive(false)
        self.mImgMaterialInfoBg:SetActive(false)
        self.mBtnProcess:SetActive(false)
        self.mGroupCost:SetActive(false)
        self.mBtnClear:SetActive(false)
        self.mTxtOrderName.gameObject:SetActive(false)
        self.mImgProduct.gameObject:SetActive(false)
        self:updateOrderBagView(true)
    end
end
-- 初始化材料列表
function createMaterialItem(self)
    for i = 1, 5 do
        local item = SimpleInsItem:create2(self:getChildGO(string.format("mMaterialItem_%s", i)))
        item:getChildGO("mImgMaterialIcon"):SetActive(false)
        -- item:addUIEvent("mGroupClick", function()
        --     self:onShowMaterialBagView(i)
        -- end)
        table.insert(self.mMaterialItemList, item)
    end
end
-- 更新材料列表显示 
function showMaterialItem(self, cusVo)
    for i = 1, #self.mMaterialItemList do
        local item = self.mMaterialItemList[i]
        item:getChildGO("mImgMaterialIcon"):SetActive(false)
        local isShow = table.indexof(cusVo.posList, i)
        item.m_go:SetActive(isShow ~= false)
        self:showTween(i)
    end
end

-- 更新材料列表
function updateMaterialItem(self)
    if not self.mSeleclVo then
        return
    end
    local index = 1
    local selectList = orderFactory.OrderFactoryManager:getSelectMaterialList()
    for i, item in ipairs(self.mMaterialItemList) do
        local isShow = table.indexof(self.mSeleclVo.posList, i) ~= false
        if isShow and selectList[index] then
            item:getChildGO("mImgMaterialIcon"):SetActive(true)
            local vo = bag.BagManager:getPropsVoById(selectList[index])
            item:getChildGO("mImgMaterialIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPropsIconUrl(vo.tid), false)
            index = index + 1
        else
            item:getChildGO("mImgMaterialIcon"):SetActive(false)
        end
    end
end

-- 回收项
function recoverMaterialItemList(self)
    if self.mMaterialItemList then
        for i, v in pairs(self.mMaterialItemList) do
            v:poolRecover()
        end
    end

    orderFactory.OrderFactoryManager.needMaterialCount = 0
    orderFactory.OrderFactoryManager:clearSelectMaterialList()
end

function showTween(self, index)
    local item = self.mMaterialItemList[index]
    local tweener = self.mMaterialTweenDic[index]

    if tweener then
        tweener:Kill()
        tweener = nil
    end

    if index == 1 then
        gs.TransQuick:LPosX(item.m_trans, -230)
        tweener = TweenFactory:move2LPosX(item.m_trans, -153.7, 0.3, gs.DT.Ease.Linear)
    end
    if index == 2 then
        gs.TransQuick:LPosX(item.m_trans, -250)
        tweener = TweenFactory:move2LPosX(item.m_trans, -194.45, 0.3, gs.DT.Ease.Linear)
    end
    if index == 3 then
        gs.TransQuick:LPosY(item.m_trans, -190)
        tweener = TweenFactory:move2LPosY(item.m_trans, -102.7, 0.3, gs.DT.Ease.Linear)
    end
    if index == 4 then
        gs.TransQuick:LPosX(item.m_trans, 180)
        tweener = TweenFactory:move2LPosX(item.m_trans, 113.9, 0.3, gs.DT.Ease.Linear)
    end
    if index == 5 then
        gs.TransQuick:LPosY(item.m_trans, 130)
        tweener = TweenFactory:move2LPosY(item.m_trans, 76, 0.3, gs.DT.Ease.Linear)
    end

    self.mMaterialTweenDic[index] = tweener
    TweenFactory:canvasGroupAlphaTo(item.m_go:GetComponent(ty.CanvasGroup), 0, 1, 0.3, gs.DT.Ease.Linear)

end

-- function onShowMaterialBagView(self)
--     local color = self.mSeleclVo.materialColor
--     self:onOpenOrderBagHandler(color)
-- end
-- -- 序列物背包
-- function onOpenOrderBagHandler(self, cusColor)
--     if self.gOrderBagView == nil then
--         self.gOrderBagView = UI.new(orderFactory.OrderFactoryBagPanel)
--     end
--     self.gOrderBagView:show(self.mGroupBagTrans, cusColor)
--     self.mGroupBagTrans.gameObject:SetActive(true)
-- end
-- -- 关闭序列物背包
-- function onCloseOrderBagViewHandler(self)
--     if self.gOrderBagView then
--         self.gOrderBagView:destroy()
--         self.gOrderBagView = nil
--     end
--     self.mGroupBagTrans.gameObject:SetActive(false)
-- end
-- function onCloseBagView(self)
--     if self.gOrderBagView and self.gOrderBagView:isShowSelectTips() then
--         self.gOrderBagView:updateHasSelectVisible(false)
--     else
--         self:onCloseOrderBagViewHandler()
--     end
-- end
-----------------------------------------------------------------------------------
-- 更新筛选列表
function updateFilterList(self)
    self:recoverFilterItemList()

    -- 全部
    self.mAllFilterItem = SimpleInsItem:create2(self:getChildGO("mFilterAllItem"))
    self.mAllFilterItem:getChildGO("mBtnNomal"):SetActive(true)
    self.mAllFilterItem:getChildGO("mBtnSelect"):SetActive(false)
    self.mAllFilterItem:addUIEvent("mBtnNomal", function()
        self:onFilterSelect(0, self.mAllFilterItem)
    end)

    self:onFilterSelect(0, self.mAllFilterItem)

    -- 其他
    local list = { 2, 3, 4 }
    for i, v in ipairs(list) do
        local item = SimpleInsItem:create(self:getChildGO("GroupFilterTypeItem"), self.mGroupFilter, "OrderFactoryPanelFilterTypeItem")
        item:getChildGO("mImgNomal"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(string.format("covenantTalent/covenantTalent_type_%s_2.png", v)), true)
        item:getChildGO("mImgSelect"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(string.format("covenantTalent/covenantTalent_type_%s_2.png", v)), true)
        -- item:setText("mTxtName", v.productDes)
        -- item:setText("mTxtMsg", v.materialDes)
        item:getChildGO("mBtnNomal"):SetActive(true)
        item:getChildGO("mBtnSelect"):SetActive(false)
        item:addUIEvent("mBtnNomal", function()
            self:onFilterSelect(v, item)
        end)
        table.insert(self.mFilterItemList, item)

    end
end
-- 回收项
function recoverFilterItemList(self)
    if self.mFilterItemList then
        for i, v in pairs(self.mFilterItemList) do
            v:poolRecover()
        end
    end
    self.mFilterItemList = {}
    self.curFilterItem = nil
end

function onFilterSelect(self, type, item)
    if self.curFilterItem then
        self.curFilterItem:getChildGO("mBtnNomal"):SetActive(true)
        self.curFilterItem:getChildGO("mBtnSelect"):SetActive(false)
    end
    self.curFilterItem = item
    self.curFilterItem:getChildGO("mBtnSelect"):SetActive(true)
    self.curFilterItem:getChildGO("mBtnNomal"):SetActive(false)

    self.mSortType = type
    self:updateOrderBagView(true)
end

------------------------------------------------------------------------------------
-- 更新背包界面
function updateOrderBagView(self, cusIsInit)
    local selectList = orderFactory.OrderFactoryManager:getSelectMaterialList()

    local equipList = orderFactory.OrderFactoryManager:getEquipList(bag.BagTabType.ORDER, self.mMaterialColor, self.mSortType)
    local isSelectInList = false
    local scrollList = {}
    local _startIndex = 0
    for i = 1, #equipList do
        local equipVo = equipList[i]
        local scrollerVo = LyScrollerSelectVo.new()
        scrollerVo:setDataVo(equipVo)
        scrollerVo:setSelect(false)

        if table.indexof(selectList, equipVo.id) ~= false then
            isSelectInList = true
            scrollerVo:setSelect(true)
        end

        table.insert(scrollList, scrollerVo)
    end
    -- 选择了的装备信息如果不在列表里则置空
    if (not isSelectInList) then
        self.m_selectEquipVo = nil
    end

    if (self.mMeterialScroller.Count <= 0 or cusIsInit == nil or cusIsInit == true) then
        self.mMeterialScroller.DataProvider = scrollList
    else
        self.mMeterialScroller:ReplaceAllDataProvider(scrollList)
    end
    self.mTxtEmptyTip.gameObject:SetActive(#scrollList <= 0)

end

-- 更新选中装备的界面
function updateHasSelectVisible(self, cusIsShow)
    local isShow
    if (self.m_selectEquipVo) then
        isShow = true
    else
        isShow = false
    end
    if cusIsShow ~= nil then
        isShow = cusIsShow
    end
    self:__updateSelectGroupVisible(isShow)

    if (isShow) then
        local childGos, childTrans = GoUtil.GetChildHash(self.m_groupHasSelect)
        self:__updateHasEquipView(childGos, childTrans, self.m_selectEquipVo, self.m_hasSelectSaveType)
    end
end

function __updateSelectGroupVisible(self, isShow)
    local hasSPosX = self.m_hasStartPosX
    local hasEposX = -1025
    local hasTX = hasEposX - hasSPosX
    if isShow then
        self.mImgPrevent:SetActive(true)
        self.m_groupHasSelect:SetActive(true)
        TweenFactory:canvasGroupAlphaTo(self.m_groupHasSelectCG, 0, 1, 0.2, gs.DT.Ease.Linear)
        TweenFactory:scaleTo(self.m_rectHasSelect, { x = 1.05, y = 1.05, z = 1.05 }, { x = 1, y = 1, z = 1 }, 0.4, gs.DT.Ease.Linear)
    else
        self.mImgPrevent:SetActive(false)
        self.m_groupHasSelect:SetActive(false)
        TweenFactory:scaleTo(self.m_rectHasSelect, { x = 1.1, y = 1.1, z = 1.1 }, { x = 1, y = 1, z = 1 }, 0.2, gs.DT.Ease.Linear)
    end
end

function __updateHasEquipView(self, childGos, childTrans, equipVo, saveType)
    if (not childGos or not childTrans or not equipVo) then
        return
    end
    if (self.m_selectEquipDataLoadCompleteHandler) then
        equipVo:removeEventListener(equipVo.UPDATE_EQUIP_DETAIL_DATA, self.m_selectEquipDataLoadCompleteHandler, self)
        self.m_selectEquipDataLoadCompleteHandler = nil
    end
    if (equipVo:getTotalAttr() == nil) then
        self.m_selectEquipDataLoadCompleteHandler = function()
            self:__updateHasEquipView(childGos, childTrans, equipVo, saveType)
        end
        equipVo:addEventListener(equipVo.UPDATE_EQUIP_DETAIL_DATA, self.m_selectEquipDataLoadCompleteHandler, self)
        return
    end

    -- 更新基本显示
    childGos["TextName"]:GetComponent(ty.Text).text = equipVo:getName()

    self:__updateInfo(childGos, childTrans, equipVo, saveType)
    self:__updateBaseAttr(childGos, childTrans, equipVo, saveType)
    self:__updateSkill(childGos, childTrans, equipVo, saveType)
end

-- 更新信息
function __updateInfo(self, childGos, childTrans, equipVo, saveType)
    childGos["TextName"]:GetComponent(ty.Text).text = equipVo.name
    childGos["TextLvlTitle"]:GetComponent(ty.Text).text = _TT(27129) --"等级"
    if (saveType == self.m_hasEquipSaveType) then
        if (self.m_hasEquipGrid) then
            self.m_hasEquipGrid:poolRecover()
            self.m_hasEquipGrid = nil
        end
        self.m_hasEquipGrid = OrderGrid:create(childTrans['EquipNode'], equipVo, 0.4)
        self.m_hasEquipGrid:setClickEnable(false)
    else
        if (self.m_hasSelectGrid) then
            self.m_hasSelectGrid:poolRecover()
            self.m_hasSelectGrid = nil
        end
        self.m_hasSelectGrid = OrderGrid:create(childTrans['EquipNode'], equipVo, 0.4)
        self.m_hasSelectGrid:setClickEnable(false)
    end

    if (saveType == self.m_hasEquipSaveType) then
        childGos['HeroIconWearFor']:SetActive(false)
    elseif (saveType == self.m_hasSelectSaveType) then
        if (equipVo.heroId == 0) then
            childGos['HeroIconWearFor']:SetActive(false)
        else
            childGos['HeroIconWearFor']:SetActive(true)
            local heroVo = hero.HeroManager:getHeroVo(equipVo.heroId)
            childGos["ImgHero"]:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getHeroHeadUrl(heroVo.tid), false)
            childGos["TextHeroWearState"]:GetComponent(ty.Text).text = _TT(4329) --"穿戴中"
        end
    end

    local isCanRefine = braceletsBuild.BraceletsRefineManager:isCanRefine(equipVo.tid)
    if (isCanRefine) then
        childGos["GroupRefineLvl"]:SetActive(true)
        local maxRefineLvl = braceletsBuild.BraceletsRefineManager:getMaxRefineLvl(equipVo.tid)
        for lvl = 1, maxRefineLvl do
            local item = self:__getSimpleObj(childGos["ItemRefineLvl"], childTrans["GroupRefineLvl"], saveType)
            item:getChildGO("ImgRefineLvl"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getBraceletsRefineLvlIconUrl(equipVo.refineLvl < lvl), true)
        end
    else
        childGos["GroupRefineLvl"]:SetActive(false)
    end
end

-- 更新基础属性
function __updateBaseAttr(self, childGos, childTrans, equipVo, saveType)
    local totalAttrList, totalAttrDic = equipVo:getTotalAttr()
    for i = 1, #totalAttrList do
        local attrVo = totalAttrList[i]
        local attrTValue = 0

        attrTValue = attrVo.value

        if (attrTValue > 0) then
            local item = self:__getSimpleObj(childGos["AttrItem"], childTrans["GroupAttr"], saveType)
            item:getChildGO("TextAttrName"):GetComponent(ty.Text).text = AttConst.getName(attrVo.key)
            item:getChildGO("TextAttrValue"):GetComponent(ty.Text).text = AttConst.getValueStr(attrVo.key, attrTValue)
        end
    end
end

-- 更新技能
function __updateSkill(self, childGos, childTrans, equipVo, saveType)
    local skillEffectList, skillEffectDic = equipVo:getSkillEffect()
    if (skillEffectList and #skillEffectList > 0) then
        for i = 1, #skillEffectList do
            local skillVo = fight.SkillManager:getSkillRo(skillEffectList[i].skillId)
            local item = self:__getSimpleObj(childGos["ItemSkill"], childTrans["GroupSkill"], saveType)
            item:getChildGO("TextSkillTitle"):GetComponent(ty.Text).text = skillVo:getName()
            local des = equip.EquipSkillManager:getSkillDes(equipVo, skillEffectList[i])
            item:getChildGO("TextSkill"):GetComponent(ty.Text).text = des
        end
    end
end

function __getSimpleObj(self, go, parentsTrans, saveType)
    local item = SimpleInsItem:create(go, parentsTrans)
    if (not self.m_simpleObjDic) then
        self.m_simpleObjDic = {}
    end
    if (not self.m_simpleObjDic[saveType]) then
        self.m_simpleObjDic[saveType] = {}
    end
    table.insert(self.m_simpleObjDic[saveType], item)
    return item
end

function __cleanSimObj(self, saveType)
    if (self.m_simpleObjDic) then
        if (saveType) then
            if (self.m_simpleObjDic[saveType]) then
                for i = #self.m_simpleObjDic[saveType], 1, -1 do
                    local item = self.m_simpleObjDic[saveType][i]
                    item:poolRecover()
                end
            end
            self.m_simpleObjDic[saveType] = {}
        else
            for saveType, list in pairs(self.m_simpleObjDic) do
                for i = #list, 1, -1 do
                    local item = list[i]
                    item:poolRecover()
                end
                self.m_simpleObjDic[saveType] = {}
            end
        end
    end
end
return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
