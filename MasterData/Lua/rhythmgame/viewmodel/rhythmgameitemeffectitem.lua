RhythmGameItemEffectItem = {};

RhythmGameItemEffectItem.__index = RhythmGameItemEffectItem;

local objs = {
    button = { path = "", type = "Button" },
    redIconListener = { path = "", type = "RedIconListener" },
    selected = { path = "Selected", type = "GameObject" },
    equiped = { path = "Equiped", type = "GameObject" },
    lock = { path = "Lock", type = "GameObject" },
    icon = { path = "Icon", type = "RawImage" },
}

function RhythmGameItemEffectItem.New()
    local self = {};
    setmetatable(self, RhythmGameItemEffectItem);
    return self;
end

function RhythmGameItemEffectItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        local refresh = PlayerRhythmGameMgr.UpdateEffectNewDotData(self.data.id)
        if(refresh)then
            PlayerRhythmGameMgr.CheckEffectNewDot()
            RedMgr.Singleton:Refresh()
            RedMgr.Singleton:RefreshOtherViewModel(UIName.RhythmGameMusicViewModel)
        end
        LuaMgr.InvokeUIEventListeners(UIEventConst.RhythmGameItemEffectItem, self.data);
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
end

function RhythmGameItemEffectItem:SetData(data)
    self.data = data.data;
    self.redIconListener.RedId = "12015_"..self.data.id
    local selectItem = PlayerRhythmGameMgr.GetItemEffectItem()
    SetActive(self.selected, selectItem and selectItem.id == self.data.id or false);
    SetActive(self.equiped, DataMgr.Player.musicEquips.Equip[tostring(self.data.id)]);
    self.icon.texture = GetRhythmEquipTexture(self.data.icon);

    SetActive(self.lock, not DataMgr.Player.musicEquips.Unlock[tostring(self.data.id)])
end

function RhythmGameItemEffectItem:Clear()
    self.data = nil;
    self.icon.texture = nil;
end

function RhythmGameItemEffectItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end