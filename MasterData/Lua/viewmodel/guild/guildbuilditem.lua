GuildBuildItem = {};

GuildBuildItem.__index = GuildBuildItem;

local objs = {
    btn = { path = "bg", type = "Button" },
    buildName = { path = "bg/name/buildName", type = "Text" },

    lock = { path = "status", type = "GameObject" },
}

function GuildBuildItem.New(obj, index, callback)
    local self = {};
    setmetatable(self, GuildBuildItem);
    self.obj = obj;
    self.index = index;
    self.callback = callback
    UITool.Parse(self.obj, self, objs)
    local clickBtn = function()
        if self.callback ~= nil then
            self.callback(index)
        end
    end
    LuaMgr.AddClick(self.btn,clickBtn)
    return self;
end

function GuildBuildItem:SetData(data)
    self.data = data
    self.buildName.text = LuaMgr.GetLangText(self.data.name);
    SetActive(self.lock,self.data.lock);
    SetActive(self.image,not self.data.lock);
    
    local imgs = self.btn:GetComponentsInChildren(typeof(UnityEngine.UI.Image));
    for i = 0, imgs.Length-1 do
        if imgs[i] ~= nil then
            imgs[i].color = self.data.lock and UnityEngine.Color(0.5, 0.5, 0.5, 1) or UnityEngine.Color(1, 1, 1, 1)
        end
    end

    local txts = self.btn:GetComponentsInChildren(typeof(UnityEngine.UI.Text));
    for i = 0, txts.Length-1 do
        if txts[i] ~= nil then
            txts[i].color = self.data.lock and UnityEngine.Color(0.5, 0.5, 0.5, 1) or UnityEngine.Color(1, 1, 1, 1)
        end
    end
end


function GuildBuildItem:Clear()
    self.data = nil;
end


function GuildBuildItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.btn = nil
    self.buildName = nil
    self.image = nil
    self.lock = nil
end

