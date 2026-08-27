local UINResultCompleteNode = class("UINResultCompleteNode", UIBaseNode)

function UINResultCompleteNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINResultCompleteNode:InitResultCompleteTime(frame, isCheat, isNew)
  UIUtil.AddButtonListener(self.ui.btn_ErrorIcon, self, self.__OnBtnErrorIcon)
  UIUtil.AddButtonListener(self.ui.btn_FloatingBG, self, self.__OnBtnFloatingBG)
  self.ui.btn_ErrorIcon.gameObject:SetActive(true)
  self.ui.completeTime:SetIndex(0)
  self.ui.tex_Time.text = BattleUtil.FrameToTimeString(frame, true)
  self.ui.tex_Title.text = LanguageUtil.GetLocaleText(ConfigData:GetTipContent(8801))
  self.ui.tex_Content.text = LanguageUtil.GetLocaleText(ConfigData:GetTipContent(8802))
  self.ui.img_NewIcon:SetActive(isNew and not isCheat)
  self.ui.img_Error:SetActive(isCheat)
  self.isShowFloatingFrame = false
  self.ui.obj_floatingFrame:SetActive(self.isShowFloatingFrame)
  self.ui.btn_FloatingBG.gameObject:SetActive(self.isShowFloatingFrame)
end

function UINResultCompleteNode:InitResultCompleteItem(index, des, isNew, isCheat)
  self.ui.btn_ErrorIcon.gameObject:SetActive(false)
  self.ui.completeTime:SetIndex(index)
  self.ui.tex_Time.text = des
  self.ui.img_NewIcon:SetActive(isNew or false)
  self.ui.img_Error:SetActive(isCheat)
end

function UINResultCompleteNode:__OnBtnErrorIcon()
  self.isShowFloatingFrame = not self.isShowFloatingFrame
  self.ui.obj_floatingFrame:SetActive(self.isShowFloatingFrame)
  self.ui.btn_FloatingBG.gameObject:SetActive(self.isShowFloatingFrame)
end

function UINResultCompleteNode:__OnBtnFloatingBG()
  self.isShowFloatingFrame = false
  self.ui.obj_floatingFrame:SetActive(self.isShowFloatingFrame)
  self.ui.btn_FloatingBG.gameObject:SetActive(self.isShowFloatingFrame)
end

return UINResultCompleteNode
