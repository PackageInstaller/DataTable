require("SeasonSLG/EventPopUp/BlockTopRankItem")
BlockTopRankCom = {};

BlockTopRankCom.__index = BlockTopRankCom;
local objs = {
    goPlayer1 = { path = "player1", type = "GameObject" },
    goPlayer2 = { path = "player2", type = "GameObject" },
    goPlayer3 = { path = "player3", type = "GameObject" },
};

local PREFAB_PATH = "Assets/_BundleResources/UI/SeasonSLG/SeasonSLGTopRankCom.prefab"

BlockTopRankCom.New = function(parent)
    if parent == nil then
        return nil
    end

    local gameObject = LuaMgr.GetPrefab(PREFAB_PATH)
    if gameObject == nil then
        return nil
    end

    local self = {}
    setmetatable(self, BlockTopRankCom)
    self.parent = parent
    self.gameObject = gameObject
    self.transform = gameObject:GetComponent("RectTransform")
    self.transform:SetParent(parent, false)
    UITool.Parse(self.gameObject, self, objs);
    return self
end

function BlockTopRankCom:SetData(data,max)
    self.data = data;
    SetActive(self.goPlayer1,true)
    SetActive(self.goPlayer2,true)
    SetActive(self.goPlayer3,true)
    local list = self.data~=nil and self.data.TopSeize or nil;
    if type(list) == "function" then
        list = nil
    end
    if self.player1Item == nil then
        self.player1Item = BlockTopRankItem.New(self.goPlayer1)
    end
    self.player1Item:SetData(list~=nil and list[1] or nil,max)
    if self.player2Item == nil then
        self.player2Item = BlockTopRankItem.New(self.goPlayer2)
    end
    self.player2Item:SetData(list~=nil and list[2] or nil,max)
    if self.player3Item == nil then
        self.player3Item = BlockTopRankItem.New(self.goPlayer3)
    end
    self.player3Item:SetData(list~=nil and list[3] or nil,max)
end


function BlockTopRankCom:Clear()
    self.data = nil;
    if self.player1Item ~= nil then
        self.player1Item:Clear()
    end
    if self.player2Item ~= nil then
        self.player2Item:Clear()
    end
    if self.player3Item ~= nil then
        self.player3Item:Clear()
    end
end

function BlockTopRankCom:Destroy()
    if self.player1Item ~= nil then
        self.player1Item:Destroy()
    end
    if self.player2Item ~= nil then
        self.player2Item:Destroy()
    end
    if self.player3Item ~= nil then
        self.player3Item:Destroy()
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end