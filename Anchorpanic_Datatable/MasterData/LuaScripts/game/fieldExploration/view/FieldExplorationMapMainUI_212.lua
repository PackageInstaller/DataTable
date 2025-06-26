-- @FileName:   FieldExplorationMapMainUI_212.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.view.FieldExplorationMapMainUI_212', Class.impl(fieldExploration.FieldExplorationMapMainUI))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("fieldExploration/FieldExplorationMapMainUI_212.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图

--构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(92023))
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mTextActivityTime = self:getChildGO("mTextActivityTime"):GetComponent(ty.Text)
end

--激活
function active(self, args)
    super.active(self, args)

    local activity_id = fieldExploration.FieldExplorationManager:getActivityId()
    local mainActivityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity_id)
    local overTime = mainActivityVo:getOverTimeDt()
    local t = os.date('*t', overTime)
    self.mTextActivityTime.text = string.format("活动截止时间：%02d/%02d %02d:%02d", t.month, t.day, t.hour, t.min)
end

return _M
