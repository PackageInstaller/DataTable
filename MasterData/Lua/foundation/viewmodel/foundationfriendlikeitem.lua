FoundationFriendLikeItem = {};

FoundationFriendLikeItem.__index = FoundationFriendLikeItem;

local objs = {
    head = { path = "Head", type = "RawImage" },
    frame = { path = "Head/Frame", type = "Image" },
    name = { path = "Name", type = "Text" },
    content = { path = "Content", type = "Text" },
    itemGO = { path = "Item", type = "GameObject" },
    itemText = { path = "Item", type = "Text" },
    itemIcon = { path = "Item/Icon", type = "RawImage" },
    btnLike = { path = "BtnLike", type = "Button" },
    imgLike2 = { path = "BtnLike/ImgLike2", type = "GameObject" },
}

function FoundationFriendLikeItem.New()
    local self = {};
    setmetatable(self, FoundationFriendLikeItem);
    return self;
end

function FoundationFriendLikeItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickBtnLike = function()
        ApiMgr.Request("friends/visit_like", { Uid = self.data.Uid }, true, function(result)
            local data = json.decode(result);
            if (data ~= nil and data.result ~= nil) then
                if (not IsNull(data.result.Rewards)) then
                    local reward = json.encode(data.result.Rewards);
                    LuaMgr.ShowItemRewared(reward);
                else
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("RoomViewModel_22"));
                end
            end
            self.btnLike.enabled = false
            SetActive(self.imgLike2, false)
        end, nil, true, true);
    end
    LuaMgr.AddClick(self.btnLike, self.OnClickBtnLike);
end

function FoundationFriendLikeItem:SetData(data)
    self.data = data.data;
    local avatarData = FoundationMsgMgr.GetAvatarFrame(self.data.Avatar);
    if (avatarData ~= nil) then
        local headPath = ConfigHelper.GetHeadIconPath(avatarData.img, avatarData.imgId);
        self.head.texture = LuaMgr.GetTexture(headPath);
    end
    PlayerAvatarFrameTool.SetAvatarFrame(self.frame, self.data.CurrentAvatarFrame);
    self.name.text = self.data.Name;
    self.content.text = LuaMgr.GetLangText("FoundationFriendLikeItem_0");
    local thumbsupReward = ConfigMgr.Config.FriendConstants.ThumbsupReward[1];
    if (thumbsupReward ~= nil) then
        self.itemText.text = "X" .. self.data.LikeCount * thumbsupReward.count;
        self.itemIcon.texture = GetItemHomeIcon(thumbsupReward.id);
    end
    SetActive(self.itemGO, self.data.LikeCount > 0);
    self.btnLike.enabled = false
    SetActive(self.imgLike2, false)
    local point = DataMgr.Player.Friends.FriendLikePoint
    if (point ~= nil and point[self.data.Uid] == nil) then
        local curTime = LuaMgr.Timestamp()
        if (self.data.LikeTime <= (curTime + 604800)) then
            self.btnLike.enabled = true
            SetActive(self.imgLike2, true)
        end
    end
end

function FoundationFriendLikeItem:Clear()
    self.data = nil;
    self.head.texture = nil;
    PlayerAvatarFrameTool.ClearImage(self.frame);
    self.itemIcon.texture = nil;
end

function FoundationFriendLikeItem:Destroy()
    PlayerAvatarFrameTool.ClearImage(self.frame);
    if (self.OnClickBtnLike ~= nil) then
        LuaMgr.RemoveClick(self.btnLike, self.OnClickBtnLike);
        self.OnClickBtnLike = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end