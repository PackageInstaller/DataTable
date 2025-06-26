module("props.PropsConfigVo", Class.impl("lib.event.EventDispatcher"))

function ctor(self)
    self:__init()
end

function __init(self)
    -- tid
    self.tid = nil
    -- 名称
    self.name = nil
    -- 类型
    self.type = nil
    -- 子类型
    self.subType = nil
    -- 图标
    self.icon = nil
    -- 品质
    self.color = nil
    -- 描述
    self.des = nil
    -- 最大堆叠数
    self.maxNum = nil
    -- 是否可批量使用
    self.isCanBatchUse = nil
    -- 使用等级
    self.useLvl = nil
    -- 是否可出售
    self.isCanSell = nil
    -- 是否可分解
    self.isCanDecompose = nil
    -- 出售类型
    self.sellType = nil
    -- 价格
    self.price = nil
    -- uiCode
    self.uiCode = nil
    -- 获取途径列表
    self.uiCodeList = nil
    -- 排序
    self.sort = nil

    -- 效果类型
    self.effectType = nil
    -- 效果参数
    self.effectList = nil
    -- 是否快捷使用
    self.isQuickUse = nil
    -- 是否可使用：控制背包对应显示使用按钮
    self.isCanUse = nil
end

function parseConfigData(self, cusTid, cusData)
    self.tid = cusTid
    self.name = _TT(cusData.name)
    self.type = cusData.type
    self.subType = cusData.subtype
    self.icon = cusData.icon
    self.color = cusData.default_color
    self.des = _TT(cusData.description)
    self.maxNum = cusData.max_num
    self.isCanBatchUse = cusData.use_all
    self.useLvl = cusData.min_lv
    self.isCanSell = cusData.is_sell
    self.isCanDecompose = cusData.is_decompose
    self.sellType = cusData.sell_type
    self.price = cusData.sell_price
    self.uiCode = cusData.ui_code
    self.uiCodeList = cusData.ui_code_list
    self.useUiCodeList = cusData.use_ui_code
    self.sort = cusData.sort

    self.effectType = cusData.effect
    self.effectList = cusData.effect_param
    self.isQuickUse = cusData.use_fast == 1 and true or false
    self.isCanUse = cusData.use == 1 and true or false
    self.mainCode = cusData.main_code
end

-- name为语言包id，本方法为取区域语言，请勿直接使用name
function getName(self)
    return self.name
end

-- 道具说明（同上）
function getDes(self)
    return self.des
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
