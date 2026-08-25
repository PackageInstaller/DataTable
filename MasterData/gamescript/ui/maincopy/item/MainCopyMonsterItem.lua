local MainCopyMonsterItem, Super = System.NewComponent("MainCopyMonsterItem")

function MainCopyMonsterItem:ctor(uiNode, stageId, monsterTid, onClickFunc)
  Super.ctor(self)
  self.ui = UI_Chapter_Item_MonsterResource(uiNode)
  self.stageId = Vue.ref(stageId)
  self.monsterTid = Vue.ref(monsterTid)
  self.onClickFunc = onClickFunc
end

function MainCopyMonsterItem:_CheckValueValid(val)
  if type(val) == "number" then
    return val and val > 0
  end
  if type(val) == "string" then
    return val and "" ~= val
  end
end

function MainCopyMonsterItem:OnBind(binder)
  binder:onDestroy(function()
    self.onClickFunc = nil
  end)
  binder:BindButtonClick(self.ui.Btn_Click, function()
    if self.onClickFunc then
      self.onClickFunc()
    end
  end)
  binder:BindToText(self.ui.Text_Level, function()
    local stageTid = self.stageId.value
    local monsterTid = self.monsterTid.value
    if not self:_CheckValueValid(stageTid) or not self:_CheckValueValid(monsterTid) then
      return
    end
    local monsterLevel = CopyDataUtils.GetMonsterLevel(stageTid, monsterTid)
    return "Lv." .. monsterLevel
  end)
  binder:BindToText(self.ui.Text_TypeName, function()
    local monsterTid = self.monsterTid.value
    if not CopyDataUtils.HasMonsterTypeName(monsterTid) then
      return ""
    end
    do return CopyDataUtils.GetMonsterTypeName end
    return CopyDataUtils.GetMonsterTypeName, monsterTid
  end)
  binder:BindToImage(self.ui.Image_Monster, function()
    local monsterTid = self.monsterTid.value
    if not self:_CheckValueValid(monsterTid) then
      return
    end
    local monsterCfg = CopyDataUtils.GetMonsterConfig(monsterTid) or {}
    return monsterCfg.MiniIcon
  end)
  binder:BindToVisible(self.ui.Image_Boss, function()
    local monsterTid = self.monsterTid.value
    do return CopyDataUtils.HasMonsterTypeName end
    return CopyDataUtils.HasMonsterTypeName, monsterTid
  end)
end

function MainCopyMonsterItem:SetStageTid(stageTid)
  if stageTid == self.stageId.value then
    return
  end
  stageTid = stageTid or 0
  self.stageId.value = stageTid
end

function MainCopyMonsterItem:SetMonsterTid(monsterTid)
  if monsterTid == self.monsterTid.value then
    return
  end
  monsterTid = monsterTid or 0
  self.monsterTid.value = monsterTid
end

return MainCopyMonsterItem
