local base = UIBaseWindow
local UICardDiffUnlock = class("UICardDiffUnlock", base)
local cs_DoTween = CS.DG.Tweening.DOTween

function UICardDiffUnlock:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_bottom, self, self._OnClickReturn)
end

function UICardDiffUnlock:InitCardSetDiffUnlock(diffList, curDiffId, actId)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self._OnReturn):SetTopStatusVisible(false):PushTopStatusDataToBackStack()
  local indexList = {}
  local numUiList = {
    self.ui.tex_Num_Last2,
    self.ui.tex_Num_Last,
    self.ui.tex_Num_cur,
    self.ui.tex_Num_next
  }
  for index, diffId in ipairs(diffList) do
    if curDiffId == diffId then
      local last2Index = index - 2
      local lastIndex = index - 1
      local nextIndex = index + 1
      indexList = {
        last2Index,
        lastIndex,
        index,
        nextIndex
      }
    end
  end
  for i, index in ipairs(indexList) do
    if 0 < index and index <= #diffList then
      local diffId = diffList[index]
      local cfg = ConfigData.activity_card_diff[actId][diffId]
      numUiList[i].text = LanguageUtil.GetLocaleText(cfg.difficulty_name)
    else
      numUiList[i].text = ""
    end
  end
  local sequence = cs_DoTween.Sequence()
  sequence:AppendCallback(function()
    self.ui.cg_Main.alpha = 0
    self.ui.cg_unlockNode.alpha = 0
  end)
  sequence:Append(self.ui.cg_Main:DOFade(1, 1))
  sequence:Join(self.ui.ViewPort:DOLocalMoveY(315, 0.5))
  sequence:Join(self.ui.cg_unlockNode:DOFade(1, 0.5):SetDelay(0.5))
  sequence:SetLink(self.gameObject)
end

function UICardDiffUnlock:_OnClickReturn()
  UIUtil.OnClickBackByUiTab(self)
end

function UICardDiffUnlock:_OnReturn()
  self:Delete()
end

function UICardDiffUnlock:OnDelete()
  base.OnDelete(self)
end

return UICardDiffUnlock
