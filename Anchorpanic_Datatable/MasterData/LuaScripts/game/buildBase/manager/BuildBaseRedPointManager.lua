--[[ 
-----------------------------------------------------
@filename       : BuildBaseRedPointManager
@Description    : 战舰(基建)-红点管理器
@date           : 2023/2/25
@Author         : Tonn
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("buildBase.BuildBaseRedPointManager", Class.impl(Manager))


function ctor(self)
	super.ctor(self)

end

--析构函数
function dtor(self)

end

-- Override 重置数据
function resetData(self)
	
end


function checkRedPoint(self)
      local flag = buildBase.DispatchDockManager:updateRedPoint() or buildBase.BuildBaseManager:updateBuildBaseRedPoint()
      mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_WARSHIP, flag)
end

return _M


--[[ 替换语言包自动生成，请勿修改！
	语言包:
]]