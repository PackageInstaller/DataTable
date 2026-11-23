FriendChat_themeItem = {};

FriendChat_themeItem.__index = FriendChat_themeItem;

local objs = {
    bgSprite={path="root/imgBg",type="Image"},
    goLock={path="root/imgLock",type="GameObject"},
    goSelect={path="root/imgSelect",type="GameObject"},
    name={path="root/Info/name",type="Text"},
    summer={path="root/Info/summer",type="Text"},
    rawHead={path="root/Info/Avatar",type="RawImage"},
    headFrame={path="root/Info/Avatar/AvatarFrame",type="Image"},
    headBtn={path="root/imgBg",type="Button"},
    rootTf={path="root",type="Transform"},
    goRed={path="root/Red",type="GameObject"},
}

local colorList={
    "ffffff","d8d8d8"
}

function FriendChat_themeItem.New()
    local self = {};
    setmetatable(self, FriendChat_themeItem);
    return self;
end


function FriendChat_themeItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.headBtn,function()
        local key = DataMgr.Player.uid .. "_FriendChatTheme_" .. self.data.id
        PlayerPrefs.SetInt(key,1)
        PlayerPrefs.Save();
        SetActive(self.goRed, false)
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end);
end


function FriendChat_themeItem:SetData(data)
    self.data=data.data
    SetActive(self.goLock,not self.data.isUnlock)
    self.bgSprite.sprite=LuaMgr.GetSprite("FriendChat","ui_hy_theme_"..self.data.index)
    self:isSelect(self.data.isCur);
    self.name.text=DataMgr.Player.name;
    self.summer.text=string.format("<color=#%s>%s</color>",colorList[self.data.index],DataMgr.Player.motto);
    local avatarPath,avatarFrame=FriendChatMgr.GetAvatarAndAvatarFramePath(nil,nil);
    self.rawHead.texture=LuaMgr.GetTexture(avatarPath);
    PlayerAvatarFrameTool.SetAvatarFrame(self.headFrame, avatarFrame)
    SetActive(self.goRed, FriendChatMgr.IsShowThemeRedIcon(self.data.id))
end


function FriendChat_themeItem:isSelect(isOn)
    SetActive(self.goSelect,isOn)
    self.rootTf.anchoredPosition=isOn and Vector2(-20,0) or Vector2(0,0);
    
end


function FriendChat_themeItem:Clear()
    PlayerAvatarFrameTool.ClearImage(self.headFrame)
    self.data=nil;
end


function FriendChat_themeItem:Destroy()
    PlayerAvatarFrameTool.ClearImage(self.headFrame)
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end

