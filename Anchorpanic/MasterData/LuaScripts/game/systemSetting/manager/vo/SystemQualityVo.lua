module('game.systemSetting.SystemQualityVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.quality_type = key
    self.fps = cusData.fps
    self.v_sync = cusData.v_sync
    self.render_resolution = cusData.render_resolution
    self.shadow_quality = cusData.shadow_quality
    self.visual_effects = cusData.visual_effects
    self.sfx_quality = cusData.sfx_quality
    self.environment_detail = cusData.environment_detail
    self.anti_aliasing = cusData.anti_aliasing
    self.volumetric_fog = cusData.volumetric_fog
    self.reflections = cusData.reflections
    self.motion_blur = cusData.motion_blur
    self.bloom = cusData.bloom
    self.crowd_density = cusData.crowd_density
    self.co_op_teammate_effects = cusData.co_op_teammate_effects
    self.subsurfasce_scattering = cusData.subsurfasce_scattering
    self.anisotropic_filtering = cusData.anisotropic_filtering
    self.dispersion = cusData.dispersion
    self.radial_Blur = cusData.radial_blur
    self.special_effect_distortion = cusData.special_effect_distortion
    self.post_processing = cusData.post_processing

end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
