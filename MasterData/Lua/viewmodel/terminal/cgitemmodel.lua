




CGItemModel = {}

CGItemModel.__index = CGItemModel

local objs = {
    icon = {path = "Icon", type = "RawImage"},
    iconButton = {path = "Icon", type = "Button"},
    normalIsShow = {path = "Normal", type = "GameObject"},
    lockIsShow = {path = "Lock", type = "GameObject"},
    nameText = {path = "Name/Text", type = "Text"},
    shareIsShow = {path = "Share", type = "GameObject"},
    settingIsShow = {path = "Setting", type = "GameObject"},
    unLockIsShow = {path = "UnLock", type = "GameObject"},
    sliderIsShow = {path = "Slider", type = "GameObject"},
    sliderValue = {path = "Slider/Image", type = "Image"},
    countText = {path = "Count", type = "Text"},
}

function CGItemModel.New(prefab, parent)
    local self = {}
    setmetatable(self, CGItemModel)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    UITool.Parse(self.gameObject, self, objs)
    self.transform = self.gameObject:GetComponent("RectTransform")
    self.clickCommand = function()
        if self.tempData.unlock or self.tempData.current == self.tempData.target then
            LuaMgr.InvokeUIEventListeners(UIEventConst.CollectionCGClick, self.data.id)
        else
            local tipStr = LuaMgr.GetLangText(self.data.sourceTipLan)
            LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
        end
    end
    LuaMgr.AddClick(self.iconButton,self.clickCommand)
    return self
end
CGItemModel.countFormat = "%d<color=#efe5cc><size=24>/%d</size></color>"
function CGItemModel:SetData(data)
    self.data = data
    self.icon.texture = LuaMgr.GetTexture(Path.CGSmallImagePath..self.data.headPathCG)
    self.nameText.text = LuaMgr.GetLangText(self.data.nameCGLan)
    self.tempData = DataMgr.Player.collectCGMap[self.data.id]
    if self.tempData ~= nil then
        if self.tempData.unlock == false then
            if self.tempData.target > 0 then
                self.countText.text = string.format(self.countFormat,self.tempData.current,self.tempData.target)
                self.sliderValue.fillAmount = self.tempData.current / self.tempData.target
            else
                self.countText.text = ""
                self.sliderValue.fillAmount = 1
            end
        else
            self.countText.text = ""
        end
        SetActive(self.normalIsShow,self.tempData.unlock)
        SetActive(self.lockIsShow,self.tempData.unlock == false)
        SetActive(self.unLockIsShow,self.tempData.unlock == false and self.tempData.current == self.tempData.target)
        SetActive(self.settingIsShow,self:WhetherSetting())
        SetActive(self.shareIsShow,self.tempData.shared)
        SetActive(self.sliderIsShow,self.tempData.unlock == false)
    end
    self.gameObject:SetActive(true)
end

function CGItemModel:WhetherSetting()
    for i = 1, #DataMgr.Player.selectedCG do
        if DataMgr.Player.selectedCG[i] == self.data.id then return true end
    end
    return false
end

function CGItemModel:Clear()
    self.data = nil
    self.gameObject:SetActive(false)
end

function CGItemModel:Destroy()
    if (self.clickCommand ~= nil) then
        LuaMgr.RemoveClick(self.iconButton, self.clickCommand)
        self.clickCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end