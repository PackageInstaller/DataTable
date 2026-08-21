module('vision.VisionMirrorPassDupVo', Class.impl())

function parseMsg(self, msg)
    self.layer = msg.layer
    self.score = msg.score
    -- 层内已通关关卡列表：pt_pass_vision_mirror_dup { dup_id, battle_round, hero_die_num, score(最终评分) }
    self.dupList = {}
    for i, v in ipairs(msg.dup_list or {}) do
        table.insert(self.dupList, { dupId = v.dup_id, score = v.score })
    end
end

return _M
