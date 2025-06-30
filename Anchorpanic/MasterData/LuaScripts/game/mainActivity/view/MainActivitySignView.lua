--[[
-----------------------------------------------------
@filename       : MainActivitySignView
@Description    : 活动签到界面
@date           : 2023-5-29 15:59:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("mainActivity.MainActivitySignView", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("mainActivity/MainActivitySignView.prefab")
destroyTime = 0 -- 自动销毁时间-1默认
panelType = 1 -- 窗口类型 1 全屏 2 弹窗
isShowCloseAll = 0 --是否显示导航按钮

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(92002))
    self:setBg("activity_main_bg02.jpg", false, "mainActivity")
    self:setUICode(LinkCode.MainActivitySign)
end
-- 初始化数据
function initData(self)
    super.initData(self)
end
-- 初始化
function configUI(self)
    super.configUI(self)
    self.mTxtTimeEnd = self:getChildGO("mTxtTimeEnd"):GetComponent(ty.Text)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mLyScroller = self:getChildGO("mLyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(mainActivity.MainActivitySignItem)
end
-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    self:updateView()
end
--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    if self.mLyScroller then
        self.mLyScroller:CleanAllItem()
    end
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtTitle.text = _TT(85007)--11天累计登陆领取大奖
end

function updateView(self)
    local list = mainActivity.MainActivityManager:getMainActivitySignList()
    for index, vo in ipairs(list) do
        vo.tweenId = 2 * index - 1
    end
    if self.mLyScroller.Count <= 0 then
        self.mLyScroller.DataProvider = list
    else
        self.mLyScroller:ReplaceAllDataProvider(list)
    end
    -- local tweenId = mainActivity.MainActivityManager:getLoginDay() > 0 and mainActivity.MainActivityManager:getLoginDay() - 1 or 0
    -- if tweenId >= self.mLyScroller:GetItemListCount() then
    --     self:addTimer(0.5, 1, function()
    --         self.mLyScroller:SetItemIndex(tweenId, 0, 0, 0.1)
    --     end)
    -- end

    self.mTxtTimeEnd.text = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.Sign):getRemainingTime()
end

function __closeOpenAction(self)
    if self.isPop == 1 then
        self:close()
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
