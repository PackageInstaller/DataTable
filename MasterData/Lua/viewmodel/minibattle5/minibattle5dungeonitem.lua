MiniBattle5DungeonItem = {};

MiniBattle5DungeonItem.__index = MiniBattle5DungeonItem;

local objs = {
    clickBtn = { path = "", type = "Button" },
    RedGo = { path = "Red", type = "GameObject" },
}

function MiniBattle5DungeonItem.New(obj)
    local self = {};
    setmetatable(self, MiniBattle5DungeonItem);
    self.gameObject = obj
    return self;
end

function MiniBattle5DungeonItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.onClickCommand = function()
        if self.data.unlockTime > LuaMgr.Timestamp() then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, os.date(LuaMgr.GetLangText("MiniBattle5DungeonItem_0"), self.data.unlockTime));
            return
        end
        LuaMgr.ShowLuaPanel(UIName.MiniBattle5BuffViewModel, self.data.plotId)
    end
    LuaMgr.AddClick(self.clickBtn, self.onClickCommand);
    SetActive(self.LockGo, false)
    SetActive(self.SelectGo, false)
end

function MiniBattle5DungeonItem:SetData(pdata)
    self.data = pdata
    for i = 1, self.gameObject.transform.childCount do
        local child = self.gameObject.transform:GetChild(i - 1)
        SetActive(child.gameObject,false)
    end
    local cofig = ConfigMgr.Config.MiniBattleNewMap[self.data.plotId]
    local group = self.gameObject.transform:Find("Group" .. cofig.SpecialSkin).gameObject
    local Nametxt = self.gameObject.transform:Find("Group" .. cofig.SpecialSkin .. "/Name"):GetComponent("Text")
    local LockGo = self.gameObject.transform:Find("Group" .. cofig.SpecialSkin .. "/Lock").gameObject
    local MaskGo_1 = self.gameObject.transform:Find("Group" .. cofig.SpecialSkin .. "/Lock/Mask_1").gameObject
    local MaskGo_2 = self.gameObject.transform:Find("Group" .. cofig.SpecialSkin .. "/Lock/Mask_2").gameObject
    local indexTxt_1 = self.gameObject.transform:Find("Group" .. cofig.SpecialSkin .. "/Bg/IndexText3"):GetComponent("Text")
    local indexTxt_2 = self.gameObject.transform:Find("Group" .. cofig.SpecialSkin .. "/Bg/IndexText4"):GetComponent("Text")
    local BgGo_1 = self.gameObject.transform:Find("Group" .. cofig.SpecialSkin .. "/Bg/Bg_1").gameObject
    local BgGo_2 = self.gameObject.transform:Find("Group" .. cofig.SpecialSkin .. "/Bg/Bg_2").gameObject
    local ScoreGo =  self.gameObject.transform:Find("Group" .. cofig.SpecialSkin .. "/Score").gameObject
    local Scoretxt =  self.gameObject.transform:Find("Group" .. cofig.SpecialSkin .. "/Score/Score"):GetComponent("Text")
    local LockTips = self.gameObject.transform:Find("Group" .. cofig.SpecialSkin .. "/Lock/Tips"):GetComponent("Text")
    
    SetActive(group,true)
    
    Nametxt.text = self.data.showName
    if self.data.isLock then
        LockTips.text = os.date(LuaMgr.GetLangText("MiniBattle5DungeonItem_1"), self.data.unlockTime)
    end

    SetActive(LockGo, self.data.isLock)
    local showBg1 = self.data.groupIndex % 2 == 1
    local showBg2 = self.data.groupIndex % 2 == 0

    SetActive(MaskGo_1, showBg1)
    SetActive(MaskGo_2, showBg2)
    SetActive(self.RedGo,RedMgr.Singleton:GetRedStateById(self.data.redId) > 0)
    SetActive(self.gameObject, true)

    Scoretxt.text = self.data.score
    SetActive(ScoreGo, not isLock)
    indexTxt_1.text = LuaMgr.GetLangText(self.data.dungeonText)
    indexTxt_2.text = LuaMgr.GetLangText(self.data.dungeonText)
    SetActive(BgGo_1, showBg1)
    SetActive(BgGo_2, showBg2)
end

function MiniBattle5DungeonItem:Hide()
    SetActive(self.gameObject, false)
end

function MiniBattle5DungeonItem:Clear()
    self.data = nil
end

function MiniBattle5DungeonItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    if (self.onClickCommand ~= nil) then
        LuaMgr.RemoveClick(self.clickBtn, self.onClickCommand)
        self.onClickCommand = nil
    end
    self.gameObject = nil
end 