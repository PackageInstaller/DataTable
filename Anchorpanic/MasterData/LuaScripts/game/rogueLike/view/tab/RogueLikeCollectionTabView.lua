--[[ 
-----------------------------------------------------
@filename       : RogueLikeCollectionTabView
@Description    : 收藏品界面
@Author         : sxt
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("rogueLike.RogueLikeCollectionTabView",Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("rogueLike/tab/RogueLikeCollectionTabView.prefab")

filterType = rogueLike.CollectionType.All

function ctor(self)
    super.ctor(self)
end

--析构  
function dtor(self)
end

-- 初始化
function configUI(self)
    self.mCollectionScroll = self:getChildGO("mCollectionScroll"):GetComponent(ty.LyScroller)
    self.mCollectionScroll:SetItemRender(rogueLike.RogueLikeBuffItem)
    self.mRogueLikeCollectionItem = self:getChildGO("RogueLikeBuffSelectItem")

    self.mNothing = self:getChildGO("Nothing")
end

-- 激活
function active(self, args)
    super.active(self, args)
   
    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.UPDATE_ROGUELIKE_COLLECTION_FILTER, self.onUpdateFilter, self)
    GameDispatcher:addEventListener(EventName.SWITCH_ROGUELIKE_SELECT_COLLECTION, self.onSwitchSelect, self)
    self:showPanel(true)
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ROGUELIKE_COLLECTION_FILTER, self.onUpdateFilter, self)
    GameDispatcher:removeEventListener(EventName.SWITCH_ROGUELIKE_SELECT_COLLECTION, self.onSwitchSelect, self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
end

function onSwitchSelect(self, selectData)
    self.mSelectData = selectData
    self:showPanel(true)
end

function onUpdateFilter(self,args)
    self.mSelectData = nil
    self:showPanel(true)
    --self.isDesc = args.isDesc
    --self.isCurrentFilter = args.currentFilter
end

function showPanel(self, isInit)
    self.isDesc,self.filterLevel,self.isShowHas = rogueLike.RogueLikeManager:getFilterData()
    local showData = {}
    
    local dataList
    if self.isShowHas then
        dataList = rogueLike.RogueLikeManager:getCurrentHasCollectionData()
    else
        dataList = rogueLike.RogueLikeManager:getCollectionData()
    end

    dataList = self:filterList(dataList)
    dataList = self:filterByLevel(dataList)

    self.mHasColl = rogueLike.RogueLikeManager:getServerCollectionData()
    for i = 1, #dataList do
        if self.isShowHas then
            table.insert(showData, {id = i, vo = dataList[i].vo, key = dataList[i].key, isSelect = false, isHas = true})
        else
            local has = true
            --local has = table.indexof01(self.mHasColl, dataList[i].key) > 0
            if self.mSelectData ~= nil and self.mSelectData.id == i then
                table.insert(showData, {id = i, vo = dataList[i].vo, key = dataList[i].key, isSelect = true, isHas = has})
            else
                table.insert(showData, {id = i, vo = dataList[i].vo, key = dataList[i].key, isSelect = false, isHas = has})
            end
        end
    end

    table.sort(showData,function(a,b)
        if self.isDesc then
            return a.vo.collectionLevel < b.vo.collectionLevel
        else
            return a.vo.collectionLevel > b.vo.collectionLevel
        end
    end)

    if isInit then
        self.mCollectionScroll.DataProvider = showData
    else
        self.mCollectionScroll:ReplaceAllDataProvider(showData)
    end
    --self.mCollectionScroll:SetItemIndex(0,0,0,0)


    self.mNothing:SetActive(#showData == 0)
end

function filterList(self,list)
    if self.filterType == rogueLike.CollectionType.All then
        return list
    end

    local retList= {}
    for i = 1 , #list do
        if list[i].vo.collectionType == self.filterType then
            table.insert(retList,list[i])
        end
    end
    return retList
end

function filterByLevel(self,list)
    if self.filterLevel == rogueLike.BuffLevel.All then
        return list
    end

    local retList= {}
    for i = 1 , #list do
        if list[i].vo.collectionLevel == self.filterLevel then
            table.insert(retList,list[i])
        end
    end
    return retList
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
