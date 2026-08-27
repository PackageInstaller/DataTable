local UINSpring23InteractiveItem = class("UINAthItem", UIBaseNode)
local base = UIBaseNode
local ActivitySpringStoryEnum = require("Game.ActivitySpring.Data.ActivitySpringStoryEnum")
local CS_EventTriggerListener = CS.EventTriggerListener

function UINSpring23InteractiveItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self._OnClickRoot)
end

function UINSpring23InteractiveItem:SetSpring23InteractiveItemEntt(actLbEntt)
  self._actLbEntt = actLbEntt
end

function UINSpring23InteractiveItem:RefreshSpring23InteractiveItem(interactCfg, costNum, CloseAni)
  self.ui.img.color = self.ui.normal_color
  self.ui.img_Interactiveglow.gameObject:SetActive(false)
  if not CloseAni then
    self.ui.ani:Play("UI_Spring23Interactive")
    local aniState = self.ui.ani:get_Item("UI_Spring23Interactive")
    local length = aniState.length
    local setTime = Time.time % length
    aniState.time = setTime
  end
  if costNum < interactCfg.needNum then
    self.ui.img.color = self.ui.dark_color
  end
  if interactCfg.stage_id == ActivitySpringStoryEnum.stageEnum.main then
    self.ui.img_type:SetIndex(0)
    if costNum >= interactCfg.needNum and not CloseAni then
      self:_StartSEAni()
      self.ui.img_Interactiveglow:SetIndex(0)
    end
  elseif interactCfg.stage_id == ActivitySpringStoryEnum.stageEnum.side then
    self.ui.img_type:SetIndex(1)
    if costNum >= interactCfg.needNum and not CloseAni then
      self:_StartSEAni()
      self.ui.img_Interactiveglow:SetIndex(1)
    end
  elseif interactCfg.stage_id == ActivitySpringStoryEnum.stageEnum.fixReward then
    self.ui.img_type:SetIndex(2)
  end
end

function UINSpring23InteractiveItem:_StartSEAni()
  self.ui.img_Interactiveglow.gameObject:SetActive(true)
  local length = self.ui.tweenAni_pick.duration * 2
  local setTime = Time.time % length
  self.ui.tweenAni_pick.tween:Goto(setTime, true)
end

function UINSpring23InteractiveItem:SetArrowOpen(arrowDir)
  self.ui.img_Arrow_trans.gameObject:SetActive(true)
  local angle = Vector3.Angle(Vector3.up, arrowDir)
  local norDir = Vector3.Cross(Vector3.up, arrowDir)
  if norDir.z > 0 then
    angle = angle * -1
  end
  angle = angle + 45
  self.ui.img_Arrow_trans.rotation = Quaternion.AngleAxis(angle, Vector3.back)
end

function UINSpring23InteractiveItem:SetArrowClose()
  self.ui.img_Arrow_trans.gameObject:SetActive(false)
end

function UINSpring23InteractiveItem:CloseAllAni()
  self.ui.btn_root.transform.anchoredPosition = Vector2.zero
  self.ui.img_Interactiveglow.gameObject:SetActive(false)
  self.ui.tweenAni_pick:DOPause()
  self.ui.ani:Stop()
end

function UINSpring23InteractiveItem:_OnClickRoot()
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  if actLbCtrl == nil then
    return
  end
  actLbCtrl.actLbCmderCtrl:LbCmdMove2Entt(self._actLbEntt)
end

function UINSpring23InteractiveItem:GetInteractiveItemWidth()
  return 100
end

function UINSpring23InteractiveItem:OnHide()
  self:CloseAllAni()
end

function UINSpring23InteractiveItem:OnDelete()
  base.OnDelete(self)
end

return UINSpring23InteractiveItem
