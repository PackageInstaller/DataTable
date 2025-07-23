--[[ 
-----------------------------------------------------
@filename       : WelfareOptOpenBetaView
@Description    : 公测活动
@Author         : tonn
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("game.welfareOpt.view.tab.WelfareOptOpenBetaView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("welfareOpt/tab/WelfareOptOpenBetaView.prefab")

function ctor(self)
    super.ctor(self)
end

function initData(self)

end

function configUI(self)
    self.mTxtTileTimer = self:getChildGO("mTxtTileTimer"):GetComponent(ty.Text)
    self.mLyScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(welfareOpt.WelfareOptOpenBetaItem)
end

--激活
function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.FIVE_RESET, self.onFiveReset, self)
    self:setScrollerData()
    self:updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.FIVE_RESET, self.onFiveReset, self)
    if self.mSn then
        LoopManager:removeTimerByIndex(self.mSn)
    end
    if self.mLyScroller then
        self.mLyScroller:CleanAllItem()
    end
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:getChildGO("mTxtTileBar"):GetComponent(ty.Text).text = _TT(91005)
end

--LyScroller赋值
function setScrollerData(self)
    if not self.mList then
        self.mList = welfareOpt.WelfareOptOpenBetaManager:getConfigTable()
    end

    if self.mList and next(self.mList) then
        if self.mList[1].tweenId == nil then
            for i = 1, #self.mList do
                self.mList[i].tweenId = i * 3
            end
        end
    end
    if (self.mLyScroller.Count > 0) then
        self.mLyScroller:ReplaceAllDataProvider(self.mList)

    else
        self.mLyScroller.DataProvider = self.mList
    end

end

--更新View
function updateView(self)
    self.mEndTime = welfareOpt.WelfareOptOpenBetaManager:getEndTime()
    self.mLeftTime = self.mEndTime - GameManager:getClientTime()
    local _updateTimer = function()
        if self.mLeftTime >= 0 then
            self.mTxtTileTimer.text = TimeUtil.getNewRoleShowTime(self.mLeftTime, true)
            self.mLeftTime = self.mLeftTime - 1
        else
            self.mTxtTileTimer.text = "00:00:00"
            if self.mSn then
                LoopManager:removeTimerByIndex(self.mSn)
            end
        end
    end
    _updateTimer()
    self.mSn = LoopManager:addTimer(1, 0, self, _updateTimer)

end

--五点重置
function onFiveReset(self)
    welfareOpt.WelfareOptOpenBetaManager:dispatchEvent(welfareOpt.WelfareOptOpenBetaManager.ON_FIVE_RESET)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(7):	"已领取"
	语言包: _TT(3):	"领取"
]]