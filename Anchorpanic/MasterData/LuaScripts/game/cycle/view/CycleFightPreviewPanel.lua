module("cycle.CyclePreviewPanel", Class.impl("lib.component.BaseContainer"))

UIRes = UrlManager:getUIPrefabPath("cycle/CycleFightPreviewPanel.prefab")

function ctor(self)
    super.ctor(self)
end

-- 析构
function dtor(self)
end

function initData(self)
    self.mWeaknessGrid = {}
end

function configUI(self)
    super.configUI(self)
    -- self.ani = self.UIObject:GetComponent(ty.Animator)
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mBtnOK = self:getChildGO("mBtnOK")
    self.mOkColor = self.mBtnOK:GetComponent(ty.Image)
    self.mImgBar = self:getChildGO("mImgBar"):GetComponent(ty.Image)
    self.mTxtOK = self:getChildGO("mTxtOK"):GetComponent(ty.Text)

    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mTxtElement = self:getChildGO("mTxtElement"):GetComponent(ty.Text)
    self.mTxtElementDes = self:getChildGO("mTxtElementDes"):GetComponent(ty.TMP_Text)
    self.mTxtElementDesLink = self:getChildGO("mTxtElementDes"):GetComponent(ty.TextMeshProLink)
    self.mTxtElementDesLink:SetEventCall(notice.HrefUtil.commonTitleDesLinkData)
    self.mFormationIconNode = self:getChildTrans("mFormationIconNode")
    self.mGroupEnemyFormation = self:getChildGO("mGroupEnemyFormation")
    self.mAnemyFormation = self:getChildGO("mAnemyFormation")
    self.mImgEleBg = self:getChildGO("mImgEleBg")
    self.ScrollDes = self:getChildTrans("ScrollDes"):GetComponent(ty.RectTransform)

    self.mTxtElement.text = _TT(77750)
    self:addOnClick(self.mAnemyFormation, self.onOpenFormationPanel)
    self:addOnClick(self.mBtnClose, self.closeView)
    self:addOnClick(self.mBtnOK, self.openEventView)
end

function onOpenFormationPanel(self)
    GameDispatcher:dispatchEvent(EventName.HIDE_CYCLE_TOP_PANEL)
    local dupVo = cycle.CycleManager:getCycleDupData(self.dupId)
    GameDispatcher:dispatchEvent(EventName.OPEN_FORMATION_PREVIEW, { dupVo = dupVo })
end

function show(self, args, parent)
    self:setParentTrans(parent)
    self:showViewAni()
    self.mSelectCellId = args.id
    self.mIsCanClick = args.isCanClick
    self.mBtnOK:SetActive(self.mIsCanClick)
    self.cellMsgVo = cycle.CycleManager:getCellDataById(self.mSelectCellId)
    self.dupId = self.cellMsgVo.normalArgs[1]
    local eventDataVo = cycle.CycleManager:getCycleEventData(self.cellMsgVo.eventId)

    if eventDataVo.eventType == EVENT_TYPE.FIGHT then
        gs.TransQuick:SizeDelta01(self.ScrollDes, 286.8)
        local dupVo = cycle.CycleManager:getCycleDupData(self.dupId)
        self.mGroupEnemyFormation:SetActive(true)
        self.mTxtName.text = _TT(dupVo.name)
        self.mTxtDes.text = _TT(dupVo.des)
        self.mTxtOK.text = _TT(27)
        self.mTxtElementDes.text = _TT(dupVo.unusualDes)
        self:recoverWeaknessGrid()
        local suggestEle = dupVo.suggestEle
        for i = 1, #suggestEle do
            local item = SimpleInsItem:create(self.mImgEleBg, self.mFormationIconNode, "CycleFightEleMonstergrid")
            local type = item:getChildGO("mImgEleType"):GetComponent(ty.AutoRefImage)
            type:SetImg(UrlManager:getHeroEleTypeIconUrl(suggestEle[i]), false)
            table.insert(self.mWeaknessGrid, item)
        end
        self.mFormationIconNode.gameObject:SetActive(true)
    else
        gs.TransQuick:SizeDelta01(self.ScrollDes, 388)
        self.mGroupEnemyFormation:SetActive(false)
        self.mTxtName.text = _TT(eventDataVo.eventTitle)
        self.mTxtDes.text = _TT(eventDataVo.eventDes) -- .. "||" .. cycle.getEventTypeName(eventDataVo.eventType)
        self.mTxtOK.text = _TT(eventDataVo.eventBtn)
        self.mFormationIconNode.gameObject:SetActive(false)
    end
    local color = "000000ff"
    if eventDataVo.eventColor ~= "" then
        color = eventDataVo.eventColor
    end
    self.mOkColor.color = gs.ColorUtil.GetColor(color)
    self.mImgBar.color = gs.ColorUtil.GetColor(color)
end

function deActive(self)
    self:recoverWeaknessGrid()
end

function closeView(self)
    GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_PREVIEW_PANEL)
end

function openEventView(self)
    if self.mIsCanClick == false then
        gs.Message.Show(_TT(27541))
        return
    end

    self:hideViewAni()

    local currentCellId = cycle.CycleManager:getCurrentCell()
    local eventDataVo = cycle.CycleManager:getCycleEventData(self.cellMsgVo.eventId)

    if self.mSelectCellId ~= currentCellId then
        GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_TRIGGER_EVENT, {
            cellId = self.mSelectCellId
        })
        cusLog("通知触发了|" .. self.mSelectCellId .. "|格子")
    end
end

function showViewAni(self)
    if self.ani then
        self.ani:SetTrigger("show")
    end
end

function hideViewAni(self)
    if self.ani then
        self.ani:SetTrigger("exit")
        LoopManager:addTimer(0.3, 1, self, self.closeView)
    else
        self:closeView()
    end
end

function recoverWeaknessGrid(self)
    for k, v in pairs(self.mWeaknessGrid) do
        v:poolRecover()
    end
    self.mWeaknessGrid = {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(27541):	"当前事件无法触发 请选择正确的格子"
	语言包: _TT(27):	"挑战"
]]