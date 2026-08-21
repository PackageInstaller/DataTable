--[[ 
-----------------------------------------------------
@filename       : AccRechargePanel
@Description    : 累计充值
@date           : 2023-3-23 17:27:35
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("purchase.AccRechargePanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("purchase/AccRechargePanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1-- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

function ctor(self)
    super.ctor(self)
    self:setSize(1120, 520)
    self:setTxtTitle("充值奖励")
end
-- 初始化数据
function initData(self)
end

function configUI(self)
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.accTxt = self:getChildGO("AccTxt"):GetComponent(ty.Text)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(purchase.AccRechargeItem)
end

function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({ MoneyTid.PAY_ITIANIUM_TID, MoneyTid.ITIANIUM_TID })
    GameDispatcher:addEventListener(EventName.UPDATE_ACCRECHARGEPANEL, self.__updatePanel, self)
    self:onShow()
end

function deActive(self)
    MoneyManager:setMoneyTidList({ MoneyTid.PAY_ITIANIUM_TID, MoneyTid.ITIANIUM_TID })
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ACCRECHARGEPANEL, self.__updatePanel, self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.close)
end

function __updatePanel(self)
    self:onShow()
end
--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtTitle.text = "累计充值奖励"--_TT(-1)
end

function onShow(self)
    self.accTxt.text = _TT(50007, purchase.AccRechargeManager:getAccPlyNum())--"累计充值:" .. purchase.AccRechargeManager:getAccPlyNum()

    local list = purchase.AccRechargeManager:getAccRechargeConfig()
    if self.mFrameSn then
        LoopManager:removeFrameByIndex(self.mFrameSn)
        self.mFrameSn = nil
    end
    self.mFrameSn = LoopManager:addFrame(3, 1, self, function()
        for i = 1, #list do
            list[i].tweenId = 2 * i
        end
        if self.mScroller.Count <= 0 then
            self.mScroller.DataProvider = list
        else
            self.mScroller:ReplaceAllDataProvider(list)
        end
    end)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]