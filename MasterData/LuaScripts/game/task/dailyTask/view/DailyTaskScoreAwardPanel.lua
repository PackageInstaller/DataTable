module("task.DailyTaskScoreAwardPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("taskHall/dailyTask/DailyTaskScoreAwardPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认
panelType = -1 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(800, 550)
    self:setTxtTitle("")
end

-- 初始化数据
function initData(self)
    self.data = nil
    self.m_propsGridList = {}
end

function configUI(self)
    super.configUI(self)

    self.m_textTip = self:getChildGO("TextTip"):GetComponent(ty.Text)
    -- self.m_textTitle = self:getChildGO("TextTitle"):GetComponent(ty.LanText)
    -- self.m_textTitle.text = "奖励详情"
    self.m_groupContent = self:getChildGO("Content").transform
end

function active(self)
    super.active(self)
end

function deActive(self)
    super.deActive(self)
end

function onClickClose(self)
    self:recoverAllGrid()
    super.onClickClose(self)
end

function recoverAllGrid(self)
    for i = 1, #self.m_propsGridList do
        self.m_propsGridList[i]:poolRecover()
    end
    self.m_propsGridList = {}
end

function setData(self, cusData)
    self.data = cusData
    self:__updateView()
end

function __updateView(self)
    self:recoverAllGrid()

    -- self.m_textTip.text = "评分达到" .. HtmlUtil:color(self.data.score, ColorUtil.BLUE_NUM) .. "可领取"
    self.m_textTip.text = self.data.tip --_TT(663, self.data.score)

    local awardList = self.data.propsList

    for k, v in pairs(awardList) do
        v.color = props.PropsManager:getTypePropsVoByTid(v.tid).color
    end
    table.sort(awardList, bag.BagManager.sortPropsListByDescending)
    for i = 1, #awardList do
        local count = awardList[i].count and awardList[i].count or awardList[i].num
        local propsGrid = PropsGrid:createByData({ tid = awardList[i].tid, num = count, parent = self.m_groupContent, isTween = true, showUseInTip = false })
        propsGrid:setIsShowName(true)
        table.insert(self.m_propsGridList, propsGrid)
    end

    self:setMovementType()
end


function setMovementType(self)
    local w = self.m_groupContent.rect.size.x
    local scrollRect = self:getChildGO("Scroll View"):GetComponent(ty.ScrollRect)
    local scrollTrans = self:getChildGO("Scroll View"):GetComponent(ty.RectTransform)
    if w > scrollTrans.rect.size.x then
        scrollRect.movementType = gs.ScrollRect.MovementType.Elastic
    else
        scrollRect.movementType = gs.ScrollRect.MovementType.Clamped
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]