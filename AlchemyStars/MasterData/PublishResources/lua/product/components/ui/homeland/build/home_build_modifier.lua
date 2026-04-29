_class("HomeBuildModifier", Object)
HomeBuildModifier = HomeBuildModifier

function HomeBuildModifier:Constructor(building)
  self._building = building
  self._buildingParent = building.Parent
  self._insID = building:InsID()
  self._originPos = self._building:Pos()
  self._originRotY = self._building:RotY()
  self._originSkin = self._building:SkinID()
  self._type = HomeBuildEditType.None
  self._isEnd = false
  self._pickUpOffset = Vector3(0, 0, 0)
  self._legal = nil
  self._illegalType = nil
  self._replacedBuilding = nil
end

function HomeBuildModifier:InsID()
  return self._insID
end

function HomeBuildModifier:Building()
  return self._building
end

function HomeBuildModifier:Type()
  return self._type
end

function HomeBuildModifier:Start(legal, illegalType)
  if self._isEnd then
    BuildError("操作结束，不能开始")
    return
  end
  self._isEnd = false
  self._building:ShowOutline()
  self:SetLegal(legal, illegalType)
  self._originLegal = legal
  self._pickUpOffset.y = 0.0
  self._building:SetPos(self._building:Pos() + self._pickUpOffset)
  self._building:ShowArea(true, legal)
end

function HomeBuildModifier:StartChangeSkin()
  if self._isEnd then
    BuildError("操作结束，不能开始")
    return
  end
  self._isEnd = false
  self._originLegal = true
  self._legal = true
end

function HomeBuildModifier:Move(target)
  if self._isEnd then
    BuildError("操作结束，不能移动")
    return
  end
  self._type = self._type | HomeBuildEditType.Move
  self._building:SetPos(target)
end

function HomeBuildModifier:Rotate(y)
  if self._isEnd then
    BuildError("操作结束，不能旋转")
    return
  end
  self._type = self._type | HomeBuildEditType.Rotate
  self._building:SetRotY(y)
end

function HomeBuildModifier:Add()
  if self._isEnd then
    BuildError("操作结束，不能添加")
    return
  end
  self._type = self._type | HomeBuildEditType.Add
end

function HomeBuildModifier:FixedAdd(replacedBuilding)
  self:Add()
  self._replacedBuilding = replacedBuilding
end

function HomeBuildModifier:Delete()
  if self._isEnd then
    BuildError("操作结束，不能删除")
    return
  end
  if self._type & HomeBuildEditType.Add > 0 then
    BuildError("新增的建筑不能收纳，只能取消")
  end
  self._type = self._type | HomeBuildEditType.Delete
  self._building:Delete()
end

function HomeBuildModifier:ChangeSkin(skinID)
  if self._isEnd then
    BuildError("操作结束，不能换肤")
    return
  end
  self._type = self._type | HomeBuildEditType.ChangeSkin
  self._building:ChangeSkin(skinID)
end

function HomeBuildModifier:DropDown()
  if self._replacedBuilding ~= nil then
    local homelandClient = self._replacedBuilding:GetHomelandClient()
    local buildManager = homelandClient:BuildManager()
    local pstid = self._replacedBuilding:GetArchitecture().pstid
    if buildManager:GetArchitecture(pstid) == nil then
      buildManager:RemoveBuilding(self._replacedBuilding)
      self._replacedBuilding:Dispose()
    end
    self._replacedBuilding = nil
  end
end

function HomeBuildModifier:Finish()
  if self._isEnd then
    BuildError("操作结束，不能完成")
    return
  end
  self._isEnd = true
  BuildLog("操作结束:", self._insID)
  self._building:SetPos(self._building:Pos() - self._pickUpOffset)
  self._pickUpOffset.y = 0
  self._building:ShowArea(false)
  self._building:HideOutline()
end

function HomeBuildModifier:FinishChangeSkin()
  if self._isEnd then
    BuildError("操作结束，不能完成")
    return
  end
  self._isEnd = true
  BuildLog("换肤结束:", self._insID)
end

function HomeBuildModifier:Revert()
  if self._type == HomeBuildEditType.None then
    return
  end
  if self._buildingParent ~= nil then
    self._buildingParent:AddChild(self._building)
  end
  if self._type & HomeBuildEditType.Add > 0 then
    if self._replacedBuilding ~= nil then
      local parent = self._replacedBuilding.Parent
      parent:AddChild(self._replacedBuilding)
      self._replacedBuilding:ShowBuilding(true)
      self._replacedBuilding = nil
    end
    self._building:Dispose()
    return
  end
  if 0 < self._type & HomeBuildEditType.Delete then
    self._building:ShowBuilding(true)
  end
  if 0 < self._type & HomeBuildEditType.Move then
    self._building:SetPos(self._originPos)
  end
  if 0 < self._type & HomeBuildEditType.Rotate then
    self._building:SetRotY(self._originRotY)
  end
  if 0 < self._type & HomeBuildEditType.ChangeSkin then
    self._building:RevertSkin(self._originSkin)
  end
end

function HomeBuildModifier:SetLegal(legal, illegalType)
  self._illegalType = illegalType
  if self._legal == legal then
    return
  end
  self._legal = legal
  if self._legal then
    self._building:SetOutlineColor(Color(0.23921568627450981, 0.5882352941176471, 1.0, 1))
  else
    self._building:SetOutlineColor(Color(1.0, 0 / 255, 0 / 255, 1))
  end
end

function HomeBuildModifier:GetIllegalType()
  return self._illegalType
end

function HomeBuildModifier:IsLegal()
  return self._legal
end

function HomeBuildModifier:IsOriginLegal()
  return self._originLegal
end

function HomeBuildModifier:SetAdsorb(adsorb)
  self._adsorb = adsorb
end

function HomeBuildModifier:IsAdsorb()
  return self._adsorb
end
