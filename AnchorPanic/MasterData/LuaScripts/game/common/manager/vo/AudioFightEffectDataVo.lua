--战斗音效
module("AudioFightEffectDataVo", Class.impl(AudioDataVo))

--计时器计时间隔
function getTimeDetaTime(self)
    return (1/gs.Application.targetFrameRate * gs.Time.timeScale)
end

--设置播放速度
function setPitch(self, pitch)
    if not self.m_source or not self.m_source.clip or self.m_source.clip.length <= 0 then
        return
    end

    self.m_source.pitch = pitch
end

return _M 
 
--[[ 替换语言包自动生成，请勿修改！
]]
