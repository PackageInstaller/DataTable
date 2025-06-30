
module("battleMap.MainMapStageAwardView", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("battleMapHall/mainMap/MainMapStarAwardPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(2914))
    self:setSize(1120, 520)
end

function initData(self)

end

function configUI(self)
    super.configUI(self)
    self.mLyScroller = self:getChildGO("mLyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(battleMap.MainMapStageAwardItem)
end

function active(self, args)
    super.active(self, args)
    self.mStageAwardList = args[1]
    self:updateView()
end

function updateView(self)
    if self.mLyScroller.Count > 0 then
        self.mLyScroller:CleanAllItem()
    end
    if self.mLyScroller.Count <= 0 then
        self.mLyScroller.DataProvider = self.mStageAwardList
    else
        self.mLyScroller:ReplaceAllDataProvider(self.mStageAwardList)
    end
end

function deActive(self)
    super.deActive(self)
    if self.mLyScroller then
        self.mLyScroller:CleanAllItem()
    end
end

return _M