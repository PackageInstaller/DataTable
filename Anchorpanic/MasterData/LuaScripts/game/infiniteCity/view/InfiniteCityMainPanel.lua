--[[ 
-----------------------------------------------------
@filename       : InfiniteCityMainPanel
@Description    : 无限城活动主界面
@date           : 2021-03-01 14:34:03
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.infiniteCity.view.InfiniteCityMainPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("infiniteCity/InfiniteCityMainPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)

    self:setBg("infiniteCity_bg_1.jpg", false, "infiniteCity")
end
--析构  
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    -- self.aa = self:getChildGO(""):GetComponent(ty.Image)
    -- self.aa = self:getChildTrans("")
    self.mTxtActivityTimeLab = self:getChildGO("mTxtActivityTimeLab"):GetComponent(ty.Text)
    self.mTxtActivityTime = self:getChildGO("mTxtActivityTime"):GetComponent(ty.Text)
    self.mTxtRemaindTimeLab = self:getChildGO("mTxtRemaindTimeLab"):GetComponent(ty.Text)
    self.mTxtRemaindTime = self:getChildGO("mTxtRemaindTime"):GetComponent(ty.Text)

    self.mBtnFight = self:getChildGO("mBtnFight")
    self.mBtnShop = self:getChildGO("mBtnShop")
    self.mBtnRank = self:getChildGO("mBtnRank")
    self.mBtnAward = self:getChildGO("mBtnAward")

    self:setGuideTrans("funcTips_infiniteCity_Time", self:getChildTrans("mGroupFuncTipsTime"))
    self:setGuideTrans("funcTips_infiniteCity_shop", self.mBtnShop.transform)
    self:setGuideTrans("funcTips_infiniteCity_rank", self.mBtnRank.transform)
    self:setGuideTrans("funcTips_infiniteCity_award", self.mBtnAward.transform)
end

--激活
function active(self)
    super.active(self)
    GameDispatcher:dispatchEvent(EventName.REQ_INFINITE_CITY_INFO)

    self:updateView()
    infiniteCity.InfiniteCityManager:addEventListener(infiniteCity.InfiniteCityManager.EVENT_TARGET_DATA_UPDATE, self.updateInfiniteCityRedFlag, self)
    self:updateInfiniteCityRedFlag()

end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    infiniteCity.InfiniteCityManager:removeEventListener(infiniteCity.InfiniteCityManager.EVENT_TARGET_DATA_UPDATE, self.updateInfiniteCityRedFlag, self)

end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
    self.mTxtActivityTimeLab.text = _TT(27130)--"活动时间:"
    self.mTxtRemaindTimeLab.text = _TT(27131)--"剩余       天"
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnFight, self.onOpenDup)
    self:addUIEvent(self.mBtnShop, self.onOpenShop)
    self:addUIEvent(self.mBtnRank, self.onOpenRank)
    self:addUIEvent(self.mBtnAward, self.onOpenAward)
    self:addUIEvent(self:getChildGO("mBtnFuncTips"), self.onClickFuncTipsHandler)
end

function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, { id = LinkCode.InfiniteCity })
end

-- 打开副本页面
function onOpenDup(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_INFINITE_CITY_DUP_PANEL)
end
-- 打开夜市
function onOpenShop(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_INFINITE_CITY_SHOP_PANEL)
end
-- 打开无限榜
function onOpenRank(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_INFINITE_CITY_RANK_PANEL)
end
-- 打开目标奖励
function onOpenAward(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_INFINITE_CITY_AWARD_PANEL)
end

function updateView(self)
    local startTime = infiniteCity.InfiniteCityManager.startTime
    local endTime = infiniteCity.InfiniteCityManager.endTime
    local nowTime = GameManager:getClientTime()
    self.mTxtActivityTime.text = string.format("%s-%s", TimeUtil.getMDHByTime2(startTime), TimeUtil.getMDHByTime2(endTime))
    local days = math.ceil((endTime - nowTime) / 86400)
    self.mTxtRemaindTime.text = string.format("%02d", days)
end


-- 无限城目标红点
function updateInfiniteCityRedFlag(self)
    local isFlag = infiniteCity.InfiniteCityManager:getRedFlag()
    if isFlag then
        RedPointManager:add(self.mBtnAward.transform, nil, 80, 21)
    else
        RedPointManager:remove(self.mBtnAward.transform)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
