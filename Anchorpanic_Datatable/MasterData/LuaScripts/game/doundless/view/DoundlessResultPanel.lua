module("doundless.DoundlessResultPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("doundless/DoundlessResultPanel.prefab")
panelType = -1 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0
isBlur = 0 -- 是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
end

-- 初始化数据
function initData(self)
    self.mTargetItemList = {}
end

function configUI(self)
    super.configUI(self)

    self.mTxtCity = self:getChildGO("mTxtCity"):GetComponent(ty.Text)
    self.mTxtRound = self:getChildGO("mTxtRound"):GetComponent(ty.Text)
    self.mTxtDie = self:getChildGO("mTxtDie"):GetComponent(ty.Text)

    self.mTargetScroll = self:getChildGO("mTargetScroll"):GetComponent(ty.ScrollRect)
    self.mTargetItem = self:getChildGO("mTargetItem")
    self.mTxtAllPoint = self:getChildGO("mTxtAllPoint"):GetComponent(ty.Text)

    self.mBtnClose = self:getChildGO("mBtnClose")

    self.mPreviewBtn = self:getChildGO("mPreViewBtn")
end

function active(self, args)
    super.active(self, args)
    self.resultData = args
    self.isCanClose = false
    self:setTimeout(1.5, function()
        self.isCanClose = true
    end)

    self:showPanel()
end

function deActive(self)
    super.deActive(self)

    self:clearTargetItemList()
    self:sendFightOver()
    
end

function sendFightOver(self)
    if #self.resultData.award > 0 or #self.resultData.detail_item_award > 0 then
        ShowAwardPanel:showPropsAwardMsg(self.resultData.award, function()
            GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PANEL_OVER, { isWin = true })
            --GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_CHALLAGE})
            GameDispatcher:dispatchEvent(EventName.REQ_DOUNDLESS_INFO)
        end)
    else
        GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PANEL_OVER, { isWin = true })
        --GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_CHALLAGE})
        GameDispatcher:dispatchEvent(EventName.REQ_DOUNDLESS_INFO)
    end
end


function initViewText(self)
    self:getChildGO("mTxtRoundTips"):GetComponent(ty.Text).text = _TT(97032)
    self:getChildGO("mTxtDieTips"):GetComponent(ty.Text).text = _TT(97033)

    self:getChildGO("mTxtNext"):GetComponent(ty.Text).text = _TT(269)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.onClickClose)

    self:addUIEvent(self.mPreviewBtn, self.onPreviewClick)
end

function onPreviewClick(self)
    GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PREVIEW_SHOW)
end

function onClickClose(self)
    if self.isCanClose then
        super.onClickClose(self)
    end
end




function showPanel(self)
    local fieldId = fight.FightManager:getBattleFieldID()

    local stageVo = doundless.DoundlessManager:getDoundlessCityStageDataById(tonumber(fieldId))

    self.cityId = doundless.DoundlessManager:getServerCityId()
    local name = doundless.getCityEasyName(self.cityId)
    self.mTxtCity.text = name .. "-" .. stageVo.indexName

    local round = doundless.DoundlessManager:getDoundlessSettleInfoRound()
    self.mTxtRound.text = round
    local die = doundless.DoundlessManager:getDoundlessSettleInfoDie()
    self.mTxtDie.text = die
    local point = doundless.DoundlessManager:getDoundlessSettleInfoPoint()
    self.mTxtAllPoint.text = _TT(97057,point)-- "最终战斗评分:<color=#ffb136>" .. point .. "</color>"

    local list = doundless.DoundlessManager:getDoundlessSettleInfoTarget()

    for i = 1, #stageVo.targetList do
        local id = stageVo.targetList[i]
        local vo = doundless.DoundlessManager:getDoundlessCityTargetData(id)
        local item = SimpleInsItem:create(self.mTargetItem, self.mTargetScroll.content, "myDoundlessTargetItem")
        item:getChildGO("mTxtDes"):GetComponent(ty.Text).text = _TT(vo.des)
        if table.indexof01(list, id) > 0 then
            item:getChildGO("mTxtPoint"):GetComponent(ty.Text).text =
            _TT(97058,vo.point)
            item:getChildGO("mEffect"):SetActive(true)
                --"<color=#18ec68>达成(评分+" .. vo.point .. ")</color>"
        else
       
            item:getChildGO("mTxtPoint"):GetComponent(ty.Text).text =
            _TT(97059,0)
            item:getChildGO("mEffect"):SetActive(false)
            --    "<color=#fa3a2b>未达成(评分+" .. 0 .. ")</color>"
        end
        table.insert(self.mTargetItemList, item)
    end
end

function clearTargetItemList(self)
    for i = 1, #self.mTargetItemList do
        self.mTargetItemList[i]:poolRecover()
    end
    self.mTargetItemList = {}
end

return _M
