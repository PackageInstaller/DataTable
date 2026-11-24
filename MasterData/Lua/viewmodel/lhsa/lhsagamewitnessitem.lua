LHSAGameWitnessItem = {};

LHSAGameWitnessItem.__index = LHSAGameWitnessItem;

local objs = {
    bgImg = { path = "bgImg", type = "GameObject" },
    icon = { path = "bgImg/witnessIcon", type = "RawImage" },
    nameText = { path = "bgImg/witnessName", type = "Text" },
    contentText = { path = "bgImg/witnessContent", type = "Text" },
};

function LHSAGameWitnessItem.New()
    local self = {};
    setmetatable(self, LHSAGameWitnessItem);
    return self;
end

function LHSAGameWitnessItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function LHSAGameWitnessItem:SetData(data)
    self.config = data.data.config;
    if self.config then
        self.nameText.text = self.config.name or ""
        self.contentText.text = self.config.content or self.config.text or ""
        if self.config.icon then
            local textture = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(self.config.icon))
            if (textture ~= nil) then
                self.icon.texture = textture
            else
                textture = LHSAMgr.GetTexture(self.config.icon)
                if (textture ~= nil) then
                    self.icon.texture = textture
                end
            end
        end
    end
end

function LHSAGameWitnessItem:Clear()
    self.config = nil;
end

function LHSAGameWitnessItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end