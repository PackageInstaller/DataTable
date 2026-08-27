local base = UIBaseWindow
local UIReinforceCardSysLvUp = class("UIReinforceCardSysLvUp", base)
local UINRfCardSysBig = require("Game.Reinforce.UI.SystemCard.UINRfCardSysBig")
local UINRfCdSysLvInfo = require("Game.Reinforce.UI.SystemCard.LvUp.UINRfCdSysLvInfo")
local ReinforceUtil = require("Game.Reinforce.Util.ReinforceUtil")

function UIReinforceCardSysLvUp:OnInit()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self._OnClickClose):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  UIUtil.SetTopStatusBtnShow(false, false)
  UIUtil.AddButtonListener(self.ui.btn_Comfirm, self, self._OnClickConfirm)
  UIUtil.AddButtonListener(self.ui.bg, self, self._OnClickBg)
  self._card = UINRfCardSysBig.New()
  self._card:Init(self.ui.uINReinforceCardBig)
  self._resloader = CS.ResLoader.Create()
  self._lvInfoPool = UIItemPool.New(UINRfCdSysLvInfo, self.ui.lvInfo, false)
  self._OnItemChangeFunc = BindCallback(self, self._OnItemChange)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
  self._OnSysCanrdChangeFunc = BindCallback(self, self._OnSysCanrdChange)
  MsgCenter:AddListener(eMsgEventId.ReinforceCardSysChange, self._OnSysCanrdChangeFunc)
  ReinforceUtil.RfCdShowTween(self.ui.canvasGroup)
  self.ui.tex_Progress.gameObject:SetActive(false)
end

function UIReinforceCardSysLvUp:InitReinforceCardSysLvUp(rfCardData, closeFunc)
  self._rfCardData = rfCardData
  self._closeFunc = closeFunc
  self._card:InitRfCardSysBig(rfCardData, self._resloader)
  self._lvInfoPool:HideAll()
  local maxStar = rfCardData:GetRfCardStarMax()
  local starCfgList = ConfigData.reinforce_card_card_star[rfCardData.dataId]
  for i = 1, maxStar do
    local starCfg = ConfigData.reinforce_card_card_star[rfCardData.dataId][i]
    if starCfg ~= nil then
      local starItem = self._lvInfoPool:GetOne()
      starItem:InitRfCdSysLvInfo(starCfg, self._rfCardData, true)
      starItem:SetRfCdRfCdSysLvInfoCardTransfrom(self._card.transform)
    end
  end
  local isCheck = self._rfCardData:GetRfCardSysNum() == nil
  self.ui.btn_Comfirm.gameObject:SetActive(not isCheck)
  if isCheck then
    self.ui.tex_Tip:SetIndex(2)
  else
    self:_UpdStar()
  end
end

function UIReinforceCardSysLvUp:_UpdStar()
  local isMaxLv = self._rfCardData:IsRfCardStarMax()
  self.ui.tex_Tip:SetIndex(isMaxLv and 1 or 0)
  self:_UpdProgress()
  local curStar = self._rfCardData:GetRfCardStar()
  for k, infoItem in ipairs(self._lvInfoPool.listItem) do
    infoItem:UpdRfCdSysLvInfo(curStar)
  end
end

function UIReinforceCardSysLvUp:_UpdProgress()
  local curNum = self._rfCardData:GetRfCardSysNumShow()
  local needNum = self._rfCardData:GetRfCdNextNeed()
  self.ui.tex_Progress:SetIndex(0, tostring(curNum), tostring(needNum))
  self.ui.tex_Progress.gameObject:SetActive(true)
  self.ui.btn_Comfirm.gameObject:SetActive(true)
  self._isCanLvUp = curNum >= needNum
  local btnColor, btnTextColor
  if self._rfCardData:IsRfCardStarMax() then
    btnColor = self.ui.confirmBtnColor[3]
    btnTextColor = self.ui.confirmTexColor[1]
    self.ui.tex_Progress.gameObject:SetActive(false)
    self.ui.btn_Comfirm.gameObject:SetActive(false)
  elseif self._isCanLvUp then
    btnColor = self.ui.confirmBtnColor[1]
    btnTextColor = self.ui.confirmTexColor[1]
  else
    btnColor = self.ui.confirmBtnColor[2]
    btnTextColor = self.ui.confirmTexColor[2]
  end
  self.ui.btn_Comfirm.targetGraphic.color = btnColor
  self.ui.tex_Comfirm.color = btnTextColor
end

function UIReinforceCardSysLvUp:_OnClickConfirm()
  if self._rfCardData:IsRfCardStarMax() then
    UIUtil.OnClickBackByUiTab(self)
    return
  end
  if not self._isCanLvUp then
    return
  end
  self._waitLvUpAnim = true
  NetworkManager:GetNetwork(NetworkTypeID.Reinforce):CS_ReinforceCard_Upgrade(self._rfCardData.dataId, function()
    self:_LvUpTween()
  end)
end

function UIReinforceCardSysLvUp:_LvUpTween()
  self.ui.tex_LvAnim.gameObject:SetActive(false)
  self.ui.mask.gameObject:SetActive(true)
  self.ui.anim:SetActive(true)
  local curStar = self._rfCardData:GetRfCardStar()
  self.ui.tex_LvAnim:SetIndex(0, tostring(curStar))
  UIUtil.AddOneCover("RfCdLvUpTween")
  CS.DG.Tweening.DOTween.Sequence():Append(self.ui.mask:DOScaleY(0, 1):From()):Join(self.ui.aniBar:DOScaleX(0, 1):From()):Join(self.ui.aniArrow:DOAnchorPosX(830, 1):SetEase(CS.DG.Tweening.Ease.OutQuad)):InsertCallback(0.5, function()
    self.ui.tex_LvAnim.gameObject:SetActive(true)
  end):Insert(0.5, self.ui.tex_LvAnim.transform:DOAnchorPosX(100, 0.5):From()):InsertCallback(1, function()
    self:_UpdStar()
    self._card:InitRfCdRoomSys()
  end):InsertCallback(1.5, function()
    self.ui.mask.gameObject:SetActive(false)
    self.ui.anim:SetActive(false)
    self._waitLvUpAnim = false
    UIUtil.CloseOneCover("RfCdLvUpTween")
  end):SetLink(self.gameObject)
end

function UIReinforceCardSysLvUp:_OnItemChange(itemUpdate)
  if itemUpdate[self._rfCardData.dataId] == nil then
    return
  end
  if self._waitLvUpAnim then
    return
  end
  self:_UpdProgress()
end

function UIReinforceCardSysLvUp:_OnSysCanrdChange()
  if self._waitLvUpAnim then
    return
  end
  self:_UpdStar()
  self._card:InitRfCdRoomSys()
end

function UIReinforceCardSysLvUp:_OnClickBg()
  UIUtil.OnClickBackByUiTab(self)
end

function UIReinforceCardSysLvUp:_OnClickClose()
  self:Delete()
  if self._closeFunc then
    self._closeFunc()
  end
end

function UIReinforceCardSysLvUp:OnDelete()
  UIUtil.CloseOneCover("RfCdLvUpTween")
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
  MsgCenter:RemoveListener(eMsgEventId.ReinforceCardSysChange, self._OnSysCanrdChangeFunc)
  self._card:Delete()
  self._lvInfoPool:DeleteAll()
  self._resloader:Put2Pool()
  self._resloader = nil
  base.OnDelete(self)
end

return UIReinforceCardSysLvUp
