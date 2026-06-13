local DormStoryGiftTabCtrl = BaseClass("DormStoryGiftTabCtrl")
local M = DormStoryGiftTabCtrl

function M:__init(view)
    self._view = view
    self._tabLabel = {
        ConfigHelper.GetLocalString(BagConst.Tab.ITEM.labels),
        ConfigHelper.GetLocalString(BagConst.Tab.NURTURE.labels),
        ConfigHelper.GetLocalString(BagConst.Tab.FOODS.labels),
        ConfigHelper.GetLocalString(BagConst.Tab.PLOT.labels),
        ConfigHelper.GetLocalString(BagConst.Tab.FAVOR.labels),
    }
    self._tabLabelEn = {
        ConfigHelper.GetLocalString(BagConst.Tab.ITEM.labelsEn),
        ConfigHelper.GetLocalString(BagConst.Tab.NURTURE.labelsEn),
        ConfigHelper.GetLocalString(BagConst.Tab.FOODS.labelsEn),
        ConfigHelper.GetLocalString(BagConst.Tab.PLOT.labelsEn),
        ConfigHelper.GetLocalString(BagConst.Tab.FAVOR.labelsEn),
    }
    self._tabTypes = {
        BagConst.TabType.ITEM,
        BagConst.TabType.NURTURE,
        BagConst.TabType.FOODS,
        BagConst.TabType.PLOT,
        BagConst.TabType.FAVOR
    }
    self._tabIcons = {
        "UI/SpritePics/warehouse/ui_warehouse_icon_01", -- 道具
        "UI/SpritePics/warehouse/ui_warehouse_icon_02", -- 养成
        "UI/SpritePics/warehouse/ui_warehouse_icon_03", -- 料理
        "UI/SpritePics/warehouse/ui_warehouse_icon_04", -- 剧情
        "UI/SpritePics/warehouse/ui_warehouse_icon_07", -- 好感
    }

    self._curTabType = 0
    self._tab = self._view.tab
end

--initTab 默认显示页签
--列表变化时回调
function M:SetTab(initTab, initCallback)
    local index = table.indexof(self._tabTypes, initTab)
    self._curTabType = index
    self._tab:InitIconItems(
        index - 1,
        self._tabLabel,
        self._tabLabelEn,
        self._tabIcons,
        function(idx)
            local tabIdx = idx + 1
            local tabType = self._tabTypes[tabIdx]
            self._curTabType = tabType
            EventMgr:Broadcast(UIMessageNames.BAG_TYPE_TABLE_CHANGE, self._curTabType)
        end
    )

    if initCallback == nil then initCallback = true end
    self._tab:SetIndex(index - 1, initCallback)
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return DormStoryGiftTabCtrl
