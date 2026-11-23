VoyageSelectCaptainItem = {};

VoyageSelectCaptainItem.__index = VoyageSelectCaptainItem;

local objs = {
    body = { path = "Body", type = "RawImage" },
    name = { path = "Name", type = "Text" },
}

function VoyageSelectCaptainItem.New(gameObject, select)
    local self = {};
    setmetatable(self, VoyageSelectCaptainItem);
    UITool.Parse(gameObject, self, objs);
    self.select = select;
    if (not select) then
        self.bodyBtn = self.body:GetComponent("Button");
        self.OnClickBody = function()
            LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageSelectCaptainInfo, self.data);
        end
        LuaMgr.AddClick(self.bodyBtn, self.OnClickBody);
    end
    return self;
end

function VoyageSelectCaptainItem:SetData(data)
    self.data = data;
    self.body.texture = ConfigVoyageMgr.GetCaptainTexture(self.data.CaptainID, self.select);
    self.name.text = LuaMgr.GetLangText(self.data.CaptainNameLan);
end

function VoyageSelectCaptainItem:Clear()
    self.data = nil;
    self.body.texture = nil;
end

function VoyageSelectCaptainItem:Destroy()
    if (self.OnClickBody ~= nil) then
        LuaMgr.RemoveClick(self.bodyBtn, self.OnClickBody);
        self.OnClickBody = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end