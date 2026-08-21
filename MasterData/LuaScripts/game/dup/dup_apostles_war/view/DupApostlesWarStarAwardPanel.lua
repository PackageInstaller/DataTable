--[[ 
-----------------------------------------------------
@filename       : DupApostlesWarStarAwardPanel
@Description    : 使徒之战奖励面板
@date           : 2022-06-13 15:03:15
@Author         : lyx
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup_apostle_war.view.DupApostlesWarStarAwardPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("dupApostleWar/DupApostlesWarStarAwardPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 541)
    self:setTxtTitle(_TT(3541))
end

function initData(self)
    self.mEnterItemList = {}
end

-- 初始化
function configUI(self)
    self.mTaskScroll = self:getChildGO("mLyScroller"):GetComponent(ty.LyScroller)
    self.mTaskScroll:SetItemRender(dup.DupApostlesRewardItem)
end

--激活
function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_DUP_APOSTLES_PANEL, self.updateView, self)
    self:updateView(true)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_DUP_APOSTLES_PANEL, self.updateView, self)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function updateView(self, init)
    self.data = dup.DupApostlesWarManager:getPanelInfo()
    self.configVo = dup.DupApostlesWarManager:getClositerDataById(self.data.id)
    local rewardVoList = self.configVo.taskRewardList
    local state = 1
    for i = 1, #rewardVoList do
        local hasGetList = self.data.receivedStarId
        if (self.data.starNum >= rewardVoList[i].star) then
            state = 0
            for j = 1, #hasGetList do
                if (hasGetList[j] == rewardVoList[i].id) then
                    state = 2
                end
            end
        end
    end
    table.sort(rewardVoList, function(a, b)
        if not a or not b then
            return false
        end

        local aState = 1
        local hasGetList = self.data.receivedStarId
        if (self.data.starNum >= a.star) then
            aState = 0
            for j = 1, #hasGetList do
                if (hasGetList[j] == a.id) then
                    aState = 2
                end
            end
        end

        local bState = 1
        local hasGetList = self.data.receivedStarId
        if (self.data.starNum >= b.star) then
            bState = 0
            for j = 1, #hasGetList do
                if (hasGetList[j] == b.id) then
                    bState = 2
                end
            end
        end
        if (aState == bState) then
            return a.id < b.id
        end
        return aState < bState
    end)

    for i = 1, #rewardVoList do
        rewardVoList[i].tweenId = i
    end
    if init then
        self.mTaskScroll.DataProvider = rewardVoList
    else
        self.mTaskScroll:ReplaceAllDataProvider(rewardVoList)
    end

end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(3541):	"<size=24>阶</size>段奖励"
]]
