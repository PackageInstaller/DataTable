SelectCharacter_KVItem = {};

SelectCharacter_KVItem.__index = SelectCharacter_KVItem;

local objs = {
    button = {path = "", type = "Button"},
    normal = { path = "group/Normal", type = "GameObject" },
    select = { path = "group/Select", type = "GameObject" },
    bgPic = { path = "group/BgPic", type = "RawImage" },
    nameGO = { path = "group/Name", type = "GameObject" },
    nameText = { path = "group/Name/Text", type = "Text" },





    useGO = { path = "group/Use", type = "GameObject" },
    useText = { path = "group/Use/Text", type = "Text" },

}

function SelectCharacter_KVItem.New()
    local self = {};
    setmetatable(self, SelectCharacter_KVItem);
    return self;
end

function SelectCharacter_KVItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
end









function SelectCharacter_KVItem:SetData(data)
    self.data = data.data;
    SetActive(self.normal, not self.data.select);
    SetActive(self.select, self.data.select);
    local bgPath = string.format("Assets/_BundleResources/Images/KVPic/%s.png", self.data.picName);
    self.bgPic.texture = LuaMgr.GetTexture(bgPath);
    self.nameText.text = self.data.name;























    self.useText.text = ConfigMgr.LangGlobal("15959");
    SetActive(self.useGO, self.data.isUse);
end


function SelectCharacter_KVItem:Clear()
    self.data = nil;
end

function SelectCharacter_KVItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
end