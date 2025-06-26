--[[ 
    怪物控制器
    @author Jacob
]]
module('monster.MonsterController', Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)

end

--注册server发来的数据
function registerMsgHandler(self)
    return {}
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
