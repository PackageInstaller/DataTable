local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local Vec3 = require("base.vec3")
local NodeImage = "UIBattleGame1/Battlegame_icon_jd"
local MODEL = {
  v_button = {
    "Button",
    BIND_TYPE.BUTTON
  },
  v_content = {
    "Content",
    BIND_TYPE.OBJECT
  },
  v_left = {
    "Left",
    BIND_TYPE.IMAGE
  },
  v_lock = {
    "Lock",
    BIND_TYPE.IMAGE
  },
  v_lower = {
    "Lower",
    BIND_TYPE.IMAGE
  },
  v_node_type = {
    "NodeType",
    BIND_TYPE.IMAGE
  },
  v_right = {
    "Right",
    BIND_TYPE.IMAGE
  },
  v_rotation = {
    "Rotation",
    BIND_TYPE.OBJECT
  },
  v_top = {
    "Top",
    BIND_TYPE.IMAGE
  }
}

function ui:ui_finish_load()
end

function ui:set_data(data)
  self.pipe_cnt = #data.directions
  if self.pipe_cnt < 1 then
    self.v_uiobjects.Content:SetActive(false)
    self.v_uiobjects.Button:SetActive(false)
    return
  else
    self.v_uiobjects.Content:SetActive(true)
    self.v_uiobjects.Button:SetActive(true)
  end
  self:init_model(MODEL)
  self.v_pipes = {
    self.v_top,
    self.v_right,
    self.v_lower,
    self.v_left
  }
  self.v_data = data
  self.v_lock:SetActive(data.isLock)
  self:set_pipe()
  self:set_initial()
  if not self.v_data.isLock then
    self:set_button("Button", function()
      self:rotate()
    end)
  end
end

function ui:set_pipe()
  for k, obj in ipairs(self.v_pipes) do
    obj:SetActive(false)
  end
  local directions = self.v_data.directions
  self.v_pipe_dict = {}
  for i = 1, #directions do
    directions[i] = (directions[i] + math.floor(self.v_data.rotateAngle / 90)) % 4
    self.v_pipes[directions[i] + 1]:SetActive(true)
    table.insert(self.v_pipe_dict, directions[i] + 1)
  end
  self:set_node_icon(self.v_data.centerType)
end

function ui:set_node_icon(type)
  ResMgr:load_set_icon(self.v_node_type, NodeImage .. type, nil)
end

function ui:rotate()
  if not self.v_parent_class then
    self.v_parent_class = UIMgr:get_ui("ui_water_pipe")
  end
  Global.sound_mgr:play_sound_by_id("Sound_pipe_turn")
  self.v_parent_class:change_canvas_raycaster(false)
  for i = 1, self.pipe_cnt do
    self.v_data.directions[i] = (self.v_data.directions[i] + 3) % 4
  end
  self:clear_sequence()
  self.v_sequence = Util.create_sequence()
  self.v_sequence:Join(self.v_uiobjects.Rotation.transform:DORotate(Vec3.New(0, 0, 90), 0.1, CS.DG.Tweening.RotateMode.WorldAxisAdd))
  self.v_sequence:OnComplete(function()
    self.v_parent_class:check_is_pass()
  end)
end

function ui:set_pipe_state(state)
  if self.pipe_cnt < 1 or state == self.v_state then
    return
  end
  for i = 1, #self.v_pipe_dict do
    local transform = self.v_pipes[self.v_pipe_dict[i]].transform
    if not transform then
      break
    end
    if 3 == state then
      transform:GetChild(0):SetActive(false)
      transform:GetChild(1):SetActive(true)
      transform:FindChild("DirtyWater/Fx_UIBattleGame_DirtyWater"):SetActive(true)
      self:set_link()
    elseif 2 == state then
      transform:GetChild(0):SetActive(true)
      transform:GetChild(1):SetActive(false)
      transform:FindChild("Water/Fx_UIBattleGame_Water"):SetActive(true)
      self:set_link()
    elseif 1 == state then
      transform:GetChild(0):SetActive(false)
      transform:GetChild(1):SetActive(false)
    end
  end
  self.v_state = state
end

function ui:set_initial()
  if self.pipe_cnt < 1 then
    return
  end
  if not self.ani_node then
    self.ani_node = self.v_content:FindChild("Animation/Ani_UIBattleGame1_Node")
  end
  if self.ani_node.activeSelf then
    self.ani_node:SetActive(false)
  end
  self.ani_node:SetActive(true)
end

function ui:set_link()
  if self.pipe_cnt < 1 then
    return
  end
  if not self.ani_link then
    self.ani_link = self.v_content:FindChild("Animation/Ani_UIBattleGame1_Link")
  end
  if self.ani_link.activeSelf then
    self.ani_link:SetActive(false)
  end
  self.ani_link:SetActive(true)
end

function ui:set_glow(state)
  if self.pipe_cnt < 1 then
    return
  end
  if not self.ani_glow then
    self.ani_glow = self.v_content:FindChild("Animation/Ani_UIBattleGame1_Glow")
  end
  if not self.bg_glow then
    self.bg_glow = self.v_content:FindChild("Bg/BgGlow"):GetComponent("CanvasGroup")
  end
  if self.ani_glow.activeSelf then
    self.ani_glow:SetActive(false)
  end
  if state then
    self.ani_glow:SetActive(true)
  else
    self.bg_glow.alpha = 0
  end
end

function ui:on_clear()
  self:set_glow(false)
  if self.ani_link and self.ani_link.activeSelf then
    self.ani_link:SetActive(false)
  end
  self:clear_sequence()
end

function ui:clear_sequence()
  if self.v_sequence then
    self.v_sequence:Kill(false)
    self.v_sequence = nil
  end
end

return ui
