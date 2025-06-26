module("tips.ClimbTowerTips", Class.impl(tips.BaseTips))

UIRes = UrlManager:getUIPrefabPath("tips/CenterMessageTips.prefab")

panelType = 2 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isBlur = 1 -- 是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
isAdapta = 0 -- 是否开启适配刘海 0 否 1 是
-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
end

-- 析构函数
function dtor(self)
    super.dtor(self)
end

-- 初始化UI
function configUI(self)
    super.configUI(self)
    self.mTxtMessageDes = self:getChildGO("mTxtMessageDes"):GetComponent(ty.Text)
end

function active(self, args)
    super.active(self, args)

    self.mDes = args
    self:updateView()
end

function deActive(self)
    super.deActive(self)
    if self.timeId ~= nil then
        LoopManager:removeTimerByIndex(self.timeId)
    end
end

-- 初始化数据
function initData(self)
    self.mDes = nil
end

function onCloseHandler(self)
    self:close()
end

function updateView(self)
    self.mTxtMessageDes.text = self.mDes
    if self.timeId ~= nil then
        LoopManager:removeTimerByIndex(self.timeId)
    end
    self.timeId = LoopManager:addTimer(3, 1, self, self.onCloseHandler)
end

-- 在资源销毁前，对需要回收的资源进行回收处理
function recover(self)
    super.recover(self)
    self:initData()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(4062):	"<未解锁>"
]]