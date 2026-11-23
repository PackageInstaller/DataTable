FoundationMsgBoardItem = {};

FoundationMsgBoardItem.__index = FoundationMsgBoardItem;

local objs = {
    head = { path = "Head", type = "RawImage" },
    frame = { path = "Head/Frame", type = "Image" },
    name = { path = "Name", type = "Text" },
    date = { path = "Date", type = "Text" },
    content = { path = "Content", type = "Text" },
    operateGO = { path = "Operate", type = "GameObject" },
    operateBtn = { path = "Operate", type = "Button" },
    operatesGO = { path = "Operates", type = "GameObject" },
    operatesTF = { path = "Operates", type = "RectTransform" },
    operateTop = { path = "Operates/Top", type = "Button" },
    operateReplyGO = { path = "Operates/Reply", type = "GameObject" },
    operateReply = { path = "Operates/Reply", type = "Button" },
    operateDelete = { path = "Operates/Delete", type = "Button" },
    playerTitle = {path="Name/PlayerTitle",type="Image"},
    playerTitleText = {path="Name/PlayerTitle/Text",type="Text"},
    titleTextPos = {path="Name/PlayerTitle/Text",type="RectTransform"},
}

function FoundationMsgBoardItem.New()
    local self = {};
    setmetatable(self, FoundationMsgBoardItem);
    return self;
end

function FoundationMsgBoardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.isOperate = false;
    self:SetOperate(false);
    self.OnClickOperate = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationMsgBoardOperate, self, 0);
    end
    self.OnClickOperateTop = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationMsgBoardOperate, self, 1);
    end
    self.OnClickOperateReply = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationMsgBoardOperate, self, 2);
    end
    self.OnClickOperateDelete = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationMsgBoardOperate, self, 3);
    end
    LuaMgr.AddClick(self.operateBtn, self.OnClickOperate);
    LuaMgr.AddClick(self.operateTop, self.OnClickOperateTop);
    LuaMgr.AddClick(self.operateReply, self.OnClickOperateReply);
    LuaMgr.AddClick(self.operateDelete, self.OnClickOperateDelete);
end

function FoundationMsgBoardItem:SetData(data)
    self.data = data.data;
    local avatarData = FoundationMsgMgr.GetAvatarFrame(self.data.Avatar);
    if (avatarData ~= nil) then
        local headPath = ConfigHelper.GetHeadIconPath(avatarData.img, avatarData.imgId);
        self.head.texture = LuaMgr.GetTexture(headPath);
    end
    PlayerAvatarFrameTool.SetAvatarFrame(self.frame, self.data.AvatarFrame);

    local title = ConfigHelper.GetTitleConfig(self.data.Title)
    if not TableIsNull(title) then
        self.playerTitle.sprite = LuaMgr.GetSprite("PlayerTitle",title.img)
        self.playerTitleText.text = LuaMgr.GetLangText(title.namelan)
        if title.img == "Title_40001" then
           self.titleTextPos.anchoredPosition =  Vector2(2,1)
        else
           self.titleTextPos.anchoredPosition =  Vector2(10,1)
        end
    end
    self.name.text = self.data.Name;
    self.date.text = os.date("%Y-%m-%d", self.data.LevMsgTime);
    if (IsNull(self.data.Answer)) then
        self.content.text = self.data.Msg;
    else
        self.content.text = string.format(LuaMgr.GetLangText("FoundationMsgBoardItem_0"), self.data.Msg, self.data.Answer.Name, self.data.Answer.Msg);
    end
    SetActive(self.operateGO, not FoundationMgr.IsVisitor());
end

function FoundationMsgBoardItem:SetOperate(status)
    self.isOperate = status;
    if (status) then
        local sizeDelta = self.operatesTF.sizeDelta;
        if (IsNull(self.data.Answer)) then
            sizeDelta.x = 136;
            SetActive(self.operateReplyGO, true);
        else
            sizeDelta.x = 76;
            SetActive(self.operateReplyGO, false);
        end
        self.operatesTF.sizeDelta = sizeDelta;
    end
    SetActive(self.operatesGO, status);
end

function FoundationMsgBoardItem:Clear()
    self.head.texture = nil;
    PlayerAvatarFrameTool.ClearImage(self.frame);
    self:SetOperate(false);
end

function FoundationMsgBoardItem:Destroy()
    PlayerAvatarFrameTool.ClearImage(self.frame);
    if (self.OnClickOperate ~= nil) then
        LuaMgr.RemoveClick(self.operateBtn, self.OnClickOperate);
        self.OnClickOperate = nil;
    end
    if (self.OnClickOperateTop ~= nil) then
        LuaMgr.RemoveClick(self.operateTop, self.OnClickOperateTop);
        self.OnClickOperateTop = nil;
    end
    if (self.OnClickOperateReply ~= nil) then
        LuaMgr.RemoveClick(self.operateReply, self.OnClickOperateReply);
        self.OnClickOperateReply = nil;
    end
    if (self.OnClickOperateDelete ~= nil) then
        LuaMgr.RemoveClick(self.operateDelete, self.OnClickOperateDelete);
        self.OnClickOperateDelete = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end