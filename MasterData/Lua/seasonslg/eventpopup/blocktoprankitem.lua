BlockTopRankItem = {};

BlockTopRankItem.__index = BlockTopRankItem;
local objs = {
    headInfo = { path = "root/headInfo", type = "GameObject" },
    imgAvatar = { path = "root/headInfo/avatar", type = "RawImage" },
    avatarFrame = { path = "root/headInfo/avatarFrame", type = "Image" },
    imgDynamicAvatar = { path = "root/headInfo/DynamicAvatar", type = "PlayerDynamicAvatar" },
    txtName = { path = "root/name", type = "Text" },
    txtPercent= { path = "root/percent", type = "Text" },
};

function BlockTopRankItem.New(gameObject)
    local self = {};
    setmetatable(self, BlockTopRankItem);
    self.gameObject = gameObject
    self.transform = gameObject:GetComponent("RectTransform")
    UITool.Parse(self.gameObject, self, objs);
    self.playerAvatarFrameTool = PlayerAvatarFrameTool.New(self.avatarFrame)
    return self;
end

function BlockTopRankItem:Init()

end


function BlockTopRankItem:SetData(data,max)
    self.data = data;
    SetActive(self.txtPercent.gameObject,true)
    SetActive(self.headInfo.gameObject,true)
	SetActive(self.txtName.gameObject,true)
    if data == nil then
        SetActive(self.txtName.gameObject,false)
        SetActive(self.headInfo.gameObject,false)
        self.playerAvatarFrameTool:Clear()
        return
    end
    self.txtName.text=self.data.Name;
    local length = #ConfigMgr.Config.avatarFrames
    local avatarConfig = nil
    if not IsNullOrEmpty(data.Avatar) then
        for i = 1, length do
            if ConfigMgr.Config.avatarFrames[i].id == data.Avatar then
                avatarConfig = ConfigMgr.Config.avatarFrames[i]
                break
            end
        end
    end
    SetActive(self.imgAvatar.gameObject,false)
    SetActive(self.imgDynamicAvatar.gameObject,false)
    if not TableIsNull(avatarConfig) then
        if avatarConfig.imgType == 1 then
            local avatarPath = ConfigHelper.GetHeadIconPath(avatarConfig.img, avatarConfig.imgId);
            self.imgAvatar.texture = LuaMgr.GetTexture(avatarPath);
            SetActive(self.imgAvatar.gameObject,true)
        elseif avatarConfig.imgType == 2 then
            self.imgDynamicAvatar:AppointAvatar(avatarConfig.id)
            SetActive(self.imgDynamicAvatar.gameObject,true)
        end
    end

    avatarConfig = nil
    for i = 1, length do
        if ConfigMgr.Config.avatarFrames[i].id == data.AvatarFrame then
            avatarConfig = ConfigMgr.Config.avatarFrames[i]
            break
        end
    end
    if not TableIsNull(avatarConfig) then
        self.playerAvatarFrameTool:AppointAvatarFrame(avatarConfig.id);
    else
        self.playerAvatarFrameTool:Clear()
    end
end


function BlockTopRankItem:Clear()
    self.data = nil;
    if self.playerAvatarFrameTool ~= nil then
        self.playerAvatarFrameTool:Clear()
    end
end

function BlockTopRankItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    if self.playerAvatarFrameTool ~= nil then
        self.playerAvatarFrameTool:Dispose()
        self.playerAvatarFrameTool = nil
    end
    self.gameObject = nil;
end