FoundationMsgItem = {};

FoundationMsgItem.__index = FoundationMsgItem;

local objs = {
    text = { path = "Text", type = "Text" },
    friend = { path = "Text/Friend", type = "GameObject" },
    stranger = { path = "Text/Stranger", type = "GameObject" },
}

function FoundationMsgItem.New(prefab, parent)
    local self = {};
    setmetatable(self, FoundationMsgItem);
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    UITool.Parse(self.gameObject, self, objs);
    self.transform = self.gameObject:GetComponent("RectTransform");
    self.isLive = false;
    self.pos = Vector3(0, 0, 0);
    return self;
end

function FoundationMsgItem:SetData(data)
    self.data = data;
    local len = LuaMgr.GetStringLength(data.Msg);
    if (len > 6) then
        self.text.text = LuaMgr.Substring(data.Msg, 6) .. "...";
    else
        self.text.text = data.Msg;
    end
    self.pos.x = math.random(-60, 60);
    self.pos.y = -230;
    self.transform.localPosition = self.pos;
    SetActive(self.friend, data.Friend);
    SetActive(self.stranger, not data.Friend);
    self.isLive = true;
    self.gameObject:SetActive(true);
end

function FoundationMsgItem:Update()
    self.pos.y = self.pos.y + 1;
    self.transform.localPosition = self.pos;
    self.isLive = self.pos.y <= 230;
end

function FoundationMsgItem:Clear()
    self.data = nil;
    self.gameObject:SetActive(false);
end

function FoundationMsgItem:Destroy()
    self.pos = nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end