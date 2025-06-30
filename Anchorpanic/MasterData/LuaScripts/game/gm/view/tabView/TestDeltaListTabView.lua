--[[ 
-----------------------------------------------------
@filename       : TestDeltaListTabView
@Description    : 差量列表效果
@date           : 2022-2-22 
@Author         : zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('gm.TestDeltaListTabView', Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath('gm/TestDeltaListTab.prefab')

--构造函数
function ctor(self)
    super.ctor(self)
end

function configUI(self)
    super.configUI(self)
    self.mkNode = self:getChildTrans("GroupContent")
end

-- 初始化数据
function initData(self)
    self.mItemList = nil
    self.mItemDataList = nil
end

function active(self)
    super.active(self)
    if(not self.mDeltaList)then
        self.mDeltaList = DeltaList.new()
        self.mDeltaList:setFormulaParams(150, 60)
        self.mDeltaList:setTweenParams(0.5, gs.DT.Ease.InSine)
        self.mDeltaList:setViewParams(560, 301, 199, 301, true)

        local dataList = {}
        table.insert(dataList, {bodySource = UrlManager:getHeroBodyImgUrl(1501)})
        table.insert(dataList, {bodySource = UrlManager:getHeroBodyImgUrl(1502)})
        table.insert(dataList, {bodySource = UrlManager:getHeroBodyImgUrl(1503)})
        table.insert(dataList, {bodySource = UrlManager:getHeroBodyImgUrl(1504)})
        table.insert(dataList, {bodySource = UrlManager:getHeroBodyImgUrl(2101)})
        table.insert(dataList, {bodySource = UrlManager:getHeroBodyImgUrl(2102)})
        table.insert(dataList, {bodySource = UrlManager:getHeroBodyImgUrl(2103)})
        table.insert(dataList, {bodySource = UrlManager:getHeroBodyImgUrl(2104)})
        self.mDeltaList:setData(dataList, 2, self.mkNode, gm.TestDeltaListItem, 
        function(data)
            local itemData = data.itemData
            local itemIndex = data.itemIndex
            gs.Message.Show("点击Item" .. itemIndex)
        end)
    end
end

function deActive(self)
    super.deActive(self)
    if (self.mDeltaList) then
        self.mDeltaList:destroy()
        self.mDeltaList = nil
    end
end

function initViewText(self)
end

function addAllUIEvent(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]