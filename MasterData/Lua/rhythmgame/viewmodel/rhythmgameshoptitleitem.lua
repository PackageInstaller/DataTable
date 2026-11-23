RhythmGameShopTitleItem = {};

RhythmGameShopTitleItem.__index = RhythmGameShopTitleItem;

local objs = {
    aniRoot = { path = "", type = "Animator" },
    canvasGroup = { path = "", type = "CanvasGroup" },
    button = { path = "", type = "Button" },
    redIconListener = { path = "", type = "RedIconListener" },
    title = { path = "Title", type = "GameObject" },
    select = { path = "Select", type = "GameObject" },
    titleName = { path = "Title/Name", type = "Text" },
    titleMask = { path = "Mask", type = "GameObject" },
    NameMask = { path = "Mask/NameMask", type = "Text" },
    selectName = { path = "Select/Name", type = "Text" },   
}

function RhythmGameShopTitleItem.New()
    local self = {};
    setmetatable(self, RhythmGameShopTitleItem);
    return self;
end

function RhythmGameShopTitleItem:Init()   
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        if (not self.isLock) then
            PlayerRhythmGameMgr.UpdateShopNewDotData(self.data.config.id)
            PlayerRhythmGameMgr.SetShopTap(self.index)
            LuaMgr.InvokeUIEventListeners(UIEventConst.RhythmGameShopTitle);
        else
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText(self.data.config.remarksLan));
        end
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
end

function RhythmGameShopTitleItem:SetData(data)
    self.dataQuests = DataMgr.Player.quests;
    self.data = data.data;
    self.index = self.data.index
    self.isLock = self.data.isLock
    self.redIconListener.RedId = "12010_"..self.index
    local type = PlayerRhythmGameMgr.GetShopTap()
    local select = self.data.index == type
    SetActive(self.select, select)
    SetActive(self.titleMask, self.isLock)
    SetActive(self.title, not select and not self.isLock)
    self.titleName.text = LuaMgr.GetLangText(self.data.config.namelan);
    self.selectName.text = LuaMgr.GetLangText(self.data.config.namelan);
    self.NameMask.text = "-" .. ConfigMgr.LangGlobal("10352") .. "-" 
    self.canvasGroup.alpha = self.data.lockAlpha 
    self:ShowAim(self.index)
end

function RhythmGameShopTitleItem:ShowAim(groupIndex)    
    if(self.aniRoot == nil)then return end 
    self.coroutine = coroutine_runner.start(
        function()           
            SetActive(self.aniRoot.gameObject, false)
            coroutine_runner.wait(0.1 * (groupIndex - 1))
            SetActive(self.aniRoot.gameObject, true)
            self.aniRoot.enabled = false;
            self.aniRoot.enabled = true;
            self.aniRoot:Rebind();
            self.aniRoot:Play("ani_RhythmGameShopPanel_TitleItem_001");
            coroutine_runner.wait(0.5)
            self.aniRoot.enabled = false; 
        end)
end

function RhythmGameShopTitleItem:Clear()
    if self.coroutine ~= nil then
        coroutine_runner.stop(self.coroutine);
        self.coroutine = nil;
        SetActive(self.aniRoot.gameObject, true)        
    end
end

function RhythmGameShopTitleItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end