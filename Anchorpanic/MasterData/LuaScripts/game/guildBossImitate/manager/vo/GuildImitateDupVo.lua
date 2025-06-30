-- @FileName:   GuildImitateDupVo.lua
-- @Description:   描述
-- @Author: ZDH
-- @Date:   2024-04-10 16:34:23
-- @Copyright:   (LY) 2024 锚点降临

module('guildBossImitate.GuildImitateDupVo', Class.impl())

function parseCogfigData(self, id, cusData)
    self.dupId = id
    self.difficulty = cusData.difficulty
    self.weakness_ele = cusData.weakness_ele
    self.stage_name = cusData.stage_name
    self.dup_guard = cusData.dup_guard
    self.boss_id = cusData.boss_id
    self.formationId = cusData.formation_id
    self.mMusicId = cusData.music_id
    self.mSceneId = cusData.scene_id
    self.suggestLevel = cusData.suggest_level
    self.suggestEle = cusData.suggest_ele

    self.enemyList = {self.boss_id}
end

return _M
