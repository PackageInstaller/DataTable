-- @FileName:   FieldExplorationMapMainUI_213.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.view.FieldExplorationMapMainUI_213', Class.impl(fieldExploration.FieldExplorationMapMainUI))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("fieldExploration/FieldExplorationMapMainUI_213.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图

--构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(92001))
end

return _M
