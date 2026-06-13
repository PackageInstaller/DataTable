local Base = require("obj.base_component")
local CSAddMaterial = CS.Game.AddMaterial
local CSUnityMaterial = UnityEngine.Material
local QualityCfg = require("manager.render.quality_cfg")
local QualityShadow = QualityCfg.SHADOW
local SHADOW_PATH = "Fx_Common_Shadow"
local CUSTOM_ROLE_LIGHT = "_CUSTOM_ROLE_LIGHT"
local UnityShader = UnityEngine.Shader
local MAIN_SCENE_SHOW_ID = UnityShader.PropertyToID("_MAIN_SCENE_SHOW")
local M = Util.create_child_mt(Base)
local _tinsert = table.insert
local _tremove = table.remove
local CHAR_EFFECT = Config.CHAR_EFFECT
local FILTERATE_EYE = "eye"
local FILTERATE_FACE = "face"
local EFFECT = {
  [CHAR_EFFECT.SHADOW] = "ShadowCaster.mat",
  [CHAR_EFFECT.RIM] = "CharacterRim.mat",
  [CHAR_EFFECT.PLANE_SHADOW] = "PlaneShadow.mat"
}
local EFFECT_QUALITY_FUNC = {
  [CHAR_EFFECT.SHADOW] = function(quality_cfg)
    return quality_cfg.shadow >= QualityShadow.MIDDLE
  end,
  [CHAR_EFFECT.RIM] = function(quality_cfg)
    return quality_cfg.rim
  end,
  [CHAR_EFFECT.PLANE_SHADOW] = function()
    return true
  end
}

function M:_init(char)
  Base._init(self)
  self.v_char = char
  self.v_has_setup = false
  self:mgr_bind_auto_mq(Const.MSG_QUALIY_CHANGE, self._on_quality_change, self)
  self:mgr_bind_auto_mq(Const.MSG_ON_WEAPON_LOADED, self._on_weapon_loaded, self)
  self:check_hero_shadow()
end

function M:on_before_destroy()
  self.v_char = nil
end

function M:on_destroy_gameobj()
  if self.v_has_setup then
    self.v_add_material:RemoveAll()
  end
  if self.v_effect_mats then
    for k, _ in pairs(self.v_effect_mats) do
      ResMgr:unload_res(Path.get_res_path(k), CSUnityMaterial)
    end
  end
  self.v_effect_enables = nil
  self.v_effect_mats = nil
end

function M:enable_effect(effect, enable)
  if nil == enable then
    Log.Error("char_renderers:enable_effect enable 参数不能为空")
    return
  end
  local effect_mat_name = EFFECT[effect]
  if not effect_mat_name then
    Log.Error("找不到效果: ", effect)
    return
  end
  if enable and not self.v_has_setup then
    self.v_has_setup = true
    self.v_add_material = CSAddMaterial.Bind(self.v_char.gameobj.gameObject)
    self.v_add_material.Enable = true
  end
  if not self.v_effect_enables then
    self.v_effect_enables = {}
  end
  local old_enable = self.v_effect_enables[effect]
  if old_enable == enable then
    return
  end
  if not enable and nil == old_enable then
    return
  end
  self.v_effect_enables[effect] = enable
  if not self.v_effect_mats then
    self.v_effect_mats = {}
  end
  local mat = self.v_effect_mats[effect_mat_name]
  if not mat then
    if not enable then
      return
    end
    mat = ResMgr:load_res(Path.get_res_path(effect_mat_name), CSUnityMaterial)
    if not mat then
      Log.Error("没有对应的材质", effect_mat_name)
      return
    end
    self.v_effect_mats[effect_mat_name] = mat
  end
  if not self.v_need_enable_effect then
    self.v_need_enable_effect = {}
  end
  self.v_need_enable_effect[effect] = false
  if enable then
    if EFFECT_QUALITY_FUNC[effect](Global.quality_cfg) then
      if effect == CHAR_EFFECT.SHADOW then
        self.v_add_material:ClearFilterate()
        self.v_add_material:Filterate(FILTERATE_EYE, mat)
        self.v_add_material:Filterate(FILTERATE_FACE, mat)
        self.v_add_material:AddMat(mat)
      else
        self.v_add_material:AddMat(mat)
      end
    else
      self.v_need_enable_effect[effect] = true
    end
  else
    self.v_add_material:RemoveMat(mat)
    self.v_effect_mats[effect_mat_name] = nil
    ResMgr:unload_res(Path.get_res_path(effect_mat_name))
  end
end

function M:_on_weapon_loaded(msg)
  if msg.mm_obj == self.v_char then
    self:update_effect()
  end
end

function M:update_effect()
  if self.v_add_material then
    self.v_add_material:UpdateRenderMat()
  end
end

function M:check_hero_shadow()
  if not self.v_char:is_hero() then
    return
  end
  if SceneMgr:check_main_scene() then
    return
  end
  local shadow_quality = BattleSettingMgr:get_shadow_quality()
  if shadow_quality < QualityShadow.LOW then
    return
  end
  if shadow_quality < QualityShadow.MIDDLE then
    if not self.v_simple_shadow or self.v_simple_shadow:IsNull() then
      self.v_simple_shadow = ResMgr:load_gameobj(Path.get_res_path(SHADOW_PATH))
    end
  elseif self.v_simple_shadow then
    ResMgr:destroy_gameobj(self.v_simple_shadow)
    self.v_simple_shadow = nil
  end
  if self.v_simple_shadow then
    local trans = self.v_simple_shadow.transform
    trans:SetParent(self.v_char.transform, false)
    local radius = self.v_char.v_body_radius or 0.3
    trans:SetLocalScaleA(radius, 1, radius)
  end
end

function M:_on_quality_change(msg)
  self:check_hero_shadow()
  if not self.v_need_enable_effect or not self.v_effect_enables then
    return
  end
  for effect, enable in pairs(self.v_effect_enables) do
    if not enable then
    else
      local can_enable = EFFECT_QUALITY_FUNC[effect](Global.quality_cfg)
      local need_enable = self.v_need_enable_effect[effect] == true
      if can_enable == need_enable then
        self.v_need_enable_effect[effect] = not need_enable
        local effect_mat_name = EFFECT[effect]
        local mat = self.v_effect_mats[effect_mat_name]
        if not mat then
        elseif can_enable then
          if effect == CHAR_EFFECT.SHADOW then
            self.v_add_material:ClearFilterate()
            self.v_add_material:Filterate(FILTERATE_EYE, mat)
            self.v_add_material:Filterate(FILTERATE_FACE, mat)
            self.v_add_material:AddMat(mat)
          else
            self.v_add_material:AddMat(mat)
          end
        else
          self.v_add_material:RemoveMat(mat)
        end
      end
    end
  end
end

function M:before_fight()
  local trans = self.v_char.transform
  if not trans then
    return
  end
  trans:SetKeyWordAll("_SHADOW_RECEIVE", false)
  Util.set_all_mat(trans, function(mat)
    local name = mat.name
    if "H1001009_Weapon_1_2" == name or "H1001019_Weapon_1_2" == name then
      mat:SetKeyword("_SHADOW_RECEIVE", true)
    end
  end)
  UnityShader.SetGlobalFloat(MAIN_SCENE_SHOW_ID, 0)
  UnityShader.SetGlobalFloat(CUSTOM_ROLE_LIGHT, 0)
  local char_util = self.v_char:get_character_util()
  char_util:ChangeAllCharacterMat(false)
end

return M
