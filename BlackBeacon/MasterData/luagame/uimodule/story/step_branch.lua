local Base = require("uimodule.story.step_base")
local M = Util.create_child_mt(Base)
local TypeEffectStatus = _ENV.TypeEffectStatus
local TypeCSPlayableDirector = typeof(UnityEngine.Playables.PlayableDirector)
local TextMeshProType = typeof(CS.TMPro.TextMeshProUGUI)
local STORY_CONFIG = require("uimodule.story.story_config")
local BRANCH_NUM = STORY_CONFIG.BRANCH_NUM
local EFFECT_TYPE = {DEFAULT = 0, GARDUAL = 1}
local SEQENCE_TIME = 0.6

function M:_init(...)
  Base._init(self, ...)
end

function M:on_destroy()
  Base.on_destroy(self)
  self.v_uiobjects.Branch_List:SetActive(false)
  self.v_click_effect = false
end

function M:init_ui()
  self.v_uiobjects.Branch_List:SetActive(true)
  self.v_uiobjects.TimeBar:SetActive(false)
end

function M:start()
  self:init_ui()
  self.v_click_effect = false
  local step_cfg = self.v_step_cfg
  SEQENCE_TIME = step_cfg.FadeTime
  if step_cfg.Branch or step_cfg.FightBranch then
    self:update_branch_list()
  elseif step_cfg.NoBranch then
    self.v_uiobjects.Branch_List:SetActive(false)
    self.v_uiobjects.BgBtn:SetActive(true)
    self:no_branch_view()
  end
  self:check_limit_select_time()
end

function M:update()
  Base.update(self)
  self:update_limit_time()
end

function M:update_branch_list()
  local step_cfg = self.v_step_cfg
  local branch_list = step_cfg.SelectionList
  for index = 1, BRANCH_NUM do
    local branch_data = branch_list[index]
    local branch_obj = self.v_uiobjects["Branch" .. index]
    branch_obj:SetActive(false)
    local click_on = Util.get_child_gameobj("VX_cilck_on", branch_obj)
    local click_off = Util.get_child_gameobj("VX_cilck_off", branch_obj)
    click_on:SetActive(false)
    click_off:SetActive(false)
    local off_mask = self.v_uiobjects["OffMask" .. index]
    off_mask:SetActive(false)
    self.v_uiobjects["BranchMask" .. index]:SetActive(false)
    if branch_data then
      local branch_canvas = Util.get_canvas_group(nil, branch_obj)
      if branch_canvas then
        branch_canvas.alpha = 1
      end
      branch_obj:SetActive(true)
      local tip = LanguageMgr:get_story_text(branch_data.Content)
      tip = self:replace_talk_content(tip)
      local jump_id = self.v_lua_obj:get_jump_step_idx(branch_data.Jump)
      local branch_txt = self.v_uicompents["Branch_Text" .. index .. "_txt"]
      if branch_txt then
        branch_txt.text = tip
      else
        local branch_txt_obj = self.v_uiobjects["Branch_Text" .. index]
        branch_txt = branch_txt_obj:GetComponent(TextMeshProType)
        branch_txt.text = tip
      end
      local is_has_chose = self.v_lua_obj:check_branch_has_chose(jump_id)
      self.v_uiobjects["BranchMask" .. index]:SetActive(is_has_chose)
    end
    self:update_alpha("BranchBtn" .. index, 1)
    self:update_alpha("Branch_Text" .. index, 1)
  end
  self:show_effect()
end

function M:update_alpha(obj_name, alpha)
  local obj = self.v_uiobjects[obj_name]
  local canvas = obj:GetComponent("CanvasGroup")
  canvas.alpha = alpha
end

function M:show_effect()
  local step_cfg = self.v_step_cfg
  local effect_type = step_cfg.ShowEffect or EFFECT_TYPE.DEFAULT
  local branch_content = self.v_uiobjects.Branch_List
  local canvas = branch_content:GetComponent("CanvasGroup")
  branch_content:SetActive(true)
  if effect_type == EFFECT_TYPE.DEFAULT then
    canvas.alpha = 1
  elseif effect_type == EFFECT_TYPE.GARDUAL then
    canvas.alpha = 0
    local seqence = self:get_new_sequence("step_branch_show_effec")
    seqence:Append(canvas:DOFade(1, SEQENCE_TIME))
  end
end

