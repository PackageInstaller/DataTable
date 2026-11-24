











LHSANovelItem = {}
LHSANovelItem.__index = LHSANovelItem

local objs = {
    rectTrans = {path = "", type = UITool.RectTransform},
    button = {path = "Group", type = UITool.Button},
    newBG = {path = "Group/NewBG", type = UITool.GameObject},
    normalBG = {path = "Group/NormalBG", type = UITool.GameObject},
    gotFlag = {path = "Group/NormalBG/_LeftTop", type = UITool.GameObject},
    arrowLight = {path = "Group/ArrowLight", type = UITool.GameObject},
    arrowDark = {path = "Group/ArrowDark", type = UITool.GameObject},
    selectObj = {path = "Group/SelectObj", type = UITool.GameObject},
    name = {path = "Group/Name", type = UITool.Text}
}

LHSANovelItem.New = function(prefab, needInstantiate, parent)

    local self = {}
    setmetatable(self, LHSANovelItem)
    if needInstantiate == true then
        self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    else
        self.gameObject = prefab
    end
    self:Init()
    return self
end

function LHSANovelItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.OnClickButton = function()
        if self.data.OnClickButton ~= nil then
            self.data.OnClickButton(self)
        end
    end
    LuaMgr.AddClick(self.button, self.OnClickButton)
end

function LHSANovelItem:SetData(data)
    self.data = data
    self.name.text = LuaMgr.GetLangText(self.data.namelan)
    SetActive(self.newBG, self.data.IsNew == true)
    SetActive(self.normalBG, self.data.IsNew == false)
    SetActive(self.gotFlag, self.data.Status == CommonRewardItem.Status.Got)
    local isLight = self.data.Status == CommonRewardItem.Status.Got or self.data.IsNew == true
    SetActive(self.arrowLight, isLight == true)
    SetActive(self.arrowDark, isLight == false)
    self:SetSelectStatus(false)
end

function LHSANovelItem:SetIsEven(isEven)
    self.isEven = isEven
end

function LHSANovelItem:SetSelectStatus(isSelect)
    SetActive(self.selectObj, isSelect)
end

function LHSANovelItem:SetPosition(pos)
    self.rectTrans.anchoredPosition = pos
end

function LHSANovelItem:ClearItems()
end

function LHSANovelItem:Clear()
    self:ClearItems()
end

function LHSANovelItem:Destroy()
    LuaMgr.RemoveClick(self.button, self.OnClickButton)
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end