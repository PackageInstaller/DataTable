SelectCharacter_MainUIItem = {};

SelectCharacter_MainUIItem.__index = SelectCharacter_MainUIItem;

local objs = {
    button = {path = "", type = "Button"},
    normal = { path = "group/Normal", type = "GameObject" },
    select = { path = "group/Select", type = "GameObject" },
    bgPic = { path = "group/BgPic", type = "RawImage" },
    nameGO = { path = "group/Name", type = "GameObject" },
    nameText = { path = "group/Name/Text", type = "Text" },
    lockNameGO = { path = "group/LockName", type = "GameObject" },
    lockNameText = { path = "group/LockName/Text", type = "Text" },
    preview = { path = "group/Preview", type = "GameObject" },
    unlock = { path = "group/Unlock", type = "GameObject" },
    lock = { path = "group/Lock", type = "GameObject" },
    useGO = { path = "group/Use", type = "GameObject" },
    useText = { path = "group/Use/Text", type = "Text" },
    dot = { path = "group/Dot", type = "GameObject" },
}

function SelectCharacter_MainUIItem.New()
    local self = {};
    setmetatable(self, SelectCharacter_MainUIItem);
    return self;
end

function SelectCharacter_MainUIItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        local key = DataMgr.Player.uid .. "_MianUISwitch_" .. self.data.id
        PlayerPrefs.SetInt(key,1)
        SetActive(self.dot, false)
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index,self.data.id);
        end
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
end











function SelectCharacter_MainUIItem:SetData(data)
    self.data = data.data;
    SetActive(self.unlock,false)
    SetActive(self.lock,false);
    SetActive(self.lockNameGO,false)
    SetActive(self.useGO,self.data.isCur)
    self.nameText.text=self.data.name;
    local bgPath = string.format("Assets/_BundleResources/Images/HomeTheme/%s.png", self.data.imgName);
    self.bgPic.texture= LuaMgr.GetTexture(bgPath);
    self:SetIsOn(self.data.isSelect);
    if not self.lock.activeSelf and self.data.id ~= "2001" then
        local key = DataMgr.Player.uid .. "_MianUISwitch_" .. self.data.id
        SetActive(self.dot, not PlayerPrefs.HasKey(key) or PlayerPrefs.GetInt(key) == 0)
    else
        SetActive(self.dot, false)
    end
end


function SelectCharacter_MainUIItem:SetIsOn(isOn)
    SetActive(self.preview,isOn);
    SetActive(self.select,isOn);
    SetActive(self.normal,not isOn);
end

    

function SelectCharacter_MainUIItem:Clear()
    self.data = nil;
end

function SelectCharacter_MainUIItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
end