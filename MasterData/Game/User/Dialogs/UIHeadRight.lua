local UIHeadRight = class("UIHeadRight", UIBaseNode)
local base = UIBaseNode
local UINUserHead = require("Game.CommonUI.Head.UINUserHead")

function UIHeadRight:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnChangeConfirm)
  self.isHead = true
  self.infoUI = UIManager:GetWindow(UIWindowTypeID.UserInfo)
  self.savedHeadItem = nil
  self.savedHeadFrameItem = nil
  self.userHeadNode = UINUserHead.New()
  self.userHeadNode:Init(self.ui.obj_UINUserHead)
end

function UIHeadRight:BindHeadRightResloader(resloader)
  self.resloader = resloader
end

function UIHeadRight:BindCloseFun(onCloseCallback)
  self._onCloseCallback = onCloseCallback
end

function UIHeadRight:OnChangeConfirm()
  if self.infoUI == nil then
    self.infoUI = UIManager:GetWindow(UIWindowTypeID.UserInfo)
  end
  if self.savedHeadItem ~= nil and self.savedHeadItem.id ~= PlayerDataCenter.inforData.avatarId then
    if PlayerDataCenter:IsItemOutTime(self.savedHeadItem.id) then
      CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(6041))
    else
      NetworkManager:GetNetwork(NetworkTypeID.Object):CS_User_AvatarModify(self.savedHeadItem.id, function()
        self.infoUI:RefreshUserHead(self.savedHeadItem.id)
      end)
    end
  end
  if self.savedHeadFrameItem ~= nil and self.savedHeadFrameItem.id ~= PlayerDataCenter.inforData.avatarFrameId then
    if PlayerDataCenter:IsItemOutTime(self.savedHeadItem.id) then
      CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(6041))
    else
      NetworkManager:GetNetwork(NetworkTypeID.Object):CS_User_AvatarFrameMod(self.savedHeadFrameItem.id, function()
        self.infoUI:RefreshUserHeadFrame(self.savedHeadFrameItem.id)
      end)
    end
  end
  self._onCloseCallback()
end

function UIHeadRight:SaveHead(itemHeadCfg)
  if itemHeadCfg == nil or self.itemHeadCfg.count == 0 then
    self.savedHeadItem = nil
    return
  end
  self.savedHeadItem = itemHeadCfg
end

function UIHeadRight:SaveHeadFrame(itemHeadFrameCfg)
  if itemHeadFrameCfg == nil or self.itemHeadFrameCfg.count == 0 then
    self.savedHeadFrameItem = nil
    return
  end
  self.savedHeadFrameItem = itemHeadFrameCfg
end

function UIHeadRight:changeHeadState()
  if self.itemHeadCfg ~= nil and self.itemHeadCfg.cfg ~= nil then
    self.userHeadNode:InitBaseHead(self.itemHeadCfg.id, self.resloader)
  else
    return
  end
  if self.itemHeadCfg.count == 0 then
    self.ui.btn_Confirm.gameObject:SetActive(false)
    self.ui.img_Locked:SetActive(true)
    self.ui.tex_CurEquip.gameObject:SetActive(false)
  else
    self.ui.btn_Confirm.gameObject:SetActive(true)
    self.ui.img_Locked:SetActive(false)
    self.ui.tex_CurEquip.gameObject:SetActive(true)
  end
  self.ui.tex_Condition.gameObject:SetActive(true)
  self.ui.tex_Condition.text = LanguageUtil.GetLocaleText(self.itemHeadCfg.cfg.describe_name)
  self.ui.tex_ItemName.text = LanguageUtil.GetLocaleText(self.itemHeadCfg.cfg.name)
  self.outTime = self.itemHeadCfg.outTime
  if self.outTime ~= -1 then
    self.ui.obj_time:SetActive(true)
    self:StartUpdateTimeText()
  else
    self.ui.obj_time:SetActive(false)
  end
end

function UIHeadRight:changeHeadFrameState()
  if self.itemHeadFrameCfg ~= nil and self.itemHeadFrameCfg.cfg ~= nil then
    if self.itemHeadCfg then
      self.userHeadNode:InitBaseHeadFull(self.itemHeadCfg.id, self.itemHeadFrameCfg.id, self.resloader)
    else
      self.userHeadNode:InitBaseHeadFrame(self.itemHeadFrameCfg.id, self.resloader)
    end
  else
    return
  end
  if self.itemHeadFrameCfg.count == 0 then
    self.ui.btn_Confirm.gameObject:SetActive(false)
    self.ui.img_Locked:SetActive(true)
    self.ui.tex_CurEquip.gameObject:SetActive(false)
  else
    self.ui.btn_Confirm.gameObject:SetActive(true)
    self.ui.img_Locked:SetActive(false)
    self.ui.tex_CurEquip.gameObject:SetActive(true)
  end
  self.ui.tex_Condition.gameObject:SetActive(true)
  self.ui.tex_Condition.text = LanguageUtil.GetLocaleText(self.itemHeadFrameCfg.cfg.achieve_name)
  self.ui.tex_ItemName.text = LanguageUtil.GetLocaleText(self.itemHeadFrameCfg.cfg.name)
  self.outTime = self.itemHeadFrameCfg.outTime
  if self.outTime ~= -1 then
    self.ui.obj_time:SetActive(true)
    self:StartUpdateTimeText()
  else
    self.ui.obj_time:SetActive(false)
  end
end

function UIHeadRight:StartUpdateTimeText()
  TimerManager:StopTimer(self.LimitTimeItemTimerId)
  self.LimitTimeItemTimerId = TimerManager:StartTimer(5, self.RefreshTime, self, false, false)
  self:RefreshTime()
end

function UIHeadRight:RefreshTime()
  local diffTime = self.outTime - PlayerDataCenter.timestamp
  if 0 < diffTime then
    local d, h, m, s = TimeUtil:TimestampToTimeInter(diffTime, false, true)
    if 0 < d then
      self.ui.tex_time:SetIndex(0, tostring(d), tostring(h))
    elseif 0 < h then
      self.ui.tex_time:SetIndex(1, tostring(h), tostring(m))
    elseif 0 < m then
      self.ui.tex_time:SetIndex(2, tostring(m))
    else
      self.ui.tex_time:SetIndex(2, tostring(1))
    end
  else
    TimerManager:StopTimer(self.LimitTimeItemTimerId)
    self.ui.tex_time:SetIndex(3)
  end
end

function UIHeadRight:OnDelete()
  TimerManager:StopTimer(self.LimitTimeItemTimerId)
  base.OnDelete(self)
end

return UIHeadRight
