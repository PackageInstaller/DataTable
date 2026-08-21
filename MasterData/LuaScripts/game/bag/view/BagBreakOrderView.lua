--[[ 
-----------------------------------------------------
@filename       : BagBreakOrderView
@Description    : 装置分解
@date           : 2021-11-02 10:12:10
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.bag.view.BagBreakOrderView', Class.impl(bag.BagBreakEquipView))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("bag/BagBreakOrderView.prefab")

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mGridScroller:SetItemRender(bag.BagOrderScrollerItem)
end

function showSortView(self)
    self.mSortView:addOrderMenu({-1, PropsOrderSubType.ATTACK, PropsOrderSubType.DEFENCE, PropsOrderSubType.EFFECT }, nil, false)
    self.mSortView:addSortMenu(bag.getSortList(self.tabType), nil, true, false)
end

function updatePropsListView(self, cusIsInit)
    local propsList = bag.BagManager:getBagPagePropsList(self.tabType, nil, nil, nil, self.m_sortData)
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
        if ((bag.BagManager.propsOpState ~= 2 or propsVo.isLock ~= 1 or propsVo.heroId == 0) and not equipBuild.EquipPlanManager:isInEquipPlan(propsVo)) then
            local scrollerVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
            -- local scrollerVo = LyScrollerSelectVo.new()
            scrollerVo:setDataVo(propsVo)
            scrollerVo:setSelect(false)

            if self:getBreakSelect(propsVo) then
                scrollerVo:setArgs({ selectBreak = true })
            else
                scrollerVo:setArgs(nil)
            end
            -- if(self.m_propsId == nil)then
            -- 	if(pos == 1)then
            -- 		self.m_propsId = propsVo.id
            -- 		scrollerVo:setSelect(true)
            -- 	end
            -- elseif(self.m_propsId == propsVo.id)then
            -- 	scrollerVo:setSelect(true)
            -- end
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

function getBagType(self)
    return bag.BagType.ORDER
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
