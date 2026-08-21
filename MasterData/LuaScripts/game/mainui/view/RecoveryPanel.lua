--[[
-----------------------------------------------------
@filename       : RecoveryPanel
@Description    : 回收界面
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]] module("mainui.RecoveryPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("mainui/RecoveryPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(834, 334)
    self:setTxtTitle(_TT(25228))
end

function initData(self)
    self.mPropsList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mTxtInfo = self:getChildGO("mTxtInfo"):GetComponent(ty.Text)
    self.mPropsScroll = self:getChildGO("mPropsScroll"):GetComponent(ty.ScrollRect)

    self.mBtnClose = self:getChildGO("mBtnClose")
end

function initViewText(self)
    self.mTxtInfo.text = _TT(25229)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.close)
end

function active(self, args)
    super.active(self, args)

    local nt = os.date("*t", GameManager:getClientTime())
    local s = nt.year..  nt.month .. nt.day
    local red = StorageUtil:getBool1(gstor.RECOVERY_PANEL_REDPOINT..s)== false
    if red then
        StorageUtil:saveBool1(gstor.RECOVERY_PANEL_REDPOINT..s, true)
        GameDispatcher:dispatchEvent(EventName.UPDATE_RECOVERY_PANEL)
    end

    local award = bag.BagManager:getRecycleData()
    for i = 1,#award do
        local propGrid = PropsGrid:createByData({ tid = award[i].tid, num = award[i].num, parent =self.mPropsScroll.content, scale = 0.7, showUseInTip = true })
        table.insert(self.mPropsList, propGrid)
    end

end

function deActive(self)
    super.deActive(self)
end

function clearProps(self)
    for i = 1, #self.mPropsList do
        self.mPropsList[i]:poolRecover()
    end
    self.mPropsList = {}
end

return _M