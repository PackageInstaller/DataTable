DHSurveyRewardItem = {};

DHSurveyRewardItem.__index = DHSurveyRewardItem;

local objs = {
    text = { path = "Count/Text", type = "Text" },
    rewardListTF = { path = "Icon", type = "Transform" }
};

function DHSurveyRewardItem.New()
    local self = {};
    setmetatable(self, DHSurveyRewardItem);
    return self;
end

function DHSurveyRewardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function DHSurveyRewardItem:SetData(_data)
    local data = _data.data
    local scale = Vector3(0.6, 0.6, 1);
    local gridType = ConfigDHMgr.GetGridType(data.type);
    local levelconfig = data.curLevel
    if (gridType ~= nil) then
        if (self.item == nil) then
            self.item = GoodsDataItem.New(self.rewardListTF);
        end
        local itemData = table.Copy(ConfigMgr.Config.itemMap[gridType.ItemsID]);
        self.item:SetData(1, itemData, 1, false, scale, false, true);
        self.item:SetIconBg(false);
        local itemCount = PlayerDHMgr.GetBoxToolsCount(DataMgr.Player.DunHuang.StageId, gridType.ItemsID);
        local curTotleNum = 0
        self.item.goodsBtn.onClick:RemoveAllListeners();
        if (data.type == DHSurveyGrid.Box and itemCount > 0) then            
            self.item.GoodsCommand = function()
                LuaMgr.ShowLuaPanel(UIName.DHAllusionViewModel, DataMgr.Player.DunHuang.StageId);
            end
            LuaMgr.AddClick(self.item.goodsBtn, self.item.GoodsCommand)
        else   
            local cacheData = {}
            cacheData.gridData = gridType
            cacheData.callback = nil
            self.item.CacheCommand = function()
                LuaMgr.ShowLuaPanel(UIName.DHSurveyResultViewModel, DHSurveyResultType.Battle, cacheData);
            end
            LuaMgr.AddClick(self.item.goodsBtn, self.item.CacheCommand)
        end
        if (data.type == DHSurveyGrid.Box2) then
            for k, v in pairs(levelconfig.BoxNum) do
                curTotleNum = curTotleNum + v
            end
        else
            for k, v in pairs(levelconfig.TextNum) do
                curTotleNum = curTotleNum + v
            end
        end
        self.text.text = string.format("%d/%d", itemCount, curTotleNum)
    end
end

function DHSurveyRewardItem:Clear()

end

function DHSurveyRewardItem:Destroy()
    if (self.item ~= nil) then
        self.item:Clear();
        self.item = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end