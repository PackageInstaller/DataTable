module('dup.DupMainController', Class.impl(Controller))

--构造函数
function ctor(self)
    super.ctor(self)
end

--析构函数
function dtor(self)
end


--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_DUP_DATA = self.onDupDataMsgHandler,
        SC_DUP_UPDATE = self.onDupUpdateMsgHandler,
        SC_DUP_DOUBLE_TIMES = self.onDupUpInfoMsgHandler
    }
end

--- *s2c* 副本列表信息 18001
function onDupDataMsgHandler(self, msg)
    dup.DupMainManager:parseDupDataMsg(msg)
end

--- *s2c* 副本信息更新 18002
function onDupUpdateMsgHandler(self, msg)
    dup.DupMainManager:parseDupUpdateMsg(msg)
end

--- *s2c* 副本Up信息更新 18002
function onDupUpInfoMsgHandler(self, msg)
    dup.DupMainManager:parseDupUpInfoMsg(msg)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]