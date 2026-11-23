DHSurveyMapDrawItem = {};

DHSurveyMapDrawItem.__index = DHSurveyMapDrawItem;

local objs = {
    iconBtn = { path = "Icon", type = "Button" },
    iconGo = { path = "Icon", type = "GameObject" },
    effectObj = { path = "eff_light", type = "GameObject" },
};

function DHSurveyMapDrawItem.New()
    local self = {};
    setmetatable(self, DHSurveyMapDrawItem);
    return self;
end

function DHSurveyMapDrawItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.IconBtnOnClick = function()
        self.iconBtn.interactable = false;
        PlayerDHMgr.ExploreDraw(self.stageId, self.index)
    end
    LuaMgr.AddClick(self.iconBtn, self.IconBtnOnClick);
end

function DHSurveyMapDrawItem:SetData(data)
    self.iconBtn.interactable = true;
    self.stageId = data.data.stageId
    self.index = data.data.index
    self.gameObject.name = self.index
    local isOpen = data.data.isOpen
    local isInit = data.data.isInit
    if (not isInit and self.iconGo.activeSelf and isOpen) then
        SetActive(self.effectObj, true)
        if self.startDelay ~= nil then
            coroutine_runner.stop(self.startDelay)
        end
        self.startDelay = coroutine_runner.start(function()
            self.iconBtn.interactable = false;
            coroutine_runner.wait(0.5)
            SetActive(self.iconGo, false)
        end)
        return
    else
        SetActive(self.effectObj, false)
    end
    SetActive(self.iconGo, not isOpen)
end

function DHSurveyMapDrawItem:Clear()

end

function DHSurveyMapDrawItem:Destroy()
    if (self.IconBtnOnClick ~= nil) then
        LuaMgr.RemoveClick(self.iconBtn, self.IconBtnOnClick);
    end
    if self.startDelay ~= nil then
        coroutine_runner.stop(self.startDelay)
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end