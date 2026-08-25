local CompPublicMonsterIconItem, Super = NewViewComponent("CompPublicMonsterIconItem")

function CompPublicMonsterIconItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dungeons_Item_Award_CreationResource(uiNode)
  self.data = data
end

function CompPublicMonsterIconItem:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Click, System.fn(self, self._OnClick))
end

function CompPublicMonsterIconItem:OnEnterComponent()
  self:RefreshUI()
end

function CompPublicMonsterIconItem:RefreshUI()
  local monsterLvStr = self:_GetMonsterLevelStr()
  self:SetText(self.ui.Text_Level, monsterLvStr)
  local monsterTypeStr = self:_GetMonsterTypeStr()
  self:SetText(self.ui.Text_TypeName, monsterTypeStr)
  local monsterIconPath = self:_GetMonsterIconPath()
  self:SetImage(self.ui.Image_Monster, monsterIconPath)
  local isShowMonsterTypeName = self:_IsShowMonsterTypeName()
  self.ui.Image_Boss:SetActive(isShowMonsterTypeName)
end

function CompPublicMonsterIconItem:_GetMonsterLevelStr()
  if not self.data then
    return
  end
  local stageTid = self.data.stageId
  local monsterTid = self.data.monsterTid
  if not self:_CheckValueValid(stageTid) or not self:_CheckValueValid(monsterTid) then
    return
  end
  local monsterLevel = CopyDataUtils.GetMonsterLevel(stageTid, monsterTid)
  return "Lv." .. monsterLevel
end

function CompPublicMonsterIconItem:_GetMonsterIconPath()
  if not self.data then
    return
  end
  local monsterTid = self.data.monsterTid
  if not self:_CheckValueValid(monsterTid) then
    return
  end
  local monsterCfg = CopyDataUtils.GetMonsterConfig(monsterTid) or {}
  return monsterCfg.MiniIcon
end

function CompPublicMonsterIconItem:_GetMonsterTypeStr()
  if not self.data then
    return
  end
  local monsterTid = self.data.monsterTid
  if not self:_CheckValueValid(monsterTid) then
    return
  end
  if not CopyDataUtils.HasMonsterTypeName(monsterTid) then
    return ""
  end
  do return CopyDataUtils.GetMonsterTypeName end
  return CopyDataUtils.GetMonsterTypeName, monsterTid, monsterTid
end

function CompPublicMonsterIconItem:_IsShowMonsterTypeName()
  if not self.data then
    return
  end
  local monsterTid = self.data.monsterTid
  if not self:_CheckValueValid(monsterTid) then
    return
  end
  do return CopyDataUtils.HasMonsterTypeName end
  return CopyDataUtils.HasMonsterTypeName, monsterTid, monsterTid
end

function CompPublicMonsterIconItem:_OnClick()
  if self.data and self.data.onClickFunc then
    self.data.onClickFunc()
  end
end

function CompPublicMonsterIconItem:_CheckValueValid(val)
  if type(val) == "number" then
    return val and val > 0
  end
  if type(val) == "string" then
    return val and "" ~= val
  end
end

function CompPublicMonsterIconItem:OnExitComponent()
  Super.OnExitComponent(self)
end

return CompPublicMonsterIconItem
