local _SetWidth = CS.Framework.TransformUtil.SetWidth
local _SetHeight = CS.Framework.TransformUtil.SetHeight
local _SetLocalPos = CS.Framework.TransformUtil.SetLocalPos
local MonsterIconBase = NewClass("MonsterIconBase")

function MonsterIconBase:ctor(container)
  self.gameObject = container.gameObject
  self.data = nil
  self.binder = nil
end

function MonsterIconBase:GetData()
  return self.data
end

function MonsterIconBase:SetProxy(proxy)
  self.proxy = proxy
end

function MonsterIconBase:SetData(data)
  self.data = data
end

function MonsterIconBase:SetView(view)
  self.view = view
end

function MonsterIconBase:Dispose()
  if self.binder then
    self.binder:teardown()
    self.binder = nil
  end
end

function MonsterIconBase:SetBinder(binder)
  if self.parentBinder ~= binder and self.binder then
    self.binder:teardown()
    self.binder = nil
  end
  self.parentBinder = binder
  if not self.binder then
    self.binder = binder:createChild()
    binder:onDestroy(function()
      self.binder = nil
    end)
    self.binder:UpdateLocalizedTextAndResouce(self.ui.uiNode)
  end
  self.binder:clearChildren()
end

function MonsterIconBase:OnActive()
  self:Refresh()
end

function MonsterIconBase:OnDeative()
  if self.binder then
    self.binder:teardown()
    self.binder = nil
  end
end

function MonsterIconBase:Refresh()
  self:AddButtonClickListener()
  self:RefreshIcon()
  self:RefreshLevel()
  self:RefreshMonsterType()
  self:RefreshChooseStatus()
end

function MonsterIconBase:AddButtonClickListener()
  self.view:AddButtonClickListener(self.ui.Btn_Click, System.fn(self, self.OnClick))
end

function MonsterIconBase:RefreshIcon()
  local monsterIconPath = self:_GetMonsterIconPath()
  self.view:SetImage(self.ui.Image_Monster, monsterIconPath)
end

function MonsterIconBase:_GetMonsterIconPath()
  if not self.data then
    return
  end
  local monsterTid = self.data.tid
  if not self:_CheckValueValid(monsterTid) then
    return
  end
  local monsterCfg = CopyDataUtils.GetMonsterConfig(monsterTid) or {}
  return monsterCfg.MiniIcon
end

function MonsterIconBase:RefreshLevel()
  local monsterLvStr = self:_GetMonsterLevelStr()
  self.view:SetText(self.ui.Text_Level, monsterLvStr)
end

function MonsterIconBase:_GetMonsterLevelStr()
  if not self.data then
    return
  end
  local stageTid = self.data.stageId
  local monsterTid = self.data.tid
  if not self:_CheckValueValid(stageTid) or not self:_CheckValueValid(monsterTid) then
    return
  end
  local monsterLevel = CopyDataUtils.GetMonsterLevel(stageTid, monsterTid)
  return "Lv." .. monsterLevel
end

function MonsterIconBase:RefreshMonsterType()
  local monsterTypeStr = self:_GetMonsterTypeStr()
  self.view:SetText(self.ui.Text_TypeName, monsterTypeStr)
  local isShowMonsterTypeName = self:_IsShowMonsterTypeName()
  self.ui.Image_Boss:SetActive(isShowMonsterTypeName)
end

function MonsterIconBase:_GetMonsterTypeStr()
  if not self.data then
    return
  end
  local monsterTid = self.data.tid
  if not self:_CheckValueValid(monsterTid) then
    return
  end
  if not CopyDataUtils.HasMonsterTypeName(monsterTid) then
    return ""
  end
  do return CopyDataUtils.GetMonsterTypeName end
  return CopyDataUtils.GetMonsterTypeName, monsterTid, monsterTid
end

function MonsterIconBase:_IsShowMonsterTypeName()
  if not self.data then
    return
  end
  local monsterTid = self.data.tid
  if not self:_CheckValueValid(monsterTid) then
    return
  end
  local show = CopyDataUtils.HasMonsterTypeName(monsterTid)
  return show
end

function MonsterIconBase:RefreshChooseStatus()
  local isChoosed = false
  if self.data.isChoosed then
    isChoosed = self.data.isChoosed(self.data.tid)
  end
  self:_SetChoosed(isChoosed)
end

function MonsterIconBase:_SetChoosed(isChoosed)
  self.ui.Image_Select:SetActive(isChoosed)
end

function MonsterIconBase:_CheckValueValid(val)
  if type(val) == "number" then
    return val and val > 0
  end
  if type(val) == "string" then
    return val and "" ~= val
  end
end

function MonsterIconBase:OnClick()
  if not self.data.onClick then
    return
  end
  self.data.onClick(self.data.tid)
end

return MonsterIconBase
