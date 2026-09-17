local this = class("cellHomeLevelInfo", G_UIModuleBase)
local _homeLevelShowTpl = L_GameTpl:getHomeLevelShowTpl()

function this.bind()
  return {
    alpha_Value = 1,
    txt_level = nil,
    list_content = {
      moduleName = "pages/home/homeLevel/cellHomeLevelInfoItem"
    },
    go_curLevelBg = false,
    go_curLevel = false,
    color_bg = nil,
    go_lock = false,
    raycast_lock = true,
    rect_SelectScale_1 = L_Vector3.one,
    rect_SelectScale_2 = L_Vector3.one
  }
end

function this.methods()
  return {
    list_content = {
      onClick_select = function(self, bind, pos)
        self._selectIndex = bind.index
        self:emit("onClick_select", bind, pos)
      end
    }
  }
end

function this:open()
  this.super.open(self)
  self:initCell()
end

function this:initCell()
  if not self.isBind then
    return
  end
  L_ReddotManager:registerReddot(self.bindComponents.rect_reddotNormal, string.format(L_ReddotManager.DotDef.LevelUnlockHomeContent, self.bind.level))
  self.isPlayUnLockAnim = C_PlayerPrefsUtility.GetBool(L_PlayerStore:getPlayerId() .. self.bind.level, false)
  local isLock = self.bind.level > L_PlayerStore:getLv()
  if not self.isPlayUnLockAnim and not isLock and self.bind.level ~= self.bind.curLevel then
    C_PlayerPrefsUtility.SetBool(L_PlayerStore:getPlayerId() .. self.bind.level, true)
    self.isPlayUnLockAnim = true
  end
  local tpl = _homeLevelShowTpl:getTplById(self.bind.level)
  local tmp = _homeLevelShowTpl:getAllUnlockContent(tpl)
  for _, v in pairs(tmp) do
    v.isFatherLock = isLock
    v.isPlayUnLockAnim = self.isPlayUnLockAnim
  end
  local itemCount = #tmp
  local columnsPerRow = 10
  local rows = math.ceil(itemCount / columnsPerRow)
  local rowHeight = 165
  local paddingVertical = 0
  local height = rows * rowHeight + paddingVertical + 30
  local contentRect = self.bindComponents.viewport
  contentRect.sizeDelta = C_Vector2(contentRect.sizeDelta.x, height)
  self.bind.list_content:freshAll(tmp)
  self.bind.txt_level = tostring(self.bind.level)
  local isCurLevel = self.bind.level == self.bind.curLevel and self.isPlayUnLockAnim
  self.bind.go_curLevel = isCurLevel
  self.bind.go_curLevelBg = isCurLevel
  if isLock or not self.isPlayUnLockAnim then
    self.bind.go_lock = true
    self.aniState = self.bindComponents.ani_cellHomeLevelInfo:CrossFadeQueued("anim_homeLeve_cell_unlock")
    self.bindComponents.ani_cellHomeLevelInfo:Play("anim_homeLeve_cell_unlock")
    self.aniState.time = 0
    self.bindComponents.ani_cellHomeLevelInfo:Sample()
    self.bindComponents.ani_cellHomeLevelInfo:Stop()
  else
    self.bind.go_lock = false
  end
  if not self.isPlayUnLockAnim and not isLock then
    self:playUnlockAnim()
  end
  self.bind.raycast_lock = isLock
  self:ShowCellInAnim()
  self.bind.color_bg = isLock and C_Color(0.4150943, 0.4150943, 0.4150943, 1) or C_Color.white
end

function this:playUnlockAnim()
  local isLock = self.bind.level > L_PlayerStore:getLv()
  self.bind.raycast_lock = isLock
  self.bind.go_lock = not isLock
  self.bindComponents.ani_cellHomeLevelInfo:Play("anim_homeLeve_cell_unlock")
  C_PlayerPrefsUtility.SetBool(L_PlayerStore:getPlayerId() .. self.bind.level, true)
end

function this:ShowCellInAnim()
  if self.bind.isPlayCurLevelUnLockAnim then
    if C_Time.time >= self.bind.basePlayTime then
      self.bind.isPlayCellAnim = true
    end
    self.bind.alpha_Value = not self.bind.isPlayCellAnim and 0 or 1
    if not self.bind.isPlayCellAnim then
      L_TimerManager:newOrResetTimer(self, "ani_cellHomeLevelInfo", function()
        self.bind.alpha_Value = 1
        self.bindComponents.ani_cellHomeLevelInfo:Play("anim_homeLeve_cell_In")
        self.bind.isPlayCellAnim = true
      end, self.bind.basePlayTime - C_Time.time)
    end
  end
end

function this:clearSelect()
  if not self.isBind then
    return
  end
  for i, v in pairs(self.modules.list_content) do
    v:setSelect(false)
  end
end

function this:selectItem(type, id)
  if not self.isBind then
    return
  end
  local list = self.modules.list_content
  for i, v in pairs(list) do
    if v.bind.type == type and v.bind.id == id then
      v:onClickSelect()
    end
  end
end

return this
