














DispatchCondItem = {}
DispatchCondItem.__index = DispatchCondItem

local objs = {
    checkBox = {path = "CheckBox", type = UITool.GameObject},
    extraCondObj = {path = "ExtraCondBG", type = UITool.GameObject},
    fullExtraCondObj = {path = "ExtraCondBG/FullExtraCondObj", type = UITool.GameObject},
    condDesc = {path = "CondDesc", type = UITool.Text},
    extraCondScore = {path = "ExtraCondBG/ExtraCondScore", type = UITool.Text}
}

DispatchCondItem.New = function(prefab, parent)

    local self = {}
    setmetatable(self, DispatchCondItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    UITool.Parse(self.gameObject, self, objs)
    return self
end

function DispatchCondItem:SetData(data)
    if data ~= nil then
        self.data = data
    end
    SetActive(self.checkBox, self.data.isFull == true)
    SetActive(self.extraCondObj, self.data.isBaseCond == false)
    SetActive(self.fullExtraCondObj, self.data.isFull == true)
    if self.data.isFull == true then
        self.condDesc.text = BalatroUtil.ColorText("#4B494E", self.data.text)
        if self.data.isBaseCond == false then
            self.extraCondScore.text = BalatroUtil.ColorText("#4B494E", "+" .. self.data.score)
        end
    else
        self.condDesc.text = BalatroUtil.ColorText("#4B494E", self.data.text)
        if self.data.isBaseCond == false then
            self.extraCondScore.text = BalatroUtil.ColorText("#4B494E", "+" .. self.data.score)
        end
    end
end