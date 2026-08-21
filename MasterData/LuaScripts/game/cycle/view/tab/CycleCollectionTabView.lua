--[[ 
-----------------------------------------------------
@filename       : CycleCollectionTabView
@Description    : 收藏品界面
@Author         : sxt
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("cycle.CycleCollectionTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("cycle/tab/CycleCollectionTabView.prefab")

filterType = COLLECTION_TYPE.ALL

function ctor(self)
    super.ctor(self)
end

-- 析构  
function dtor(self)
end

-- 初始化
function configUI(self)
    self.mCollectionScroll = self:getChildGO("mCollectionScroll"):GetComponent(ty.LyScroller)
    self.mCollectionScroll:SetItemRender(cycle.CycleCollectionItem)
    self.mImgPropInfo = self:getChildGO("mImgPropInfo"):GetComponent(ty.AutoRefImage)
    self.mTxt_01 = self:getChildGO("mTxt_01"):GetComponent(ty.Text)
    self.mTxt_02 = self:getChildGO("mTxt_02"):GetComponent(ty.Text)
    self.mTxt_Attr01 = self:getChildGO("mTxt_Attr01"):GetComponent(ty.Text)
    -- self.mTxt_Attr02 = self:getChildGO("mTxt_Attr02"):GetComponent(ty.Text)
    self.mBg1 = self:getChildGO("Bg")
    self.mEmpty = self:getChildGO("mEmpty")
    self.mTxt01 = self:getChildGO("mTxt01"):GetComponent(ty.Text)

    self.mBtnAward = self:getChildGO("mBtnAward")
    self.mTxtAward = self:getChildGO("mTxtAward"):GetComponent(ty.Text)
end
-- 激活
function active(self, args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.UPDATE_CYCLE_RED,self.updateRed,self)
    GameDispatcher:addEventListener(EventName.COLLETION_ITEM_SELECTED, self.updateIsSelected, self)
    MoneyManager:setMoneyTidList({})
    self:showPanel()

    self:updateRed()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_CYCLE_RED,self.updateRed,self)
    GameDispatcher:removeEventListener(EventName.COLLETION_ITEM_SELECTED, self.updateIsSelected, self)
    if self.mCollectionScroll then
        self.mCollectionScroll:CleanAllItem()
    end
end

function updateRed(self)
    if cycle.CycleManager:canGetCollection() then
        RedPointManager:add(self.mBtnAward.transform, nil, -65.6, 18.9)
    else
        RedPointManager:remove(self.mBtnAward.transform)
    end
end
--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxt01.text = _TT(77609)
    self.mTxtAward.text = "收集奖励"
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnAward,self.onBtnAwardClickHandler)
end

function onBtnAwardClickHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_COLLECTION_AWARD_PANEL)
end

function updateIsSelected(self, data)
    if data.has then
        self.mTxt_01.text = _TT(data.name)
        self.mImgPropInfo:SetImg(UrlManager:getCycelCollectionIcon(data.icon), false)
        self.mImgPropInfo.color = gs.ColorUtil.GetColor("FFFFFFFF")
        self.mTxt_02.text = _TT(data.des2)
        self.mTxt_Attr01.text = _TT(data.des)
    else
        self.mTxt_01.text = _TT(77608)
        self.mImgPropInfo:SetImg(UrlManager:getCycelCollectionIcon(data.icon), false)
        self.mImgPropInfo.color = gs.ColorUtil.GetColor("4D4D4DFF")
        --  self.mImgPropInfo:SetImg(UrlManager:getPropsIconUrl(data.icon), false)
        self.mTxt_02.text =_TT(77607)
        self.mTxt_Attr01.text = _TT(77608)
    end

end

function showPanel(self)

    self:filterList()
    if next(self.list) then
        self.mEmpty:SetActive(false)
        self.mBg1:SetActive(true)


        if self.mCollectionScroll.Count > 0 then
            self.mCollectionScroll:ReplaceAllDataProvider(self.list)
        else
            self.mCollectionScroll.DataProvider = self.list
        end
        cycle.CycleManager:setCollectionSelect(self.list[1])
    else
        self.mEmpty:SetActive(true)
        self.mBg1:SetActive(false)
    end

end

function filterList(self)

    self.mBtnAward:SetActive(true)
    if self.filterType == COLLECTION_TYPE.ALL then
        self.list = cycle.CycleManager:getCycleCurrentCollectionList()

    elseif self.filterType == COLLECTION_TYPE.POSSESS then
        self.list = cycle.CycleManager:getCycleCurrentCollectionList()
        
        local flag = false
        for _, Vo in pairs(self.list) do
            if Vo.has == true then
                flag = true
                break
            end
        end

        if flag == false then
            self.list = {}
        end
        self.mBtnAward:SetActive(#self.list>0)
    elseif self.filterType == COLLECTION_TYPE.LACK then
        self.list = cycle.CycleManager:getCycleLackColletionList()
        self.mBtnAward:SetActive(#self.list>0)
    end
    cycle.CycleManager:setCollectTabViewType(self.filterType)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
