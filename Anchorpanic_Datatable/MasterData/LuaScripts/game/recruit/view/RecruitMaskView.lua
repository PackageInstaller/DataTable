module('game.recruit.view.RecruitMaskView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("recruit/RecruitMaskView.prefab")

panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isAdapta = 0 --是否开启适配刘海
escapeClose = 0

--构造函数
function ctor(self)
    super.ctor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)

end

function __playOpenAction(self)
    
end

--激活
function active(self)
    super.active(self)

end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
