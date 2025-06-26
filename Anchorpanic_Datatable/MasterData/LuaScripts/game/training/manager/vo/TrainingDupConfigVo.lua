module("training.TrainingDupConfigVo", Class.impl())

function ctor(self)
end

function parseData(self, dupId, dupData)
    self.dupId = dupId
    self.stepId = dupData.step_id
    self.diffLvl = dupData.diff_lvl
    self.des = dupData.explain
    self.cost = {dupData.need_tid, dupData.need_num}
    self.showAwardId = dupData.show_drop
    
    self.m_musicId = dupData.music_id
    self.m_sceneId = dupData.scene_id
end

function getDes(self)
    return _TT(self.des)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
