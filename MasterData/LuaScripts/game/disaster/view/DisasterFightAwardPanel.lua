module("disaster.DisasterFightAwardPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("disaster/DisasterFightAwardPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(104005))
    self:setSize(1120, 520)
end

function initData(self)

end

function configUI(self)
    super.configUI(self)
    self.mLyScroller = self:getChildGO("mLyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(disaster.DisasterFightAwardItem)
end

function active(self, args)
    super.active(self, args)

    GameDispatcher:addEventListener(EventName.UPDATE_DISASTER_FIGHT_AWARD_PANEL,self.showPanel,self)
    self:showPanel()
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_DISASTER_FIGHT_AWARD_PANEL,self.showPanel,self)
    if self.mLyScroller then
        self.mLyScroller:CleanAllItem()
    end
end

function showPanel(self)
    local list = disaster.DisasterManager:getDisasterAwardData()
    if self.mLyScroller.Count <= 0 then
        self.mLyScroller.DataProvider = list
    else
        self.mLyScroller:ReplaceAllDataProvider(list)
    end
end

return _M