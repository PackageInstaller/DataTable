--[[
-----------------------------------------------------
@filename       : MainActivityUpView
@Description    : 活动双倍经验
@date           : 2023-5-31 15:34:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("mainActivity.MainActivityUpView", Class.impl(TabSubView))
UIRes = UrlManager:getUIPrefabPath("mainActivity/MainActivityUpView.prefab")
--构造函数
function ctor(self)
    super.ctor(self)
    -- self:setUICode(LinkCode.MainActivitySign)
end
-- 初始化数据
function initData(self)
    super.initData(self)
end
-- 初始化
function configUI(self)
    super.configUI(self)
    self.mBtnGo = self:getChildGO("mBtnGo")
    self.mTxtRule = self:getChildGO("mTxtRule"):GetComponent(ty.Text)
    self.mTxtRemainDes = self:getChildGO("mTxtRemainDes"):GetComponent(ty.Text)
    self.mTxtTitleDes = self:getChildGO("mTxtTitleDes"):GetComponent(ty.Text)
    self.mTxtActivityTime = self:getChildGO("mTxtActivityTime"):GetComponent(ty.Text)
end
-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    --   GameDispatcher:addEventListener(EventName.UPDATE_DUP_UP, self.updateView, self)
    GameDispatcher:addEventListener(EventName.FIVE_RESET, self.updateFiveHandler, self)
    self:updateView()
end
--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    -- GameDispatcher:removeEventListener(EventName.UPDATE_DUP_UP, self.updateView, self)
    GameDispatcher:removeEventListener(EventName.FIVE_RESET, self.updateFiveHandler, self)
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtTitleDes.text = _TT(85008)--活动期间资源副本掉落x2
    self.mTxtRule.text = _TT(85011)--描述
    self:setBtnLabel(self.mBtnGo, -1, "进入")
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnGo, self.onClickEnterHandler)
end

function updateView(self)
    local curNum, maxNum = dup.DupMainManager:getUpNumAndMaxNum()
    local color = curNum > 1 and "ffb136" or "fa3a2b"
    self.mTxtRemainDes.text = _TT(85010, _TT(45013, HtmlUtil:color(curNum, color), maxNum))
    local md, hm = TimeUtil.getMDHByTime2(activity.ActivityManager:getActivityVoById(activity.ActivityId.Double):getEndTime())
    self.mTxtActivityTime.text = _TT(85009, md .. " " .. hm)
end

function onClickEnterHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = LinkCode.DupDaily})
end

function updateFiveHandler()
    welfareOpt.WelfareOptOpenBetaManager:dispatchEvent(welfareOpt.WelfareOptOpenBetaManager.ON_FIVE_RESET)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
