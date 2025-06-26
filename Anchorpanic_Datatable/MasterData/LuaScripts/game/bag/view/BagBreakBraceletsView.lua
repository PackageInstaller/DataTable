--[[-----------------------------------------------------
@filename       : BagBreakBraceletsView
@Description    : 手环分解
@date           : 2021-11-02 10:12:10
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.bag.view.BagBreakBraceletsView', Class.impl(bag.BagBreakEquipView))

function showSortView(self)
    self.mSortView:addSortMenu(bag.getSortList(self.tabType), nil, true, false)
    self.mSortView:setShowTipGroup(true)
end

function getPrpsList(self)
    local propsList = bag.BagManager:getBagPagePropsList(self.tabType, nil, nil, nil, self.mSortData, self:getBagType())
    for i = #propsList, 1, -1 do
        if (propsList[i].heroId > 0) then
            table.remove(propsList, i)
        end
    end
    return propsList
end

function active(self, args)
    super.active(self, args)

    self.mToggleG.gameObject:SetActive(false)
end

function updatePropsListView(self, cusIsInit)
    local propsList = self:getPrpsList()
    local scrollList = {}
    for pos = 1, #propsList do
        local propsVo = propsList[pos]
        if ((bag.BagManager.propsOpState ~= 2 or propsVo.isLock ~= 1 or propsVo.heroId == 0) and not equipBuild.EquipPlanManager:isInEquipPlan(propsVo)) then
            
            local scrollerVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
            scrollerVo:setDataVo(propsVo)
            scrollerVo:setSelect(false)

            -- if bag.BagManager:getBreakSelect(propsVo) then
            --     scrollerVo:setArgs({selectBreak = true})
            -- else
            --     scrollerVo:setArgs(nil)
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
            local count = v.count * (1 + propsVo.refineLvl)
            if not list[v.tid] then
                list[v.tid] = count
            else
                list[v.tid] = list[v.tid] + count
            end
        end
    end
    for tid, allCount in pairs(list) do
        local propsVo = props.PropsManager:getPropsVo({ tid = tid, num = allCount })
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


function getBagType(self)
    return bag.BagType.Bracelets
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]