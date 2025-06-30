module("bag.BagNormalTabView", Class.impl(bag.BagBaseTabView))

--构造函数
function ctor(self)
    super.ctor(self)
end

function initData(self)
    super.initData(self)
    self.mPropsId = nil
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

    -- 因为背包列表不显示空格子了，只有更新和删除情况下才可以取到虚拟列表的对应项，新增无法取到对应项，为了方便直接整体刷新数据
    -- 判断选中的物品是否被删掉了
    local delList = args.delList
    local len
    len = #delList
    for i = 1, len do
        local propsVo = delList[i]
        if (propsVo.id == self.mPropsId) then
            self.mPropsId = nil
        end
    end
end

function setData(self, cusTabType, cusParams)
    super.setData(self, cusTabType, cusParams)
end

function getBagType(self)
    return bag.BagType.Bag
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
