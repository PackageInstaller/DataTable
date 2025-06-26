--[[ 
-----------------------------------------------------
@filename       : BagFragmentTabView
@Description    : 背包英雄碎片页签内容
@date           : 2022-02-08 11:38:16
@Author         : Zzz
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("bag.BagFragmentTabView", Class.impl(bag.BagNormalTabView))

--构造函数
function ctor(self)
    super.ctor(self)
end

function initData(self)
    super.initData(self)
end

function configUI(self)
    super.configUI(self)
end

function active(self)
    super.active(self)
end

function deActive(self)
    super.deActive(self)
end

-- 移除
function destroy(self, isAuto)
    super.destroy(self, isAuto)
end

-- 背包红点更新
function onBubbleUpdateHandler(self, args)
    super.onBubbleUpdateHandler(self, args)
end

-- 背包初始化（一登陆/断线重连/服务器道具id重置）
function onBagInitHandler(self, args)
    super.onBagInitHandler(self, args)
end

-- 背包更新
function onBagUpdateHandler(self, args)
    super.onBagUpdateHandler(self, args)
end

-- 点击了道具格子
function onSelectGridHandler(self, args)
    super.onSelectGridHandler(self, args)
end

function setData(self, cusTabType, cusParams)
    super.setData(self, cusTabType, cusParams)
end

function getBagType(self)
    return bag.BagType.HeroFragment
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
