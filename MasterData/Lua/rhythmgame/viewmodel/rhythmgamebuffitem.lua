
RhythmGameBuffItem = {};

RhythmGameBuffItem.__index = RhythmGameBuffItem;

RhythmGameBuffItem.addWidth = 0;


local objs = {
    rect = { path = "", type = "RectTransform" },
    unlockBg = { path = "unlockBg", type = "GameObject" },
    icon = { path = "unlockBg/icon/icon", type = "Image" },
    iconOutLine = { path = "unlockBg/icon/iconOutLine", type = "GameObject" },
    iconNum = { path = "unlockBg/icon/iconNum", type = "Image" },
    iconNumGo = { path = "unlockBg/icon/iconNum", type = "GameObject" },
    titleText = { path = "unlockBg/titleBg/titleText", type = "Text" },
    equipBg = { path = "unlockBg/titleBg/equipBg", type = "GameObject" },
    contentText = { path = "unlockBg/contentText", type = "Text" },

    lockBg = { path = "lockBg", type = "GameObject" },
    lockText = { path = "lockBg/titleBg/lockText", type = "Text" },
    contentText2 = { path = "lockBg/contentText", type = "Text" },
    unSelectBox = { path = "unSelectBox", type = "GameObject" },
    selectBox = { path = "selectBox", type = "GameObject" },
    btn = { path = "btn", type = "Button" },
    redIconListener = { path = "btn", type = "RedIconListener" },
}

function RhythmGameBuffItem.New()
    local self = {};
    setmetatable(self, RhythmGameBuffItem);
    return self;
end

function RhythmGameBuffItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickBtn = function()
        if (self.isUnlock) then
            local curBuffs = PlayerRhythmGameMgr.GetEquipBuffs()
            local removeIndex = -1
            for i, v in ipairs(curBuffs) do
                if (self.config.id == v.id) then
                    removeIndex = i
                end
            end
            if (removeIndex < 0) then
                PlayerRhythmGameMgr.SetEquipBuffs(self.config)
            else
                table.remove(curBuffs, removeIndex)
            end
            PlayerRhythmGameMgr.UpdateBuffNewDotData(self.config.id)
            LuaMgr.InvokeUIEventListeners(UIEventConst.RhythmGameEquipBuff);
        else
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("10757"));
        end
    end
    LuaMgr.AddClick(self.btn, self.OnClickBtn);
end

function RhythmGameBuffItem:SetData(data)
    self.data = data.data
    self.config = data.data.config
    self.redIconListener.RedId = "12021_"..self.config.id
    self.rect.sizeDelta = Vector2(749,self.data.height)
    local buff = ConfigRhythmGameMgr.GetBuffById(self.config.buffID)
    self.icon.sprite = LuaMgr.GetSprite("RhythmGame", self.config.icon);    
    self.titleText.text = LuaMgr.GetLangText(self.config.nameLan)
    self.contentText.text = LuaMgr.GetLangText(buff.DescriptionLan)
    self.contentText2.text = LuaMgr.GetLangText(buff.DescriptionLan)
    self.lockText.text = LuaMgr.GetLangText(self.config.lockTipsLan)
    self.isUnlock = DataMgr.Player.msBtDrives[self.config.id] ~= nil
    self:IsUnlock(self.isUnlock)
self:IsSelected()
end

function RhythmGameBuffItem:IsUnlock(bUnlock)
    SetActive(self.unlockBg, bUnlock)
    SetActive(self.lockBg, not bUnlock)
end

function RhythmGameBuffItem:IsSelected()
    local bSelect = false
    local index = 0
    if (self.isUnlock) then
        self.getCurBuffs = PlayerRhythmGameMgr.GetEquipBuffs()
        for i, v in ipairs(self.getCurBuffs) do
            if (self.config.id == v.id) then
                bSelect = true
                index = i
            end
        end
    end
    SetActive(self.iconNumGo, bSelect)
    SetActive(self.selectBox, bSelect)
    SetActive(self.iconOutLine, bSelect)
    SetActive(self.equipBg, bSelect)
    SetActive(self.unSelectBox, not bSelect)
    if (bSelect) then
        local numName = ConfigRhythmGameMgr.GetEquipBuffIndexImg(true, index)
        self.iconNum.sprite = LuaMgr.GetSprite("RhythmGame", numName);
    end
end

function RhythmGameBuffItem:Clear()
    self.data = nil;
end

function RhythmGameBuffItem:Destroy()
    if (self.OnClickBtn ~= nil) then
        LuaMgr.RemoveClick(self.btn, self.OnClickBtn);
        self.OnClickBtn = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end