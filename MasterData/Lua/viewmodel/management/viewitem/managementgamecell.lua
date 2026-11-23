













ManagementGameCell = {}
ManagementGameCell.__index = ManagementGameCell

local objs = {
    lightIcon = {path = "Group/LightIcon", type = UITool.Image},
    darkIcon = {path = "Group/DarkIcon", type = UITool.Image},
    group = {path = "Group", type = UITool.GameObject},
}

function ManagementGameCell.New(prefab, parent, scale)

    local self = {}
    setmetatable(self, ManagementGameCell)
    self.CellSize = ManagementConst.SmallCellSize
    self:Init(prefab, parent, scale)
    self.isUnlock = true
    return self
end

function ManagementGameCell:Init(prefab, parent, scale)
    if parent == nil then
        self.gameObject = prefab
    else
        self.gameObject = LuaMgr.InstantiateGO(prefab, parent.transform, false)
    end
    UITool.Parse(self.gameObject, self, objs)
    local effectTrans = self.gameObject.transform:Find("Effect")
    self.animator = self.gameObject.transform:GetComponent(UITool.Animator)
    self.effect = effectTrans ~= nil and effectTrans.gameObject or nil

    local seletedTrans = self.gameObject.transform:Find("SelectedObj")
    self.selectedObj = seletedTrans ~= nil and seletedTrans.gameObject or nil
    self:SetSeleted(false)

    self.transform = self.gameObject.transform
    if scale ~= nil then
        self.transform.localScale = Vector3(scale, scale, scale)
    end
    self.data = nil
    self.elementID = 0
end

function ManagementGameCell:SetData(data)
    SetActive(self.effect, false)
    self:SetSeleted(false)
    self.data = data
    self.elementID = self.data.elementID
    local elementConfig = ManagementGameData.GetElementConfigByID(self.elementID)
    if elementConfig == nil then
        SetActive(self.group, false)
        return
    end
    self.lightIcon.sprite = LuaMgr.GetSprite("LouYiZhuoMing", elementConfig.icon)
    self.darkIcon.sprite = LuaMgr.GetSprite("LouYiZhuoMing", elementConfig.icon .. "_02")
    self:UpdatePos()
    self:RefreshItem()
    self:RefreshGameObjectName()
end


function ManagementGameCell:SetDataOnly(data)
    self.data = data
    self.elementID = self.data.elementID
    local elementConfig = ManagementGameData.GetElementConfigByID(self.elementID)
    if elementConfig == nil then
        SetActive(self.group, false)
        return
    end
    self.lightIcon.sprite = LuaMgr.GetSprite("LouYiZhuoMing", elementConfig.icon)
    self.darkIcon.sprite = LuaMgr.GetSprite("LouYiZhuoMing", elementConfig.icon .. "_02")
    if self.lightIcon.sprite == nil or self.darkIcon.sprite == nil then
        LuaDebug.error("ManagementGameCell:SetDataOnly找不到元素图标，elementID=" .. tostring(self.elementID))
    end
    self:RefreshItem()
end

function ManagementGameCell:SetElement(elementID, isPlayAnim)
    local func = function()
        self.data.elementID = elementID
        self.elementID = self.data.elementID
        local elementConfig = ManagementGameData.GetElementConfigByID(self.elementID)
        if elementConfig == nil then
            SetActive(self.group, false)
            return
        end
        self.lightIcon.sprite = LuaMgr.GetSprite("LouYiZhuoMing", elementConfig.icon)
        self.darkIcon.sprite = LuaMgr.GetSprite("LouYiZhuoMing", elementConfig.icon .. "_02")
        self:UpdatePos()
        self:RefreshItem()
        self:RefreshGameObjectName()
        SetActive(self.effect, false)
    end
    if isPlayAnim == true then
        SetActive(self.effect, true)
        self:SetSeleted(false)
        self.delayAnim = DOTWeen:Sequence()
        self.delayAnim:AppendInterval(ManagementConst.EliminateAniTime):OnComplete(func)
    else
        func()
    end
end

