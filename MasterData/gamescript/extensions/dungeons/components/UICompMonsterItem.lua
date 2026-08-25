local UICompMonsterItem, Super = NewViewComponent("UICompMonsterItem")

function UICompMonsterItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Chapter_Item_MonsterResource(uiNode)
  self.monsterTid = data.monsterTid
  self.stageTid = data.stageTid
  self.onClickFunc = data.onClickFunc
  self.isSelect = data.isSelect
end

local function _CheckValueValid(val)
  if type(val) == "number" then
    return val and val > 0
  end
  if type(val) == "string" then
    return val and "" ~= val
  end
end

function UICompMonsterItem:OnEnterComponent()
  self:RefreshComp()
end

function UICompMonsterItem:RefreshComp()
  self:AddButtonClickListener(self.ui.Btn_Click, function()
    if self.onClickFunc then
      self.onClickFunc()
    end
  end)
  self:SetText(self.ui.Text_Level, self:_GetTextLevel())
  self:SetText(self.ui.Text_TypeName, self:_GetTextTypeName())
  self:SetImage(self.ui.Image_Monster, self:_GetImageMonster())
  self.ui.Image_Boss:SetActive(CopyDataUtils.HasMonsterTypeName(self.monsterTid))
  self.ui.Image_Select:SetActive(self.isSelect)
end

function UICompMonsterItem:SetStageTid(stageTid)
  if stageTid == self.stageTid then
    return
  end
  stageTid = stageTid or 0
  self.stageTid = stageTid
  self:RefreshComp()
end

function UICompMonsterItem:SetMonsterTid(monsterTid)
  if monsterTid == self.monsterTid then
    return
  end
  monsterTid = monsterTid or 0
  self.monsterTid = monsterTid
  self:RefreshComp()
end

function UICompMonsterItem:_GetImageMonster()
  local monsterTid = self.monsterTid
  if not _CheckValueValid(monsterTid) then
    return
  end
  local monsterCfg = CopyDataUtils.GetMonsterConfig(monsterTid) or {}
  return monsterCfg.MiniIcon
end

function UICompMonsterItem:_GetTextLevel()
  local stageTid = self.stageTid
  local monsterTid = self.monsterTid
  if not _CheckValueValid(stageTid) or not _CheckValueValid(monsterTid) then
    return
  end
  local monsterLevel = CopyDataUtils.GetMonsterLevel(stageTid, monsterTid)
  return "Lv." .. monsterLevel
end

function UICompMonsterItem:_GetTextTypeName()
  local monsterTid = self.monsterTid
  if not CopyDataUtils.HasMonsterTypeName(monsterTid) then
    return ""
  end
  do return CopyDataUtils.GetMonsterTypeName end
  return CopyDataUtils.GetMonsterTypeName, monsterTid
end

return UICompMonsterItem
