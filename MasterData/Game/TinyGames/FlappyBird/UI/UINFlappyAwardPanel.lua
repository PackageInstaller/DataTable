local UINFlappyAwardPanel = class("UINFlappyAwardPanel", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINFlappyAwardPanel:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.awardPool = UIItemPool.New(UINBaseItemWithCount, self.ui.obj_award)
end

function UINFlappyAwardPanel:ShowAwardList(awardList, fbConfig, titleIndex)
  if fbConfig ~= nil then
    self.ui.text_title:SetIndex(titleIndex, tostring(fbConfig.join_rewards_score))
  else
    self.ui.text_title:SetIndex(titleIndex)
  end
  self.awardPool:HideAll()
  if awardList == nil or #awardList <= 0 then
    return
  end
  for _, v in ipairs(awardList) do
    local awardItem = self.awardPool:GetOne()
    local itemCfg = ConfigData.item[v.itemId]
    awardItem:InitItemWithCount(itemCfg, v.count, function()
      UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
        if win ~= nil then
          win:SetNotNeedAnyJump(true)
          win:InitCommonItemDetail(itemCfg)
        end
      end)
    end)
  end
end

function UINFlappyAwardPanel:UpdatePosAndTips(progress, percent, totalWidth)
  local pos = self.ui.rectTrans.anchoredPosition
  pos.x = totalWidth * percent / 100
  self.ui.rectTrans.anchoredPosition = pos
  self.ui.tex_Rate:SetIndex(0, tostring(percent))
  if percent <= progress // 100 then
    self.ui.obj_isPicked:SetActive(true)
  end
end

function UINFlappyAwardPanel:OnDelete()
  base.OnDelete(self)
end

return UINFlappyAwardPanel
