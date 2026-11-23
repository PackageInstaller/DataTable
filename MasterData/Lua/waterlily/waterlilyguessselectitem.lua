













WaterlilyGuessSelectItem = {}
WaterlilyGuessSelectItem.__index = WaterlilyGuessSelectItem

local objs = {
    selectBtn = {path = "", type = UITool.Button},
    descText = {path = "Desc", type = UITool.Text},
    numberObj = {path = "Number", type = UITool.GameObject},
    lockObj = {path = "LockObj", type = UITool.GameObject},
    unlockCondTxt = {path = "LockObj/UnlockCondTxt", type = UITool.Text}
}

function WaterlilyGuessSelectItem.New()
    local self = {}
    setmetatable(self, WaterlilyGuessSelectItem)
    return self
end

function WaterlilyGuessSelectItem:Init()
    for i = 1, 3 do
        local name = string.format("ItemParent%d", i)
        local tempPath = string.format("RewardParent/%s", name)
        objs[name] = {path = tempPath, type = UITool.GameObject}
    end
    UITool.Parse(self.gameObject, self, objs)
    self.rewardItems = {}
    for i = 1, 3 do
        local name = string.format("ItemParent%d", i)
        table.insert(self.rewardItems, i, CommonRewardItem.New(self[name], true, 0.6))
    end
    self.numberUI = ArtWordTemplate.New(self.numberObj, 2, "Waterlily", "ui_hd_sl_xsgy_0", true)
    self.onClickCallback = function()
        if self.data.isUnlock == false then
            local tipsContent = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7319"), self.data.unlockPassName)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
            return
        end
        if self.data and self.data.onClickCallback then
            self.data.onClickCallback(self)
        else
            LuaDebug.error("WaterlilyGuessSelectItem onClickCallback is nil")
        end
    end
    LuaMgr.AddClick(self.selectBtn, self.onClickCallback)
end

function WaterlilyGuessSelectItem:SetData(data)
    self.data = data.data
    SetActive(self.lockObj, not self.data.isUnlock)
    self.numberUI:SetNum(data.id)
    if self.data.isUnlock == false then
        self.descText.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_15005")
    elseif self.data.guessNum > 0 then
        self.descText.text = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_25505"), self.data.guessNum)
    else
        self.descText.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_25506")
    end
    for i = 1, #self.rewardItems do
        local rewardItem = self.rewardItems[i]
        if i <= #self.data.rewardItemList then
            rewardItem:SetData1(self.data.rewardItemList[i])
            SetActive(rewardItem.gameObject, true)
            if self.data.isFinish == true then
                rewardItem:SetStatus(CommonRewardItem.Status.Got)
            else
                rewardItem:SetStatus(CommonRewardItem.Status.None)
            end
        else
            SetActive(rewardItem.gameObject, false)
        end
    end
end

function WaterlilyGuessSelectItem:Clear()
    self:ClearItems()
end

function WaterlilyGuessSelectItem:ClearItems()
    self.data = nil
end

function WaterlilyGuessSelectItem:Destroy()
end