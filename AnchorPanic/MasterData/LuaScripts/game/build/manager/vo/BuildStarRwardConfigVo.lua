module('build.BuildStarRwardConfigVo', Class.impl())

-- 解析星级累计奖励配置，缓存领取门槛、奖励内容和描述
function parseCogfigData(self, key, cusData)
    self.id = key
    self.star_num = cusData.star_num
    self.reward = cusData.reward
    self.des = cusData.des

end

function getDesc(self)
    return _TT(self.des)
end

return _M
