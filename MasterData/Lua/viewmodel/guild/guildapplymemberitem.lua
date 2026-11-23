GuildApplyMemberItem = {};

GuildApplyMemberItem.__index = GuildApplyMemberItem;

local objs = {
    avatar={path="headInfo/avatar",type="RawImage"},
    avatarFrame={path="headInfo/avatarFrame",type="Image"},
    playerName={path="playerName",type="Text"},
    playerLv={path="playerLv",type="Text"},
    applyBtn={path="btnApply",type="Button"},
    refuseBtn={path="btnRefuse",type="Button"},
    playerDynamicAvatar = { path = "headInfo/DynamicAvatar", type = "PlayerDynamicAvatar" },
    playerTitle = { path="PlayerTitle", type = "Image" },
    playerTitleText = { path="PlayerTitle/Text", type = "Text" },
    titleTextPos = { path="PlayerTitle/Text", type = "RectTransform" },
}

function GuildApplyMemberItem.New()
    local self = {};
    setmetatable(self, GuildApplyMemberItem);
    return self;
end

function GuildApplyMemberItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.applyBtn,function()
        if self.data.ApplyCallBack~=nil then
            self.data.ApplyCallBack();
        end
    end);

    LuaMgr.AddClick(self.refuseBtn,function()
        if self.data.RefuseCallBack~=nil then
            self.data.RefuseCallBack();
        end
    end);
end

function GuildApplyMemberItem:SetData(data)
    self.data = data.data

    local title = ConfigHelper.GetTitleConfig(self.data.info.title)
    if not TableIsNull(title) then
        self.playerTitle.sprite = LuaMgr.GetSprite("PlayerTitle",title.img)
        self.playerTitleText.text = LuaMgr.GetLangText(title.namelan)
        if title.img == "Title_40001" then
           self.titleTextPos.anchoredPosition =  Vector2(2,1)
        else
           self.titleTextPos.anchoredPosition =  Vector2(10,1)
        end
    end
    self.playerName.text = self.data.info.name;
    self.playerLv.text = tostring(self.data.info.level)
    local length = #ConfigMgr.Config.avatarFrames
    local avatarConfig = nil
    if not IsNullOrEmpty(data.data.info.avatar) then
        for i = 1, length do
            if ConfigMgr.Config.avatarFrames[i].id == data.data.info.avatar then
                avatarConfig = ConfigMgr.Config.avatarFrames[i]
                break
            end
        end
    end
    SetActive(self.avatar.gameObject,false)
    SetActive(self.playerDynamicAvatar.gameObject,false)
    if not TableIsNull(avatarConfig) then
        if avatarConfig.imgType == 1 then
            local avatarPath = ConfigHelper.GetHeadIconPath(avatarConfig.img, avatarConfig.imgId);
            self.avatar.texture = LuaMgr.GetTexture(avatarPath);
            SetActive(self.avatar.gameObject,true)        
        elseif avatarConfig.imgType == 2 then
            self.playerDynamicAvatar:AppointAvatar(avatarConfig.id)
            SetActive(self.playerDynamicAvatar.gameObject,true)
        end
    end

    avatarConfig = nil
    for i = 1, length do
        if ConfigMgr.Config.avatarFrames[i].id == data.data.info.avatarFrame then
            avatarConfig = ConfigMgr.Config.avatarFrames[i]
            break
        end
    end
    if not TableIsNull(avatarConfig) then
        PlayerAvatarFrameTool.SetAvatarFrame(self.avatarFrame, avatarConfig.id);
    else
        PlayerAvatarFrameTool.ClearImage(self.avatarFrame);
    end
end


function GuildApplyMemberItem:Clear()
    PlayerAvatarFrameTool.ClearImage(self.avatarFrame);
    self.data=nil;
end


function GuildApplyMemberItem:Destroy()
    PlayerAvatarFrameTool.ClearImage(self.avatarFrame);
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.avatar = nil
    self.avatarFrame = nil
    self.playerName = nil
    self.playerLv = nil
    self.applyBtn = nil
    self.btnRefuse = nil
end

