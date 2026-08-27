local UINAvgChoose = class("UINAvgChoose", UIBaseNode)
local base = UIBaseNode
local UINAvgChooseItem = require("Game.Avg.UI.UINAvgChooseItem")
local fadeTweenId = "Fade"

function UINAvgChoose:ctor(avgSystem)
  self.avgSystem = avgSystem
end

function UINAvgChoose:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__onClickChooseItem = BindCallback(self, self.OnClickChooseItem)
  self.ui.chooseItem:SetActive(false)
  self.chooseItemPool = UIItemPool.New(UINAvgChooseItem, self.ui.chooseItem)
  self.ui.tween_Fade.onRewind:AddListener(BindCallback(self, self.__OnFadeTweenRewind))
end

function UINAvgChoose:ShowAvgChoose(branchCfg)
  if branchCfg == nil then
    return
  end
  self.branchCfg = branchCfg
  self:Show()
  self.ui.choose_Canvas.interactable = true
  self.__isFadeTweenRewind = false
  self.ui.tween_Fade:DORestartAllById(fadeTweenId)
  self.chooseItemPool:HideAll()
  for index, v in ipairs(branchCfg) do
    local chooseItem = self.chooseItemPool:GetOne()
    local content = self.avgSystem.avgCtrl:GetAvgLanguage(v.content)
    local couldNotSelect = false
    if branchCfg.disableSelected and v.jumpAct ~= nil then
      couldNotSelect = self.avgSystem.avgCtrl:GetIsBranchSelected(self.avgSystem.avgCtrl.curActId, index)
    end
    chooseItem:InitAvgChooseItem(index, content, self.__onClickChooseItem, couldNotSelect)
  end
end

function UINAvgChoose:OnClickChooseItem(index)
  local cfg = self.branchCfg[index]
  if cfg == nil then
    self.avgSystem.avgCtrl:AvgLogError("Can't find branchCfg, index = " .. tostring(index))
    return
  end
  self.avgSystem:BranchChooseComplete(index, cfg.jumpAct, cfg.jumpChapter)
end

function UINAvgChoose:HideAvgChoose()
  if not self.active or self.__isFadeTweenRewind then
    return
  end
  self.ui.choose_Canvas.interactable = false
  self.__isFadeTweenRewind = true
  self.ui.tween_Fade:DOPlayBackwardsAllById(fadeTweenId)
end

function UINAvgChoose:ShowAvgUI(show)
  self.ui.canvasGroup.alpha = show and 1 or 0
  self.ui.canvasGroup.interactable = show
end

function UINAvgChoose:__OnFadeTweenRewind()
  if self.__isFadeTweenRewind then
    self:Hide()
  end
  self.__isFadeTweenRewind = false
end

function UINAvgChoose:OnDelete()
  base.OnDelete(self)
end

return UINAvgChoose
