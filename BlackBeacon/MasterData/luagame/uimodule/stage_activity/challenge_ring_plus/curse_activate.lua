local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local _tinsert = table.insert
local DoTween = typeof(CS.DG.Tweening.DOTweenAnimation)

function ui:ui_finish_load()
  self:set_button("BtnClose", function()
    if next(self.v_queue) == nil then
      self:ui_hide()
    else
      self:set_view()
    end
  end)
  self:init_tween()
end

function ui:ui_on_show(curse_index)
  self.v_debuff_list = ChallengeRingPlusMgr:get_debuff()
  self.v_debuff_list_old = ChallengeRingPlusMgr:get_debuff_old()
  self.v_index = #self.v_debuff_list_old
  self.v_queue = {}
  for index = #self.v_debuff_list_old + 1, #self.v_debuff_list do
    if index <= 4 then
      _tinsert(self.v_queue, self.v_debuff_list[index])
    end
  end
  self.v_uiobjects.CurseTem5:SetActive(false)
  self:set_original_curse_tem_info()
  self:set_view()
end

function ui:ui_on_hide()
  for _, tween in pairs(self.v_tween_list) do
    tween:DOKill()
  end
  ChallengeRingPlusMgr:set_debuff_old(self.v_debuff_list)
end

function ui:init_tween()
  self.v_tween_list = {}
  local title_tween = self.v_uiobjects.Title:GetComponent(DoTween)
  _tinsert(self.v_tween_list, title_tween)
  local curse_icon_tween = self.v_uiobjects.CurseIconBg:GetComponent(DoTween)
  _tinsert(self.v_tween_list, curse_icon_tween)
  local effect_content_tween = self.v_uiobjects.EffectContent:GetComponent(DoTween)
  _tinsert(self.v_tween_list, effect_content_tween)
  local desc_content_tween = self.v_uiobjects.DescContent:GetComponent(DoTween)
  _tinsert(self.v_tween_list, desc_content_tween)
end

function ui:set_original_curse_tem_info()
  local original_dubuff_count = #self.v_debuff_list_old
  for index = 1, 4 do
    self.v_uiobjects["CurseIcon" .. index]:SetActive(index <= original_dubuff_count)
    self.v_uiobjects["BgRed" .. index]:SetActive(index <= original_dubuff_count)
    if index <= original_dubuff_count then
      self:set_curse_icon(index)
    end
  end
end

function ui:set_curse_icon(index)
  local curse_id = self.v_debuff_list[index]
  local curse_icon = self.v_uicompents["CurseIcon" .. index .. "_img"]
  local icon_path = ShareRes.get_curse_ring_curse_iocn(curse_id)
  ResMgr:load_set_icon(curse_icon, icon_path)
end

function ui:set_view()
  if next(self.v_queue) == nil then
    self:ui_hide()
    return
  end
  Global.sound_mgr:play_common_sound("Sound_miyin")
  self.v_index = self.v_index + 1
  local curse_id = self.v_queue[1]
  table.remove(self.v_queue, 1)
  self:reset_ui()
  for _, tween in pairs(self.v_tween_list) do
    tween:RecreateTween()
    tween:DOPlay()
  end
  self:update_view(curse_id)
end

function ui:reset_ui()
  local title_trans = self.v_uiobjects.Title.transform
  title_trans:SetLocalPositionA(0, 181.1, 0)
  local icon_trans = self.v_uiobjects.CurseIconBg.transform
  icon_trans:SetLocalPositionA(-15, 19, 0)
  local canvas = self.v_uiobjects.EffectContent:GetComponent("CanvasGroup")
  canvas.alpha = 0
  canvas = self.v_uiobjects.DescContent:GetComponent("CanvasGroup")
  canvas.alpha = 0
end

function ui:update_view(curse_id)
  local debuff_cfg = ShareRes.create("activity.curse_effect", curse_id)
  self.v_uicompents.CurseName_txt.text = debuff_cfg.Name
  self.v_uicompents.EffectDescTem_txt.text = debuff_cfg.Desc
  self.v_uicompents.CurseDesc_txt.text = debuff_cfg.WorldDesc
  ResMgr:load_set_icon(self.v_uicompents.CurseIcon_img, debuff_cfg.Icon)
  self.v_uiobjects["CurseIcon" .. self.v_index]:SetActive(true)
  self.v_uiobjects["BgRed" .. self.v_index]:SetActive(true)
  self:set_curse_icon(self.v_index)
end

return ui