function M:hide_effect()
  local step_cfg = self.v_step_cfg
  local effect_type = step_cfg.HideEffect or EFFECT_TYPE.DEFAULT
  local branch_content = self.v_uiobjects.Branch_List
  local canvas = branch_content:GetComponent("CanvasGroup")
  if effect_type == EFFECT_TYPE.DEFAULT then
    branch_content:SetActive(false)
    self:complete()
    self.v_lua_obj:check_step_all_complete()
  elseif effect_type == EFFECT_TYPE.GARDUAL then
    local seqence = self:get_new_sequence("step_branch_hide_effec")
    seqence:Append(canvas:DOFade(0, SEQENCE_TIME))
    seqence:AppendCallback(function()
      branch_content:SetActive(false)
      self:complete()
      self.v_lua_obj:check_step_all_complete()
    end)
  end
end

function M:no_branch_view()
  local step_cfg = self.v_step_cfg
  local go_step_id = self.v_lua_obj:get_jump_step_idx(step_cfg.Jump)
  self.v_lua_obj:set_branch_step_id(go_step_id)
  self:complete()
end

function M:check_limit_select_time()
  local step_cfg = self.v_step_cfg
  local is_limit_time = step_cfg.IsTimeLimit
  self.v_is_limit_time = false
  self:update_time_bar_effect(true)
  if not is_limit_time then
    return
  end
  local branch_list = step_cfg.SelectionList
  if #branch_list <= 0 then
    return
  end
  self:update_time_bar_effect()
  self.v_is_limit_time = true
  local limit_time = step_cfg.LimitTime
  self.v_end_time_val = Global.real_time + limit_time
  local random_idx = math.random(1, #branch_list)
  
  function self.v_end_cb()
    self:click_branch(random_idx)
    self:update_time_bar_effect(true)
  end
end

function M:update_time_bar_effect(is_hide)
  local step_cfg = self.v_step_cfg
  local ui_obj = self.v_uiobjects.TimeBar
  ui_obj:SetActive(false)
  local effect_name = step_cfg.TimeBarEffectName
  if not effect_name or "" == effect_name then
    return
  end
  local effect_obj = Util.get_child_gameobj(effect_name, ui_obj)
  if not effect_obj then
    return
  end
  local on_playable = effect_obj:GetComponent(TypeCSPlayableDirector)
  on_playable:Stop()
  if is_hide then
    effect_obj:SetActive(false)
    return
  end
  ui_obj:SetActive(true)
  effect_obj:SetActive(true)
  on_playable:Play()
end

function M:update_limit_time()
  if not self.v_is_limit_time then
    return
  end
  local now_time = Global.real_time
  if self.v_end_time_val - now_time <= 0 then
    if self.v_end_cb then
      self.v_end_cb()
      self.v_end_cb = nil
    end
    self.v_is_limit_time = false
  end
end

function M:branch_effect(index)
  local step_cfg = self.v_step_cfg
  local branch_list = step_cfg.SelectionList
  local data = branch_list[index]
  Util.assert(data, "branch data is nil", step_cfg)
  local go_step_id = self.v_lua_obj:get_jump_step_idx(data.Jump)
  if self.v_lua_obj:check_branch_has_chose(go_step_id) then
    return
  end
  self.v_lua_obj:set_branch_step_id(go_step_id)
  self.v_lua_obj:cache_branch_select_data(go_step_id, self.v_story_id)
  self.v_lua_obj:cache_talk_data(nil, data, self.v_story_id)
  self:hide_effect()
end

function M:click_branch(select_index)
  if self.v_click_effect then
    return
  end
  StoryMgr:add_trace_step_record(select_index)
  self.v_click_effect = true
  for index = 1, BRANCH_NUM do
    local branch_obj = self.v_uiobjects["Branch" .. index]
    local click_on = Util.get_child_gameobj("VX_cilck_on", branch_obj)
    local click_off = Util.get_child_gameobj("VX_cilck_off", branch_obj)
    local off_mask = self.v_uiobjects["OffMask" .. index]
    off_mask:SetActive(false)
    local on_playable = click_on:GetComponent(TypeCSPlayableDirector)
    local off_playable = click_off:GetComponent(TypeCSPlayableDirector)
    on_playable:Stop()
    off_playable:Stop()
    if index == select_index then
      on_playable:RemovePlayableDirectorListener()
      click_on.transform:SetTimelineSeqEndCB(function()
        self:branch_effect(select_index)
      end)
      off_mask:SetActive(true)
      click_on:SetActive(true)
      on_playable:Play()
      click_off:SetActive(false)
    else
      click_on:SetActive(false)
      click_off:SetActive(true)
      off_playable:Play()
    end
  end
  Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.story_branch_click_UI_SOUND)
end

return M
