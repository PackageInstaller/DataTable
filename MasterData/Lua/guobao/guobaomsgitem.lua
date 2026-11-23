GuoBaoMsgItem = {};

GuoBaoMsgItem.__index = GuoBaoMsgItem;

local objs = {
    textTF = { path = "", type = "RectTransform" },
    text = { path = "", type = "Text" },
}

function GuoBaoMsgItem.New(prefab, parent)
    local self = {};
    setmetatable(self, GuoBaoMsgItem);
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    UITool.Parse(self.gameObject, self, objs);
    self.transform = self.gameObject:GetComponent("RectTransform");
    self.isLive = false;
    self.pos = Vector3(0, 0, 0);
    self.size = Vector2(0, 50);
    self.minX = 0;
    return self;
end

function GuoBaoMsgItem:SetData(data, lineIndex, lastX)
    self.data = data;
    self.text.text = data.Msg;
    self.size.x = self.text.preferredWidth + 10;
    self.textTF.sizeDelta = self.size;
    local halfWidth = self.size.x * 0.5;
    local maxX = LuaMgr.GetScreenWidth() * 0.5 + halfWidth;
    self.minX = -maxX;
    if (lastX > maxX) then
        self.pos.x = lastX + halfWidth + 200;
    elseif (lastX == 0) then
        self.pos.x = maxX + 50;
    else
        self.pos.x = maxX + halfWidth + 200;
    end
    self.pos.y = 250 - lineIndex * 60;
    self.transform.localPosition = self.pos;
    self.isLive = true;
    self.gameObject:SetActive(true);
end

function GuoBaoMsgItem:Update()
    self.pos.x = self.pos.x - 6;
    self.transform.localPosition = self.pos;
    self.isLive = self.pos.x > self.minX;
end

function GuoBaoMsgItem:Clear()
    self.data = nil;
    self.gameObject:SetActive(false);
end

function GuoBaoMsgItem:Destroy()
    self.pos = nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end