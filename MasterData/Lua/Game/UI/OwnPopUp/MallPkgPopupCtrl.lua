local MallPkgPopupCtrl = class("MallPkgPopupCtrl", BaseCtrl)
local JumpUtil = require("Game.Common.Utils.JumpUtil")
local ClientManager = CS.ClientManager.Instance
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
MallPkgPopupCtrl._mapNodeConfig = {
  goContent = {
    sNodeName = "---Common---"
  },
  nameRoot = {sNodeName = "--Name--", sComponentName = "Transform"},
  btnGo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Goto"
  },
  txtBtnGo = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_PopUp_Goto_1"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnCloseBg = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txtDate = {sComponentName = "TMP_Text"},
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mall_Package_PopupTitle"
  },
  ClickScreenToContinue = {
    sComponentName = "TMP_Text",
    sLanguageId = "Tips_Continue"
  }
}
MallPkgPopupCtrl._mapEventConfig = {}

function MallPkgPopupCtrl:ShowPopUp(id, callback, index)
  self.popUpIndex = index
  self.nCurId = id
  self.callback = callback
  self.mapCfg = ConfigTable.GetData("PopUp", self.nCurId)
  self.nOpenTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(self.mapCfg.StartTime)
  if self.mapCfg.EndType == GameEnum.PopUpEndType.Date then
    self.nEndTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(self.mapCfg.EndTime)
  elseif self.mapCfg.EndType == GameEnum.activityEndType.TimeLimit then
    self.nEndTime = self.nOpenTime + self.mapCfg.EndDuration * 86400
  end
  self:RefreshDate()
  self.anim = self.gameObject:GetComponent("Animator")
  self:PlayOpenAnim()
end

function MallPkgPopupCtrl:PlayOpenAnim()
  self:RefreshName()
  if self.anim then
    self.anim:Play("open", 0, 0)
  end
end

function MallPkgPopupCtrl:RefreshDate()
  local nOpenMonth = tonumber(os.date("%m", self.nOpenTime))
  local nOpenDay = tonumber(os.date("%d", self.nOpenTime))
  local nEndMonth = tonumber(os.date("%m", self.nEndTime))
  local nEndDay = tonumber(os.date("%d", self.nEndTime))
  local strOpenDay = string.format("%d", nOpenDay)
  local strEndDay = string.format("%d", nEndDay)
  local dateStr = string.format("%s/%s ~ %s/%s", nOpenMonth, strOpenDay, nEndMonth, strEndDay)
  NovaAPI.SetTMPText(self._mapNode.txtDate, dateStr)
end

function MallPkgPopupCtrl:RefreshName()
  local tbParams = decodeJson(self.mapCfg.ScriptParams)
  local nCount = #tbParams
  for i = 1, nCount do
    local mapCfg = ConfigTable.GetData("MallPackage", tbParams[i])
    if mapCfg then
      local sName = mapCfg.SimpleName
      local goRoot = self._mapNode.nameRoot:Find("goName" .. i)
      if goRoot then
        local goCal = self._mapNode.nameRoot:Find("goName" .. i .. "/txtCalNameWidth")
        local txtCal = goCal:GetComponent("TMP_Text")
        local rtCal = goCal:GetComponent("RectTransform")
        local goName1 = self._mapNode.nameRoot:Find("goName" .. i .. "/Mask/txtName1")
        local txtName1 = goName1:GetComponent("TMP_Text")
        local goName2 = self._mapNode.nameRoot:Find("goName" .. i .. "/Mask/txtName2")
        local txtName2 = goName2:GetComponent("TMP_Text")
        local rtName2 = goName2:GetComponent("RectTransform")
        local rtMask = self._mapNode.nameRoot:Find("goName" .. i .. "/Mask"):GetComponent("RectTransform")
        NovaAPI.SetTMPText(txtName1, sName)
        NovaAPI.SetTMPText(txtName2, sName)
        NovaAPI.SetTMPText(txtCal, sName)
        LayoutRebuilder.ForceRebuildLayoutImmediate(rtCal)
        local nWidth = rtCal.rect.width
        local nMaxWidth = rtMask.rect.width
        rtName2.anchoredPosition = Vector2(0, 0)
        goName1.gameObject:SetActive(nWidth <= nMaxWidth)
        goName2.gameObject:SetActive(nWidth > nMaxWidth)
        if nWidth > nMaxWidth then
          do
            local nPosX = 0
            self:AddTimer(0, 0.034, function()
              nPosX = nPosX - 1
              if nPosX < -nWidth then
                nPosX = nMaxWidth
              end
              rtName2.anchoredPosition = Vector2(nPosX, 0)
            end, true, true)
          end
        end
      end
    end
  end
end

function MallPkgPopupCtrl:ClosePopUp(callback)
  if self.anim ~= nil then
    self.anim:Play("close", 0, 0)
    self:AddTimer(1, 0.1, function()
      if callback ~= nil then
        callback()
      end
    end, true, true, true)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.1)
  elseif callback ~= nil then
    callback()
  end
end

function MallPkgPopupCtrl:OnBtnClick_Close()
  self:ClosePopUp(self.callback)
end

function MallPkgPopupCtrl:OnBtnClick_Goto()
  local function callback()
    if nil ~= self.nCurId then
      PopUpManager.InterruptPopUp(self.popUpIndex)
      
      local endTime = self.nEndTime
      local curTime = ClientManager.serverTimeStamp
      local remainTime = endTime - curTime
      if remainTime <= 0 then
        EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Mall_Package_Expired"))
        if self.callback ~= nil then
          self.callback()
        end
        return
      end
      EventManager.Hit(EventId.ClosePanel, PanelId.ActivityPopUp)
      JumpUtil.JumpTo(self.mapCfg.JumpToParams)
    end
  end
  
  self:ClosePopUp(callback)
end

return MallPkgPopupCtrl
