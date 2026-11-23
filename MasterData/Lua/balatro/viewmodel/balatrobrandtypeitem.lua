


















BalatroBrandTypeItem = {}
BalatroBrandTypeItem.__index = BalatroBrandTypeItem

local objs = {
    nameTriganleObj = {path = "AnimRoot/NameBGTriganle", type = BalatroUtil.GameObject},
    itemBtn = {path = "", type = BalatroUtil.Button},
    selectFlag = {path = "AnimRoot/selectFlag", type = BalatroUtil.GameObject},
    levelTxt = {path = "AnimRoot/Level", type = BalatroUtil.Text},
    nameTxt = {path = "AnimRoot/Name", type = BalatroUtil.Text},
    scoreTxt = {path = "AnimRoot/Score", type = BalatroUtil.Text},
    rateTxt = {path = "AnimRoot/Rate", type = BalatroUtil.Text},
    timesTxt = {path = "AnimRoot/Times", type = BalatroUtil.Text}
}

function BalatroBrandTypeItem.New()

    local self = {}
    setmetatable(self, BalatroBrandTypeItem)
    return self
end

function BalatroBrandTypeItem:Init()
    self._IsSelected = false
    UITool.Parse(self.gameObject, self, objs)
    self.OnClickItem = function()
        if not self.data or not self.data.clickCallback then
            return
        end
        self.data.clickCallback(self)
    end
    if self.itemBtn then
        LuaMgr.AddClick(self.itemBtn, self.OnClickItem)
    end
    SetActive(self.nameTriganleObj, false)
end

function BalatroBrandTypeItem:SetData(params)
    self:Clear()
    SetActive(self.gameObject, true)
    self.data = params.data
    if self.data == nil then
        return
    end

    local brandTypeData = self.data.brandTypeData
    local constStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20026")
    self.levelTxt.text = string.format(constStr, BalatroUtil.ColorText("#FFE078", brandTypeData:GetLevel(true)))
    self.nameTxt.text = brandTypeData:GetName()
    self.scoreTxt.text = brandTypeData:GetTotalScore(true)
    self.rateTxt.text = brandTypeData:GetTotalRate(true)
    self.timesTxt.text = brandTypeData:GetValidTimes()
end



function BalatroBrandTypeItem:GetData()
    return self.data.brandTypeData
end

function BalatroBrandTypeItem:SetSelected(selected)
    self._IsSelected = selected
    SetActive(self.selectFlag, selected)
end

function BalatroBrandTypeItem:IsSelected()
    return self._IsSelected
end

function BalatroBrandTypeItem:CloseDetailPanel()
    if self.nameTriganleObj then
        SetActive(self.nameTriganleObj, false)
    end
end

function BalatroBrandTypeItem:Clear()
end

function BalatroBrandTypeItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.itemBtn, self.OnClickItem)
        self.OnClickItem = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end