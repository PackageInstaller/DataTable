-- @FileName:   BigHostelModelConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.bighostel.manager.configVo.BigHostelModelConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.modelId = key
    self.cvData = {}
    for k, v in pairs(cusData.action) do
        self.cvData[gs.Animator.StringToHash(v.action)] =
        {
            cv_id = v.cv,
            voice_layback = v.voice_layback,
        }
    end
end

function getActionCVConfig(self, action_name)
    return self.cvData[action_name]
end

function getCVConfig(self)
    return self.cvData
end

return _M
