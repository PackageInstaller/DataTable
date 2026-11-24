SeasonSLGTopRankRewardCom = {};

SeasonSLGTopRankRewardCom.__index = SeasonSLGTopRankRewardCom;
local objs = {
    goScrollView = { path = "goScrollView", type = "GameObject" },
    transContent = { path = "goScrollView/Viewport/transContent", type = "RectTransform" },
};

local PREFAB_PATH = "Assets/_BundleResources/UI/SeasonSLG/SeasonSLGTopRankRewardCom.prefab"

SeasonSLGTopRankRewardCom.New = function(parent)
    if parent == nil then
        return nil
    end

    local gameObject = LuaMgr.GetPrefab(PREFAB_PATH)
    if gameObject == nil then
        return nil
    end

    local self = {}
    setmetatable(self, SeasonSLGTopRankRewardCom)
    self.parent = parent
    self.gameObject = gameObject
    self.transform = gameObject:GetComponent("RectTransform")
    self.transform:SetParent(parent, false)
    UITool.Parse(self.gameObject, self, objs);
    return self
end

function SeasonSLGTopRankRewardCom:SetData(gridId)
    self:Clear()
    self.gridId = gridId
    if self.rewardItemList == nil then
        self.rewardItemList = {}
    end
    local gridTypeCfg = SeasonSLGMapMgr.GetGridTypeCfgByGridId(gridId)
    if gridTypeCfg == nil or IsNull(gridTypeCfg.FirstRewardShow) then
        return
    end
    local rewards = gridTypeCfg.FirstRewardShow
    for i, v in ipairs(rewards) do
        local itemConfig = ConfigMgr.Config.itemMap[v.id]
        if itemConfig ~= nil then
            if self.rewardItemList[i] == nil then
                self.rewardItemList[i] = GoodsDataItem.New(self.transContent)
            end
            local itemData = table.Copy(itemConfig);
            itemData.count0 = v.count;
            SetActive(self.rewardItemList[i].gameObject, true);
            self.rewardItemList[i]:SetData(1, itemData, 1, false, Vector3(0.6, 0.6, 0.6), false);
        end
    end
end


function SeasonSLGTopRankRewardCom:Clear()
    self.gridId = nil;
    if self.rewardItemList ~= nil then
        for i, v in ipairs(self.rewardItemList) do
            SetActive(v.gameObject, false)
        end
    end
end

function SeasonSLGTopRankRewardCom:Destroy()
    self:Clear()
    if self.rewardItemList ~= nil then
        for i, v in ipairs(self.rewardItemList) do
            v:Clear()
        end
    end
    self.rewardItemList = {}
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end