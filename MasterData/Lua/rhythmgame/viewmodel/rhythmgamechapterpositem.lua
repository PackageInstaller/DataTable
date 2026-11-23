
RhythmGameChapterPosItem = {};

RhythmGameChapterPosItem.__index = RhythmGameChapterPosItem;

RhythmGameChapterPosItem.addWidth = 0;


local objs = {
    btn = { path = "", type = "Button" },
    light = { path = "Light", type = "GameObject" },
    textNum = { path = "TextNum", type = "Text" },
    textNumGo = { path = "TextNum", type = "GameObject" },
    maskPos = { path = "MaskPos", type = "GameObject" },
    redBox = { path = "TextNum/RedBox", type = "GameObject" },
    ImglockEffect = { path = "eff_positem_unlock", type = "GameObject" },
    redIconListener = { path = "TextNum/RedBox", type = "RedIconListener" },
}

function RhythmGameChapterPosItem.New()
    local self = {};
    setmetatable(self, RhythmGameChapterPosItem);
    return self;
end

function RhythmGameChapterPosItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickBtn = function()
        if (self.isLock) then
            local unlockName = ConfigRhythmGameMgr.GetUnlockName(self.data.config.unlockParam)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(ConfigMgr.LangGlobal("10754"), unlockName));
        else
            local cur = PlayerRhythmGameMgr.GetChapterArea()
            if (cur == self.data.index) then return end
            PlayerRhythmGameMgr.SetChapterArea(self.data.index)
            LuaMgr.InvokeUIEventListeners(UIEventConst.RhythmGameChapterArea);
        end
    end
    SetActive(self.ImglockEffect, false)
    LuaMgr.AddClick(self.btn, self.OnClickBtn);
end

function RhythmGameChapterPosItem:SetData(data)
    self.data = data.data
    self.isLock = self.data.isLock
    self.redIconListener.RedId = "12017_" .. self.data.index
    local pos = PlayerRhythmGameMgr.GetChapterArea()
    self.textNum.text = self.data.index
    SetActive(self.light, pos == self.data.index)
    SetActive(self.redBox, pos ~= self.data.index)   
    if (PlayerRhythmGameMgr.CheckChapterShownById(self.data.config.unlockParam)) then
        if self.startDelay ~= nil then
            coroutine_runner.stop(self.startDelay)
        end
        self.startDelay = coroutine_runner.start(function()
            SetActive(self.textNumGo, false)
            SetActive(self.maskPos, false)
            coroutine_runner.wait(0.9)
            SetActive(self.ImglockEffect, true)
            coroutine_runner.wait(1)
            SetActive(self.textNumGo, true)
            SetActive(self.ImglockEffect, false)
        end)
        return
    end   
    self:IsMask(self.isLock)
end

function RhythmGameChapterPosItem:IsMask(_bMask)
    SetActive(self.textNumGo, not _bMask)
    SetActive(self.maskPos, _bMask)
end

function RhythmGameChapterPosItem:Clear()
    self.data = nil;
    if (not coroutine_runner.checkIsDestory()) and self.startDelay ~= nil then
        coroutine_runner.stop(self.startDelay);
        self.startDelay = nil;
    end
end

function RhythmGameChapterPosItem:Destroy()
    if (self.OnClickBtn ~= nil) then

        self.OnClickBtn = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end