function ManagementGameCell:RefreshItem()
    if self.data == nil or self.elementID == nil or self.elementID == 0 then
        SetActive(self.group, false)
        return
    end
    SetActive(self.group, true)
    SetActive(self.lightIcon.gameObject, self.isUnlock == true)
    SetActive(self.darkIcon.gameObject, self.isUnlock ~= true)
end

function ManagementGameCell:SetIsUnlock(isUnlock)
    if self.isUnlock ~= isUnlock then
        self.isUnlock = isUnlock
        self:RefreshItem()
        if isUnlock == true then
            self.animator.enabled = true
        else
            self.animator.enabled = false
        end
    else
        self:RefreshItem()
    end
end

function ManagementGameCell:GetElementID()
    return self.elementID
end


function ManagementGameCell:SetSmallGridPos(gridPos)
    self.data.smallGridPos = gridPos
end

function ManagementGameCell:GetSmallGridPos()
    return self.data.smallGridPos
end



function ManagementGameCell:SetBigGridPos(gridPos)
    self.data.bigGridPos = gridPos
end

function ManagementGameCell:GetBigGridPos()
    return self.data.bigGridPos
end

function ManagementGameCell:UpdatePos()
    self.transform.localPosition = self:GetCurUIPos()
end

function ManagementGameCell:SetAsLastSibling()
    self.transform:SetAsLastSibling()
end

function ManagementGameCell:GetCurUIPos()
    if self.data == nil then
        return self.transform.localPosition
    end
    local smallCellSpace = ManagementConst.SmallCellSpace
    local bigCellSpace = ManagementConst.BigCellSpace
    local smallPos = self.data.smallGridPos
    local bigCellPos = self.data.bigGridPos

    local cellTotalSpaceX = smallCellSpace.Width * (smallPos.X - 1) + bigCellSpace.Width * (bigCellPos.X - 1)
    local cellTotalSpaceY = smallCellSpace.Height * (smallPos.Y - 1) + bigCellSpace.Height * (bigCellPos.Y - 1)
    local localPosX = 7 + smallPos.X * self.CellSize.Width - ManagementConst.HalfGridParentSize.Width - ManagementConst.HalfSmallCellSize.Width + cellTotalSpaceX
    local localPosY = -16 - smallPos.Y * self.CellSize.Height + ManagementConst.HalfGridParentSize.Height + ManagementConst.HalfSmallCellSize.Height - cellTotalSpaceY
    return Vector3(localPosX, localPosY, 0)
end

function ManagementGameCell:ResetPos()
    if self.tweenMove ~= nil then
        self.tweenMove:Kill(false)
    end
    local goalPos = self:GetCurUIPos()
    self.tweenMove = self.transform:DOLocalMove(goalPos, ManagementConst.SwapSuccessTime):SetEase(CS.DG.Tweening.Ease.InOutCubic)
end

function ManagementGameCell:IsEmpty()
    return self.data == nil or self.elementID == nil or self.elementID == 0
end


function ManagementGameCell:PlayAnim(isOut)
    if isOut == true then
        self.animator:Play("ani_ManagementGamePanel_GridCell_out")
    end
end

function ManagementGameCell:SetSeleted(selected)
    if self.selectedObj ~= nil then
        SetActive(self.selectedObj, selected)
        local scale = selected and 1.2 or 1
        self.gameObject.transform.localScale = Vector3(scale, scale, scale)
    end
end

function ManagementGameCell:Destroy()
    self.data = nil
    LuaMgr.DestroyGO(self.gameObject)
end

function ManagementGameCell:RefreshGameObjectName(isNew)
    if LuaMgr.IsDebug() then
        if self.data == nil then
            return
        end
        local data = self.data
        local prefix = "Cell_"
        if isNew then
            prefix = "NewCell_"
        end
        self.gameObject.name = prefix .. tostring(data.bigGridPos.X) .. "_" .. tostring(data.bigGridPos.Y) .. "_" .. tostring(data.smallGridPos.X) .. "_" .. tostring(data.smallGridPos.Y)
    end
end