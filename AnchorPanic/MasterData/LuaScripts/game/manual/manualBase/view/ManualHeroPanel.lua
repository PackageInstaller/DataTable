--[[ 
-----------------------------------------------------
@filename       : ManualHeroPanel
@Description    : 图鉴英雄面板
@date           : 2022-2-22 10:25:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("manual.ManualHeroPanel", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("manual/ManualHeroPanel.prefab")

destroyTime = -1 -- 自动销毁时间-1默认
panelType = 1 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setBg("maze_bg_1.jpg", false, "maze")
    self:setUICode(LinkCode.Manual)
end

-- 关闭所有UI
function onCloseAllCall(self)
    super.onCloseAllCall(self)
    self:__playerClose()
end

-- 玩家点击关闭
function onClickClose(self)
    super.onClickClose(self)
    self:__playerClose()
end

function __playerClose(self)
end

function open(self, args)
    super.open(self, args)
end

function initData(self)
end

-- 初始化
function configUI(self)
end

function initViewText(self)
end

function addAllUIEvent(self)
end

-- 激活
function active(self, args)
    MoneyManager:setMoneyTidList()
    self:__updateView()
end

-- 非激活
function deActive(self)
    MoneyManager:setMoneyTidList()
end

function __updateView(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
