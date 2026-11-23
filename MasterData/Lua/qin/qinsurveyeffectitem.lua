QinSurveyEffectItem = {};

QinSurveyEffectItem.__index = QinSurveyEffectItem;

local objs = {
    text = { path = "Text", type = "Text" },
};

function QinSurveyEffectItem.New()
    local self = {};
    setmetatable(self, QinSurveyEffectItem);
    return self;
end

function QinSurveyEffectItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function QinSurveyEffectItem:SetData(data)
    local buff = ConfigQinMgr.GetBuff(data.data);
    if (buff ~= nil) then
        self.text.text = LuaMgr.GetLangText(buff.DescriptionLan);
    end
end

function QinSurveyEffectItem:Clear()
    
end

function QinSurveyEffectItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end