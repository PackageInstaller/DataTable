--[[ 
-----------------------------------------------------
@filename       : MiningEventVo
@Description    : 挖矿事件配置
@date           : 2023-11-30 17:38:30
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.mining.manager.vo.MiningEventVo', Class.impl())

function parseData(self, key, cusData)
    self.id = key
    self.skillIds = cusData.skill_id
    self.point = cusData.point
    self.grabSpeed = cusData.grab_speed
    self.moveSpeed = cusData.move_speed
    self.prefabName = cusData.prefab_name
    self.interactType = cusData.interact_type
    self.movePos = cusData.movePos
    self.effect = cusData.effect
    self.soundEffect = cusData.sound_effect
    self.isBubble = cusData.is_bubble
end

return _M