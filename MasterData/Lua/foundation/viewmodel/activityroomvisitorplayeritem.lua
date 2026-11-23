ActivityRoomVisitorPlayerItem = {};

ActivityRoomVisitorPlayerItem.__index = ActivityRoomVisitorPlayerItem;

local objs = {
    head = { path = "Group/Head", type = "RawImage" },
    frame = { path = "Group/Head/Frame", type = "Image" },
    name = { path = "Group/Name", type = "Text" },
    score = { path = "Group/Score", type = "Text" },
    like = { path = "Group/Like/Text", type = "Text" },
    visitorBtn = { path = "Group/Visitor", type = "Button" },
};

function ActivityRoomVisitorPlayerItem.New()
    local self = {};    
    setmetatable(self, ActivityRoomVisitorPlayerItem);
    return self;
end

function ActivityRoomVisitorPlayerItem:Init()    
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickVisitor = function()
        PlayerFoundationMgr.Visit(self.data);
    end
    LuaMgr.AddClick(self.visitorBtn, self.OnClickVisitor);
end

function ActivityRoomVisitorPlayerItem:SetData(data)
    self.data = data.data;
    local avatarData = FoundationMsgMgr.GetAvatarFrame(self.data.Avatar);
    if (avatarData ~= nil) then
        local headPath = ConfigHelper.GetHeadIconPath(avatarData.img, avatarData.imgId);
        self.head.texture = LuaMgr.GetTexture(headPath);
    end
    local hasFrameEffect = PlayerAvatarFrameTool.SetAvatarFrame(self.frame, self.data.AvatarFrame);
    if not hasFrameEffect then
        if not IsObjectNull(self.frame.sprite) then
            self.frame:SetNativeSize();
        end
    end
    self.name.text = self.data.Name;
    self.score.text = LuaMgr.GetLangText("ActivityRoomVisitorPlayerItem_0") .. self.data.Score;
    self.like.text = tostring(self.data.LikePoint);
end

function ActivityRoomVisitorPlayerItem:Clear()
    self.data = nil;
    self.head.texture = nil;
    PlayerAvatarFrameTool.ClearImage(self.frame);
end

function ActivityRoomVisitorPlayerItem:Destroy()
    PlayerAvatarFrameTool.ClearImage(self.frame);
    if (self.OnClickVisitor ~= nil) then
        LuaMgr.RemoveClick(self.visitorBtn, self.OnClickVisitor);
        self.OnClickVisitor = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end