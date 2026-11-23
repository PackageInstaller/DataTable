
RhythmGameGetBuffItem = {};

RhythmGameGetBuffItem.__index = RhythmGameGetBuffItem;

RhythmGameGetBuffItem.addWidth = 0;


local objs = {
    getBuffItem = { path = "getBuffItem", type = "Image" },
    getBuffItemGo = { path = "getBuffItem", type = "GameObject" },
    icon = { path = "getBuffItem/icon", type = "Image" },
    iconOutLine = { path = "getBuffItem/iconOutLine", type = "GameObject" },
    iconNum = { path = "getBuffItem/iconNum", type = "Image" },
    lockImg = { path = "lockImg", type = "GameObject" },
    btn = { path = "btn", type = "Button" },
}

function RhythmGameGetBuffItem.New()
    local self = {};
    setmetatable(self, RhythmGameGetBuffItem);
    return self;
end

function RhythmGameGetBuffItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickBtn = function()
        if (self.unlock) then
            local curBuffs = PlayerRhythmGameMgr.GetEquipBuffs()
            if (curBuffs[self.index] ~= nil) then
                table.remove(curBuffs, self.index)
                LuaMgr.InvokeUIEventListeners(UIEventConst.RhythmGameEquipBuff);
            end
        else
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(ConfigMgr.LangGlobal("10761"),self.maxNum));
        end
    end
    LuaMgr.AddClick(self.btn, self.OnClickBtn);
end

function RhythmGameGetBuffItem:SetData(data)
    self.data = data.data
    self.maxNum = self.data.maxNum
    self.index = self.data.index
    self.unlock = data.data.unlock
    local curBuffs = PlayerRhythmGameMgr.GetEquipBuffs()
    SetActive(self.getBuffItemGo,self.unlock)
    SetActive(self.lockImg, not self.unlock)
    if (self.unlock) then
        local config = curBuffs[self.index]
        local isSelected = config ~= nil
        SetActive(self.icon.gameObject,isSelected)
        if(isSelected)then           
            self.icon.sprite = LuaMgr.GetSprite("RhythmGame", config.icon);  
        end          
        SetActive(self.iconOutLine,isSelected)
        local numName = ConfigRhythmGameMgr.GetEquipBuffIndexImg(isSelected, self.index)
        self.iconNum.sprite = LuaMgr.GetSprite("RhythmGame", numName);   
    else
        SetActive(self.iconOutLine,false)  
    end
end

function RhythmGameGetBuffItem:Clear()
    self.data = nil;
end

function RhythmGameGetBuffItem:Destroy()
    if (self.OnClickBtn ~= nil) then
        LuaMgr.RemoveClick(self.btn, self.OnClickBtn);
        self.OnClickBtn = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end