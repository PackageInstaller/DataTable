













SSYXBuildSceneItem = {}
SSYXBuildSceneItem.__index = SSYXBuildSceneItem

local objs = {
    rectTrans = {path = "", type = UITool.RectTransform},
    lightObj = {path = "Group/Light", type = UITool.GameObject},
    darkObj = {path = "Group/Dark", type = UITool.GameObject},
    canUpgrede = {path = "Group/Light/CanUpgredeObj", type = UITool.GameObject},
    canCreateObj = {path = "Group/Dark/CanCreateObj", type = UITool.GameObject},
    confirmCreateBtn = {path = "Group/Dark/ConfirmBtn", type = UITool.Button},
    clickAreaBtn = {path = "Group/ClickAreaBtn", type = UITool.Button}
}

SSYXBuildSceneItem.New = function(obj)

    local self = {}
    setmetatable(self, SSYXBuildSceneItem)
    self.gameObject = obj
    self:Init()
    return self
end

function SSYXBuildSceneItem:Init()
    self.redPointNum = 0
    self.isRewardTips = false
    UITool.Parse(self.gameObject, self, objs)
    local canGetTrans = self.gameObject.transform:Find("Group/Light/CanGetObj")
    if canGetTrans ~= nil then
        self.canGetObj = canGetTrans.gameObject
        SetActive(self.canGetObj, false)
    end

    local newObjTrans = self.gameObject.transform:Find("Group/Light/NewObj")
    if newObjTrans ~= nil then
        self.newObj = newObjTrans.gameObject
        SetActive(self.newObj, false)
    end

    self.OnClickAreaBtn = function()
        if self.data.IsSelf ~= true then
            local tipsContent = LuaMgr.GetLangText(SSYXConst.LanText.LanText50)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
            return
        end
        if self.data.IsCreated == false then
            local tipsContent = LuaMgr.GetLangText(SSYXConst.LanText.LanText4)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
            return
        end
        if self.data.OnClickBuild ~= nil then
            self.data.OnClickBuild(self)
        end
    end
    LuaMgr.AddClick(self.clickAreaBtn, self.OnClickAreaBtn)

    self.OnClickConfirmCreateBtn = function()
        self:OnCreateBuild()
    end
    LuaMgr.AddClick(self.confirmCreateBtn, self.OnClickConfirmCreateBtn)

    self.OnCreateBuildNotify = function(param)
        if param == nil or param.Length == 0 then
            LuaDebug.error("通知创建参数有误")
            return
        end
        local data = param[0]
        if data == nil or self.data == nil or data.ID ~= self.data.ID then
            return
        end
    end
    LuaMgr.AddUIEventListener(UIEventConst.SSYXCreateBuildNotify, self.OnCreateBuildNotify)
end

function SSYXBuildSceneItem:SetData(data)
    self.data = data
    SetActive(self.lightObj, self.data.IsCreated == true)
    SetActive(self.darkObj, self.data.IsCreated ~= true)
    SetActive(self.canUpgrede, false)
    SetActive(self.canCreateObj.gameObject, false)
    SetActive(self.canGetObj, false)
    SetActive(self.newObj, false)
    SetActive(self.confirmCreateBtn.gameObject, false)
    if self.data.IsSelf == true then
        SetActive(self.canUpgrede, self.data.CanUpgrade == true)
        SetActive(self.confirmCreateBtn.gameObject, false)
        SetActive(self.canCreateObj.gameObject, false)
        self:RefreshRedPointTips()
    end
end

function SSYXBuildSceneItem:RefreshRedPointTips()
    local redPointNum = 0
    local isReward = true
    if self.data.ID == SSYXConst.BuildID.JieDao then
        redPointNum = SSYXData.CheckRewardRedPoint()
    elseif self.data.ID == SSYXConst.BuildID.ShangCheng then
        redPointNum = SSYXData.CheckShopRedPoint()
    elseif self.data.ID == SSYXConst.BuildID.YinHang then
        redPointNum = SSYXData.CheckBankRedPoint()
    elseif self.data.ID == SSYXConst.BuildID.WenXunChu then
        isReward = false
        redPointNum = SSYXData.CheckTechRedPoint()
    elseif self.data.SceneIndex == 2 then
        redPointNum = SSYXData.CheckProduceSingleBuildRedPoint(self.data)
    end
    if self.canGetObj ~= nil and isReward == true then
        SetActive(self.canUpgrede, false)
        SetActive(self.canGetObj, redPointNum > 0)
    elseif self.newObj ~= nil and isReward == false then
        SetActive(self.newObj, redPointNum > 0)
    end
    self.redPointNum = redPointNum
    self.isRewardTips = isReward
end

function SSYXBuildSceneItem:OnCreateBuild()
end

function SSYXBuildSceneItem:GetPosX()
    return self.rectTrans.anchoredPosition.x
end

function SSYXBuildSceneItem:GetWorldPos()
    return self.gameObject.transform.position
end

function SSYXBuildSceneItem:ClearItems()
end

function SSYXBuildSceneItem:Clear()
    self:ClearItems()
end

function SSYXBuildSceneItem:Destroy()
    self.gameObject = nil
    self.data = nil
    LuaMgr.RemoveUIEventListener(UIEventConst.SSYXCreateBuildNotify, self.OnCreateBuildNotify)
end