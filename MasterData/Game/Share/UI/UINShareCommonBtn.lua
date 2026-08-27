local base = UIBaseNode
local UINShareCommonBtn = class("UINShareCommonBtn", base)

function UINShareCommonBtn:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self._OnClickRoot)
end

function UINShareCommonBtn:InitShareCommonBtn(shareFunc, shareId)
  self._shareFunc = shareFunc
  TimerManager:StopTimer(self._hideTipsTimer)
  self.ui.shareTip:SetActive(false)
  if shareId == nil or not ControllerManager:GetController(ControllerTypeId.Share, true):CanGetShareReward(shareId) then
    return
  end
  local shareCfg = ConfigData.share[shareId]
  if shareCfg == nil then
    error("Cant get shareCfg, id:" .. tostring(shareId))
    return
  end
  for itemId, itemNum in pairs(shareCfg.reward) do
    local itemCfg = ConfigData.item[itemId]
    self.ui.img_ItemIcon.sprite = CRH:GetSprite(itemCfg.icon)
    self.ui.tex_ItemNum.text = tostring(itemNum)
    self.ui.shareTip:SetActive(true)
    self._hideTipsTimer = TimerManager:StartTimer(self.ui.hideTipsTime, function()
      if IsNull(self.transform) then
        return
      end
      self.ui.shareTip:SetActive(false)
    end)
    break
  end
end

function UINShareCommonBtn:_OnClickRoot()
  if self._shareFunc ~= nil then
    self._shareFunc()
  end
end

function UINShareCommonBtn:OnDelete()
  TimerManager:StopTimer(self._hideTipsTimer)
  base.OnDelete(self)
end

return UINShareCommonBtn
