module("formation.FormationPosEffVo", Class.impl())

function setData(self, id, data)
    self.id = id

    -- 阵营
    self.side = data.side

    self.posList = data.pos_list
    self.effectSkillList = data.effect_list

    self.iconList = data.icon_list
    -- self.effPrefabList = data.effect_prefab_list 
    self.backGroundList = data.background_list

    self.col = data.col
    self.row = data.row

    -- 常显的特效
    self.mEffectPrefabIcon = data.effect_prefab_icon
    -- 有战员时的特效
    self.mEffectPrefabBuff = data.effect_prefab_buff
end

return _M
