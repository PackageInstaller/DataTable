module("bag.BagOrderTabView", Class.impl(bag.BagBaseTabView))

--构造函数
function ctor(self)
    super.ctor(self)
end

function initData(self)
    super.initData(self)
    self.mPropsId = nil
end

function configUI(self)
    super.configUI(self)
end

function setItemRender(self)
    self.mGridScroller:SetItemRender(bag.BagScrollerItem)
end

function active(self)
    super.active(self)
end

function deActive(self)
    super.deActive(self)
end

-- 移除
function destroy(self, isAuto)
    super.destroy(self, isAuto)
end

-- 背包红点更新
function onBubbleUpdateHandler(self, args)
    super.onBubbleUpdateHandler(self, args)
end

-- 背包初始化（一登陆/断线重连/服务器道具id重置）
function onBagInitHandler(self, args)
    super.onBagInitHandler(self, args)
end

-- 背包更新
function onBagUpdateHandler(self, args)
    super.onBagUpdateHandler(self, args)

    -- 因为背包列表不显示空格子了，只有更新和删除情况下才可以取到虚拟列表的对应项，新增无法取到对应项，为了方便直接整体刷新数据
    -- 判断选中的物品是否被删掉了
    local delList = args.delList
    local len
    len = #delList
    for i = 1, len do
        local propsVo = delList[i]
        if (propsVo.id == self.mPropsId) then
            self.mPropsId = nil
        end
    end
end

-- 设置排序数据
function showSortView(self)
    self.mSortView:addOrderMenu({-1, PropsOrderSubType.ATTACK, PropsOrderSubType.DEFENCE, PropsOrderSubType.EFFECT}, nil, false)
    super.showSortView(self)
end

function setData(self, cusTabType, cusParams)
    super.setData(self, cusTabType, cusParams)
end

function updateView(self, cusIsInit)
    super.updateView(self,cusIsInit)
    if (cusIsInit) then
        self:showSortView()
    end
end

function updatePropsListView(self, cusIsInit)
    local propsList = bag.BagManager:getBagPagePropsList(self.mTabType, nil, nil, nil, self.mSortData, self:getBagType())
    for i = #propsList, 1, -1 do
        local findSubType = self.mSortView:getOrderFilterType()
        if(findSubType ~= -1)then
            if(propsList[i].subType ~= findSubType)then
                table.remove(propsList, i)
            end
        end
    end

    local scrollList = {}
    for pos = 1, #propsList do
        local propsVo = propsList[pos]
        if bag.BagManager.propsOpState ~= 2 or propsVo.isLock ~= 1 then
            local scrollerVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
            -- local scrollerVo = LyScrollerSelectVo.new()
            scrollerVo:setDataVo(propsVo)
            scrollerVo:setSelect(false)

            if self:getBreakSelect(propsVo) then
                scrollerVo:setArgs({ selectBreak = true })
            else
                scrollerVo:setArgs(nil)
            end
            table.insert(scrollList, scrollerVo)
        end
    end

    self:loadGridData(cusIsInit, scrollList)
end

function getBagType(self)
    return bag.BagType.Bag
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
