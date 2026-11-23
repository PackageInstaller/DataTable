VoyageSelectCharacterDiceItem = {};

VoyageSelectCharacterDiceItem.__index = VoyageSelectCharacterDiceItem;

local objs = {
    button = { path = "", type = "Button" },
    type = { path = "Type", type = "Image" },
    name = { path = "Name", type = "Text" },
    desc = { path = "Desc", type = "Text" },
    lock = { path = "Lock", type = "GameObject" },
    lockMsg = { path = "Lock/Msg", type = "Text" },
}

function VoyageSelectCharacterDiceItem.New()
    local self = {};
    setmetatable(self, VoyageSelectCharacterDiceItem);
    return self;
end

function VoyageSelectCharacterDiceItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        if (PlayerVoyageMgr.IsLockCaptain(self.data)) then
            local portConfig = ConfigVoyageMgr.GetPortConfig(self.data.UnlockHarbor);
            if (portConfig ~= nil) then
                local msg = string.format(ConfigMgr.LangGlobal("10455"), LuaMgr.GetLangText(portConfig.HarborNameLan));
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, msg);
            end
            return;
        end
        PlayerVoyageMgr.SetCaptain(self.data.CaptainID);
        LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageSelectCharacterSkill);
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
end

function VoyageSelectCharacterDiceItem:SetData(data)
    self.data = data.data;
    self.type.sprite = LuaMgr.GetSprite("VoyageRichMan", self.data.SkillPic);
    self.name.text = LuaMgr.GetLangText(self.data.SkillNameLan);
    self.desc.text = LuaMgr.GetLangText(self.data.CaptainDesLan);
    if (PlayerVoyageMgr.IsLockCaptain(self.data)) then
        local portConfig = ConfigVoyageMgr.GetPortConfig(self.data.UnlockHarbor);
        if (portConfig ~= nil) then
            self.lockMsg.text = string.format(ConfigMgr.LangGlobal("10455"), LuaMgr.GetLangText(portConfig.HarborNameLan));
        end
        SetActive(self.lock, true);
    else
        SetActive(self.lock, false);
    end
end

function VoyageSelectCharacterDiceItem:Clear()
    self.data = nil;
    self.type.sprite = nil;
end

function VoyageSelectCharacterDiceItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end