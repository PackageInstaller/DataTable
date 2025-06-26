--[[ 
-----------------------------------------------------
@filename       : EquipFilterRulePanel
@Description    : 筛选界面
@date           : 2023-12-6 00:00:00
@Author         : Zzz
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("game.bag.view.EquipFilterRulePanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("bag/EquipFilterRulePanel.prefab")
panelType = 2 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isBlur = 1 -- 是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
isAdapta = 0 -- 是否开启适配刘海 0 否 1 是

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1122, 522)
    self:setTxtTitle(_TT(4237)) --"筛选规则"
end

-- 取父容器
function getParentTrans(self)
    return super.getParentTrans(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.mColorItemDic = {}
    self.mSuitItemDic = {}
    self.mMainAttrItemDic = {}
    self.mSecondaryAttrItemDic = {}
    self:initSelectList()
end

function initSelectList(self)
    self.mSelectColorList = {}
    self.mSelectSuitConfigVoList = {}
    self.mSelectMainAttrConfigVoList = {}
    self.mSelectSecondaryAttrConfigVoList = {}
end

function configUI(self)
    super.configUI(self)

    self.mBtnReset = self:getChildGO("mBtnReset")
    self.mBtnConfirm = self:getChildGO("mBtnConfirm")
    
    self.mTxtColorTitle = self:getChildGO("mTxtColorTitle"):GetComponent(ty.Text)
    self.GroupSuitTitle = self:getChildGO("GroupSuitTitle")
    self.mGroupColor = self:getChildTrans("GroupColor")
    self.mItemColor = self:getChildGO("ItemColor")
    
    self.mTxtSuitTitle = self:getChildGO("mTxtSuitTitle"):GetComponent(ty.Text)
    self.mGroupSuit = self:getChildTrans("GroupSuit")
    self.mSelectSuitEnter = self:getChildGO("SelectSuitEnter")
    self.mTxtSuitTip = self:getChildGO("mTxtSuitTip"):GetComponent(ty.Text)
    self.mItemSuit = self:getChildGO("ItemSuit")
    
    self.mTxtMainAttrTitle = self:getChildGO("mTxtMainAttrTitle"):GetComponent(ty.Text)
    self.mGroupMainAttr = self:getChildTrans("GroupMainAttr")
    self.mSelectMainAttrEnter = self:getChildGO("SelectMainAttrEnter")
    self.mTxtMainAttrTip = self:getChildGO("mTxtMainAttrTip"):GetComponent(ty.Text)
    self.mItemMainAttr = self:getChildGO("ItemMainAttr")
    
    self.mTxtSecondaryAttrTitle = self:getChildGO("mTxtSecondaryAttrTitle"):GetComponent(ty.Text)
    self.mGroupSecondaryAttr = self:getChildTrans("GroupSecondaryAttr")
    self.mSelectSecondaryAttrEnter = self:getChildGO("SelectSecondaryAttrEnter")
    self.mTxtSecondaryAttrTip = self:getChildGO("mTxtSecondaryAttrTip"):GetComponent(ty.Text)
    self.mItemSecondaryAttr = self:getChildGO("ItemSecondaryAttr")    
end

function hideAgentInfo(self)
    self.mGroupColor.gameObject:SetActive(false)
    self.GroupSuitTitle.gameObject:SetActive(false)
    self.mSelectSuitEnter:SetActive(false)
end

function initViewText(self)
    self:setBtnLabel(self.mBtnReset, 4238, "重置")
    self:setBtnLabel(self.mBtnConfirm, 1, "确定")
    self.mTxtColorTitle.text = _TT(577) --"品质"

    self.mTxtSuitTitle.text = _TT(1316) --"套装属性"
    self.mTxtSuitTip.text = _TT(4239) --"点击选择"

    self.mTxtMainAttrTitle.text = _TT(1331) --"主属性"
    self.mTxtMainAttrTip.text = _TT(4239) --"点击选择"

    self.mTxtSecondaryAttrTitle.text = _TT(1422) --"附加属性"
    self.mTxtSecondaryAttrTip.text = _TT(4239) --"点击选择"
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnReset, self.onClickResetHandler)
    self:addUIEvent(self.mBtnConfirm, self.onClickConfirmHandler)

    self:addUIEvent(self.mSelectSuitEnter, self.onClickSuitHandler)
    self:addUIEvent(self.mSelectMainAttrEnter, self.onClickMainAttrHandler)
    self:addUIEvent(self.mSelectSecondaryAttrEnter, self.onClickSecondaryAttrHandler)
end

function close(self)
    super.close(self)
end

function onClickClose(self)
    super.onClickClose(self)
end

-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    super.onCloseAllCall(self)
end

function active(self, args)
    super.active(self, args)
    
    self.mCallFun = args.callFun
    self.mSelectColorList = args.selectColorList
    self.mSelectSuitConfigVoList = args.suitConfigVoList
    self.mSelectMainAttrConfigVoList = args.selectMainAttrConfigVoList
    self.mSelectSecondaryAttrConfigVoList = args.selectSecondaryAttrConfigVoList

    self:updateView()
end

function deActive(self)
    super.deActive(self)
    self:clearColorItem()
    self:clearSuitItem()
    self:clearMainAttrItem()
    self:clearSecondaryAttrItem()
    self:initSelectList()
end

function onClickResetHandler(self)
    self:initSelectList()
    self:updateView()
end

function onClickConfirmHandler(self)
    self.mCallFun(self.mSelectColorList, self.mSelectSuitConfigVoList, self.mSelectMainAttrConfigVoList, self.mSelectSecondaryAttrConfigVoList)
    self:initSelectList()
    self:close()
end

function onClickSuitHandler(self)
    self:onOpenEquipFilterRuleSubPanel(1, self.mSelectSuitConfigVoList, 
    function(selectList)
        self.mSelectSuitConfigVoList = selectList
        self:updateSuitView()
    end)
end

function onClickMainAttrHandler(self)
    self:onOpenEquipFilterRuleSubPanel(2, self.mSelectMainAttrConfigVoList, 
    function(selectList)
        self.mSelectMainAttrConfigVoList = selectList
        self:updateMainAttrView()
    end)
end

function onClickSecondaryAttrHandler(self)
    self:onOpenEquipFilterRuleSubPanel(3, self.mSelectSecondaryAttrConfigVoList, 
    function(selectList)
        self.mSelectSecondaryAttrConfigVoList = selectList
        self:updateSecondaryAttrView()
    end)
end

function onEquipPlanSelectHandler(self, args)
    self:updateView()
end

function updateView(self)
    self:updateColorView()
    self:updateSuitView()
    self:updateMainAttrView()
    self:updateSecondaryAttrView()
end

function updateColorView(self)
    self:clearColorItem()
    local list = {ColorType.GREEN, ColorType.BLUE, ColorType.VIOLET, ColorType.ORANGE}
    for i = 1, #list do
        local color = list[i]
        local item = SimpleInsItem:create(self.mItemColor, self.mGroupColor, "mItemColor")
        item:getChildGO("mTxtName"):GetComponent(ty.Text).text = bag.getNameByColor(color)
        item:getChildGO("mImgSelect"):SetActive(table.indexof(self.mSelectColorList, color) ~= false)
        item:addUIEvent(nil, function()
            local index = table.indexof(self.mSelectColorList, color)
            if(index ~= false)then
                table.remove(self.mSelectColorList, index)
            else
                table.insert(self.mSelectColorList, color)
            end
            self:updateColorView()
        end)
        self.mColorItemDic[i] = item
    end
end

function updateSuitView(self)
    self:clearSuitItem()
    local suitConfigList = self.mSelectSuitConfigVoList
    for i = 1, #suitConfigList do
        local suitConfigVo = suitConfigList[i]
        local item = SimpleInsItem:create(self.mItemSuit, self.mGroupSuit, "mItemSuit")
        item:getChildGO("mTxtName"):GetComponent(ty.Text).text = suitConfigList[i].name
        item:addUIEvent(nil, function()
            local index = table.indexof(self.mSelectSuitConfigVoList, suitConfigVo)
            if(index ~= false)then
                table.remove(self.mSelectSuitConfigVoList, index)
            end
            self:updateSuitView()
        end)
        self.mSuitItemDic[i] = item
    end
    self.mGroupSuit.gameObject:SetActive(#suitConfigList > 0)
end

function updateMainAttrView(self)
    self:clearMainAttrItem()
    local mainAttrList = self.mSelectMainAttrConfigVoList
    for i = 1, #mainAttrList do
        local mainAttrVo = mainAttrList[i]
        local item = SimpleInsItem:create(self.mItemMainAttr, self.mGroupMainAttr, "mItemMainAttr")
        item:getChildGO("mTxtName"):GetComponent(ty.Text).text = AttConst.getName(mainAttrVo:getRefID())
        item:addUIEvent(nil, function()
            local index = table.indexof(self.mSelectMainAttrConfigVoList, mainAttrVo)
            if(index ~= false)then
                table.remove(self.mSelectMainAttrConfigVoList, index)
            end
            self:updateMainAttrView()
        end)
        self.mMainAttrItemDic[i] = item
    end
    self.mGroupMainAttr.gameObject:SetActive(#mainAttrList > 0)
end

function updateSecondaryAttrView(self)
    self:clearSecondaryAttrItem()
    local secondaryAttrList = self.mSelectSecondaryAttrConfigVoList
    for i = 1, #secondaryAttrList do
        local secondaryAttrVo = secondaryAttrList[i]
        local item = SimpleInsItem:create(self.mItemSecondaryAttr, self.mGroupSecondaryAttr, "mItemSecondaryAttr")
        item:getChildGO("mTxtName"):GetComponent(ty.Text).text = AttConst.getName(secondaryAttrVo:getRefID())
        item:addUIEvent(nil, function()
            local index = table.indexof(self.mSelectSecondaryAttrConfigVoList, secondaryAttrVo)
            if(index ~= false)then
                table.remove(self.mSelectSecondaryAttrConfigVoList, index)
            end
            self:updateSecondaryAttrView()
        end)
        self.mSecondaryAttrItemDic[i] = item
    end
    self.mGroupSecondaryAttr.gameObject:SetActive(#secondaryAttrList > 0)
end

function clearColorItem(self)
    for _, item in pairs(self.mColorItemDic) do
        item:poolRecover()
    end
    self.mColorItemDic = {}
end

function clearSuitItem(self)
    for _, item in pairs(self.mSuitItemDic) do
        item:poolRecover()
    end
    self.mSuitItemDic = {}
end

function clearMainAttrItem(self)
    for _, item in pairs(self.mMainAttrItemDic) do
        item:poolRecover()
    end
    self.mMainAttrItemDic = {}
end

function clearSecondaryAttrItem(self)
    for _, item in pairs(self.mSecondaryAttrItemDic) do
        item:poolRecover()
    end
    self.mSecondaryAttrItemDic = {}
end

-- 装备筛选规则子界面
function onOpenEquipFilterRuleSubPanel(self, type, list, callFun)
    if self.mEquipFilterRuleSubPanel == nil then
        self.mEquipFilterRuleSubPanel = UI.new(bag.EquipFilterRuleSubPanel)
        self.mEquipFilterRuleSubPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEquipFilterRuleSubPanelHandler, self)
    end
    self.mEquipFilterRuleSubPanel:open({type = type, list = list, callFun = callFun})
end

-- ui销毁
function onDestroyEquipFilterRuleSubPanelHandler(self)
    self.mEquipFilterRuleSubPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEquipFilterRuleSubPanelHandler, self)
    self.mEquipFilterRuleSubPanel = nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]