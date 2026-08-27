local base = UIBaseNode
local UINSGChapterMapDownNode = class("UINSGChapterMapDownNode", base)
local eActInteract = require("Game.ActivityLobby.Activity.2023SteinsGate.eActInteract")
local cs_MessageCommon = CS.MessageCommon

function UINSGChapterMapDownNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Repeat, self, self.__OnClickRepeat)
  UIUtil.AddButtonListener(self.ui.btn_DiffChange, self, self.__OnClickSwitchDiff)
  UIUtil.AddButtonListener(self.ui.btn_Jump, self, self.__OnClickJump)
  self.lightPool = UIItemPool.New(UIBaseNode, self.ui.obj_LigthItem, false)
end

function UINSGChapterMapDownNode:InitSGChapterMapDownNode(MapWin)
  self.MapWin = MapWin
  self:__RefreshIsSGRepeatUnlock()
  self:__RefreshDiffName()
end

function UINSGChapterMapDownNode:RefreshWorldLine(num)
  local numStr = tostring(num)
  self.lightPool:HideAll()
  for i = 1, string.len(numStr) do
    local c = string.sub(numStr, i, i)
    local item = self.lightPool:GetOne().gameObject:GetComponent(typeof(CS.UiImageItemInfo))
    if c == "." then
      item:SetIndex(10)
    elseif c == "-" then
      item:SetIndex(10)
    else
      local c_num = tonumber(c)
      if c_num == nil then
        error("illegal num input")
      end
      item:SetIndex(c_num)
    end
  end
end

function UINSGChapterMapDownNode:__RefreshIsSGRepeatUnlock()
  local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  local isUnlock = ctrl.actLbIntrctCtrl:GetActLbEntityIsUnlock(eActInteract.eLbIntrctEntityId.RepeatDg)
  self.ui.obj_RepeatLock:SetActive(not isUnlock)
end

function UINSGChapterMapDownNode:__RefreshDiffName()
  local diff = self.MapWin.sgStoryData:Act23Gs_GetDiffIndex()
  local diffList = self.MapWin.sgStoryData:Act23Gs_GetDiffList()
  local diffCfg
  for _, theDiffCfg in ipairs(diffList) do
    if theDiffCfg.difficulty_id == diff then
      diffCfg = theDiffCfg
    end
  end
  if diffCfg == nil then
    error("diffCfg is nil")
    return
  end
  self.ui.tex_DiffName.text = LanguageUtil.GetLocaleText(diffCfg.difficulty_name)
end

function UINSGChapterMapDownNode:__OnClickRepeat()
  local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  local isUnlock = ctrl.actLbIntrctCtrl:GetActLbEntityIsUnlock(eActInteract.eLbIntrctEntityId.RepeatDg)
  if not isUnlock then
    local tipFunc = eActInteract.eActIntrctActionLockClickTipFunc[eActInteract.eLbIntrctEntityId.RepeatDg]
    if tipFunc ~= nil then
      local tip = tipFunc()
      cs_MessageCommon.ShowMessageTips(tip)
    end
    return
  end
  self.MapWin:__CloseDetail()
  local func = ctrl.actLbIntrctCtrl:GetActLbIntrctActionFunc(eActInteract.eLbIntrctActionId.RepeatDg)
  if func ~= nil then
    func(nil, {isAsSub = true})
  end
end

function UINSGChapterMapDownNode:__OnClickSwitchDiff(callback)
  local diff = self.MapWin.sgStoryData:Act23Gs_GetDiffIndex()
  local diffList = self.MapWin.sgStoryData:Act23Gs_GetDiffList()
  UIManager:ShowWindowAsync(UIWindowTypeID.UISteinsGateDiffSelect, function(win)
    if win == nil then
      return
    end
    self.MapWin.sgStoryData:Act23Gs_SetIsNeedFirstSelectDiff()
    win:InitSteinsGateDiffSelect(diff, diffList, function(diffIndex)
      self.MapWin.sgStoryData:Act23Gs_SetDiffIndex(diffIndex)
      self.MapWin:__RefreshDiffDeco()
      self.MapWin:__RefreshDiffNodeChange()
      self.MapWin:RefreshWinTween()
      if callback ~= nil then
        callback()
      elseif self.MapWin.__seletedNodeId == nil then
        self.MapWin:__FocusFarrestCouldBattleNode(0.5)
      end
      self:__RefreshDiffName()
    end)
  end)
end

function UINSGChapterMapDownNode:__OnClickJump()
  if self.MapWin ~= nil and self.MapWin.curNodeData ~= nil then
    local nodeId = self.MapWin.curNodeData:Act23GSSN_GetNodeID()
    self.MapWin:__SelectNode(nodeId)
  end
end

function UINSGChapterMapDownNode:OpenAndForceSelectDiff(callback)
  self:__OnClickSwitchDiff(callback)
end

function UINSGChapterMapDownNode:OnDelete()
  base.OnDelete(self)
end

return UINSGChapterMapDownNode
